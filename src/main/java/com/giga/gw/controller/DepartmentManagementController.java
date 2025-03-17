package com.giga.gw.controller;

import java.util.List;
import java.util.Map;


import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IDeptManagementDao;
import com.giga.gw.service.DepartmentServiceImpl;
import com.giga.gw.service.DeptManagementServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/deptManagement")
@Slf4j
public class DepartmentManagementController {
	
	private final IApprovalDao approvalDao;
	
	private final IDeptManagementDao deptManagementDao ;
	
	@GetMapping("/tree.json")
	@ResponseBody
	public List<Map<String, Object>> deptTree() {
		return deptManagementDao.getAllDept();
	}
	
	// 등록
	@PostMapping("/deptManagement.do")
	@ResponseBody
	public String insertDepartment(
		@RequestBody Map<String, Object> map, HttpSession session) {
		
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		map.put("create_emp", loginDto.getEmpno());
		log.info("♧♣♧♣♧♣♧♣ DepartmentManagementController insertDepartment POST 요청");
		System.out.println("\n\n"+map+"\n\n");
		return deptManagementDao.insertDepartment(map)==1 ?"true":"false";
	}
	
	// 중복검사
	@GetMapping("/deptCheck.do")
	@ResponseBody
	public boolean duplicateDetp(String deptname) {
		return deptManagementDao.duplicateCheck(deptname) == 0 ? true:false;
	}
	
	// select박스 값 가져오기
	@GetMapping("/deptManagement.do")
	public String hqSelct(Model model) {
		List<DepartmentDto> hqList = deptManagementDao.hqSelect();
		
		log.info("♧♣♧♣♧♣♧♣DepartmentManagementController hqSelct GET 요청");
		
		log.info("DAO 호출 후 결과 확인: hqList 널 여부: {}", (hqList == null));
	    log.info("조회된 본부 개수: {}", hqList != null ? hqList.size() : "null");
		if (hqList != null && !hqList.isEmpty()) {
	        DepartmentDto firstDept = hqList.get(0);
	        log.info("첫번째 부서 정보 - deptno: {}, deptname: {}", 
	                firstDept.getDeptno(), firstDept.getDeptname());
	    } else {
	        log.info("조회된 부서 정보가 없습니다.");
	    }
		
		model.addAttribute("hqList", hqList);
		log.info("모델에 'hqList' 속성 추가 완료");
		return "deptManagement";
	}
	
	// 값 가져오기
	@GetMapping("/deptGet.json")
	@ResponseBody
	public DepartmentDto getOneDept(@RequestParam("seq") String seq){
		
		log.info("♧♣♧♣♧♣♧♣DepartmentManagementController getOneDept GET 요청");
		
		DepartmentDto dept = deptManagementDao.getOneDept(seq);
		return dept;
	}
	
	
	
	
	
		
	
	
}
