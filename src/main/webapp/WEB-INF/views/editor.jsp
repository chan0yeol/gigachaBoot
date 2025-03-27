<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디터</title>


	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
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
</head>
<body>
<%-- 	<%@ include file="./layout/sidebar.jsp"%> --%>
	<div id="content">
		<h3 class="content_title">에디터</h3>
		<div id="editor"></div>
		<button id="editorViewBtn">에디터 뷰 버튼</button>
		<div id="viewer" class="toastui-editor-contents"></div>
	</div>


	<!-- 에디터 cdn  -->
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
    <script>
        const editor = new toastui.Editor({
            el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
            height: '500px',
            initialEditType: 'wysiwyg'
        });
        
        document.querySelector("#editorViewBtn").addEventListener('click',()=>{
        	console.log("버튼클릭확인");
        	document.querySelector("#viewer").innerHTML = editor.getHTML();
        });
    </script>

</body>
</html>