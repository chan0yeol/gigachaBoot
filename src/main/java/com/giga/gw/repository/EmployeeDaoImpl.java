package com.giga.gw.repository;

import com.giga.gw.dto.EmployeeDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Slf4j
@RequiredArgsConstructor
public class EmployeeDaoImpl implements IEmployeeDao {
	
	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.EmployeeDaoImpl.";
	
	@Override
	public boolean saveSignature(Map<String, Object> map) {
		return sql.insert(NS+"saveSignature",map)==1?true:false;
	}

	@Override
	public List<Map<String, Object>> readSignature(String empno) {
		return sql.selectList(NS+"readSignature",empno);
	}

	@Override
	public int updateSignature(String empno) {
		return sql.update(NS+"updateSignature",empno);
	}
	
	@Override
	public String getNextEmpno(String empno) {
		return sql.selectOne(NS+"getNextEmpno", empno);
	}

	@Override
	public int insertEmployee(Map<String, Object> map) {
		return sql.insert(NS+"insertEmployee", map);
	}

	@Override
	public List<EmployeeDto> employeeList() {
		return sql.selectList(NS+"employeeList");
	}
	
	@Override
	public EmployeeDto getEmpno(String empno) {
		return sql.selectOne(NS+"getEmpno", empno);
	}

	@Override
	public EmployeeDto getMypage(String empno) {
		return sql.selectOne(NS+"getMypage", empno);
	}

	

	



}
