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
public class CalendarDto {

	private int 
	sch_id, //스케줄 아이디
	empno,  // 사원번호
	create_empno, //생성자
	update_empno; //수정자
	
	private String 
	sch_repeat, //반복여부
	allday, //종일 일정
	use_yn, // 사용여부
	sch_title, // 제목
	sch_content, //내용
	sch_category, // 카테고리
	sch_status, // 상태 (예정, 진행, 종료)
	sch_condition, // 
	sch_color, //스케줄 컬러
	sch_startdate, // 시작일
	sch_enddate, // 종료일
	create_date, //최초 생성일
	update_date; //수정일

}
