<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식관리</title>

<%@ include file="layout/header.jsp"%>


<style type="text/css">

#viewer table {
	margin: 0 auto;
	width: 80%;
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">

</head>
<body>
	<%@ include file="layout/newNav.jsp" %>
	<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">문서양식추가</h3>
			<div class="card">
				<div class="card-body">
					<form>
						<div class="mb-3">
							<label class="col-form-label">양식이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="form_name" >
							</div>
						</div>
						<div class="mb-3">
							<label class="col-sm-2 col-form-label">카테고리</label>
							<div class="col-sm-10">
								<input type="hidden" value="" name="category_id" readonly="readonly">
								<div class="form-control">
									<span id="category_id" ></span>
									<button class="btn" id="cateBtn">카테고리 선택</button>
								</div>						
								
							</div>
						</div>
						<div class="mb-3">
							<label class="col-form-label">양식</label>
							<div class="col-sm-10">
								<div id="editor"></div>
								<input type="hidden" name="form_content">
	<!-- 							<button id="editorViewBtn">에디터 뷰 DB에서 가져오기 버튼</button> -->
	<!-- 							<button id="editorSaveBtn">에디터 내용 저장</button> -->
	<!-- 							<div id="viewer" class="toastui-editor-contents"></div> -->
							</div>
						</div>
						<div class="mb-3">
							<label class="col-form-label">Submit Button</label>
							<div class="col-sm-10">
								<button type="submit" class="btn btn-primary">저장</button>
								<button type="reset" class="btn btn-light">리셋</button>
								<button type="button" class="btn btn-info" onclick="history.back()">뒤로가기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
	
		</div>
	</div>	
</main>
	<script src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	<script type="text/javascript">
	function categoryPick(category_id,category_name) {
		console.log("팝업에서 보낸 값", category_id, category_name);
		document.querySelector("input[name=category_id]").value = category_id;
		document.querySelector("#category_id").textContent = category_name;
	}
	window.onload = function() {
		
		document.querySelector("button[type=reset]").addEventListener('click',()=> {
			console.log("리셋클릭");
			editor.setData();
		}); 
		
		document.querySelector("#cateBtn").addEventListener('click',(event)=>{
			event.preventDefault();
			console.log("cateBtn클릭");
			window.open('./categoryPop.do',"popupWindow","width=400,height=600,top=150,left=300");
		});
		
		document.querySelector("button[type=submit]").addEventListener('click', (event) => {
			event.preventDefault();
			let editorHtml = editor.getData();
			console.log(editorHtml);
			let formData = new FormData(document.forms[0]);
			let jsonData = {};
			formData.forEach((value, key) => {
				jsonData[key] = value;
			});
			jsonData["form_content"] = editorHtml;
			console.log(jsonData);
			fetch('./approvalFormSave.json',{
	 			method:'POST',
	 			headers:{
	 				'Content-Type':'application/json'
	 			},
	 			body:JSON.stringify(jsonData)
	 		})
	 		.then(resp => resp.json())
	 		.then(data => console.log(data))
	 		.catch(err => console.log(err))
		});
		
	  // --- 에디터 저장
	 	var editorSaveBtn = document.querySelector("#editorSaveBtn");
	 	editorSaveBtn.addEventListener('click',()=>{
	 		let editorHtml = editor.getData();
	 		
	 		fetch('./approvalFormSave.json',{
	 			method:'POST',
	 			headers:{
	 				'Content-Type':'application/json'
	 			},
	 			body:JSON.stringify({html:editorHtml})
	 		})
	 		.then(res => res.text())
	 		.then(data => console.log(data))
	 		.catch(err => console.log(err));
	 	});
	}
	 
	</script>
</body>
</html>
