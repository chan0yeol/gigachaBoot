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
public class DepartmentDto {

	private String deptno;
	private String deptname;
	private String parent_deptno;
	private String parent_deptname;
	private String use_yn;
	private String create_date;
	private String update_date;
	private String create_emp;
	private String update_emp;

}
