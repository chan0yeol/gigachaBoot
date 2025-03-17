package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalFormDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IApprovalFormDao {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formDelete(String form_id);
	List<ApprovalFormDto> formSelectAll();
	ApprovalFormDto formSelectDetail(String form_id);
	Map<String, Object> formSelectById(String form_id);
}
