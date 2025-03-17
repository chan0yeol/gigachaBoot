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
public class ApprovalLineDto {
	String approval_id, reject_reason, create_date, status_id, approval_time, update_date, use_yn, signature,approver_empno, delegatee_empno;
	int line_id, sequence;
}
