<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재</title>
<%@ include file="./layout/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<style type="text/css">
	#content {
		margin-top:65px;
		margin-right: 30px;
		margin-left: 230px;
	}

	.content_title {
		margin-top: 10px;
		padding-bottom: 5px;
		border-bottom: 1px solid #ccc;
	}

	.wrapper {
		position: relative;
		width: 400px;
		height: 200px;
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	
	.signature-pad {
		position: absolute;
		left: 0;
		top: 0;
		width: 400px;
		height: 200px;
		border: 1px solid black;
	}

	#viewer table {
		margin: 0 auto;
		width: 80%;
	}
	.toastui-editor-contents table {
		margin: 0 auto;
		width:80%;
	}
	.toastui-editor-contents table th{
	
	background-color:#fff;
		color:black;
	}
	.toastui-editor-contents th p {
	background-color:#fff;
		color:black;
	}
	#sigImg>img{
		width:50px;
		height:50px;
	}
</style>

</head>
<body>
<%-- <%@ include file="./layout/nav.jsp" %> --%>
<%-- <%@ include file="./layout/sidebar.jsp"%> --%>
<main id="main" class="main">
	<div id="content">
		<h3 class="content_title">기안문 작성</h3>
		<button id="line">결재선</button>
		<div id="approvalLine"></div>

		<hr>

		<h3 class="content_title">에디터</h3>
		<div id="editor"></div>
		<button id="editorViewBtn">에디터 뷰 DB에서 가져오기 버튼</button>
		<button id="editorSaveBtn">에디터 내용 저장</button>
		<div id="viewer" class="toastui-editor-contents"></div>


		<hr>
		<h3 class="content_title">signaturepad</h3>
		<div class="wrapper">
			<canvas id="signature-pad" class="signature-pad" width=400 height=200></canvas>
		</div>
		<div>
			<button id="read">불러오기</button>
			<button id="save">save</button>
			<button id="clear">Clear</button>
		</div>
		<div id="sigImg"></div>
	</div>
</main>
	<%-- 	<%@ include file="./layout/newSide.jsp"%> --%>
	
</body>
<script type="text/javascript">
   // --- 결제선 script 시작 ---- 
	document.getElementById("line").addEventListener('click', () => {
		window.open('./tre.do',"popupWindow","width=400,height=600,top=150,left=300");
	});
	
	function line(approvalLine) {
		console.log("팝업에서 보낸값", approvalLine);
		
		let html = "";
		approvalLine.forEach( (emp , i) => { 
				console.log(emp.name,emp.id);
				html += "<div class='approval-item'>";
				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
				html += "</div>";
				console.log(html);
		})
		document.getElementById("approvalLine").innerHTML = html;
	}
	
	// -------- editor 

        const editor = new toastui.Editor({
            el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
            height: '500px',
            initialEditType: 'wysiwyg',
            previewStyle:"vertical",
            hideModeSwitch:"true",
            
        });
        // 에디터 DB에서 불러오기
        document.querySelector("#editorViewBtn").addEventListener('click',()=>{
        	console.log("버튼클릭확인");
        	
        	document.querySelector("#editor").style.display = "none";
        	fetch('./editorRead.do')
        	.then(res => res.json())
        	.then(data => {
        		document.querySelector("#viewer").innerHTML = data.html;	
        	})
        	.catch(err => console.log(err));
        });
        
     // --- 에디터 저장
    	var editorSaveBtn = document.querySelector("#editorSaveBtn");
    	editorSaveBtn.addEventListener('click',()=>{
    		let editorHtml = editor.getHTML();
    		fetch('./editorSave.do',{
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
        
	// --------- 시그니처패드 
	var signaturePad = new SignaturePad(document.getElementById('signature-pad'), {
	  backgroundColor: 'rgba(255, 255, 255, 0)', // 배경
	  penColor: 'rgb(0, 0, 0)' // 사인색
	});
	var saveButton = document.getElementById('save');
	var cancelButton = document.getElementById('clear');
	var readButton = document.getElementById('read');
	saveButton.addEventListener('click', function (event) {
	  var data = signaturePad.toDataURL('image/png');
		console.log(btoa(data));
		console.log(data)
	  //window.open(data);
		fetch('./signatureSaveAjax.do',{
			method:'post',
			headers:{
				'Content-Type':'application/json'
			},
			body:JSON.stringify({img : data})
		})
		.then(res => res.json())
		.then(data => {
			console.log(data);
		})
		.catch(err => console.log(err));
	});
	
	readButton.addEventListener('click',()=>{
		fetch('./signatureReadAjax.do')
		.then(res => res.json())
		.then(data => {
			console.log(data);
			data.forEach(d => {
				let img = document.createElement("img");
                img.src=d.FILE_BASE;
                document.querySelector("#sigImg").appendChild(img);
			})
		})
		.catch(err => console.log(err));
		
	});
	
	cancelButton.addEventListener('click', function (event) {
	  signaturePad.clear();
	});
	
</script>
</html>