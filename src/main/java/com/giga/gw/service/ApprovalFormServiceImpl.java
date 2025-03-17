package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalFormDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalFormServiceImpl implements IApprovalFormService {
	private final IApprovalFormDao approvalFormDao;
	private final IApprovalDao approvalDao;

	@Override
	public int formInsert(ApprovalFormDto approvalFormDto) {
		return approvalFormDao.formInsert(approvalFormDto);
	}

	@Override
	public int formUpdate(ApprovalFormDto approvalFormDto) {
		int cnt = approvalDao.countApproval(approvalFormDto.getForm_id());

		return cnt == 0 ? approvalFormDao.formUpdate(approvalFormDto) : 0;
	}

	@Override
	public int formDelete(String form_id) {
		int cnt = approvalDao.countApproval(form_id);
		return cnt == 0 ? approvalFormDao.formDelete(form_id) : 0;
	}

	@Override
	public List<ApprovalFormDto> formSelectAll() {
		return approvalFormDao.formSelectAll();
	}

	@Override
	public ApprovalFormDto formSelectDetail(String form_id) {
		return approvalFormDao.formSelectDetail(form_id);
	}

	@Override
	public Map<String, Object> formSelectById(String form_id) {
		return approvalFormDao.formSelectById(form_id);
	}

}
