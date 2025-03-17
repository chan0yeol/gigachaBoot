package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.EmployeeDto;

public interface IEmployeeDao {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(String empno);
	int updateSignature(String empno);
	
}
