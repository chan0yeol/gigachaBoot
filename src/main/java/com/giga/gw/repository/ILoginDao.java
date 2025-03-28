package com.giga.gw.repository;

import com.giga.gw.dto.EmployeeDto;

import java.util.Map;

public interface ILoginDao {

	EmployeeDto login(String empno);
	String findEmpnoByNameAndEmail(Map<String, Object> map);
}
