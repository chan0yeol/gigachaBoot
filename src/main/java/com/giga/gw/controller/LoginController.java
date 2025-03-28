package com.giga.gw.controller;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.service.ILoginService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
//@RequestMapping("/employee")
public class LoginController {
	
	private final ILoginService loginService;
	private final WebSocketHandler webSocketHandler;

 	@GetMapping("/loginForm.do")
	public String login(HttpServletRequest request) {
		 // TODO RememberMe 쿠키
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("remember-me-cookie")) {
				log.info("remember-me-cookie : {}", cookie.getValue());
				return "redirect:/";
			}
		}

		return "login";
	}
	
	@PostMapping("/login.do")
	public String login(@RequestParam Map<String,Object> map, HttpSession session) {
		System.out.println(map.toString());
		log.info("전달값 : {}", map.toString());
		// TODO /login.do
//		EmployeeDto employeeDto = loginService.login(map);
//		System.out.println(employeeDto);

//		if(employeeDto == null) {
//
//			return "login";
//		}
//		session.setAttribute("loginDto", employeeDto);
        /*try {
            webSocketHandler.sendMessageToUser(employeeDto.getEmpno() , "메세지테스트");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }*/
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
	// 세션 만료 or 중복로그인 시 이동할 페이지
	@GetMapping("/expried.do")
	public String expried() {
		return "error/expried";
	}

}