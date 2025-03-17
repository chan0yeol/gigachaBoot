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
public class ApprovalReferenceDto {
	private String ref_id,
	approval_id,
	empno,
	create_date,
	use_yn,
	update_date;
}
