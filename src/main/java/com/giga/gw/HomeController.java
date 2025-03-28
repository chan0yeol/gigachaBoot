package com.giga.gw;


import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.IApprovalService;
import com.giga.gw.service.ILoginService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {

	private final IApprovalService approvalService;
	private final ILoginService loginService;

	@GetMapping("/")
	public String index(@AuthenticationPrincipal UserDetails user, HttpSession session) {
		log.info("권한 : !!!! {} ", user.getAuthorities());
		EmployeeDto loginDto = loginService.login(user.getUsername());
		session.setAttribute("loginDto", loginDto);
		return "index";
	}

	@GetMapping("/editor.do")
	public String editor() {
		return "editor";
	}
	@GetMapping("/tree.do")
	public String tree() {
		return "tree";
	}
	@GetMapping("/ckeditor.do")
	public String ckeditor() {
		return "ckEditor";
	}
	@GetMapping(value = "/approvalChartDataAjax.do", produces = "application/json")
	public ResponseEntity<Map<String, Object>> getApprovalChartData(HttpSession session) {
		EmployeeDto loginDto =(EmployeeDto) session.getAttribute("loginDto");
		Map<String, Object> response = new HashMap<>();

		// 내가 결재한 문서 상태 개수 조회
		Map<String, Object> approvalLineStats = approvalService.selectApprovalLineStats(loginDto.getEmpno());

		// 내가 기안한 문서 상태 개수 조회
		Map<String, Object> approvalStats = approvalService.selectApprovalStats(loginDto.getEmpno());

		response.put("approvalLine", approvalLineStats);
		response.put("approval", approvalStats);

		return ResponseEntity.ok().body(response);
	}


}
