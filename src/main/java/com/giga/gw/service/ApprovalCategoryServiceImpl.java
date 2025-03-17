package com.giga.gw.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.ApprovalCategoryDto;
import com.giga.gw.repository.IApprovalCategoryDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalCategoryServiceImpl implements IApprovalCategoryService{
	private final IApprovalCategoryDao approvalCategoryDao;

	@Override
	public int categoryInsert(ApprovalCategoryDto categoryDto) {
		return approvalCategoryDao.categoryInsert(categoryDto);
	}

	@Override
	public List<ApprovalCategoryDto> categorySelect() {
		return approvalCategoryDao.categorySelect();
	}

	@Override
	public ApprovalCategoryDto categorySelectById(String category_id) {
		return approvalCategoryDao.categorySelectById(category_id);
	}

	@Override
	public int categoryCheck(String category_yname) {
		return approvalCategoryDao.categoryCheck(category_yname);
	}
	
}
