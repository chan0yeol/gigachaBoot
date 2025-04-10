package com.giga.gw.repository;

import com.giga.gw.dto.ApprovalFormDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface IApprovalFormDao {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formUpdateUseYN(Map<String, Object> map);
	List<ApprovalFormDto> formSelectAll(Map<String, Object> map);
	ApprovalFormDto formSelectDetail(String form_id);
	Map<String, Object> formSelectById(String form_id);
	int cntFormSelectAll();
	int cntFormSelectUser();
}
