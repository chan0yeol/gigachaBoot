package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IApprovalDao {
	List<Map<String, Object>> getDepartments();
    List<Map<String, Object>> getEmployeesByDepartment();
    List<Map<String, Object>> getOrganizationTree();
    int editorSave(String content);
    String editorRead();
    
    int countApproval(String form_id);
    int insertApproval(ApprovalDto approvalDto);
    int insertApprovalTemp(ApprovalDto approvalDto);
    int updateApproval(ApprovalDto approvalDto);
    
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
    
    int finalApprovalStatus(Map<String, Object> map);
    
    List<Map<String, Object>> postLeaveToCalendar(String empno);
    
    int insertApprovalReferences(Map<String, Object> references);
}
