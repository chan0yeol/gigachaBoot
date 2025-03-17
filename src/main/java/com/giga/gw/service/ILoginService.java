package com.giga.gw.service;

import java.util.Map;

import com.giga.gw.dto.EmployeeDto;

public interface ILoginService {
	
	EmployeeDto login(Map<String, Object> map);
	String findEmpnoByNameAndEmail(Map<String, Object> map);

}
