<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식상세</title>

<%@ include file="layout/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
</head> 
<body>
	<%@ include file="layout/newNav.jsp" %>
	<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">${form.form_name}</h3>
			<button class="btn btn-info" onclick="location.href='./approvalFormUpdate.do?id=${form.form_id}'">수정</button>
			<button class="btn btn-danger" id="deleteBtn">삭제</button>
			<div id="viewer" class="toastui-editor-contents">${form.form_content}</div>
		</div>
	</div>
</main>
</body>
	<script type="text/javascript">
		document.querySelector("#deleteBtn").addEventListener('click', () => {
			fetch("./approvalFormDelete.json?id=${form.form_id}")
			.then(resp => resp.json())
			.then(data => {
				if(data == true) {
					Swal.fire("삭제 성공").then(() => {
						location.href="./approvalFormList.do";
					})
				} else {
					Swal.fire("삭제 실패");
				}
			})
		})	
	</script>
</html>
