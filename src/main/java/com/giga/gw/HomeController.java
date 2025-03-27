package com.giga.gw;


import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.IApprovalService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class HomeController {

	private final IApprovalService approvalService;

	@GetMapping("/")
	public String index(HttpSession session) {
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
