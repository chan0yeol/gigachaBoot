package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AttendanceDaoImpl implements IAttendanceDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.AttendanceDaoImpl.";

	@Override
	public void createattendacetable() {
		sessionTemplate.insert(NS + "createattendacetable");
	}

	
	@Override
	public void dropSequence() {
		sessionTemplate.update(NS + "dropSequence");
		
	}
	
	@Override
	public void createSequence() {
		sessionTemplate.update(NS + "createSequence");
		
	}

	@Override
	public List<Map<String, Object>> leaveList(String empno) {
		List<Map<String, Object>> list = sessionTemplate.selectList(NS + "leaveListByEmpno", empno);
//		System.out.println(list);
		return list;
	}

	@Override
	public boolean workInCheck(Map<String, Object>  workInInfo) {
		sessionTemplate.update(NS + "workInCheck", workInInfo);
		return true;
	}
	
	@Override
	public boolean workOutCheck(Map<String, Object> workInInfo) {
		sessionTemplate.update(NS + "workOutCheck", workInInfo);
		return true;
	}
	
	@Override
	public List<Map<String, Object>> getAttendance(Map<String, Object> getempatt) {
	    // 여러 결과가 반환될 경우 selectList 사용
	    List<Map<String, Object>> employeeAttendancelist = sessionTemplate.selectList(NS + "loadworktime", getempatt);

	    System.out.println(employeeAttendancelist);
	    
	    return employeeAttendancelist;
	}

}
