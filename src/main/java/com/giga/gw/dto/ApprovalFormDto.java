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
public class ApprovalFormDto {
	String form_id,
	category_id,
	form_name,
	form_content,
	use_yn,
	create_date,
	update_date;
}
