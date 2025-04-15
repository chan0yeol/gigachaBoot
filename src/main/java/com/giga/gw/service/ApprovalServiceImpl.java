package com.giga.gw.service;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.dto.ApprovalLineDto;
import com.giga.gw.dto.ApprovalReferenceDto;
import com.giga.gw.dto.FileDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalLineDao;
import com.giga.gw.repository.IFileDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {

	private final IApprovalDao approvalDao;
	private final IApprovalLineDao approvalLineDao;
	private final IFileDao fileDao;
	private final WebSocketHandler webSocketHandler;

	@Override
	public List<Map<String, Object>> getOrganizationTree() {
		return approvalDao.getOrganizationTree();
	}

	@Override
	public int countApproval(String form_id) {
		return approvalDao.countApproval(form_id);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean insertApproval(ApprovalDto approvalDto, List<MultipartFile> files, String path) { // TODO 파일
		int n = approvalDao.insertApproval(approvalDto); // 문서 row
		int m = 0; // 결재선 row
		int f = 0; // 파일 row
		int r = 0; // 참조자 row

		// 결재선 추가 로직
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos != null && !lineDtos.isEmpty()) {
			for (ApprovalLineDto line : lineDtos) {
				line.setApproval_id(approvalDto.getApproval_id());
				System.out.println(line.getApprover_empno());
			}
			Map<String, Object> map = new HashedMap<String, Object>();
			map.put("approval_id", approvalDto.getApproval_id());
			map.put("approvalLineDtos", lineDtos);
			m = approvalLineDao.insertApprovalLines(map);
		}

		// 참조자 추가 로직
		List<ApprovalReferenceDto> approvalReferenceDtos = approvalDto.getApprovalReferenceDtos();
		if (approvalReferenceDtos != null && !approvalReferenceDtos.isEmpty()) {
			for (ApprovalReferenceDto refDto : approvalReferenceDtos) {
				refDto.setApproval_id(approvalDto.getApproval_id());
				System.out.println(refDto.getEmpno());
			}

			Map<String, Object> refMap = new HashedMap<String, Object>();
			refMap.put("approval_id", approvalDto.getApproval_id());
			refMap.put("approvalReferenceDtos", approvalReferenceDtos);
			r = approvalDao.insertApprovalReferences(refMap);
		}


		if (files.get(0).getSize() == 0) {
	        return n == 1 && m >= 1;
	    }

//		if(files != null && files.size() != 0) {
			File storage = new File(path);
			if (!storage.exists()) {
	            storage.mkdirs(); // 경로가 없으면 생성
	        }
			String result = "파일 업로드 성공";
			List<FileDto> fileDtos = new ArrayList<>();
	        try {
	            for (MultipartFile file : files) {
	                String originalFileName = file.getOriginalFilename(); // 원본 파일명
	                String saveFileName = UUID.randomUUID().toString() + originalFileName.substring(originalFileName.lastIndexOf(".")); // 고유한 이름으로 저장

	                File saveFile = new File(path, saveFileName);
	                file.transferTo(saveFile); // 파일을 저장
	                FileDto fileDto = FileDto
							.builder()
							.approval_id(approvalDto.getApproval_id())
							.origin_name(file.getOriginalFilename())
							.file_name(saveFileName)
							.file_path(path)
							.create_emp(approvalDto.getEmpno())
							.code("FILE01")
							.build();
					fileDtos.add(fileDto);
	                log.info("파일 저장 완료: {}", saveFileName);
	                System.out.println("\n\n " + fileDtos.toString() + "\n\n");

	            }
	        } catch (IOException e) {
	            log.error("파일 저장 중 오류 발생", e);
	            result = "파일 업로드 실패";
	        }

	        if(!fileDtos.isEmpty()) {
				f = fileDao.insertFile(fileDtos);
			}
	        return n == 1 && m >= 1 && (fileDtos.isEmpty() || f == fileDtos.size());
		}
//	else {
//			return n == 1 && m >= 1;
//		}

//	}

//	@Transactional
	@Override
	public int updateApproval(ApprovalDto approvalDto , List<MultipartFile> files) { // TODO 파일
		int n = approvalDao.updateApproval(approvalDto);
		int m = 0;

		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
			if (approvalLineDao.countApprovalLine(approvalDto.getApproval_id()) > 0) {
				approvalLineDao.deleteApprovalLine(approvalDto.getApproval_id());
			}
			for (ApprovalLineDto line : lineDtos) {
				line.setApproval_id(approvalDto.getApproval_id());
				System.out.println(line.getApprover_empno());
			}
			Map<String, Object> map = new HashedMap<String, Object>();
			map.put("approval_id", approvalDto.getApproval_id());
			map.put("approvalLineDtos", lineDtos);
			m = approvalLineDao.insertApprovalLines(map);

			return n == 1 && m >= 1 ? 1 : 0;
		}

		return n == 1 ? 1 : 0;
	}

	@Override
	public ApprovalDto selectApprovalById(String approval_id) {
		return approvalDao.selectApprovalById(approval_id);
	}

	@Override
	public int recallApproval(String approval_id) {
		return approvalDao.recallApproval(approval_id);
	}

	@Override
	public List<Map<String, Object>> formTree() {
		return approvalDao.formTree();
	}

	@Override
	public boolean insertApprovalTemp(ApprovalDto approvalDto, List<MultipartFile> files) { // TODO 파일
		int n = approvalDao.insertApprovalTemp(approvalDto);
		int m = 0;
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos != null) {
			if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
				for (ApprovalLineDto line : lineDtos) {
					line.setApproval_id(approvalDto.getApproval_id());
					System.out.println(line.getApprover_empno());
				}
				Map<String, Object> map = new HashedMap<String, Object>();
				map.put("approval_id", approvalDto.getApproval_id());
				map.put("approvalLineDtos", lineDtos);
				m = approvalLineDao.insertApprovalLines(map);
			}
		}
		return n == 1;
	}

	@Override
	public List<ApprovalDto> selectApproval(int empno) {
		return approvalDao.selectApproval(empno);
	}

	@Override
	public int approvalRequest(String approval_id) {
		if(approvalLineDao.countApprovalLine(approval_id) == 0) {
			return -1;
		}
		return approvalDao.approvalRequest(approval_id);
	}

	@Override
	public List<ApprovalDto> selectPendingApprovalDocuments(String empno) {
		return approvalDao.selectPendingApprovalDocuments(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalTemp(String empno) {
		return approvalDao.selectApprovalTemp(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalInProgress(String empno) {
		return approvalDao.selectApprovalInProgress(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalCompleted(String empno) {
		return approvalDao.selectApprovalCompleted(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalRejected(String empno) {
		return approvalDao.selectApprovalRejected(empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalMyDocuments(String empno) {
		return approvalDao.selectApprovalMyDocuments(empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalReference(String empno) {
		return approvalDao.selectApprovalReference(empno);
	}

	@Override
	public Map<String, Object> selectApprovalLineStats(String empno) {
		return approvalDao.selectApprovalLineStats(empno);
	}

	@Override
	public Map<String, Object> selectApprovalStats(String empno) {
		return approvalDao.selectApprovalStats(empno);
	}

	@Transactional
	@Scheduled(cron = "0 0 3 * * *")
//	@Scheduled(cron = "0 * * * * *") // 매 1분마다 실행
	@Override
	public void deadlineRejectAuto() {
		log.info("크론실행");
		approvalDao.deadlineRejectAuto();
		approvalDao.deadlineLineRejectAuto();
	}

}
