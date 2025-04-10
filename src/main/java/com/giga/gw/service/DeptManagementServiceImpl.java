package com.giga.gw.service;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.repository.IDeptManagementDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeptManagementServiceImpl implements IDeptManagementService{
	
	private final IDeptManagementDao deptManagementDao;

	@Override
	public int insertDepartment(Map<String, Object> map) {
		return deptManagementDao.insertDepartment(map);
	}
	
	@Override
	public int duplicateCheck(String dto) {
		return deptManagementDao.duplicateCheck(dto);
	}
	
	@Override
	public int updateDept(Map<String, Object> map) {
		return deptManagementDao.updateDept(map);
	}

	@Override
	public List<Map<String, Object>> getAllDept() {
		return deptManagementDao.getAllDept();
	}

	@Override
	public DepartmentDto getOneDept(String dto) {
		return deptManagementDao.getOneDept(dto);
	}

	@Override
	public List<DepartmentDto> getSearchDept(Map<String, Object> map) {
		return deptManagementDao.getSearchDept(map);
	}

	@Override
	public List<DepartmentDto> getDeletedDept() {
		return deptManagementDao.getDeletedDept();
	}



}
