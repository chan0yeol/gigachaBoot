package com.giga.gw.controller;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.IDeptManagementDao;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.service.IApprovalService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/hrManagement")
public class HRManagementController {
	
	private final IApprovalService approvalDao;
	private final IEmployeeDao employeeDao;
	private final IDeptManagementDao deptManagementDao;
	
	// 마이페이지 - 사원 값 가져오기
	@GetMapping("/mypage.do")
	public String mypage(Model model, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		log.info("로그인 사번 : {}", loginDto);
		model.addAttribute("employee", loginDto);
		return "mypage";
	}
	
	// 사원 등록 - 페이지 요청
	@GetMapping("/employeeAdd.do")
	public String DeptManagement(Model model) {
		List<DepartmentDto> deptList = deptManagementDao.deptSelect();
		if (deptList != null && !deptList.isEmpty()) {
	        DepartmentDto firstDept = deptList.get(0);
	        log.info("첫번째 부서 정보 - deptno: {}, deptname: {}", 
	                firstDept.getDeptno(), firstDept.getDeptname());
	    } else {
	        log.info("조회된 부서 정보가 없습니다.");
	    }
		
		model.addAttribute("deptList", deptList);
		log.info("모델에 'deptList' 속성 추가 완료");
		return "employeeAdd";
	}
	
	// 사원 등록 - 사원번호 불러오기
	@GetMapping("/nextEmpno.do")
	@ResponseBody
	public String getNextEmpno(@RequestParam String hiredate) {
	    log.info("HRManagementController getNextEmpno Get 호출");
	    String employee = employeeDao.getNextEmpno(hiredate);
	    log.info("입사일자 불러오기{}",hiredate);
	    return employee != null ? employee : "";
	}
	
	// 사원 등록 - 사원 등록
	@PostMapping("/employeeAdd.do")
	@ResponseBody
	public String employeeResist(@RequestBody Map<String, Object> map, 
								HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		map.put("create_emp", loginDto.getEmpno());
		String empno = (String) map.get("empno");
		map.put("password", empno);
		System.out.println("hiredate: " + map.get("hiredate"));
		System.out.println("birthday: " + map.get("birthday"));
		log.info("비밀번호{}", empno);
		return employeeDao.insertEmployee(map)==1 ? "true":"false";
	}
	
	//조직도
	@ResponseBody
	@GetMapping("/tree.do")
	public List<Map<String, Object>> tree() {
		return approvalDao.getOrganizationTree();
	}
	
	@GetMapping("/hrManagement.do")
	public String hrManagerment() {
		return "hrManagement";
	}
	
	// 사원 리스트
	@GetMapping("/employeeList.do")
	@ResponseBody
	public List<EmployeeDto> employeeList() {
		log.info("사원 리스트 조회");
		return employeeDao.employeeList();
	}
	
	// 사원 조회
	@GetMapping("/empGet.do")
	@ResponseBody
	public EmployeeDto getOneEmp(@RequestParam("seq") String seq){
		log.info("HRManagementController getOneEmp GET 요청");
		EmployeeDto emp = employeeDao.getEmpno(seq);
		return emp;
	}

}
