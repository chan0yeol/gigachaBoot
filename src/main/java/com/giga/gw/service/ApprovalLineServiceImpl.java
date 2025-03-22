package com.giga.gw.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.dto.ApprovalDto;
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
	private final WebSocketHandler webSocketHandler;

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
				if(approvalDao.finalApprovalStatus(paramMap) == 1){
					try {
						ApprovalDto approvalDto = approvalDao.selectApprovalById(map.get("approval_id").toString());
						webSocketHandler.sendMessageToUser(approvalDto.getEmpno(),approvalDto.getApproval_title()+"문서에 대한 결재가 승인되었습니다.");
					} catch (IOException e) {
						throw new RuntimeException(e);
					}
					return true;
				}
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
			if(approvalDao.finalApprovalStatus(paramMap) == 1){

				ApprovalDto approvalDto = approvalDao.selectApprovalById(map.get("approval_id").toString());
				try {
					webSocketHandler.sendMessageToUser(approvalDto.getEmpno(),approvalDto.getApproval_title()+"문서에 대한 결재가 반려되었습니다. <br> 반려사유 : " + map.get("reject_reason").toString());
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
				return true;
			}
		}
		return false;
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
