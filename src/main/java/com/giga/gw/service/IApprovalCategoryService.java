package com.giga.gw.service;

import java.util.List;

import com.giga.gw.dto.ApprovalCategoryDto;

public interface IApprovalCategoryService {
	int categoryInsert(ApprovalCategoryDto categoryDto);
	List<ApprovalCategoryDto> categorySelect();
	ApprovalCategoryDto categorySelectById(String category_id);
	int categoryCheck(String category_yname);
}
