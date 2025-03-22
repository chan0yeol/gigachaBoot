package com.giga.gw.dto;

import lombok.*;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeDto {
	private String empno,
			deptno,
			deptname,
			job_id,
			job_title,
			name,
			email,
			phone,
			tel,
			hiredate,
			birthday,
			gender,
			school,
			major_code,
			degree,
			adress,
			auth,
			create_date,
			create_emp,
			update_date,
			update_emp,
			use_yn;
}
