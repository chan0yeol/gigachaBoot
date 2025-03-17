package com.giga.gw.controller;

import java.util.HashMap;
import java.util.Map;


import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.ILoginService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
//@RequestMapping("/employee")
public class LoginController {
	
	private final ILoginService loginService;
	
 	@GetMapping("/login.do")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login.do")
	public String login(@RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(map.toString());
		EmployeeDto employeeDto = loginService.login(map);
		System.out.println(employeeDto);
		
		if(employeeDto == null) {
			
			return "login";
		}
		session.setAttribute("loginDto", employeeDto);

		return "redirect:/";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
//		EmployeeDto dto = (EmployeeDto)session.getAttribute("loginDto");
//		session.removeAttribute("loginDto");
		session.invalidate(); // 세션 초기화
		return "redirect:/login.do";
	}
	
	@PostMapping("/findEmpno.do")
	@ResponseBody
	public Map<String, Object> findEmpno(@RequestParam Map<String, Object> map) {
	    log.info("LoginController /findEmpno.do POST 사원번호 찾기 : {}", map);
	    
	    String empno = loginService.findEmpnoByNameAndEmail(map);
	    Map<String, Object> response = new HashMap<>();
	    
	    if (empno != null) {
	        response.put("msg", empno);  // 사원번호 반환
	    } else {
	        response.put("msg", "사원번호를 찾을 수 없습니다.");
	    }
	    
	    return response;  // JSON 형태로 반환
	}

	
//	@PostMapping("/findEmpno.do")
//	@ResponseBody
//	public String findEmpno(@RequestParam Map<String, Object> map) {
//		log.info("LoginController /findEmpno.do POST 사원번호 찾기 : {}",map);
//		String empno = loginService.findEmpnoByNameAndEmail(map);
//		return empno;
//	}
	
//	 @PostMapping("/findEmpno")
//	    public ResponseEntity findEmpno(@RequestParam String name,String email) {
//	        String empno = loginService.findEmpnoByNameAndEmail(name, email);
//	        
//	        if (empno != null) {
//	            return ResponseEntity.ok(empno);
//	        } else {
//	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("사원번호를 찾을 수 없습니다.");
//	        }
//	    }


}