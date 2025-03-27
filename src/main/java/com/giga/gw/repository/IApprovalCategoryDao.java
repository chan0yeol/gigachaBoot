package com.giga.gw.repository;

import com.giga.gw.dto.ApprovalCategoryDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;


@Mapper
public interface IApprovalCategoryDao {
	int categoryInsert(ApprovalCategoryDto dto);
	List<ApprovalCategoryDto> categorySelect();
	List<ApprovalCategoryDto> categorySelectAll();
	ApprovalCategoryDto categorySelectById(String category_id);
	int categoryCheck(String category_yname);
	int categoryUpdateUseYN(Map<String, Object> map);
}
