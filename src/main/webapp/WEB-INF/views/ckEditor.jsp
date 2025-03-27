<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>
<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
</head>
<body>
<%-- 	<%@ include file="./layout/nav.jsp"%> --%>
<%-- 	<%@ include file="./layout/sidebar.jsp"%> --%>
	<div id="content">
		<div class="main-container">
			<div class="editor-container editor-container_classic-editor" id="editor-container">
				<div class="editor-container__editor">
				<div id="editor"></div></div>
			</div>
		</div>
		<button id="editorSaveBtn">저장버튼</button>
		<button id="editorViewBtn">뷰</button>
		<div id="view"></div>
		<script src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	</div>
	<script type="text/javascript">
// 		var contentHtml;
// 		document.querySelector("#saveBtn").addEventListener('click', () => {
// 			contentHtml = editor.getData();
// 		});
		
		var editorSaveBtn = document.querySelector("#editorSaveBtn");
    	editorSaveBtn.addEventListener('click',()=>{
    		let editorHtml = editor.getData();
    		fetch('./approval/editorSave.do',{
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
    	document.querySelector("#editorViewBtn").addEventListener('click',()=>{
        	console.log("버튼클릭확인");
        	
        	fetch('./approval/editorRead.do')
        	.then(res => res.text())
        	.then(data => {
        		editor.setData(data);	
//         		document.querySelector("#view").innerHTML = data;
        	})
        	.catch(err => console.log(err));
        });
	</script>
</body>
</html>
