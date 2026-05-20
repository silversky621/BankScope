package dev.gmpark.bankbackend.service;

import dev.gmpark.bankbackend.entities.AccountEntity;
import dev.gmpark.bankbackend.entities.LoanEntity;
import dev.gmpark.bankbackend.entities.LoanScheduleEntity;
import dev.gmpark.bankbackend.entities.UserEntity;
import dev.gmpark.bankbackend.mappers.*;
import dev.gmpark.bankbackend.results.LoanResult;
import dev.gmpark.bankbackend.services.LoanService;
import dev.gmpark.bankbackend.vos.AccountVo;
import dev.gmpark.bankbackend.vos.LoanVo;
import org.apache.commons.lang3.tuple.Pair;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.fail;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import dev.gmpark.bankbackend.entities.*;
import org.mockito.ArgumentCaptor;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest // 서비스와 매퍼 등 모든 스프링 빈을 로드하여 실제 환경과 동일하게 테스트합니다.
class LoanServiceIntegrationTest {

    @Autowired
    private LoanService loanService;

    @Autowired
    private LoanScheduleMapper loanScheduleMapper;

    @Mock
    private LoanMapper loanMapper;

    @Mock
    private AccountMapper accountMapper;

    @Test
    @DisplayName("대출 승인 시 12개월치 스케줄이 계산되어 실제 DB에 정상적으로 생성되는지 확인")
    @Transactional
    @Rollback(false) // 테스트 완료 후 데이터를 DB에 남겨두어 눈으로 직접 확인하기 위함
    void testGenerateAndSaveLoanSchedulesIntegration() {
        // given (준비 단계)
        // ⚠️ 주의: 지난번처럼 외래키 에러가 나지 않도록, 실제 loan 테이블에 존재하는 대출 ID를 적어주세요!
        Long testLoanId = 4L;

        Long principalAmount = 10000000L; // 대출 원금: 1,000만 원
        int termMonths = 12;              // 대출 기간: 12개월
        BigDecimal annualInterestRate = new BigDecimal("5.0");  // 연 금리: 5%
        LocalDate approvalDate = LocalDate.of(2026, 4, 29); // 대출 실행일

        // when (실행 단계 - 서비스 로직 호출)
        loanService.generateAndSaveLoanSchedules(Math.toIntExact(testLoanId), principalAmount, termMonths, annualInterestRate, approvalDate);

        // then (검증 단계)
        // 실제로 DB에 잘 들어갔는지 꺼내와서 확인합니다.
        List<LoanScheduleEntity> schedules = loanScheduleMapper.findPendingSchedulesByLoanId(testLoanId);

        // 12개가 잘 들어갔는지 검증
        assertEquals(12, schedules.size(), "12개의 스케줄이 생성되어 DB에 저장되어야 합니다.");

        // 콘솔 창에서 데이터가 잘 만들어졌는지 가볍게 확인
        System.out.println("=== 대출 스케줄 생성 결과 ===");
        System.out.println("1회차 상환일: " + schedules.get(0).getDueDate() + " / 납입 금액: " + schedules.get(0).getRepayAmount());
        System.out.println("12회차 상환일: " + schedules.get(11).getDueDate() + " / 납입 금액: " + schedules.get(11).getRepayAmount());
    }

    @Test
    @DisplayName("웹 대출 신청 통합 테스트 - 실제 DB에 대출 정보와 12개월 스케줄이 완벽하게 꽂히는지 확인")
    @Transactional
    @Rollback(false) // ✨ 핵심! 테스트 종료 후 데이터를 지우지 않고 DB에 확정(Commit)합니다.
    void testApplyLoanFromWeb_Integration() {
        // ==========================================
        // 1. Given (테스트 준비 단계)
        // ==========================================
        // ⚠️ 주의: 외래키 에러를 막기 위해 아래 3개의 ID는 반드시 실제 DB에 존재하는 번호여야 합니다!
        UserEntity user = UserEntity.builder().id(2).build(); // 실제 존재하는 유저 ID
        Integer productId = 18;                              // 실제 존재하는 대출 상품 ID
        Long linkedAccountId = 32L;                        // 실제 존재하는 연결 계좌 ID

        Long principalAmount = 12000000L; // 대출 원금: 1,200만 원
        Integer durationMonths = 12;      // 대출 기간: 12개월
        Integer paymentDay = 25;          // 매월 25일 상환
        String info = "웹 비대면 직장인 대출 (통합테스트용)";
        // ==========================================
        // 2. When (실행 단계 - 실제 서비스 로직 호출)
        // ==========================================
        Pair<LoanResult, LoanEntity> result = loanService.applyLoanFromWeb(
                user, productId, linkedAccountId, principalAmount, durationMonths, paymentDay, info);

        // ==========================================
        // 3. Then (검증 및 확인)
        // ==========================================
        assertEquals(LoanResult.SUCCESS, result.getLeft(), "대출 실행 결과가 SUCCESS여야 합니다.");

        System.out.println("\n✅ 대출 실행 완료! 생성된 대출 마스터 ID: " + result.getRight().getLoanId());
        System.out.println("👉 MySQL DB 관리 툴을 열어서 아래 3개 테이블을 확인해 보세요!");
        System.out.println("   1) SELECT * FROM loan; (대출 마스터 생성 확인)");
        System.out.println("   2) SELECT * FROM transaction_history; (1,200만원 입금 내역 확인)");
        System.out.println("   3) SELECT * FROM loan_schedule; (12개월치 스케줄 생성 확인)\n");
    }

    @Test
    @DisplayName("대출 상환 통합 테스트 - 돈을 내면 스케줄이 순차적으로 PAID 처리되고 잔액이 줄어드는지 확인")
    @Transactional
    @Rollback(false) // 롤백을 꺼서 상환 결과가 DB에 어떻게 찍히는지 눈으로 확인
    void testRepayLoan_Integration() {
        // ==========================================
        // 1. Given (테스트 준비 단계)
        // ==========================================
        // ⚠️ DB에 실제로 존재하는 대출 ID와 계좌번호, 그리고 유저 ID를 세팅해 주세요.
        Integer testLoanId = 5;
        String testAccountNumber = "210-765-376812"; // 실제 돈이 빠져나갈 계좌
        String testAccountPassword = "1234";         // 암호화(BCrypt) 비교를 통과할 평문 비밀번호
        Integer testUserId = 2;

        UserEntity mockUser = UserEntity.builder().id(testUserId).userType("customer").build();

        // 상환할 금액 세팅 (예: 1회차 청구금액이 87,500원일 때 100,000원을 냈다고 가정)
        Long repayAmount = 100000L;

        // ==========================================
        // 2. When (상환 API 로직 실행)
        // ==========================================
        Pair<LoanResult, LoanEntity> result = loanService.repayLoan(
                testLoanId,
                testAccountNumber,
                testAccountPassword,
                mockUser
        );

        // ==========================================
        // 3. Then (검증 및 콘솔 출력 확인)
        // ==========================================
        assertEquals(LoanResult.SUCCESS, result.getLeft(), "대출 상환이 SUCCESS여야 합니다.");

        System.out.println("\n✅ 대출 상환 완료!");
        System.out.println("👉 상환 후 남은 대출 원금 잔액: " + result.getRight().getOutstandingAmount() + "원");
        System.out.println("=================================================");
        System.out.println("👉 [DB 확인 필수] MySQL 툴을 열어서 확인해 보세요!");
        System.out.println("1) SELECT * FROM loan_schedule WHERE loan_id = " + testLoanId + " ORDER BY due_date;");
        System.out.println("   (첫 번째 스케줄의 status가 'PAID'로 바뀌었는지 확인!)");
        System.out.println("2) SELECT * FROM transaction_history;");
        System.out.println("   (상환 기록이 잘 남았는지 확인!)");
        System.out.println("=================================================\n");
    }


// ... 기존 코드 ...
private LoanEntity createMockLoan(Integer loanId, Long outstandingAmount, int remainingMonths, String status) {
    // 남은 개월 수에 맞춰 만기일 자동 세팅
    String maturityDate = LocalDate.now().plusMonths(remainingMonths).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

    return LoanEntity.builder()
            .loanId(loanId)
            .userId(1) // 테스트용 임시 유저 ID
            .outstandingAmount(outstandingAmount)
            .interestRate(new BigDecimal("5.0"))
            .maturityDate(maturityDate)
            .status(status)
            .build();
}

    private AccountEntity createMockAccount(Long accountId, String accountNumber, String password, Long balance) {
        return AccountEntity.builder()
                .accountId(accountId)
                .userId(1) // 테스트용 임시 유저 ID
                .accountNumber(accountNumber)
                .accountPassword(BCrypt.hashpw(password, BCrypt.gensalt())) // 진짜 암호화 적용
                .balance(balance)
                .status("ACTIVE")
                .build();
    }

    // ==========================================
    // 💡 [2] 실제 테스트 코드 (Helper 함수 활용)
    // ==========================================
    private AccountVo createMockAccountVo(Long accountId, String accountNumber, String password, Long balance) {
        AccountVo accountVo = new AccountVo();
        accountVo.setAccountId(accountId);
        accountVo.setUserId(1); // 테스트용 임시 유저 ID
        accountVo.setAccountNumber(accountNumber);
        accountVo.setAccountPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        accountVo.setBalance(balance);
        accountVo.setStatus("ACTIVE");
        return accountVo;
    }



}

@ExtendWith(MockitoExtension.class) // ✨ 핵심 1: 스프링/DB를 띄우지 않는 초고속 순수 단위 테스트 모드
public class LoanServiceTest2 {

    @InjectMocks // ✨ 핵심 2: 아래에서 만든 @Mock 가짜 객체들을 LoanService 안에 완벽하게 밀어넣어 줍니다!
    private LoanService loanService;

    // LoanService가 필요로 하는 모든 Mapper들을 가짜(Mock)로 선언합니다.
    @Mock private LoanMapper loanMapper;
    @Mock private AccountMapper accountMapper;
    @Mock private TransactionHistoryMapper transactionHistoryMapper;
    @Mock private LoanScheduleMapper loanScheduleMapper;
    @Mock private FinancialProductMapper financialProductMapper;

    @Test
    @DisplayName("중도 일부 상환 성공: DB 없는 순수 Mock 테스트")
    void testEarlyRepayLoan_PartialRepayment_Success() {
        // ==========================================
        // 💡 1. Given (절대 실패하지 않는 가짜 객체 세팅)
        // ==========================================
        UserEntity user = UserEntity.builder().id(1).build();

        // 가짜 대출 내역 생성 (잔액 1000만 원, 6개월 남음)
        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1)
                .userId(1)
                .outstandingAmount(10000000L)
                .interestRate(new BigDecimal("5.0"))
                .maturityDate(LocalDate.now().plusMonths(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                .status("ACTIVE")
                .build();

        // 가짜 통장 생성 (AccountVo 사용, 잔액 2000만 원)
        AccountVo mockAccount = new AccountVo();
        mockAccount.setAccountId(10L);
        mockAccount.setUserId(1);
        mockAccount.setAccountNumber("111-222-333");
        mockAccount.setAccountPassword(BCrypt.hashpw("1234", BCrypt.gensalt())); // 암호화 통과용
        mockAccount.setBalance(20000000L);
        mockAccount.setStatus("ACTIVE");

        // ✨ 핵심 3: anyInt(), anyString()을 사용해서 어떤 파라미터로 찌르든 무조건 가짜 객체를 반환하게 강제!
        when(loanMapper.selectLoanById(anyInt())).thenReturn(mockLoan);
        when(accountMapper.selectAccountByAccountNumber(anyString())).thenReturn(mockAccount);

        // ==========================================
        // 💡 2. When (400만 원 상환 로직 실행)
        // ==========================================
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "1234", 4000000L, user
        );

        // ==========================================
        // 💡 3. Then (결과 검증)
        // ==========================================
        assertEquals(LoanResult.SUCCESS, result.getLeft(), "대출 중도 상환 로직 실패!");

        // DB 쿼리가 날아가는 대신, 매퍼의 업데이트 함수가 정확한 금액으로 '호출'되었는지 검증합니다.
        verify(accountMapper).updateBalance(10L, 16000000L); // 잔액: 2000만 - 400만 = 1600만 원
        verify(loanScheduleMapper).deleteFutureSchedules(1L); // 스케줄 무효화 쿼리 실행 확인
        verify(loanMapper).updateOutstandingAmount(1, 6000000L); // 원금: 1000만 - 400만 = 600만 원

        System.out.println("🎉 환경 제약 없는 순수 단위 테스트 완벽 통과!");
    }

    @Test
    @DisplayName("중도 전액 상환 성공: 콘솔 영수증 출력")
    void testEarlyRepayLoan_FullRepayment_Success() {
        // ==========================================
        // 💡 1. Given (데이터 세팅)
        // ==========================================
        UserEntity user = UserEntity.builder().id(1).build();
        Long initialLoanAmount = 10000000L;
        Long initialAccountBalance = 20000000L;

        // ✨ 이번엔 상환액을 대출금과 똑같이 1,000만 원으로 세팅! (전액 상환)
        Long repayAmount = 10000000L;

        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1).userId(1).outstandingAmount(initialLoanAmount)
                .interestRate(new BigDecimal("5.0"))
                .maturityDate(LocalDate.now().plusMonths(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                .status("ACTIVE").build();

        AccountVo mockAccount = new AccountVo();
        mockAccount.setAccountId(10L);
        mockAccount.setUserId(1);
        mockAccount.setAccountNumber("111-222-333");
        mockAccount.setAccountPassword(BCrypt.hashpw("1234", BCrypt.gensalt()));
        mockAccount.setBalance(initialAccountBalance);
        mockAccount.setStatus("ACTIVE");

        when(loanMapper.selectLoanById(anyInt())).thenReturn(mockLoan);
        when(accountMapper.selectAccountByAccountNumber(anyString())).thenReturn(mockAccount);

        System.out.println("\n====================================================");
        System.out.println("🎉 [대출 전액(완제) 상환 시뮬레이션 시작]");
        System.out.println("====================================================");
        System.out.printf("▶ 상환 전 대출 잔액 : %,d 원\n", initialLoanAmount);
        System.out.printf("▶ 상환 전 통장 잔액 : %,d 원\n", initialAccountBalance);
        System.out.printf("▶ 고객 상환 요청액  : %,d 원\n", repayAmount);
        System.out.println("----------------------------------------------------");

        // ==========================================
        // 💡 2. When (서비스 실행)
        // ==========================================
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "1234", repayAmount, user
        );

        // ==========================================
        // 💡 3. Then (검증 및 결과 낚아채기)
        // ==========================================
        assertEquals(LoanResult.SUCCESS, result.getLeft());

        org.mockito.ArgumentCaptor<Long> balanceCaptor = org.mockito.ArgumentCaptor.forClass(Long.class);
        org.mockito.ArgumentCaptor<Long> outstandingCaptor = org.mockito.ArgumentCaptor.forClass(Long.class);
        org.mockito.ArgumentCaptor<String> statusCaptor = org.mockito.ArgumentCaptor.forClass(String.class);

        verify(accountMapper).updateBalance(eq(10L), balanceCaptor.capture());
        verify(loanMapper).updateOutstandingAmount(eq(1), outstandingCaptor.capture());
        verify(loanMapper).updateLoanStatus(eq(1), statusCaptor.capture());
        verify(loanScheduleMapper).deleteFutureSchedules(1L);

        // ✨ 전액 상환이므로 스케줄 Insert 로직은 절대 실행되면 안 됨! (never)
        verify(loanScheduleMapper, never()).insertLoanSchedules(any());

        System.out.println("\n✅ [대출 전액 상환 처리 완료 - 영수증]");
        System.out.println("====================================================");
        System.out.println("✔ 처리 결과 상태      : " + result.getLeft());
        System.out.printf("✔ 차감 후 통장 잔액   : %,d 원 (정상 출금)\n", balanceCaptor.getValue());
        System.out.printf("✔ 차감 후 대출 잔액   : %,d 원 (빚 청산 완료!)\n", outstandingCaptor.getValue());
        System.out.println("✔ 변경된 대출 상태    : " + statusCaptor.getValue());
        System.out.println("✔ 기존 스케줄 무효화  : 완료 (더 이상 낼 돈 없음)");
        System.out.println("====================================================\n");
    }
    // ==========================================
    // 🚨 [예외 테스트] 비정상적인 요청 디버깅
    // ==========================================

    @Test
    @DisplayName("실패 디버깅 1: 계좌 잔액이 상환액보다 부족할 경우")
    void testEarlyRepayLoan_Fail_InsufficientBalance() {
        // Given: 상환 요청액은 500만 원인데, 통장 잔고는 100만 원뿐인 상황
        UserEntity user = UserEntity.builder().id(1).build();
        Long repayAmount = 5000000L;

        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1).userId(1).outstandingAmount(10000000L).status("ACTIVE").build();

        AccountVo mockAccount = new AccountVo();
        mockAccount.setAccountId(10L);
        mockAccount.setUserId(1);
        mockAccount.setAccountNumber("111-222-333");
        mockAccount.setAccountPassword(BCrypt.hashpw("1234", BCrypt.gensalt())); // 비밀번호는 맞음
        mockAccount.setBalance(1000000L); // 🚨 잔고 100만 원 (부족함)
        mockAccount.setStatus("ACTIVE");

        when(loanMapper.selectLoanById(1)).thenReturn(mockLoan);
        when(accountMapper.selectAccountByAccountNumber("111-222-333")).thenReturn(mockAccount);

        // When
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "1234", repayAmount, user
        );

        // Then: 잔액 부족 실패 코드(FAILURE_INSUFFICIENT_BALANCE)가 떨어져야 함
        assertEquals(LoanResult.FAILURE_INSUFFICIENT_BALANCE, result.getLeft());

        // ✨ 가장 중요한 검증: 실패했으므로 계좌에서 돈이 빠져나가거나 대출금이 깎이는 쿼리가 절대 실행되면 안 됨!
        verify(accountMapper, never()).updateBalance(anyLong(), anyLong());
        verify(loanMapper, never()).updateOutstandingAmount(anyInt(), anyLong());
    }

    @Test
    @DisplayName("실패 디버깅 2: 계좌 비밀번호가 틀렸을 경우")
    void testEarlyRepayLoan_Fail_WrongPassword() {
        // Given: 사용자가 비밀번호를 "9999"로 잘못 입력한 상황
        UserEntity user = UserEntity.builder().id(1).build();
        Long repayAmount = 4000000L;

        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1).userId(1).outstandingAmount(10000000L).status("ACTIVE").build();

        AccountVo mockAccount = new AccountVo();
        mockAccount.setAccountId(10L);
        mockAccount.setAccountNumber("111-222-333");
        mockAccount.setAccountPassword(BCrypt.hashpw("1234", BCrypt.gensalt())); // 진짜 비밀번호는 1234
        mockAccount.setStatus("ACTIVE");

        when(loanMapper.selectLoanById(1)).thenReturn(mockLoan);
        when(accountMapper.selectAccountByAccountNumber("111-222-333")).thenReturn(mockAccount);

        // When: 비밀번호 파라미터에 "9999"를 전달
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "9999", repayAmount, user
        );

        // Then: 유효하지 않은 계좌(FAILURE_INVALID_ACCOUNT) 에러가 발생해야 함
        assertEquals(LoanResult.FAILURE_INVALID_ACCOUNT, result.getLeft());
        verify(accountMapper, never()).updateBalance(anyLong(), anyLong()); // 돈 출금 방어 확인
    }

    @Test
    @DisplayName("실패 디버깅 3: 이미 전액 상환(완제)된 대출에 또 상환하려는 경우")
    void testEarlyRepayLoan_Fail_AlreadyCompleted() {
        // Given: 대출 상태가 이미 "COMPLETED"인 경우
        UserEntity user = UserEntity.builder().id(1).build();

        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1).userId(1).outstandingAmount(0L)
                .status("COMPLETED") // 🚨 이미 갚은 대출
                .build();

        when(loanMapper.selectLoanById(1)).thenReturn(mockLoan);

        // When
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "1234", 100000L, user
        );

        // Then: 이미 완료된 대출(FAILURE_ALREADY_COMPLETED) 반환
        assertEquals(LoanResult.FAILURE_ALREADY_COMPLETED, result.getLeft());

        // 계좌 조회 자체를 시도조차 하지 않아야 함 (일찍 튕겨냈기 때문)
        verify(accountMapper, never()).selectAccountByAccountNumber(anyString());
    }

    @Test
    @DisplayName("실패 디버깅 4: 남의 대출을 상환하려고 시도할 경우 (권한 없음)")
    void testEarlyRepayLoan_Fail_Unauthorized() {
        // Given: 로그인한 유저는 ID가 1번인데, 대출의 주인은 ID가 99번인 경우
        UserEntity loginUser = UserEntity.builder().id(1).build();

        LoanEntity mockLoan = LoanEntity.builder()
                .loanId(1)
                .userId(99) // 🚨 대출 소유자가 다름!
                .outstandingAmount(10000000L).status("ACTIVE").build();

        when(loanMapper.selectLoanById(1)).thenReturn(mockLoan);

        // When
        Pair<LoanResult, LoanEntity> result = loanService.earlyRepayLoan(
                1, "111-222-333", "1234", 100000L, loginUser
        );

        // Then: 권한 없음(FAILURE_UNAUTHORIZED) 반환
        assertEquals(LoanResult.FAILURE_UNAUTHORIZED, result.getLeft());
        verify(accountMapper, never()).selectAccountByAccountNumber(anyString());
    }
}