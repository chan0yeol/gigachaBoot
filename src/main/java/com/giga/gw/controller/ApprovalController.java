package com.giga.gw.controller;

import com.giga.gw.dto.*;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.service.IApprovalCategoryService;
import com.giga.gw.service.IApprovalFormService;
import com.giga.gw.service.IApprovalService;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
@Slf4j
public class ApprovalController {
    private final IApprovalDao approvalDao;
    private final IEmployeeDao employeeDao;
    private final IApprovalCategoryService approvalCategoryService;
    private final IApprovalFormService approvalFormService;
    private final IApprovalService approvalService;
    private final PageDto pageDto;
    @GetMapping("/index.do")
    public String apprIndex() {
        return "approval";
    }

    @GetMapping("/tre.do")
    public String tre(Model model, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        return "tree";
    }

    @ResponseBody
    @GetMapping("/treeAjax.do")
    public List<Map<String, Object>> tree() {
        return approvalDao.getOrganizationTree();
    }

    @GetMapping("/signature.do")
    public String signature(HttpSession session, Model model) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		List<String> empList = new ArrayList<String>();
//		empList.add(loginDto.getEmpno());
//		model.addAttribute("signature",employeeDao.readSignature(empList));
        return "signature";
    }


    @GetMapping("/signatureReadAjax.do")
    @ResponseBody
    public List<Map<String, Object>> signatureRead(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		List<String> empList = new ArrayList<String>();
//		empList.add(loginDto.getEmpno());
//		System.out.println(employeeDao.readSignature(empList));
        return employeeDao.readSignature(loginDto.getEmpno());
    }

//	@PostMapping("/editorSave.do")
//	@ResponseBody
//	public boolean editorSave(@RequestBody String editor) {
//		int row = approvalDao.editorSave(editor);
//		return row == 1 ? true : false;
//	}

//	@GetMapping(value = "/editorRead.do", produces = "text/html; charset=UTF-8")
//	@ResponseBody
//	public String editroRead() {
//		return approvalDao.editorRead();
//	}

    // TODO 00100 전자결재 - 카테고리 Controller
    @GetMapping("/managerCategoryForm.do")
    public String categoryForm() {
        return "approvalCategoryForm";
    }

    // 카테고리 중복체크
    @GetMapping("/managerCategoryCheckAjax.do")
    @ResponseBody
    public boolean categoryCheck(String yname) {
        return approvalCategoryService.categoryCheck(yname.toUpperCase()) == 0;
    }

    // 카테고리 저장

    @GetMapping("/managerCategoryList.do")
    public String categoryList(Model model) {
        List<ApprovalCategoryDto> categoryList = approvalCategoryService.categorySelect();
        model.addAttribute("categoryList", categoryList);
        return "approvalCategoryList";
    }

    // 문서양식 등록시 카테고리 선택을 위한 팝업창
    @GetMapping("/managerCategoryPop.do")
    public String categoryPop(Model model) {
        List<ApprovalCategoryDto> categoryList = approvalCategoryService.categorySelect();
        model.addAttribute("categoryList", categoryList);
        return "categoryPop";
    }

    // TODO 00101 전자결재 문서양식 Controller
    // 문서양식 리스트 조회
    @GetMapping("/formList.do")
    public String approvalForm(@RequestParam(value="page", defaultValue = "1" ) String page, Model model, HttpSession session) {
        int selPage = Integer.parseInt(page);
        if(selPage <= 0) {
            selPage = 1;
        }
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        if(loginDto.getAuth().equals("A")) {
            pageDto.setTotalCount(approvalFormService.cntFormSelectAll());
        } else {
            pageDto.setTotalCount(approvalFormService.cntFormSelectUser());
        }
        pageDto.setCountList(10);
        pageDto.setCountPage(5);
        pageDto.setTotalPage(0);

        pageDto.setPage(selPage);
        pageDto.setStagePage(0);
        pageDto.setEndPage(0);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("first", pageDto.getPage()*pageDto.getCountList() - (pageDto.getCountList()-1) ); // (2*10) - (10-1) = 11
        map.put("last", pageDto.getPage()*pageDto.getCountList());
        List<ApprovalFormDto> formList = approvalFormService.formSelectAll(map);
        model.addAttribute("page", pageDto);
        model.addAttribute("formList", formList);
        return "approvalFormList";
    }

    @GetMapping("/managerFormDetail.do")
    public String approvalFormDetail(@RequestParam String id, Model model) {
        System.out.println(id);
        ApprovalFormDto form = approvalFormService.formSelectDetail(id);
        model.addAttribute("form", form);
        return "approvalFormDetail";
    }
    @GetMapping("/formDetailAjax.do")
    @ResponseBody
    public ResponseEntity<ApprovalFormDto> formDetailAjax(@RequestParam String id, Model model) {
        System.out.println(id);
        ApprovalFormDto form = approvalFormService.formSelectDetail(id);
        return ResponseEntity.ok(form);
    }

    // 문서양식 등록 페이지로 이동
    @GetMapping("/managerFormCreate.do")
    public String approvalFormCarete() {
        return "approvalFormCreate";
    }

    // 문서양식등록


    // 문서양식 tree 데이터 조회 api
    @ResponseBody
    @GetMapping("/formTreeAjax.do")
    public List<Map<String, Object>> formTree() {
        return approvalDao.formTree();
    }

    // 문서양식 tree view 페이지요청
    @GetMapping("/formTreeView.do")
    public String formTreeView() {
        return "formTree";
    }

    // 문서양식 불러오기


    // 문서양식 수정페이지 이동
    @GetMapping("/managerFormUpdate.do")
    public String approvalFormUpdate(@RequestParam String id, Model model, HttpSession session) {
        ApprovalFormDto dto = approvalFormService.formSelectDetail(id);
        model.addAttribute("form", dto);
        return "approvalFormUpdate";
    }

    // 문서양식 수정


    // 문서양식 삭제
    /*@GetMapping("/managerFormDeleteAjax.do")
    @ResponseBody
    public boolean formDelete(@RequestParam String id) {
        return approvalFormService.formDelete(id) == 1;
    }*/

    // TODO 00102 전자결재 문서
    // 전자결재 문서 작성 페이지 이동
    @GetMapping("/approvalDocument.do")
    public String approvalDocument(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        return "approvalDocumentCreateForm";
    }


    // 결재요청함
    @GetMapping("/approvalList.do")
    public String approvalList(Model model, HttpSession session) {
        return "approvalList";
    }


    // 임시저장함
    @GetMapping("/approvalListTemp.do")
    public String approvalListTemp() {
        return "approvalListTemp";
    }


    // 문서 상세
    @GetMapping("/approvalDetail.do")
    public String approvalDetail(@RequestParam String id, Model model, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        ApprovalDto approval = approvalService.selectApprovalById(id);
        model.addAttribute("approval", approval);
        model.addAttribute("loginDto", loginDto);
        return "approvalDetail";
    }


    // 문서 수정 FORM 이동
    @GetMapping("/approvalUpdateForm.do")
    public String approvalUpdateForm(@RequestParam String id, Model model, HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        ApprovalDto approval = approvalService.selectApprovalById(id);
        model.addAttribute("approval", approval);
        model.addAttribute("loginDto", loginDto);
        return "approvalDocumentUpdateForm";
    }


    // 내가 결재할 목록으로 이동
    @GetMapping("/approvalRequestList.do")
    public String approvalRequestList(HttpSession session, Model model) {
        return "approvalRequestList";
    }

    @GetMapping("/approvalRequestListAjax.do")
    @ResponseBody
    public String approvalRequestListAjax(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<ApprovalDto> approvalList = approvalService.selectPendingApprovalDocuments(loginDto.getEmpno());
        Gson gson = new Gson();
        return gson.toJson(approvalList);
    }

    // 결재진행함
    @GetMapping("/selectApprovalInProgress.do")
    public String selectApprovalInProgress(HttpSession session, Model model) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		List<ApprovalDto> approvalList = approvalService.selectApprovalInProgress(loginDto.getEmpno());
//		model.addAttribute("approvalList",approvalList);
        return "selectApprovalInProgress";
    }


    //
    // 결재완료함 selectApprovalCompleted 이동
    @GetMapping("/selectApprovalCompleted.do")
    public String selectApprovalCompleted(HttpSession session, Model model) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		List<ApprovalDto> approvalList = approvalService.selectApprovalCompleted(loginDto.getEmpno());
//		model.addAttribute("approvalList",approvalList);
        return "selectApprovalCompleted";
    }


    // 반려문서함
    @GetMapping("/selectApprovalRejected.do")
    public String selectApprovalRejected(HttpSession session, Model model) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		List<ApprovalDto> approvalList = approvalService.selectApprovalRejected(loginDto.getEmpno());
//		model.addAttribute("approvalList",approvalList);
        return "selectApprovalRejected";
    }


    // 나의 결재함
    @GetMapping("/myApproval.do")
    public String myApproval() {
        return "myApproval";
    }


    // 참조 문서함
    @GetMapping("/selectApprovalReference.do")
    public String selectApprovalReference() {
        return "selectApprovalReference";
    }

    @PostMapping("/categoryUseChange.do")
    @ResponseBody
    public ResponseEntity<Boolean> categoryUseChange(@RequestBody Map<String, Object> map) {
        return ResponseEntity.ok(approvalCategoryService.categoryUpdateUseYN(map));
    }
    @PostMapping("/ocrUpload.do")
    @ResponseBody
    public ResponseEntity<?> ocrUpload(@RequestParam MultipartFile ocrFile) {
        log.info("업로드 파일 {}",ocrFile);
        return null;
    }
}
