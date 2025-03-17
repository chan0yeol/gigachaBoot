package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

public interface IDepartmentDao {
	List<Map<String, Object>> getDepartments();
    List<Map<String, Object>> getEmployeesByDepartment();
}
