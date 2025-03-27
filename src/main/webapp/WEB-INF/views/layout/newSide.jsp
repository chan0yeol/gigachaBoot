<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<!-- 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/> -->
<style type="text/css">
.sidecard-body {
/*   padding: 1.5rem; */
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
/*   gap: 0.5rem; */
}

.sidecard-body .employee-name {
  font-size: 1.25rem;
  font-weight: 600;
  color: #333;
  margin-bottom: 0.3rem;
}

.sidecard-body .employee-id {
  font-size: 1rem;
  color: #666;
  font-weight: 500;
  margin-bottom: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #eee;
  width: 100%;
}

.sidecard-body .department {
  font-size: 11px;
  color: #555;
  font-weight: 500;
  margin-right: 0.5rem;
  background-color: #f8f9fa;
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
}

.sidecard-body .job-title {
  font-size: 0.9rem;
  color: #555;
  font-weight: 500;
  background-color: #e9ecef;
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
}

.employee-info-row {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  width: 100%;
}
</style>
</head>
<body>
	<aside id="sidebar" class="sidebar">
	출근사원
	<div id="connectedUsers"></div>
   	<div class="card mb-3 mt-3">
		<img class="card-img-top"
			src="https://yt3.googleusercontent.com/xydasbAktJl4OMRQGV2mEy1Rvf5Y9miqlmVsdIR0Y14rm3fHCOstsYmMlD8MLm7PletRrJr_FiI=s160-c-k-c0x00ffffff-no-rj"
			alt="Card image cap">
		<div class="sidecard-body" >
  			<span class="employee-name">${loginDto.name}</span>
  			<span class="employee-id">사원번호 | ${loginDto.empno}</span>
<!--   			<div class="employee-info-row"> -->
    			<span class="department" id="dept">${loginDto.deptname}</span>
    			<span class="job-title" id="job">${loginDto.job_title}</span>
<!--  			 </div> -->
		</div>
	</div>
    <ul class="sidebar-nav" id="sidebar-nav">
      <li class="nav-item">
        <a class="nav-link " href="${pageContext.request.contextPath}/">
          <i class="bi bi-grid"></i>
          <span>Home</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
          <i class="bi bi-clipboard2-check"></i>
          <span>전자결재</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li class="nav-heading">문서양식</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/formList.do">
              <span>문서양식관리</span>
            </a>
          </li>
          <c:if test="${loginDto.auth eq 'A' }">
	          <li>
	            <a href="${pageContext.request.contextPath}/approval/managerCategoryList.do">
	              <span>카테고리관리</span>
	            </a>
	          </li>
         </c:if>
          <li class="nav-heading">기안</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalDocument.do">
              <span>기안문작성</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalList.do">
              <span>결재요청함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalListTemp.do">
              <span>임시저장함</span>
            </a>
          </li>
          <li class="nav-heading">결재</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalRequestList.do">
              <span>결재대기함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalInProgress.do">
              <span>결재진행함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalCompleted.do">
              <span>완료문서함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalRejected.do">
              <span>반려문서함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalReference.do">
              <span>참조문서함</span>
            </a>
          </li>
          <li class="nav-heading">개인</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/myApproval.do">
              <span>나의결재목록</span>
            </a>
          </li>
          <li id="open">
            <a href="#">
              <span>서명관리</span>
            </a>
          </li>
        </ul>
      </li>
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#res-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
          <i class="bi bi-calendar2-plus"></i>
          <span>인사</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="res-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav" style="">
         <li>
            <a href="${pageContext.request.contextPath}/hrManagement/employeeAdd.do">
              <span>사원등록</span>
            </a>
          </li> 
          <li>
            <a href="${pageContext.request.contextPath}/deptManagement/deptManagement.do">
              <span>부서관리</span>
            </a>
          </li>
        </ul>
      </li>
      
     <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#res-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
          <i class="bi bi-calendar2-plus"></i>
          <span>예약</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="res-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav" style="">
         <li>
            <a href="${pageContext.request.contextPath}/rooms/reservation.do">
              <span>회의실예약</span>
            </a>
          </li> 
          <li>
            <a href="${pageContext.request.contextPath}/rooms/reservationList.do">
              <span>회의실예약내역조회</span>
            </a>
          </li>
        </ul>
      </li>
 
     <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#attendance-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
          <i class="bi bi-calendar2-week"></i>
          <span>근태관리</span>
          <i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="attendance-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li class="nav-heading">나의 근태 관리</li>
          <li>
            <a href="${pageContext.request.contextPath}/attendance/myattendance.do">
              <span>나의 근태 현황</span>
            </a>
          </li>
          <li class="nav-heading">부서 근태 관리</li>
             <li>
            <a href="${pageContext.request.contextPath}/attendance/attendance.do">
              <span>부서 근태 현황</span>
            </a>
          </li>
             <li>
            <a href="${pageContext.request.contextPath}/attendance/leaveattendance.do">
              <span>나의 연차 현황</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- 관리자 메뉴 - 권란이 있는 경우에만 표시 -->
      <c:if test="${loginDto.auth == 'A'}">
       <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#admin-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
         <i class="bi bi-incognito"></i>
          <span>관리자</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="admin-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav" style="">
          <li>
            <a href="${pageContext.request.contextPath}/rooms/roomList.do">
              <span>회의실정보 리스트</span>
            </a>
            <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/rooms/reservationList.do"> 
			  <span>전체회의실내역조회</span>
			</a>
          </li>
        </ul>
      </li>
      </c:if>
    </ul>
<!--     <button id="floatingBtn" class="btn btn-primary btn-lg rounded-circle position-fixed" style="bottom: 20px; right: 20px;"> -->
<!-- 	  + -->
<!-- 	</button> -->
  </aside>    
<!-- 	<div class="modal" id="floatingModal" data-bs-backdrop="static" data-bs-keyboard="false"> -->
<!-- 	  <div class="modal-dialog modal-dialog-scrollabl"> -->
<!-- 	    <div class="modal-content" style="width:700px"> -->
<!-- 	      <div class="modal-header d-flex mb-3"> -->
<!-- 	      	  <div class="me-auto p-2"> -->
<!-- 	      	  	<span class="fs-3">채팅</span> -->
<!-- 	      	  </div> -->
<!-- 	      </div> -->
<!-- 	      <div class="modal-body"> -->
<!-- 	      	<div class="row"> -->
<!-- 	      		<div class="col-3"> -->
<!-- 	      			<ul class="list-group"> -->
<!-- 					  <li class="list-group-item" id="1505001">1505001</li> -->
<!-- 					  <li class="list-group-item">Second item</li> -->
<!-- 					  <li class="list-group-item">Third item</li> -->
<!-- 					</ul> -->
<!-- 	      		</div> -->
<!-- 	      		<div class="col-9"> -->
<!-- 				 <div class="card"> -->
<!-- 				 	<div class="card-title" id="targetEmpno">title</div> -->
<!--   				 	<div class="card-body"> -->
<!--   				 		<div id="chat_div"> -->
<!-- 							<input type="text" id="chat" onkeypress="if((event.keyCode)==13){$('#chat_btn').click()}"> -->
<!-- 							<input type="button" id="chat_btn" value="전송"> -->
<!-- 						</div> -->
<!--   				 	</div> -->
<!--   				 </div> -->
<!-- 	      		</div> -->
<!-- 			</div> -->
<!-- 	      </div> -->
<!-- 	      <div class="modal-footer"> -->
<!-- 	       	<button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button> -->
<!-- 	      </div> -->
<!-- 	      </div> -->
<!-- 	    </div> -->
<!-- 	  </div> -->
	  <script type="text/javascript">
// 	    var chatSocket = null;
// 	    var targetEmpno = null;
// 	    document.querySelectorAll(".list-group-item").forEach(item => {
// 	        item.addEventListener("click", (event) => {
// 	            console.log("클릭됨:", event.target.id);
// 	            targetEmpno = event.target.id
// 	            // 기존 WebSocket 닫기
// 	            if (chatSocket !== null && chatSocket.readyState === WebSocket.OPEN) {
// 	                chatSocket.close();
// 	            }

// 	            // 새로운 WebSocket 연결
// 	            chatSocket = new WebSocket("ws://localhost:9999/GroupWare/wsChat.do");

// 	            chatSocket.onopen = function () {
// 	                console.log("🔗 [Chat] WebSocket 연결됨!");
// 	            };

// 	            chatSocket.onmessage = function (event) {
// 	                console.log("📩 [Chat] 서버 응답:", event.data);
// 	                const chatBox = document.getElementById("chat-box");
// 	                const messageElement = document.createElement("div");
// 	                messageElement.textContent = event.data;
// 	                chatBox.appendChild(messageElement);
// 	            };

// 	            chatSocket.onclose = function () {
// 	                console.log("❌ [Chat] WebSocket 연결 종료됨");
// 	            };

// 	            chatSocket.onerror = function (error) {
// 	                console.error("⚠ WebSocket 오류 발생:", error);
// 	            };

// 	            // 메시지 전송
// 	            document.getElementById("chat_btn").addEventListener("click", () => {
// 	                console.log("대화 내용 전달");
// 	                let messageInput = document.getElementById("chat").value;

// 	                if (messageInput.trim() === "" || targetEmpno.trim() === "") {
// 	                    alert("받는 사람과 메시지를 입력해주세요.");
// 	                    return;
// 	                } else {
// 	                    chatSocket.send("[" + targetEmpno + "]:" + messageInput);
// 	                    document.getElementById("chat").value = "";
// 	                    document.getElementById("chat").focus();
// 	                }
// 	            });
// 	        });
// 	    });
</script>
  <!-- 서명 모달 -->
  <div class="modal" id="signatureModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	      <div class="modal-header d-flex mb-3">
	      	   <div class="pagetitle">
					<h1>서명관리</h1>
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
							<li class="breadcrumb-item">전자결재</li>
							<li class="breadcrumb-item">개인</li>
							<li class="breadcrumb-item active">서명관리</li>
						</ol>
					</nav>
				</div>
			 
	      </div>
	      <div class="modal-body">
	      	<div class="row border-bottom">
				<div class="col">
					<h5>서명을 그리세요</h5>					
					<div class="wrapper" >
						<canvas id="signature-pad" class="signature-pad" width=200 height=200></canvas>
						 <div>
						  	<button id="save" class="btn btn-sm btn-success">저장</button>
						  	<button id="clear" class="btn btn-sm btn-danger">초기화</button>
						 </div>
					</div>
				</div>
				<div class="col">
					<h5>저장된서명</h5>
					<div class="info-box card">
						<div id="sigImg"></div>
	              	</div>
				</div>
			</div>
<!-- 			<div class="row mt-3"> -->
<!-- 				<div class="col"> -->
<!-- 					<h5>도장</h5> -->
<!-- 				</div> -->
<!-- 			</div> -->
	      </div>
	      <div class="modal-footer">
	       	<button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      </div>
	      </div>
	    </div>
	  </div>
</body>
<script type="text/javascript">
	
	$("#floatingBtn").on('click',() => {
		$("#floatingModal").show();
	})
	var contextUrl = "${pageContext.request.contextPath}";
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
		let response = await fetch(contextUrl+'/approval/signatureReadAjax.do');
		
		if(!response.ok) throw new Error("네트워크 오류")
			
		return await response.json();
	}

	$(".modalBtn").on('click', () => {
		$("#signatureModal").hide();
		$("#floatingModal").hide();
	})
	
	async function signatureSave(data) {
			let response = await fetch(contextUrl+'/approval/signatureSaveAjax.do',{
				method:'post',
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify({img : data})
			});
			
			if(!response.ok) throw new Error("서명저장중 오류발생")
			
			return await response.json();
		}
	
	
// 	var dept = document.getElementById("dept");
// 	var job = (document.getElementById("job");
	
// 	if(lo)
	
	
	</script>

</html>