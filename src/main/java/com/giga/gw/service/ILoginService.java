package com.giga.gw.service;

import com.giga.gw.dto.EmployeeDto;

import java.util.Map;

public interface ILoginService {
	
	EmployeeDto login(String empno);
	String findEmpnoByNameAndEmail(Map<String, Object> map);

}
