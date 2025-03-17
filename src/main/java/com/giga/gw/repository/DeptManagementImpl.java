package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.DepartmentDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeptManagementImpl implements IDeptManagementDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.giga.gw.repository.DeptManagementImpl.";

	@Override
	public int insertDepartment(Map<String, Object> map) {
		return session.insert(NS+"insertDepartment",map);
	}
	
	@Override
	public int duplicateCheck(String dto) {
		return session.selectOne(NS+"duplicateCheck",dto);
	}
	
	@Override
	public int insertHQDepartment(DepartmentDto dto) {
		return session.insert(NS+"insertHQDepartment",dto);
	}
	
	@Override
	public List<DepartmentDto> hqSelect() {
		return session.selectList(NS+"hqSelect");
	}

	@Override
	public int updateDept(DepartmentDto dto) {
		return session.update(NS+"updateDept",dto);
	}

	@Override
	public int deleteDept(List<String> dto) {
		return session.update(NS+"deleteDept", dto);
	}
	
	@Override
	public List<Map<String, Object>> getAllDept() {
		return session.selectList(NS+"getAllDept");
	}

	@Override
	public DepartmentDto getOneDept(String seq) {
		return session.selectOne(NS+"getOneDept", seq);
	}

	@Override
	public List<DepartmentDto> getSearchDept(Map<String, Object> map) {
		return session.selectList(NS+"getSearchDept", map);
	}

	@Override
	public List<DepartmentDto> getDeletedDept() {
		return session.selectList(NS+"getDeletedDept");
	}



	



 }
