package dev.gmpark.bankbackend.controllers;

import dev.gmpark.bankbackend.entities.EmailTokenEntity;
import dev.gmpark.bankbackend.entities.MemberEntity;
import dev.gmpark.bankbackend.entities.UserEntity;
import dev.gmpark.bankbackend.results.CommonResult;
import dev.gmpark.bankbackend.results.EmailResult;
import dev.gmpark.bankbackend.results.KioskResult;
import dev.gmpark.bankbackend.services.TaskService;
import dev.gmpark.bankbackend.services.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Tag(name = "회원(User)", description = "회원 가입 및 로그인 관련 API")
@RestController
@RequestMapping(value = "/api/user")
@RequiredArgsConstructor
public class  UserController {

    private final UserService userService;
    private final TaskService taskService;

    @Operation(summary = "회원가입", description = "이름, 이메일, 비밀번호, 주민번호를 받아 회원을 등록합니다. 기업회원의 경우 사업자 번호도 함께 입력해야하고 , 키오스크 가입 회원의 경우 웹사이트 회원으로 전환됩니다.")
    @RequestMapping(value = "/register", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postUserRegister(@RequestBody UserEntity user) {
        CommonResult result = this.userService.register(user);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }
    @Operation(summary = "비회원(키오스크) 회원가입", description = "주민번호, 이름만을 받아 회원을 등록합니다.")
    @RequestMapping(value = "/semi-register", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postUnregisteredUser(@RequestBody UserEntity user) {
        Map<String,Object> response = new HashMap<>();
        KioskResult result = this.userService.seminRegister(user);

        response.put("result",result.name());
        return response;
    }


    @Operation(summary = "비회원의 사업자등록", description = "워크스페이스에서 기업고객이 사업자번호를 등록합니다.")
    @RequestMapping(value = "/update-corporate", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String,Object> updateCorporate(@RequestParam(value = "identificationNumber") String identificationNumber,
                                              @RequestParam(value = "residentNumber") String residentNumber) {
        Map<String, Object> response = new HashMap<>();
        CommonResult result = this.userService.updateCorporateIdentification(identificationNumber, residentNumber);
        response.put("result", result.name());
        return response;
    }

    @Operation(summary = "멤버 등록", description = "멤버 정보를 받아 등록합니다.")
    @RequestMapping(value = "/member", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postMemberRegister(@RequestBody MemberEntity member) {
        CommonResult result = this.userService.registerMember(member);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }
    @Operation(summary = "멤버 삭제", description = "멤버를 삭제합니다.")
    @RequestMapping(value = "/member", method =  RequestMethod.DELETE, produces =  MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> deleteMember(@Param(value = "id") Long id) {
        CommonResult result = this.userService.deleteUser(id);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return  response;
    }

    @Operation(summary = "멤버 수정", description = "멤버 정보를 받아 수정합니다.")
    @RequestMapping(value = "/member", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> patchMember(@RequestBody MemberEntity member) {
        CommonResult result = this.userService.modifyMember(member);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }

    @Operation(summary = "멤버 목록 조회", description = "모든 멤버 정보를 조회합니다.")
    @GetMapping(value = "/members", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<MemberEntity> getMembers() {
        return this.userService.getMembers();
    }

    @Operation(summary = "로그인", description = "이메일, 비밀번호, 주민번호를 받아 로그인합니다.")
    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postLogin(@Param(value = "email") String email, @Param(value = "password") String password, @Param(value = "residentNumber") String residentNumber, HttpSession session) {

        UserEntity user = this.userService.login(email, password, residentNumber);
        Map<String, Object> response = new HashMap<>();
        if (user != null && ("customer".equals(user.getUserType()) || "corporate".equals(user.getUserType()))) {
            response.put("result", CommonResult.SUCCESS.name());
            session.setAttribute("user", user);
        } else {
            response.put("result", CommonResult.FAILURE.name());
        }
        return response;
    }

    @Operation(summary = "키오스크 로그인", description = "주민번호를 받아 로그인합니다.")
    @RequestMapping(value = "/kiosk/login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postKioskLogin(@Param(value = "residentNumber") String residentNumber, HttpSession session) {
        UserEntity user = this.userService.loginKiosk(residentNumber);
        Map<String, Object> response = new HashMap<>();

        /*if( !UserValidator.validateResidentNumber(residentNumber) ) {
            response.put("result", CommonResult.FAILURE.name());
            return response;
        }*/

        if (user != null) {
            if ("customer".equals(user.getUserType()) || "unregisterCustomer".equals(user.getUserType()) || "corporate".equals(user.getUserType())) {
                response.put("result", CommonResult.SUCCESS.name());
                session.setAttribute("user", user);
            } else {
                response.put("result", "FAILURE_NOT_ALLOWED");
            }
        } else {
            response.put("result", CommonResult.FAILURE.name());
        }

        return response;
    }
    @Operation(summary = "멤버 로그인", description = "이메일, 비밀번호를 받아 멤버 로그인을 합니다.")
    @RequestMapping(value = "/member/login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postMemberLogin(@Param(value = "email") String email, @Param(value = "password") String password, HttpSession session) {
        MemberEntity member = this.userService.loginMember(email, password);
        Map<String, Object> response = new HashMap<>();
        if (member != null) {
            response.put("result", CommonResult.SUCCESS.name());
            session.setAttribute("member", member);
        } else  {
            response.put("result", CommonResult.FAILURE.name());
        }
        return response;
    }

    @Operation(summary = "관리자 로그인", description = "이메일, 비밀번호를 받아 관리자 로그인을 합니다.")
    @RequestMapping(value = "/login-admin", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postAdminLogin(@Param(value = "email") String email, @Param(value = "password") String password, HttpSession session) {
        UserEntity user = this.userService.loginAdmin(email, password);
        Map<String, Object> response = new HashMap<>();
        if (user != null && "admin".equals(user.getUserType())) {
            response.put("result", CommonResult.SUCCESS.name());
            session.setAttribute("user", user);
        } else {
            response.put("result", CommonResult.FAILURE.name());
        }
        return response;
    }


    @Operation(summary = "세션 확인", description = "현재 로그인된 사용자의 정보를 반환합니다.")
    @RequestMapping(value = "/session", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> getSession(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        UserEntity user = (UserEntity) session.getAttribute("user");
        MemberEntity member = (MemberEntity) session.getAttribute("member");

        if (user != null) {
            response.put("result", "SUCCESS");
            response.put("type", "user");
            response.put("id", user.getId());
            response.put("email", user.getEmail());
            response.put("name", user.getName());
            response.put("userType", user.getUserType());
            response.put("residentNumber", user.getResidentNumber());
            response.put("identificationNumber", user.getIdentificationNumber());
            response.put("id", user.getId());
        } else if (member != null) {
            response.put("result", "SUCCESS");
            response.put("type", "member");
            response.put("email", member.getEmail());
            response.put("name", member.getName());
            response.put("level", member.getLevel());
            response.put("auth", member.getAuth());
            response.put("team", member.getTeam());

        } else {
            response.put("result", "FAILURE");
        }
        return response;
    }
    @Operation(summary = "유저정보조회", description = "유저의 id정보를 통해 유저정보를 조회합니다.")
    @RequestMapping(value = "/info", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getUserInfo(HttpSession session, @RequestParam(value = "userId") String userId) {
        MemberEntity member = (MemberEntity) session.getAttribute("member");
        Map<String, Object> response = new HashMap<>();
        if (member != null) {
            response.put("result", "SUCCESS");
        }

        Pair<CommonResult, UserEntity> result = this.userService.getUserInfo(Integer.valueOf(userId));
        if (result.getLeft() == CommonResult.SUCCESS) {
            response.put("result", "SUCCESS");
            response.put("user", result.getRight());
        }
        else {
            response.put("result", "FAILURE");
        }
        return response;

    }

    @Operation(summary = "로그아웃", description = "세션을 만료시킵니다.")
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postLogout(HttpSession session) {
        MemberEntity member = (MemberEntity) session.getAttribute("member");
        if (member != null) {
            this.taskService.reassignTasksOnMemberLogout(member.getId());
            this.userService.setMemberStatus(member.getEmail(), 0);
        }
        session.invalidate();
        Map<String, Object> response = new HashMap<>();
        response.put("result", "SUCCESS");
        return response;
    }

    // 비밀번호 변경
    @Operation(summary = "비밀번호 변경", description = "유저의 비밀번호를 변경합니다. oldPassword, newPassword(필수), name(선택) 을 json형태로 서버에 전송" )
    @RequestMapping(value = "/password", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> patchPassword(@RequestBody Map<String, String> requestBody, HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            return Map.of("result", CommonResult.FAILURE_SESSION.name());
        }

        String oldPassword = requestBody.get("oldPassword");
        String newPassword = requestBody.get("newPassword");
        String name = requestBody.get("name");

        if (oldPassword == null || newPassword == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("result", CommonResult.FAILURE.name());
            return response;
        }

        CommonResult result = this.userService.changePassword(user, oldPassword, newPassword, name);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }


    // 이메일 인증 api
    @Operation(summary = "이메일 보내기", description = "이메일 인증코드를 보냅니다. type이 register이면 중복 확인을 하고, password이면 중복 확인을 하지 않습니다.")
    @RequestMapping(value = "/email-send", method = RequestMethod.POST ,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> postEmailSend(
            @RequestParam("email") String email,
            @RequestParam(value = "type", defaultValue = "register") String type) {
        EmailResult result = this.userService.sendVerificationEmail(email, type);
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }

    @Operation(summary = "이메일 인증 코드 검증", description = "이메일과 코드를 받아 유효성을 검증합니다.")
    @RequestMapping(value = "/email-code-verify", method = RequestMethod.PATCH ,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> patchEmailCodeVerify(@RequestBody EmailTokenEntity emailToken) {
        EmailResult result = this.userService.verifyEmailCode(emailToken.getEmail(), emailToken.getCode());
        Map<String, Object> response = new HashMap<>();
        response.put("result", result.name());
        return response;
    }
}
