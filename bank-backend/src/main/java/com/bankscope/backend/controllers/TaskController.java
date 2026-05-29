package com.bankscope.backend.controllers;

import com.bankscope.backend.dtos.TaskRequestDto;
import com.bankscope.backend.entities.MemberEntity;
import com.bankscope.backend.entities.UserEntity;
import com.bankscope.backend.results.CommonResult;
import com.bankscope.backend.results.TaskResult;
import com.bankscope.backend.services.TaskService;
import com.bankscope.backend.vos.TaskVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@Tag(name = "은행업무-키오스크(Task)", description = "은행 창구 접수 관련 API")
@RestController
@RequestMapping("/api/kiosk")
@RequiredArgsConstructor
public class TaskController {
    private final TaskService taskService;

    @Operation(summary = "대기표 발급", description = "업무 유형을 받아 대기표를 발급합니다.")
    @RequestMapping(value = "/task",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> createTask(@RequestBody TaskRequestDto requestDto, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity user = (UserEntity) session.getAttribute("user");

        if (user == null) {
            response.put("result", CommonResult.FAILURE.name());
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        TaskResult result = taskService.createTask(requestDto, user.getId());
        response.put("result", result.name());
        return response;
    }
    @Operation(summary = "대기표 발급 확인", description = "업무 유형입력하여 발급된 대기표를 고객이 확인하기 위한 api입니다. ( 고객의 가장 최근 데이터를 반환 )")
    @RequestMapping(value = "/task", method = RequestMethod.GET , produces =  MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> getTask(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            response.put("result", CommonResult.FAILURE.name());
            return response;
        }
        TaskVo task = taskService.getLatestTask(user.getId());
        if (task != null) {
            response.put("result", CommonResult.SUCCESS.name());
            response.put("task", task);
        } else {
            response.put("result", CommonResult.FAILURE.name());
        }
        return response;
    }
    @Operation(summary = "평균 대기 시간", description = "평균 대기 시간을 구하여 , 현재 창구 대기 시간을 반환합니다.")
    @RequestMapping(value = "/average-time", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String getAverageTime() {
        return taskService.getAverageTime();
    }
    @Operation(summary = "현재 대기 고객", description = "모든 대기 상태의 고객수를 반환합니다. ")
    @RequestMapping(value = "/waiting-count", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String getWaitingCount() {
        return String.valueOf(taskService.getTotalWaitingPerson());
    }
    @Operation(summary = "현재 운영중인 창구", description = "현재 로그인중인 멤버의 수를 반환합니다.")
    @RequestMapping(value = "/available-count", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String getAvailableCounter() {
        return String.valueOf(taskService.getAvailableMemberCount());
    }

    @Operation(summary = "창구 토스", description = "내가 처리할수 없는 업무 창구 토스하기 , task의 memberId와 WAITING 이나 IN_PROGRESS 상태인 업무를 WAITING으로 전환" )
    @RequestMapping(value = "/toss", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> tossTask(HttpSession session,
            @RequestParam(value = "taskId") Long taskId, 
            @RequestParam(value = "targetMemberId") Integer targetMemberId) {
        Map<String, Object> response = new HashMap<>();
        MemberEntity member = (MemberEntity) session.getAttribute("member");
        if (member == null) {
            response.put("result", TaskResult.FAILURE_SESSION.name());
            return response;
        }
        TaskResult result = this.taskService.tossTask(taskId, targetMemberId);
        response.put("result", result.name());
        return response;
    }

    // 강제 창구 이관
    @Operation(summary = "관리자용 창구 토스", description = "관리자가 업무를 강제로 다른 창구로 이관합니다." )
    @RequestMapping(value = "/toss-admin", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String,Object> tossTaskByAdmin ( HttpSession session,
                                                @RequestParam(value = "taskId") Long taskId,
                                                @RequestParam(value = "targetMemberId") Integer targetMemberId) {
        Map<String, Object> response = new HashMap<>();
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            response.put("result", TaskResult.FAILURE_SESSION.name());
            return response;
        }
        TaskResult result = this.taskService.tossTaskByAdmin(user,taskId, targetMemberId);
        response.put("result", result.name());
        return response;
    }

}