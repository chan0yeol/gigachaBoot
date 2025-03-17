package com.giga.gw.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.EmployeeDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LoginDaoImpl implements ILoginDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.LoginDaoImpl.";
	
	@Override
	public EmployeeDto login(Map<String, Object> map) {
		return sessionTemplate.selectOne(NS+"login",map);
	}

	@Override
	public String findEmpnoByNameAndEmail(Map<String, Object> map) {
		return sessionTemplate.selectOne(NS+"findEmpnoByNameAndEmail",map);
	}

}
