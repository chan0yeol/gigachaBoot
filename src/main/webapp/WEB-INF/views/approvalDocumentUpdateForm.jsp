<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안수정</title>

<%@ include file="./layout/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" /> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script> -->
<style type="text/css">
#fileForm{
   height: 100px;
   border: 1px solid #ccc;
}
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
#dateRange{
	display:none;
}
#formPickBtn , #linePickBtn, #organization, #documentForm{
	display:none;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet"
	href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
</head>
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<div class="pagetitle">
				<h1>기안문 수정</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
						<li class="breadcrumb-item">전자결재</li>
						<li class="breadcrumb-item active">기안문 수정</li>
					</ol>
				</nav>
			</div>
			<div class="content_nav">
				<button class="btn btn-secondary btn-sm" id="formBtn">문서양식</button>
				<button class="btn btn-secondary btn-sm" id="lineBtn">결재선</button>
				<button class="btn btn-secondary btn-sm" id="saveBtn">문서수정</button>
				<button class="btn btn-secondary btn-sm" id="cancelBtn" onclick="javascirpt:history.back()">취소</button>
			</div>
			<div class="row" id="contentHtml">
				<div id="approvalLine" class="mt-3 col-auto ms-auto"></div>
				<form action="" class="mt-3">
					<table border="1" class="table">
						<tbody>
							<tr>
								<th>문서번호</th>
								<td>
									<input type="hidden" value="${approval.approval_id}" name="approval_id">
									${approval.approval_id}
								</td>
								<th>기안일자</th>
								<td>${approval.create_date}</td>
							</tr>
							<tr>
								<th>참조자</th>
								<td><span>참조자선택버튼</span></td>
								<th>마감기한</th>
								<td><input type="date" name="approval_deadline" value="${approval.approval_deadline}"></td>
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
								<td>
									<input type="date" name="start_date" value="${approval.start_date}">
								</td>
								<th>종료날짜</th>
								<td>
									<input type="date" name="end_date" value="${approval.start_date}">
								</td>
							</tr>
							<tr>
								<th>문서제목</th>
								<td colspan="3"><input type="text" class="form-control" name="approval_title" value="${approval.approval_title}"></td>
							</tr>
		
						</tbody>
					</table>
					<input type="hidden" name="form_id" value="${approval.form_id}">
					<div id="editor">${approval.approval_content}</div>
					<div id="fileDiv">
						<input class="btn" type="file" multiple id="formFile">
						<div id="fileForm">
						파일업로드목록
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
    	
      <div class="modal-header">
      	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
      	<div id="documentForm">
	      	<div id="documentTree"></div>
	      	<h3>선택한 양식</h3>
	    	<div id="approvalForm"></div>
    	</div>
    	<div id="organization">
	    	<h2>조직도</h2>
			<input type="text" id="searchInput" placeholder="검색">
			<br>
			<div id="organizationTree"></div>
			<hr>
			<h3>결재순서</h3>
			<div id="approvalList"></div>
		</div>
      </div>

      <div class="modal-footer">
      	<button type="button" class="btn btn-success" id="formPickBtn" data-bs-dismiss="modal">선택</button>
      	<button type="button" class="btn btn-success" id="linePickBtn" data-bs-dismiss="modal">선택</button>
        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/approval_update.js"></script>

	<script type="text/javascript">

	</script>
</body>
</html>
