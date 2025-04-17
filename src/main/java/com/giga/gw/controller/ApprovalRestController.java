package com.giga.gw.controller;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.dto.*;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IFileDao;
import com.giga.gw.service.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/approval")
@CrossOrigin(origins = "http://localhost:3000")
public class ApprovalRestController {
    private final IApprovalDao approvalDao;
    private final IEmployeeService employeeService;
    private final IApprovalCategoryService approvalCategoryService;
    private final IApprovalFormService approvalFormService;
    private final IApprovalService approvalService;
    private final IApprovalLineService approvalLineService;
    private final IFileDao fileDao;
    private final WebSocketHandler webSocketHandler;

    @PostMapping("/signatureSaveAjax.do")
    public boolean signatureSave(@RequestBody Map<String, Object> map, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        map.put("empno", loginDto.getEmpno());
        return employeeService.saveSignature(map);
    }

    @PostMapping("/managerCategorySaveAjax.do")
    public boolean categorySave(@RequestBody ApprovalCategoryDto categoryDto) {
        System.out.println(categoryDto);
        categoryDto.setCategory_yname(categoryDto.getCategory_yname().toUpperCase());
        return approvalCategoryService.categoryInsert(categoryDto) == 1;
    }

    @PostMapping("/managerFormSaveAjax.do")
    public boolean approvalFormSave(@RequestBody ApprovalFormDto approvalFormDto) {
        System.out.println(approvalFormDto);
        int row = approvalFormService.formInsert(approvalFormDto);
        return row == 1;
    }

    @PostMapping("/selectFormAjax.do")
    public Map<String, Object> selectFormContent(@RequestBody String form_id) {
        System.out.println(form_id);
        return approvalFormService.formSelectById(form_id);
    }

    @PostMapping("/approvalFormUpdateAjax.do")
    public boolean formUpdate(@RequestBody ApprovalFormDto approvalFormDto) {
        return approvalFormService.formUpdate(approvalFormDto) == 1;
    }

    @PostMapping("/approvalDocumentSaveAjax.do")
    public boolean approvalDocumentSave(
            @ModelAttribute ApprovalDto approvalDto,
            @RequestParam(value = "files", required = false) List<MultipartFile> files,
            HttpSession session,
            HttpSession request) throws FileNotFoundException {
        System.out.println(approvalDto.getApprovalLineDtos().toString());
        System.out.println(files);
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        approvalDto.setEmpno(loginDto.getEmpno());
        String path;
        path = WebUtils.getRealPath(request.getServletContext(), "/storage");
//		return result.equals("파일 업로드 성공") ? true: false;
        if(approvalService.insertApproval(approvalDto, files, path)) {
            if(approvalDto.getApproval_urgency().equals("Y")) {
                try {
                    webSocketHandler.sendMessageToUser(approvalDto.
                            getApprovalLineDtos()
                            .get(0)
                            .getApprover_empno(), "긴급문서 도착");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return true;
        }
        return false;
//		return false;
    }

    //	유효성 체크 버전
    @PostMapping("/approvalDocumentSaveRegAjax.do")
    public ResponseEntity<?> approvalDocumentSaveReg(
            @ModelAttribute ApprovalDto approvalDto,
            @RequestParam(value = "files", required = false) List<MultipartFile> files,
            HttpSession session,
            HttpServletRequest request) throws FileNotFoundException {
        System.out.println(approvalDto);
        // 유효성 체크 시작
        if (approvalDto.getForm_id() == null ||
                approvalDto.getApprovalLineDtos() == null ||
                approvalDto.getApproval_deadline() == null ||
                approvalDto.getApproval_title() == null) {
            return ResponseEntity.badRequest().body("빈 값이 존재함");
        }

        System.out.println(approvalDto.getApprovalLineDtos());
        System.out.println(files);
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        approvalDto.setEmpno(loginDto.getEmpno());

        String path;
        path = WebUtils.getRealPath(request.getSession().getServletContext(), "/storage");
//		return approvalService.insertApproval(approvalDto, files, path);

        return approvalService.insertApproval(approvalDto, files, path) ? ResponseEntity.ok(true) : ResponseEntity.ok(false);
    }

    @PostMapping("/approvalDocumentSaveTempAjax.do")
    public boolean approvalDocumentSaveTemp(@RequestBody ApprovalDto approvalDto, @RequestParam(value = "files", required = false) List<MultipartFile> files, HttpSession session) {
        System.out.println(approvalDto);
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        approvalDto.setEmpno(loginDto.getEmpno());
        return approvalService.insertApprovalTemp(approvalDto, files);
    }

    @GetMapping("/approvalListAjax.do")
    public String approvalListAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalDao.selectApproval(Integer.parseInt(loginDto.getEmpno()));
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }

    @GetMapping("/approvalListTempAjax.do")
    public String approvalListTempAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalDao.selectApprovalTemp(loginDto.getEmpno());
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }

    // 문서 상세 api 요청
    @GetMapping(value = "/approvalDetailAjax.do", produces = "application/json; charset=UTF-8")
    public String approvalDetailAjax(@RequestParam String id) {
        System.out.println(id);
        Gson gson = new Gson();
        ApprovalDto dto = approvalService.selectApprovalById(id);
        return gson.toJson(dto);
    }

    // 문서 수정
    @PostMapping("/approvalUpdateFormAjax.do")
    public boolean approvalUpdate(@RequestBody ApprovalDto approvalDto, List<MultipartFile> files, HttpSession session) {
        System.out.println(approvalDto);
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        approvalDto.setUpdate_empno(loginDto.getEmpno());
        return approvalService.updateApproval(approvalDto, files) == 1;
    }

    // 문서 회수
    @PostMapping("/approvalRecallAjax.do")
    public boolean approvalRecall(@RequestBody String approval_id) {
        return approvalService.recallApproval(approval_id) == 1;
    }

    // 임시저장상태에서 결재요청
    @PostMapping("/approvalRequestAjax.do")
    public boolean approvalRequest(@RequestBody String approval_id) {
        return approvalService.approvalRequest(approval_id) == 1;
    }

    @PostMapping("/selectApprovalInProgressAjax.do")
    public String selectApprovalInProgressAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalService.selectApprovalInProgress(loginDto.getEmpno());
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }

    @PostMapping("/selectApprovalCompletedAjax.do")
    public String selectApprovalCompletedAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalService.selectApprovalCompleted(loginDto.getEmpno());
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }

    @PostMapping("/selectApprovalRejectedAjax.do")
    public String selectApprovalRejectedAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalService.selectApprovalRejected(loginDto.getEmpno());
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }


    // 결재승인
    @PostMapping("/acceptApprovalLineAjax.do")
    @ResponseBody
    public boolean acceptApprovalLine(@RequestBody Map<String, Object> map, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        map.put("empno", loginDto.getEmpno());
        System.out.println(map);
        return approvalLineService.acceptApprovalLine(map);
    }

    // 결재 반려
    @PostMapping("/rejectApprovalLineAjax.do")
    public boolean rejectApprovalLine(@RequestBody Map<String, Object> map, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        map.put("empno", loginDto.getEmpno());

        System.out.println("\n\n" + map + "\n\n");

        return approvalLineService.rejectApprovalLine(map);
//		return false;
    }

    // 나의 결재함 api 요청주소
    @PostMapping("/myApprovalDataAjax.do")
    public Map<String, Object> myDocumentsData(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<Map<String, Object>> documents = approvalService.selectApprovalMyDocuments(loginDto.getEmpno());
        Map<String, Object> response = new HashMap<>();
        response.put("data", documents);
        return response;
    }

    // 참조문서함 api 요청주소  selectApprovalReference
    @GetMapping("/selectApprovalReferenceAjax.do")
    public Map<String, Object> selectApprovalReferenceAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<Map<String, Object>> documents = approvalService.selectApprovalReference(loginDto.getEmpno());
        Map<String, Object> response = new HashMap<>();
        response.put("data", documents);
        return response;
    }

    // 캘린더로 보낼 휴가
    @PostMapping("/postLeaveToCalendarAjax.do")
    public List<Map<String, Object>> postLeaveToCalendar(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        return approvalDao.postLeaveToCalendar(loginDto.getEmpno());
    }

    @PostMapping("/insertSaveLineAjax.do")
    public String insertSaveLine(@RequestBody Map<String, Object> map, HttpSession session) {
        System.out.println(map);
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("line_name", map.get("line_name"));
        paramMap.put("line_data", map.get("line_data").toString());
        paramMap.put("empno", loginDto.getEmpno());
        approvalLineService.insertSaveLine(paramMap);
        return "true";
    }

    @GetMapping("/selectSaveLineAjax.do")
    public List<Map<String, Object>> selectSaveLine(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        return approvalLineService.selectSaveLine(loginDto.getEmpno());
    }

    @GetMapping(value = "/fileListAjax.do", produces = "application/json; charset=UTF-8")
    public String fileList(@RequestParam String id) {
        Map<String, Object> map = new HashMap<>();
        map.put("approval_id", id);

        List<FileDto> fileList = fileDao.selectFile(map);
        Gson gson = new GsonBuilder().create();
        return gson.toJson(fileList);
    }

    //	파일다운로드
    @PostMapping("/downloadAjax.do")
    public byte[] download(
            @RequestBody Map<String, Object> map,
            HttpServletResponse response) throws IOException {
        // approval_id, file_id
        List<FileDto> dto = fileDao.selectFile(map);
        String path = dto.get(0).getFile_path();
        String saveFileName = dto.get(0).getFile_name();
        String originFileName = dto.get(0).getOrigin_name();
        File file = new File(path + "/" + saveFileName);
        //String outputFileName = new String(originFileName.getBytes(), StandardCharsets.ISO_8859_1);
        String encodedFileName = URLEncoder.encode(originFileName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        byte[] bytes = FileCopyUtils.copyToByteArray(file);

//		response.setHeader("Content-Disposition", "attachment; filename=\""+outputFileName+"\"");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        response.setContentLength(bytes.length);
        response.setContentType("application/octet-stream"); // meword로 정송 application/msword

        return bytes;
    }

    // 문서양식 삭제
    @PostMapping("/managerFormDeleteAjax.do")
    @ResponseBody
    public boolean formUpdateUseYN(@RequestBody Map<String, Object> map) {
        return approvalFormService.formUpdateUseYN(map) == 1 ? true : false;
    }
}
