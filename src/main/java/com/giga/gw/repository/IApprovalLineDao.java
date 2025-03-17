package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalLineDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IApprovalLineDao {
	int insertApprovalLines(Map<String, Object> map);
	int insertApprovalLine(ApprovalLineDto line);
	int acceptApprovalLine(Map<String, Object> map);
	int rejectApprovalLine(Map<String, Object> map);
	int countApprovalLine(String approval_id);
	int countApprovalLine(Map<String, Object> map);
	int deleteApprovalLine(String approval_id);
	int insertSaveLine(Map<String, Object> map);
	List<Map<String, Object>> selectSaveLine(String empno);
}
