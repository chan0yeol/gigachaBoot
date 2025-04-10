package com.giga.gw.repository;

import com.giga.gw.dto.EmployeeDto;

import java.util.List;
import java.util.Map;

public interface IEmployeeDao {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(String empno);
	int updateSignature(String empno);
	
	// empno 값 가져오기
	String getNextEmpno(String empno);
	
	// 사원 등록
	int insertEmployee(Map<String, Object> map);
	
	// 사원 리스트
	List<EmployeeDto> employeeList();
	
	// 사원 조회
	EmployeeDto getEmpno(String empno);
	
	// 마이페이지 조회
	EmployeeDto getMypage(String empno); 
	
	// 프로필 업로드
	
	
	// 프로필 업데이트
}
