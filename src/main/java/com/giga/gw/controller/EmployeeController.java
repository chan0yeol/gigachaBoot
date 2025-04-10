package com.giga.gw.controller;

import com.giga.gw.service.IEmployeeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class EmployeeController {
	
	private final IEmployeeService employeeService;
	
	@GetMapping("/grid.do")
	public String grid(){
		return "grid";
	}
	
	@GetMapping("/droppable.do")
	public String droppable(){
		return "droppable";
	}
	
	

	}
	
	

	

