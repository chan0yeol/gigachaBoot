package com.giga.gw.service;

import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalFormDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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
	public int formUpdateUseYN(Map<String, Object> map) {

		return approvalFormDao.formUpdateUseYN(map);
	}

	@Override
	public List<ApprovalFormDto> formSelectAll(Map<String, Object> map) {
		return approvalFormDao.formSelectAll(map);
	}

	@Override
	public ApprovalFormDto formSelectDetail(String form_id) {
		return approvalFormDao.formSelectDetail(form_id);
	}

	@Override
	public Map<String, Object> formSelectById(String form_id) {
		return approvalFormDao.formSelectById(form_id);
	}

	@Override
	public int cntFormSelectAll() {
		return approvalFormDao.cntFormSelectAll();
	}
	@Override
	public int cntFormSelectUser() {
		return approvalFormDao.cntFormSelectUser();
	}
}
