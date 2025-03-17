package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NoticeDto {

	private String notice_id;
	private int empno;
	private String title;
	private String board_code;
	private String create_date;
	private String update_date;
	private int view_count;
	private int update_emp;
	private String content;
	private String important;
	private String board_status;
	private String use_yn;

}
