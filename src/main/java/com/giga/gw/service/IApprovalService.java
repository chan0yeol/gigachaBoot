package com.giga.gw.service;

import com.giga.gw.dto.ApprovalDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface IApprovalService {
	List<Map<String, Object>> getOrganizationTree();
	int countApproval(String form_id);
	boolean insertApproval(ApprovalDto approvalDto, List<MultipartFile> files, String path);
	boolean insertApprovalTemp(ApprovalDto approvalDto, List<MultipartFile> files);
    int updateApproval(ApprovalDto approvalDto, List<MultipartFile> files);
    ApprovalDto selectApprovalById(String approval_id);
    int recallApproval(String approval_id);
    List<Map<String, Object>> formTree();
    List<ApprovalDto> selectApproval(int empno);
    List<ApprovalDto> selectApprovalTemp(String empno);
    int approvalRequest(String approval_id);
    List<ApprovalDto> selectPendingApprovalDocuments(String empno);
    List<ApprovalDto> selectApprovalInProgress(String empno);
    List<ApprovalDto> selectApprovalCompleted(String empno);
    List<ApprovalDto> selectApprovalRejected(String empno);
    List<Map<String, Object>> selectApprovalMyDocuments(String empno);
    List<Map<String, Object>> selectApprovalReference(String empno);
    Map<String, Object> selectApprovalLineStats (String empno);
    Map<String, Object> selectApprovalStats (String empno);
}
