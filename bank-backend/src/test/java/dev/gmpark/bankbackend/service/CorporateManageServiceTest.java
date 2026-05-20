package dev.gmpark.bankbackend.service;

import dev.gmpark.bankbackend.dtos.CorporateManagementDto;
import dev.gmpark.bankbackend.entities.*;
import dev.gmpark.bankbackend.enums.LoanStatus;
import dev.gmpark.bankbackend.mappers.*;
import dev.gmpark.bankbackend.services.CorporateManageService;
import dev.gmpark.bankbackend.vos.AccountVo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.argThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CorporateManageServiceTest {

    @InjectMocks
    private CorporateManageService corporateManageService;

    @Mock
    private CorporateManageMapper corporateManageMapper;
    @Mock
    private LoanMapper loanMapper;
    @Mock
    private AccountMapper accountMapper;
    @Mock
    private TransactionHistoryMapper transactionHistoryMapper;
    @Mock
    private LoanScheduleMapper loanScheduleMapper;

    @Test
    @DisplayName("부도 처리 성공: 계좌 잔액 회수 및 대출 상태 변경 (BANKRUPTCY)")
    void testDeclareBankruptcy_Success() {
        // ==========================================
        // 1. Given (가상의 상황 설정 - Mocking)
        // ==========================================
        Integer userId = 26; // 부도 처리할 대상 유저 ID
        CorporateManagementDto dto = CorporateManagementDto.builder().userId(userId).build();

        // 1) 유저의 계좌 설정 (총 잔액 15만 원: 10만 + 5만)
        AccountVo account1 = new AccountVo();
        account1.setAccountId(1L);
        account1.setStatus("ACTIVE");
        account1.setBalance(100000L);

        AccountVo account2 = new AccountVo();
        account2.setAccountId(2L);
        account2.setStatus("ACTIVE");
        account2.setBalance(50000L);

        // 2) 유저의 활성 대출 설정 (총 대출 잔액 20만 원)
        LoanEntity loan1 = new LoanEntity();
        loan1.setLoanId(1);
        loan1.setOutstandingAmount(200000L);
        loan1.setStatus("ACTIVE");

        // 3) 대출 스케줄 설정
        // 1회차: 7만 원, 2회차: 8만 원
        LoanScheduleEntity schedule1 = new LoanScheduleEntity();
        schedule1.setRepayAmount(70000L);
        schedule1.setStatus("SCHEDULED");
        
        LoanScheduleEntity schedule2 = new LoanScheduleEntity();
        schedule2.setRepayAmount(80000L);
        schedule2.setStatus("SCHEDULED");

        // Mock 객체의 동작 정의 (어떤 메서드를 호출하면 이런 결과를 반환해라)
        when(accountMapper.selectAccountsByUserId(userId)).thenReturn(List.of(account1, account2));
        when(loanMapper.selectActiveAndOverdueLoansByUserId(userId)).thenReturn(List.of(loan1));
        
        // 연체된 스케줄은 없다고 가정
        when(loanScheduleMapper.findSchedulesByLoanIdAndStatus(1L, "OVERDUE")).thenReturn(Collections.emptyList());
        // 예정된 스케줄 반환
        when(loanScheduleMapper.findSchedulesByLoanIdAndStatus(1L, "SCHEDULED")).thenReturn(List.of(schedule1, schedule2));

        // ==========================================
        // 2. When (실제 부도 확정 서비스 로직 실행)
        // ==========================================
        corporateManageService.createCorporateBankruptcy(dto);

        // ==========================================
        // 3. Then (결과 검증)
        // ==========================================
        // 1) 모든 계좌의 잔액이 0원으로 업데이트 되었는지 확인 (강제 회수)
        verify(accountMapper).updateBalance(1L, 0L);
        verify(accountMapper).updateBalance(2L, 0L);
        
        // 2) 회수 내역이 거래 이력에 2건(계좌 2개) 기록되었는지 확인
        verify(transactionHistoryMapper, times(2)).insertTransaction(any(TransactionHistoryEntity.class));

        // 3) 회수한 총 금액(15만 원)으로 스케줄 2개(7만+8만=15만)가 PAID 상태로 업데이트 되었는지 확인
        verify(loanScheduleMapper, times(2)).updateScheduleStatus(any(LoanScheduleEntity.class));

        // 4) 대출금 차감 및 상태 변경 확인
        // 초기 대출금 20만 원 - 상환액 15만 원 = 남은 대출금 5만 원.
        // 잔액이 남았으므로 상태는 BANKRUPTCY가 되어야 함.
        verify(loanMapper).updateLoan(argThat(loan ->
                loan.getStatus().equals(LoanStatus.BANKRUPTCY.name()) &&
                loan.getOutstandingAmount() == 50000L
        ));

        // 5) 남은 미래 스케줄이 무효화(CANCELLED) 처리되었는지 확인
        verify(loanScheduleMapper).cancelFutureSchedules(1L);
        
        // 6) 기업 부도 이력이 기록되었는지 확인
        verify(corporateManageMapper).insert(any(CorporateManagementEntity.class));
    }
    
    @Test
    @DisplayName("부도 처리 성공: 잔액 부족 시 대출 상태만 변경 (BANKRUPTCY)")
    void testDeclareBankruptcy_InsufficientBalance() {
        // Given
        Integer userId = 26;
        CorporateManagementDto dto = CorporateManagementDto.builder().userId(userId).build();

        // 1) 유저의 계좌 잔액이 0원인 상황
        AccountVo account1 = new AccountVo();
        account1.setAccountId(1L);
        account1.setStatus("ACTIVE");
        account1.setBalance(0L); // 잔고 없음

        // 2) 대출은 존재함
        LoanEntity loan1 = new LoanEntity();
        loan1.setLoanId(1);
        loan1.setOutstandingAmount(200000L);
        loan1.setStatus("ACTIVE");

        when(accountMapper.selectAccountsByUserId(userId)).thenReturn(List.of(account1));
        when(loanMapper.selectActiveAndOverdueLoansByUserId(userId)).thenReturn(List.of(loan1));

        // When
        corporateManageService.createCorporateBankruptcy(dto);

        // Then
        // 1) 잔고가 0원이므로 계좌 잔고 업데이트나 거래 이력 기록이 발생하지 않아야 함
        verify(accountMapper, never()).updateBalance(anyLong(), anyLong());
        verify(transactionHistoryMapper, never()).insertTransaction(any(TransactionHistoryEntity.class));

        // 2) 대출 원금은 그대로 20만 원이고 상태만 BANKRUPTCY로 강제 전환됨
        verify(loanMapper).updateLoan(argThat(loan ->
                loan.getStatus().equals(LoanStatus.BANKRUPTCY.name()) &&
                loan.getOutstandingAmount() == 200000L
        ));
        
        // 3) 남은 스케줄은 여전히 취소되어야 함
        verify(loanScheduleMapper).cancelFutureSchedules(1L);
    }
}
