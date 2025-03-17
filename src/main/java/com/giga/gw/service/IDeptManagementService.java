package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.DepartmentDto;

public interface IDeptManagementService {
	
		// 부서 등록
		public int insertDepartment(Map<String, Object> map);
		// 중복 검사
		public int duplicateCheck(String dto);
		// 부서 수정
		public int updateDept(DepartmentDto dto);
		// 부서 삭제
		public int deleteDept(List <String> dto);
		// 부서 전체 조회
		public List<Map<String, Object>> getAllDept();
		// 부서 상세 조회
		public DepartmentDto getOneDept(String dto);
		// 부서 검색
		public List<DepartmentDto> getSearchDept(Map<String, Object>map);
		// 삭제된 부서 조회
		public List<DepartmentDto> getDeletedDept();

}
