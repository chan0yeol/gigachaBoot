package com.giga.gw.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.IEmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

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
	
	

	

