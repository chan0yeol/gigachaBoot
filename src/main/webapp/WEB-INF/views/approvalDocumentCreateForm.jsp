<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기안작성</title>

<%@ include file="./layout/header.jsp"%>
<!-- 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- <script -->
<!-- 	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script> -->
<style type="text/css">
#fileForm {
	height: 100px;
	border: 1px solid #ccc;
}

.modal-content {
	width: 220mm;
	/*     height: 307mm; */
}

#dateRange {
	display: none;
}

#formPickBtn, #linePickBtn, #organization, #documentForm, #referece, #refPickBtn, #lineSaveBtn, #ocrDiv {
	display: none;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet"
	href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" /> -->
<!-- <script -->
<!-- 	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script> -->
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="row">
			<div id="content" class="col">
				<div class="pagetitle">
					<h1>기안문 작성</h1>
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
							<li class="breadcrumb-item">전자결재</li>
							<li class="breadcrumb-item active">기안문작성</li>
						</ol>
					</nav>
				</div>
				<div class="content_nav">
					<button class="btn btn-secondary btn-sm" id="formBtn">문서양식</button>
					<button class="btn btn-secondary btn-sm" id="lineBtn">결재선</button>
					<button class="btn btn-secondary btn-sm" id="saveBtn">결재요청</button>
					<button class="btn btn-secondary btn-sm" id="tempBtn">임시저장</button>
					<button class="btn btn-secondary btn-sm" id="cancelBtn" onclick="javascirpt:history.back()">취소</button>
<!-- 					<button class="btn btn-secondary btn-sm" id="getContent" data-bs-toggle="modal" -->
<!-- 						data-bs-target="#myModal">컨텐츠만 얻기</button> -->
				</div>
				<div class="row" id="contentHtml">
					<div id="ocrDiv">
						<input type="file" name="ocrFile">
						<input type="button" id="ocrBtn" value="이미지 읽기"> 
					</div>
					<div id="approvalLine" class="mt-3 col-auto ms-auto"></div>
					<form class="mt-3">
						<table border="1" class="table">
							<tbody>
								<tr>
									<th>문서번호</th>
									<td>자동입력</td>
									<th>기안일자</th>
									<td>자동입력</td>
								</tr>

								<tr>
									<th>기안자</th>
									<td>${loginDto.name}</td>
									<th>부서</th>
									<td>${loginDto.deptname}</td>
								</tr>
								<tr>
									<th>참조자</th>
									<td><button class="btn btn-secondary btn-sm" id="refBtn">참조자선택버튼</button></td>
									<th>마감기한</th>
									<td><input type="date" class="form-control" name="approval_deadline"></td>
								</tr>
								<tr>
									<th>긴급여부</th>
									<td>긴급 <input type="radio" name="approval_urgency" value="Y">
										일반 <input type="radio" name="approval_urgency" value="N" checked>
									</td>
									<th>서명/도장</th>
									<td>서명 <input type="radio" value="1" name="signature" checked> 
										도장 <input type="radio" value="2" name="signature">
									</td>
								</tr>
								<tr id="dateRange">
									<th>시작날짜</th>
									<td><input type="date"class="form-control" name="start_date"></td>
									<th>종료날짜</th>
									<td><input type="date"class="form-control" name="end_date"></td>
								</tr>
								<tr>
									<th>문서제목</th>
									<td colspan="3"><input type="text" class="form-control"
										name="approval_title" tabindex="-1"></td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" name="form_id">
						<div id="editor"></div>
						<div id="fileDiv">
							<input class="btn" type="file" name="files" multiple id="formFile">
							<div id="fileForm">파일업로드목록</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<div class="modal" id="myModal" data-bs-backdrop="static"
		data-bs-keyboard="false">
		<div class="modal-dialog">
			<div class="modal-content">

				<!--       <div class="modal-header"> -->
				<!--       	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button> -->
				<!--       </div> -->
				<div class="modal-body">
					<div id="documentForm">
						<input type="text" id="searchInputDocumentTree" placeholder="검색">
						<div id="documentTree"></div>
						<h3>선택한 양식</h3>
						<div id="approvalForm"></div>
					</div>
					<div id="organization">
						<h2>조직도</h2>
						<input type="text" id="searchInputOrganizationTree"
							placeholder="검색">
						<div class="row">
							<div id="organizationTree" class="col-6"></div>
							<div id="saveLine" class="col-6"></div>
							<hr>
							<h5>결재순서</h5>
							<div id="approvalList"></div>
							<hr>
						</div>
					</div>
					<div id="referece">
						<h2>참조자</h2>
						<input type="text" id="searchInputRefereceTree"
							placeholder="검색">
						<div class="row">
							<div id="refereceTree" class="col-6"></div>
							<hr>
							<h5>참조자</h5>
							<div id="referenceList"></div>
							<hr>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="lineSaveBtn"
						onclick="saveApprovalLine()" data-bs-dismiss="modal">결재선
						저장</button>
					<button type="button" class="btn btn-success" id="formPickBtn"
						data-bs-dismiss="modal">선택</button>
					<button type="button" class="btn btn-success" id="linePickBtn"
						data-bs-dismiss="modal">선택</button>
					<button type="button" class="btn btn-success" id="refPickBtn"
						data-bs-dismiss="modal">선택</button>
					<button type="button" class="btn btn-danger modalBtn"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/approval.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function () {
			const empno = ${loginDto.empno};
			console.log("empno" + empno);
			
			$("input[name=approval_deadline]").val(setDate());
			$("input[type=date]").attr("min",setDate());
			
			let start_date = $("input[name=start_date]");
			let end_date = $("input[name=end_date]");
			
			start_date.on('change',(event)=>{
				console.log(event.target.value);
				let start = new Date(event.target.value);
				let end = new Date(end_date.val());
				if(end_date.val() && start > end){
					Swal.fire("시작날짜는 종료일보다 빠를 수 없습니다.");
					start_date.val(end_date.val());
					return;
				}
			});
			
			end_date.on('change',(event)=>{
				console.log(event.target.value);
	            let start = new Date(start_date.val());
	            let end = new Date(event.target.value);

	            if (start_date.val() && start > end) {
	                Swal.fire("종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
	                end_date.val(start_date.val()); // 시작일로 변경
	            }
			});
		});
		
		document.querySelector("#ocrBtn").addEventListener('click', async () => {
			let data = await ocrUpload();
			console.log("ocr결과",data)
		});
		async function ocrUpload() {
			const formData = new FormData();
			const fileInput = document.querySelector("input[name=ocrFile]");
			
			formData.append("file",document.querySelector("input[name=ocrFile]").files[0]);
// 			let response = await fetch("./ocrUpload.do",{
// 				method:"POST",
// 				body:formData
// 			})
			
			let response = await fetch("http://localhost:11000/uploadAndOcr",{
				method:"POST",
				body:formData
			})
			return await response.json();
		}
	</script>

</body>
</html>
