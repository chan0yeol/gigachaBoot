package com.giga.gw.service;

import java.util.List;
import java.util.Map;

public interface IApprovalLineService {
	boolean acceptApprovalLine(Map<String, Object> map);
	boolean rejectApprovalLine(Map<String, Object> map);
	boolean insertSaveLine(Map<String, Object> map);
	List<Map<String, Object>> selectSaveLine(String empno);
}
