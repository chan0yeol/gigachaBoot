package com.giga.gw.service;

import com.giga.gw.dto.ApprovalCategoryDto;

import java.util.List;
import java.util.Map;

public interface IApprovalCategoryService {
	int categoryInsert(ApprovalCategoryDto categoryDto);
	List<ApprovalCategoryDto> categorySelect();
	List<ApprovalCategoryDto> categorySelectAll();
	ApprovalCategoryDto categorySelectById(String category_id);
	int categoryCheck(String category_yname);
	boolean categoryUpdateUseYN(Map<String, Object> map);
	int cntCategoryAll();
}
