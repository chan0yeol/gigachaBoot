<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서명관리</title>

<%@ include file="./layout/header.jsp"%>
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.signature-pad{
	border:1px solid #ccc;
}
.wrapper {
	margin:0 auto;
}
.modal-content {
	width:220mm;
}
</style>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">서명관리</h3>
			<div class="row">
<!-- 				<div class="col"> -->
<!-- 					<h5>서명을 그리세요</h5>					 -->
<!-- 					<div class="wrapper" > -->
<!-- 						<canvas id="signature-pad" class="signature-pad" width=400 height=200></canvas> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					<h5>저장된서명</h5> -->
<!-- 					<div class="info-box card"> -->
<!-- 						<div id="sigImg"></div> -->
<!-- 	              	</div> -->
<!-- 				</div> -->
			</div>
<!-- 			<button id="read">불러오기</button> -->
			
			<button id="open">모달열기</button>
		</div>
	</div>
	
	<!-- 모달 -->
	<div class="modal" id="signatureModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	      <div class="modal-header d-flex mb-3">
	      	  <div class="me-auto p-2">
	      	  	<span class="fs-3">서명관리</span>
	      	  </div>
			  <div class="p-2">
			  	<button id="save" class="btn btn-sm btn-success">저장</button>
			  </div>
			  <div class="p-2">
			  	<button id="clear" class="btn btn-sm btn-danger">Clear</button>
			  </div>
	      </div>
	      <div class="modal-body">
	      	<div class="row border-bottom">
				<div class="col">
					<h5>서명을 그리세요</h5>					
					<div class="wrapper" >
						<canvas id="signature-pad" class="signature-pad" width=200 height=200></canvas>
					</div>
				</div>
				<div class="col">
					<h5>저장된서명</h5>
					<div class="info-box card">
						<div id="sigImg"></div>
	              	</div>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col">
					<h5>도장</h5>
				</div>
			</div>
	      </div>
	      <div class="modal-footer">
	       	<button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      </div>
	      </div>
	    </div>
	  </div>
	
</main>

<script type="text/javascript">
	var signaturePad = new SignaturePad(document.getElementById('signature-pad'), {
		  backgroundColor: 'rgba(255, 255, 255, 0)', // 배경
		  penColor: 'rgb(0, 0, 0)' // 사인색
		});
	
	var saveButton = document.getElementById('save');
	var cancelButton = document.getElementById('clear');
	var readButton = document.getElementById('read');
	
	saveButton.addEventListener('click', async function (event) {
	  var data = signaturePad.toDataURL('image/png');
		console.log(btoa(data));
		console.log(data)
		
		let isConfirmed = await Swal.fire({
			  title: "저장시 이전 서명은 삭제됩니다.",
			  showCancelButton: true,
			  confirmButtonText: "Save"
			});
		
		console.log(isConfirmed);
		if(isConfirmed.isConfirmed){
			let resp = await signatureSave(data);
			if(resp == true) {
				Swal.fire("작성성공");
				signaturePad.clear();
				$("#sigImg>img").attr("src",data); 
				
			} else{
				Swal.fire("작성실패");
			}
		}
// 		.then((result) => {
// 			  if (result.isConfirmed) {
// 			    Swal.fire("Saved!", "", "success");
// 			  } else if (result.isDenied) {
// 			    Swal.fire("Changes are not saved", "", "info");
// 			  }
// 			})
		
		
		
	});
	
	cancelButton.addEventListener('click', function (event) {
	  signaturePad.clear();
	});
	
	$("#open").on('click', async function (){
		let data = await readSignature();
		data.forEach(d => {
			let img = document.createElement("img");
          img.src=d.FILE_BASE;
          $("#sigImg").html('');
          document.querySelector("#sigImg").appendChild(img);
		})
		$("#signatureModal").show();
	})

	async function readSignature(){
		let response = await fetch('./signatureReadAjax.do');
		
		if(!response.ok) throw new Error("네트워크 오류")
			
		return await response.json();
	}

	$(".modalBtn").on('click', () => {
		$("#signatureModal").hide();
	})
	
	async function signatureSave(data) {
			let response = await fetch('./signatureSaveAjax.do',{
				method:'post',
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify({img : data})
			});
			
			if(!response.ok) throw new Error("서명저장중 오류발생")
			
			return await response.json();
		}
	</script>
	
</body>
</html>
