package com.giga.gw.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.repository.IDepartmentDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class DepartmentServiceImpl implements IDepartmentService {
	private final IDepartmentDao departmentDao;

	@Override
	public List<Map<String, Object>> getOrganizationTree() {
		List<Map<String, Object>> departmentList = departmentDao.getDepartments();
        List<Map<String, Object>> employeeList = departmentDao.getEmployeesByDepartment();

        List<Map<String, Object>> treeData = new ArrayList<>();
     // 직원 데이터 변환
        for (Map<String, Object> emp : employeeList) {
            emp.put("id", String.valueOf(emp.get("id"))); // 직원 ID 변환
            emp.put("text", emp.get("text")); // 직원 이름
            emp.put("parent", String.valueOf(emp.get("parent"))); // 부서 ID 그대로 사용

            treeData.add(emp);
        }
        treeData.addAll(departmentList); // 부서 추가
        // treeData.addAll(employeeList);   // 사원 추가
        System.out.println(treeData);
		return treeData;
	}
	
}
