package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class DepartmentDaoImpl implements IDepartmentDao {
	
	private final SqlSessionTemplate sqlSession;
	private final String NS ="com.giga.gw.DepartmentDaoImpl.";
	
	@Override
	public List<Map<String, Object>> getDepartments() {
		return sqlSession.selectList(NS+"getDepartments");
	}

	@Override
	public List<Map<String, Object>> getEmployeesByDepartment() {
		return sqlSession.selectList(NS+"getEmployeesByDepartment");
	}
	
}
