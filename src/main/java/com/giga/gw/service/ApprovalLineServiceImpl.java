package com.giga.gw.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalLineDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalLineServiceImpl implements IApprovalLineService{
	private final IApprovalDao approvalDao;
	private final IApprovalLineDao approvalLineDao;

	@Override
	public boolean acceptApprovalLine(Map<String, Object> map) {
		System.out.println(map.get("approval_id"));
		int row = approvalLineDao.acceptApprovalLine(map);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("approval_id", map.get("approval_id").toString());
		paramMap.put("status_id", "ST04");
		int cnt = approvalLineDao.countApprovalLine(paramMap);
		int allCnt = approvalLineDao.countApprovalLine(map.get("approval_id").toString());
		System.out.println("\n\n"+cnt+"\n\n" + allCnt);
		if (row == 1) {
			if(cnt == allCnt) {
				return approvalDao.finalApprovalStatus(paramMap) == 1;
			} else {
				paramMap.put("status_id","ST03");
				return approvalDao.finalApprovalStatus(paramMap) == 1;
			}
		}
		return row == 1;
//		return approvalLineDao.acceptApprovalLine(map) == 1?true:false;
	}

	@Override
	public boolean rejectApprovalLine(Map<String, Object> map) {
		int row = approvalLineDao.rejectApprovalLine(map);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("approval_id", map.get("approval_id").toString());
		paramMap.put("status_id", "ST05");
		int cnt = approvalLineDao.countApprovalLine(paramMap);
//		int allCnt = approvalLineDao.countApprovalLine(map.get("approval_id").toString());
//		System.out.println("\n\n"+cnt+"\n\n");
		if (row == 1 || cnt > 0) {
			return approvalDao.finalApprovalStatus(paramMap) == 1;
		}
		return row == 1;
//		return approvalLineDao.rejectApprovalLine(map) == 1 ? true:false;
	}

	@Override
	public boolean insertSaveLine(Map<String, Object> map) {
		
		return approvalLineDao.insertSaveLine(map) == 1;
	}

	@Override
	public List<Map<String, Object>> selectSaveLine(String empno) {
		return approvalLineDao.selectSaveLine(empno);
	}

	
	
}
