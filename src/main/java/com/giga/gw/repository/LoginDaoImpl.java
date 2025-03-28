package com.giga.gw.repository;

import com.giga.gw.dto.EmployeeDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@RequiredArgsConstructor
public class LoginDaoImpl implements ILoginDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.LoginDaoImpl.";
	
	@Override
	public EmployeeDto login(String empno) {
		return sessionTemplate.selectOne(NS+"login",empno);
	}

	@Override
	public String findEmpnoByNameAndEmail(Map<String, Object> map) {
		return sessionTemplate.selectOne(NS+"findEmpnoByNameAndEmail",map);
	}

}
