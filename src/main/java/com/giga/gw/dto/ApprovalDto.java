package com.giga.gw.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ApprovalDto {
	String approval_id,
			form_id,
			approval_title,
			approval_content,
			approval_status,
			create_date,
			update_date,
			use_yn,
			approval_deadline,
			approval_urgency,
			temp_save_yn,
			start_date,
			end_date,
			empno,
			name,
			dname,
			rejectEmpName,
			update_empno;
	List<ApprovalLineDto> approvalLineDtos;
	List<ApprovalReferenceDto> approvalReferenceDtos;
}
