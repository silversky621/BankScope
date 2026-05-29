package com.bankscope.backend.controllers;


import com.bankscope.backend.entities.TransactionHistoryEntity;
import com.bankscope.backend.results.TransactionResult;
import com.bankscope.backend.services.TransactionHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@Tag(name = "거래내역(TransactionHistory)", description = "거래내역 관련 API")
@RestController
@RequestMapping(value = "/api/transaction")
@RequiredArgsConstructor
public class TransactionHistoryController {
    private final TransactionHistoryService transactionHistoryService;

    @Operation(summary = "입금", description = "계좌번호와 금액을 받아 입금을 처리합니다.")
    @RequestMapping(value = "/deposit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postDeposit(@RequestParam(value = "accountNumber") String accountNumber,
                                           @RequestParam(value = "amount") Long amount,
                                           @RequestParam(value = "description", required = false, defaultValue = "입금") String description,
                                           @RequestParam(value = "taskId", required = false) Long taskId) {
        Map<String, Object> response = new HashMap<>();
        Pair<TransactionResult, TransactionHistoryEntity> result = this.transactionHistoryService.deposit(accountNumber, amount, description, taskId);
        response.put("result", result.getLeft().name());
        if (result.getLeft() == TransactionResult.SUCCESS) {
            response.put("transaction", result.getRight());
        }
        return response;
    }

    @Operation(summary = "출금", description = "계좌번호, 비밀번호, 금액을 받아 출금을 처리합니다.")
    @RequestMapping(value = "/withdraw", method = RequestMethod.POST, produces =  MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postWithdraw(@RequestParam(value = "accountNumber") String accountNumber,
                                            @RequestParam(value = "accountPassword") String accountPassword,
                                            @RequestParam(value = "amount") Long amount,
                                            @RequestParam(value = "description", required = false, defaultValue = "출금") String description,
                                            @RequestParam(value = "taskId", required = false) Long taskId) {
        Map<String, Object> response = new HashMap<>();
        Pair<TransactionResult, TransactionHistoryEntity> result = this.transactionHistoryService.withdraw(accountNumber, accountPassword, amount, description, taskId);
        response.put("result", result.getLeft().name());
        if (result.getLeft() == TransactionResult.SUCCESS) {
            response.put("transaction", result.getRight());
        }
        return response;
    }

    @Operation(summary = "이체하기", description = "출금계좌, 비밀번호, 입금계좌, 금액을 받아 이체를 처리합니다.")
    @RequestMapping(value = "/transfer", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postTransfer(@RequestParam(value = "fromAccountNumber") String fromAccountNumber,
                                            @RequestParam(value = "accountPassword") String accountPassword,
                                            @RequestParam(value = "toAccountNumber") String toAccountNumber,
                                            @RequestParam(value = "amount") Long amount,
                                            @RequestParam(value = "description", required = false, defaultValue = "이체") String description,
                                            @RequestParam(value = "taskId", required = false) Long taskId) {
        Map<String, Object> response = new HashMap<>();
        Pair<TransactionResult, TransactionHistoryEntity> result = this.transactionHistoryService.transfer(fromAccountNumber, accountPassword, toAccountNumber, amount, description, taskId);
        response.put("result", result.getLeft() != null ? result.getLeft().name() : "FAILURE");
        if (result.getLeft() == TransactionResult.SUCCESS) {
            response.put("transaction", result.getRight());
        }
        return response;
    }

    // 자동납부
    /*1. 자동 납부 (Batch/Scheduled Process)
    주로 대출 이자나 원금 상환, 적금 납입 등에 사용됩니다. loan 테이블의 payment_day 컬럼이 핵심 기준이 됩니다.

            로직 흐름
    대상 조회: 매일 자정 혹은 특정 시간에 스케줄러(Spring Task, Quartz 등)가 실행되어, 오늘이 납입일(payment_day)인 ACTIVE 상태의 대출을 조회합니다.

    잔액 확인: loan의 linked_account_id를 통해 연결된 account 테이블의 balance가 outstanding_amount 또는 이자를 감당할 수 있는지 확인합니다.

    트랜잭션 처리 (중요):

    계좌 잔액 차감: account.balance에서 납부 금액만큼 감액합니다.

    대출 정보 갱신: loan.outstanding_amount를 업데이트하고 updated_at을 갱신합니다.

    이력 생성: transaction_history에 해당 거래 내역을 WITHDRAWAL 또는 LOAN_PAYMENT 타입으로 기록합니다.

    실패 처리: 잔액 부족 시 loan.overdue_amount를 증가시키거나 overdue_date를 기록하는 로직이 필요합니다.*/
    // 수동납부(웹사이트)
    /*2. 수동 납부 (Manual/Instant Payment)
    사용자가 앱이나 웹에서 직접 '납부하기' 버튼을 눌러 처리하는 방식입니다.

    로직 흐름
    요청 수신: 사용자 ID, 계좌 비밀번호, 납부할 금액, 대상(대출 ID 등)을 입력받습니다.

    검증: * user_pin 또는 account_password를 검증합니다.

    account.balance가 요청 금액보다 큰지 확인합니다.

            처리:

    계좌 출금: account 테이블 수정.

    대상 업데이트: 납부한 만큼 상환액 반영.

    로그 기록: transaction_history와 더불어, 은행 창구 업무였다면 task 및 task_processing_log에도 기록을 남겨 업무 증빙을 할 수 있습니다.*/

    /*창구납부 ( 대출금액 미납된 금액 수납 할수 있게하기 )*/
    /*기업 대출 미납금액 수납 및 납부    */
    // 미납금액 확인 하기
}
