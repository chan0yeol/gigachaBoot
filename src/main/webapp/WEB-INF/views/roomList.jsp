<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 리스트</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.switch {
	width: 50px;
	height: 25px;
	background-color: #ccc;
	border-radius: 25px;
	position: relative;
	cursor: pointer;
	transition: background-color 0.3s;
}

.switch .slider {
	width: 20px;
	height: 20px;
	background-color: white;
	border-radius: 50%;
	position: absolute;
	top: 50%;
	left: 3px;
	transform: translateY(-50%);
	transition: left 0.3s;
}

.switch.on {
	background-color: #4caf50;
}

.switch.on .slider {
	left: 27px;
}
</style>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="row">
			<div id="content" class="mt-3">
				<h3 class="content_title">회의실 리스트</h3>
				<div class="card">
					<div class="card-body">
						<table class="table">
							<caption>
<!-- 								<button type="button" class="btn btn-primary" -->
<!-- 									onclick="location.href='./roomform.do'">회의실 등록</button> -->
								<button type="button" class="btn btn-primary" id="insertBtn">회의실 등록</button>
							</caption>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">회의실명</th>
									<th scope="col">수용인원</th>
									<th scope="col">등록일</th>
									<th scope="col">수정일</th>
									<th scope="col">회의실이미지</th>
									<th scope="col">사용여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${roomList}" var="room">
									<tr>
										<td scope="col">${room.room_id}</td>
										<td scope="col">${room.room_name}</td>
										<td scope="col">${room.capacity}</td>
										<td scope="col">${room.created_at}</td>
										<td scope="col">${room.updated_at}</td>
										<td scope="col">${room.image_url}</td>
										<td scope="col">
											<div class="${room.use_yn eq 'Y' ? 'switch on':'switch'}">
												<div class="slider"></div>
											</div>
										</td>
										<td>
											<button type="button" name="modifyBtn" class="btn btn-info">수정</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
		<!-- 수정 모달 창 -->
		<!-- tabindex="-1": 키보드를 통해 모달을 닫을 수 없도록 -->
		<!-- Modal -->
		<div class="modal fade" id="updateModal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실 정보
							수정</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="room_id">
						<div class="mb-3">
							<label for="room_name" class="form-label">회의실 이름</label> <input
								type="text" class="form-control" id="room_name">
						</div>
						<div class="mb-3">
							<label for="capacity" class="form-label">수용인원</label> <input
								type="number" class="form-control" id="capacity" min="1"
								max="15">
						</div>
						<div class="mb-3">
							<label for="image_url" class="form-label">회의실 이미지</label> 
							<input type="file" class="form-control" id="image_url" name="file" accept="image/*" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" id="updateRoomForm" class="btn btn-primary">수정</button>
					</div>
				</div>
			</div>
		</div>
<		<!-- 등록 Modal --> 
		<div class="modal fade" id="insertModal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실 등록</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
					<form id="insertRoomForm" enctype="multipart/form-data">
						<div class="mb-3">
							<label for="room_name" class="form-label">회의실 이름</label> 
							<input type="text" class="form-control" id="room_name" name="room_name" required>
						</div>
						<div class="mb-3">
							<label for="capacity" class="form-label">수용인원</label> 
							<input type="number" class="form-control" id="capacity" name="capacity" min="1" max="15" required>
						</div>
						<div class="mb-3">
							<label for="image_url" class="form-label">회의실 이미지</label> 
							<input type="file" class="form-control" id="image_url" name="file" accept="image/*" required>
						</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" id="insertFormBtn" class="btn btn-primary">등록</button>
					</div>
					</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
             
        window.onload = function(){
        	var updateModal;
        	var insertModal;

        	var switchBtn =  document.querySelectorAll(".switch")
        	console.log("스위치 버튼 갯수 : ", switchBtn.length)
        	for(let i=0; i < switchBtn.length; i++ ){
        		switchBtn[i].onclick=function(){
        			this.classList.toggle("on");
//         			console.log(this.className)
        			var parent = this.closest("tr");  // 현재 행 찾기
        			var room_id = parent.children[0].textContent; // 첫 번째 열에 room_id 있다고 가정
					var use_yn = this.classList.contains("on") ? 'Y' : 'N'; // 스위치 상태 확인
					    
					console.log("room_id: ", room_id);
					console.log("use_yn: ", use_yn);
					
        			if (this.classList.contains("on")) {
					    console.log("스위치가 켜져 있습니다.");
					    
// 					    var room_id = document.getElementById("room_id").value;
// 	        			var room_name = document.getElementById("room_name").value;
// 	        			var capacity = document.getElementById("capacity").value;
					    //AJAX 작업으로 update use_yn 을 Y
					    $.ajax({
					        url: './update.do',
					        method: 'POST',
					        contentType: 'application/json',
					        data: JSON.stringify({
					            room_id: room_id, // 실제 회의실 ID
					            use_yn: use_yn
					        }),
					        success: function(response) {
					        	console.log(response);
					            if(response) {
					                console.log("사용 상태 업데이트 성공");
					            } else {
					                console.error("업데이트 실패");
					            }
					        },
					        error: function(error) {
					            console.error('Error:', error);
					            //실패 시 원래 상태로 되돌리기
// 					            this.classList.toggle("on");
					        }
					    });
					} else {
					    console.log("스위치가 꺼져 있습니다.");
// 					    this.classList.toggle("on");
					    
					    var parent = this.closest("tr");  // 현재 행 찾기
						var room_id = parent.children[0].textContent; // 첫 번째 열에 room_id 있다고 가정
						var use_yn = this.classList.contains("on") ? 'Y' : 'N'; // 스위치 상태 확인
						    
						console.log("room_id: ", room_id);
						console.log("use_yn: ", use_yn);
						
// 						var room_id = document.getElementById("room_id").value;
// 	        			var room_name = document.getElementById("room_name").value;
// 	        			var capacity = document.getElementById("capacity").value;
					  //AJAX 작업으로 update use_yn 을 N
					    $.ajax({
					        url: './update.do',
					        method: 'POST',
					        contentType: 'application/json',
					        data: JSON.stringify({
					        	room_id: room_id, // 실제 회의실 ID
					        	use_yn: use_yn
					        }),
					        success: function(response) {
					            if(response) {
					                console.log("사용 상태 업데이트 성공");
					            } else {
					                console.error("업데이트 실패");
					            }
					        },
					        error: function(error) {
					            console.error('Error:', error);
					        }
					    });
					}
        		};
        	} // switch 버튼 이벤트
        	
        	var modifyBtn = document.getElementsByName("modifyBtn");
        	console.log("수정버튼 갯수 :", modifyBtn.length);
        	for(let i=0; i<modifyBtn.length; i++){
        		modifyBtn[i].onclick =function(){
        			var parent = this.closest("tr");
        			var room_id_p = parent.children[0].textContent;
        			var room_name_p = parent.children[1].textContent;
        			var capacity_p = parent.children[2].textContent;
        			var created_at_p = parent.children[3].textContent;
        			var updated_at_p = parent.children[4].textContent;
        			var image_url_p = parent.children[5].textContent;
        			
        			var room_id = document.getElementById("room_id");
        			var room_name = document.getElementById("room_name");
        			var capacity = document.getElementById("capacity");
        			var image_url = document.getElementById("image_url");
//         			var created_at= document.getElementById("created_at");       			
        			
        			
        			console.log("현재정보 : " , room_id_p , room_name_p, capacity_p, created_at_p, updated_at_p);
        			
        			room_id.value = room_id_p;
        			room_name.value = room_name_p;
        			capacity.value = capacity_p;
//         			image_url.value = image_url_p;
        			
        			updateModal = new bootstrap.Modal(document.getElementById("updateModal"));
        	        updateModal.show();
        		}
        	}
        	
        	document.getElementById("updateRoomForm").onclick = function(event) {
        	    event.preventDefault();  // 폼 제출 이벤트 방지
        	    console.log(event.target) //  modal button 
        	    var room_id = document.getElementById("room_id").value;
        	    var room_name = document.getElementById("room_name").value;
    			var capacity = document.getElementById("capacity").value;
    			var image_url = document.getElementById("image_url").files[0];
    			
    			var formData = new FormData();
    		    formData.append("room_id", room_id);
    		    formData.append("room_name", room_name);
    		    formData.append("capacity", capacity);
    		    formData.append("file", image_url); // 파일 데이터 추가


    			console.log("전송될 값 :", room_id,room_name, capacity,image_url);
    			
    			var roomDto = {
    					room_id: room_id,
    					room_name: room_name,
    					capacity: capacity,
    					image_url:image_url
            	    };

    			fetch("./update.do", {
    			    method: "POST",
    			    headers: {
    			        "Content-Type": "application/json"
    			    },
    			    body: JSON.stringify(roomDto)
    			})
    			.then(response => {
    			    if (!response.ok) {
    			        throw new Error("서버 응답 오류: " + response.status);
    			    }
    			    return response.json(); // JSON 형식의 응답을 파싱
    			})
    			.then(data => {
    			    console.log(data);
					updateModal.hide();					 
    			    location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
    			})
    			.catch(error => {
    			    console.error("Error updating room data:", error);
    			});

        	}
        	
			// 회의실 등록 버튼 클릭 이벤트
        	var insertBtn = document.getElementById("insertBtn");
        	insertBtn.onclick = function() {
        	    // 모달을 열기 전에 입력 필드를 초기화 (필요한 경우)
        	    var room_id = document.getElementById("room_id");
        	    var room_name = document.getElementById("room_name");
        	    var capacity = document.getElementById("capacity");
        	    var image_url = document.getElementById("image_url");

        	    room_id.value = '';   // 입력 필드 초기화
        	    room_name.value = ''; // 입력 필드 초기화
        	    capacity.value = '';  // 입력 필드 초기화
        	    image_url.value = '';  // 입력 필드 초기화

        	    // 회의실 등록 모달 띄우기
        	    var insertModal = new bootstrap.Modal(document.getElementById("insertModal"));
        	    insertModal.show();
        	}
        	
        	//등록
        	document.getElementById("insertFormBtn").onclick = function(event) {
        	    event.preventDefault();  // 폼 제출 이벤트 방지
        	    
        	    //폼 데이터 생성
        	    var form = document.getElementById("insertRoomForm");
        	    var formData = new FormData(form);
        	    
        	    fetch("./insertRoom.do", {
    			    method: "POST",
    			    body: formData
    			})
    			.then(response => {
    			    if (!response.ok) {
    			        throw new Error("서버 응답 오류: " + response.status);
    			    }
    			    return response.json(); // JSON 형식의 응답을 파싱
    			})
    			.then(data => {
    			    console.log("서버 응답 데이터:",data);
    			    if(data == true){
    			    	Swal.fire("작성 성공").then(()=>{
    			   			location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
    			    		
    			    	});
    			    }else{
    			    	Swal.fire("로그인 해주세요.");
    			    }

// 					insertModal.hide();
    			})
    			.catch(error => {
    			    console.error("Error updating room data:", error);
    			});
        	    
        	}
        	


        }
    </script>
</body>
</html>