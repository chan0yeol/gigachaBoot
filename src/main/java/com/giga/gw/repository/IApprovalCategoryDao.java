package com.giga.gw.repository;

import java.util.List;

import com.giga.gw.dto.ApprovalCategoryDto;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface IApprovalCategoryDao {
	int categoryInsert(ApprovalCategoryDto dto);
	List<ApprovalCategoryDto> categorySelect();
	ApprovalCategoryDto categorySelectById(String category_id);
	int categoryCheck(String category_yname);
}
