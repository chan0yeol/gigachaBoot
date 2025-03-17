package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ApprovalCategoryDto {
	private String category_id,
	category_name,
	category_yname,
	use_yn,
	create_date,
	update_date;
}
