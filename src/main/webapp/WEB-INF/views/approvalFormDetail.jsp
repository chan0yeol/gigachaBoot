<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식상세</title>

<%@ include file="./layout/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
</head> 
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="pagetitle">
		<h1>양식상세</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
				<li class="breadcrumb-item">문서양식관리</li>
				<li class="breadcrumb-item active">양식상세</li>
			</ol>
		</nav>
	</div>
	<div class="row">
		<div class="card">
	        <div class="card-body">
				<div id="content" class="col">
					<h3 class="content_title">${form.form_name} 
						<c:if test="${loginDto.auth eq 'A'}">
							<button class="btn btn-secondary mb-3 btn-sm" onclick="location.href='./managerFormUpdate.do?id=${form.form_id}'">수정</button>
						</c:if>
					</h3>
					<div id="viewer" class="toastui-editor-contents">${form.form_content}</div>
				</div>
			</div>
		</div>
	</div>
</main>
</body>
</html>
