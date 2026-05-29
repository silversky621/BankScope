package com.bankscope.backend.controllers;

import com.bankscope.backend.dtos.CorporateManagementDto;
import com.bankscope.backend.dtos.CorporateRiskDto;
import com.bankscope.backend.results.CorporateManagementResult;
import com.bankscope.backend.services.CorporateManageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Tag(name = "부도 및 연체관리", description = "기업 관련 API")
@RestController
@RequestMapping(value = "/api/corporate")
@RequiredArgsConstructor
public class CorporateManagementController {

    private final CorporateManageService corporateManageService;

    @Operation(summary = "기업 부도 및 연체 내역 조회", description = "userId를 기반으로 기업의 정보(부도 및 연체 내역)를 조회합니다.")
    @RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String,Object> getCorporateInfo(@RequestParam("userId") Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            CorporateManagementDto data = corporateManageService.getCorporateInfoById(id);
            if (data == null) {
                result.put("result", CorporateManagementResult.FAILURE_NO_DATA.name());
                result.put("message", "해당 유저의 기업 정보를 찾을 수 없습니다.");
            } else {
                result.put("result", CorporateManagementResult.SUCCESS.name());
                result.put("data", data);
            }
        } catch (Exception e) {
            result.put("result", "FAILURE");
            result.put("message", "기업 정보 조회 중 오류가 발생했습니다.");
        }
        return result;
    }

    @Operation(summary = "기업 부도 확정 및 강제 상계 처리", description = "특정 기업(유저)의 부도 상황을 확정하고, 모든 계좌 잔고를 회수하여 대출금을 강제 상환(상계) 처리합니다. 남은 스케줄은 무효화(CANCELLED)되며 대출 상태는 부도(BANKRUPTCY)로 전환됩니다.")
    @RequestMapping(value = "/bankruptcy" , method =  RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public Map<String,Object> postCorporateBankruptcy(@RequestBody CorporateManagementDto dto) {
        Map<String, Object> result = new HashMap<>();
        try {
            CorporateManagementDto created = corporateManageService.createCorporateBankruptcy(dto);
            result.put("result", "SUCCESS");
            result.put("data", created);
            result.put("message", "부도 확정 및 강제 상계 처리가 완료되었습니다.");
        } catch (Exception e) {
            result.put("result", "FAILURE");
            result.put("message", "부도 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
        return result;
    }

    @Operation(summary = "기업 부도 위험 진단 조회", description = "userId를 기반으로 현재 대출 및 연체 상태를 분석하여 부도 위험도를 진단합니다.")
    @GetMapping(value = "/risk-status")
    public Map<String, Object> getCorporateRiskStatus(@RequestParam("userId") Integer userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            CorporateRiskDto data = corporateManageService.getCorporateRiskStatus(userId);
            if (data == null) {
                result.put("result", "FAILURE");
                result.put("message", "해당 유저 정보를 찾을 수 없습니다.");
            } else {
                result.put("result", "SUCCESS");
                result.put("data", data);
            }
        } catch (Exception e) {
            result.put("result", "ERROR");
            result.put("message", "부도 위험 진단 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace(); // 개발 중 확인을 위해 추가
        }
        return result;
    }
}
