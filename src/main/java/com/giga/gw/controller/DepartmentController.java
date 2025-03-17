package com.giga.gw.controller;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.giga.gw.service.IDepartmentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/department")
@RequiredArgsConstructor
public class DepartmentController {
	
	private final IDepartmentService departmentService;
	
	@GetMapping("/tree.do")
	public List<Map<String, Object>> getTree(){
		return departmentService.getOrganizationTree();
	}
}
