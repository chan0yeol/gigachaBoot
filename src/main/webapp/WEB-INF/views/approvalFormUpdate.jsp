<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식수정</title>

<%@ include file="./layout/header.jsp"%>
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
		
</head> 
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<div class="pagetitle">
				<h1>${form.form_name}</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
						<li class="breadcrumb-item active">문서양식관리</li>
						<li class="breadcrumb-item active">문서양식수정</li>
					</ol>
				</nav>
			</div>
			<form>
				<label for="inputText" class="col-sm-2 col-form-label">양식이름</label>
				<div class="col-sm-10">
					<input type="hidden" class="form-control" name="form_id" value="${form.form_id}">
					<input type="text" class="form-control" name="form_name" value="${form.form_name}">
				</div>
				<div>양식</div>
				<div id="editor" class="toastui-editor-contents">${form.form_content}</div>
				<input type="hidden" value="" name="form_content">
				<button id="saveBtn" type="submit" class="btn btn-info">수정</button>
				<button type="button" class="btn btn-danger" onclick="history.back()">뒤로가기</button>
			</form>
		</div>
	</div>
</main>
</body>
	<script src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	<script>
		window.onload = function () {
			editor.setData(document.querySelector('#editor').innerHTML);
			
			document.querySelector("#saveBtn").addEventListener('click',(event) => {
				event.preventDefault();
				let formData = new FormData(document.forms[0]);
				let jsonData = {};
				formData.forEach((value, key) => {
					jsonData[key] = value;
				});
				jsonData["form_content"] = editor.getData();
				console.log(jsonData);
				fetch("./managerFormUpdateAjax.do",{
					method:"POST",
					headers:{
						"Content-Type":"application/json"
					},
					body:JSON.stringify(jsonData)
				})
				.then(resp => resp.json())
				.then(data => {
					console.log(data);
					if(data == true) {
						Swal.fire("수정에 성공했습니다.").then(()=>{
							location.href="./formList.do";
						})
					} else {
						Swal.fire("수정에 실패했습니다.<br> 해당 양식으로 작성된 <br>글이 존재합니다.");
					}
				})
				.catch(err => console.log(err));
			})
		}
		
	</script>
</html>
