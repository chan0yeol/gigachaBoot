package com.giga.gw.service;

import com.giga.gw.dto.EmployeeDto;

import java.util.List;
import java.util.Map;

public interface IEmployeeService {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(String empno);
	// 사번 다음 값
	String getNextEmpno(String hiredate);
	// 사원 리스트
	List<EmployeeDto> employeeList();
	// 사원 조회
	EmployeeDto getEmpno(String empno);
	// 마이페이지 조회
	EmployeeDto getMypage(String empno); 
	}

