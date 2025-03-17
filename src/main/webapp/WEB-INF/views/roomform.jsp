<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 등록 폼</title>
<%@ include file="layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.container {
	max-width: 960px;
	margin: 0 auto;
	border: 1px solid #ccc;
	background-color: white;
}

.header {
	background-color: #f0f4fa;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.main-content {
	flex-grow: 1;
	padding: 0 20px;
}

.info-box {
	display: flex;
	margin-bottom: 30px;
}

.info-left {
	width: 250px;
	background-color: #4a75cb;
	color: white;
	padding: 20px;
	text-align: center;
}

.info-left h3 {
	margin: 0 0 10px 0;
	font-size: 16px;
}

.info-right {
	flex-grow: 1;
	padding: 15px;
}

.form-group {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.form-label {
	width: 150px;
	text-align: center;
	padding-right: 15px;
	font-size: 14px;
}

.form-input input {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.button-area {
	text-align: center;
	margin-top: 30px;
	margin-bottom: 20px;
}

.register-btn {
	background-color: #4a75cb;
	color: white;
	border: none;
	padding: 8px 20px;
	border-radius: 3px;
	cursor: pointer;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
}

.register-btn:hover {
	background-color: #3a65b8;
}

.btn-icon {
	margin-right: 5px;
	font-size: 16px;
}
</style>
</head>
<body>
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div id="content">
		<h3 class="content_title">회의실 등록</h3>
			<form id="roomform" action="./insertRoom.do" method="post"
				enctype="multipart/form-data">
				<div class="main-content">
					<div class="info-box">
						<div class="info-left">
							<h3>회의실 사진</h3>
							<div class="image-upload-container">
								<div class="image-preview" id="imagePreview">
									<img src="" alt="미리보기" id="preview"
										style="display: none; max-width: 100%; max-height: 100%;">
									<p id="previewText">사진을 선택해주세요</p>
								</div>
								<input type="file" id="roomImage" name="room_image"
									accept="image/*" style="display: none;">
								<button type="button" id="uploadBtn" class="btn btn-secondary">사진
									선택</button>
							</div>
						</div>

						<div class="info-right">
							<div class="form-group">
								<div class="form-label">회의실 이름:</div>
								<div class="form-input">
									<input type="text" name="room_name">
								</div>
							</div>

							<div class="form-group">
								<div class="form-label">회의실 수용인원:</div>
								<div class="form-input">
									<input type="text" name="capacity">
								</div>
							</div>
						</div>
					</div>
					<!-- 등록버튼 -->
					<div class="button-area">
						<button class="btn btn-primary" type="submit">등록하기</button>
					</div>
				</div>
			</form>
		</div>
		
		<!-- 모달 창 -->
		<div id="roomModal" class="modal">
			<div class="modal-content">
				<span class="close-btn">&times;</span>
				<h3 id="modalRoomName"></h3>
				<div class="modal-image-container">
					<img id="modalRoomImage" alt="회의실 이미지" src="">
				</div>
				<p id="modalRoomCapacity"></p>
			</div>
		</div>
	</main>
	<script type="text/javascript">
	 function registerRoom() {
         let formData = new FormData(document.forms[0]);   
     }
	 
// 	  document.getElementById("roomImage").addEventListener("change", function (event) {
// 	        const file = event.target.files[0];
// 	        if (file) {
// 	            const reader = new FileReader();
// 	            reader.onload = function (e) {
// 	                document.getElementById("imagePreview").src = e.target.result;
// 	                document.getElementById("imagePreview").style.display = "block";
// 	                document.getElementById("imagePreviewText").style.display = "none";
// 	            };
// 	            reader.readAsDataURL(file);
// 	        }
// 	    });
	 
// 	 document.addEventListener('DOMContentLoaded', function(){
// 		 //파일 업로드 기능
// 		 const uploadBtn = document.getElementById('uploadBtn');
// 		 const fileInput = document.getElementById('roomImage');
// 		 const preview = document.getElementById('preview');
// 		 const previewText = document.getElementById('previewText');
		 
// 		 uploadBtn.addEventListener('click', function(){
// 			fileInput.click(); 
// 		 });
		 
// 		 fileInput.addEventListener('change', function(){
// 			 const file = this.file[0];
// 			 if(file){
// 				 const reader = new FileReader();
// 				 reader.onload = function(event){
// 					 preview.src = event.target.result;
// 					 preview.style.display = 'block';
// 					 previewText.style.display = 'none';
// 				 };
// 				 reader.readAsDataURL(file);
// 			 }
// 		 });
		 
// // 		 //폼 제출
// 		 const roomForm = document.getElementById('roomForm');
// 		 roomForm.addEventListener('submit', function(event){
// 			 event.preventDefault();
			 
// 			 const formData = new FormData(this);
			 
// 			 //AJAX로 서버 전송
// 			 fetch('./insertRoom.do', {
// 				 method: 'POST',
// 				 body: formData
// 			 })
// 			 .then(response => response.json())
// 			 .then(data => {
// 				 if(data.success){
// 					 alert('회의실이 등록되었습니다.');
// 					 location.reload();
// 				 }else{
// 					 alert('회의실 등록이 실패했습니다.');
// 				 }
// 			 })
// 			 .catch(error => {
// 				 console.log('Error:', error);
// 				 alert('오류가 발생했습니다.');
// 			 });
			 
// 			 const room_name = formData.get('room_name');
// 			 const room_name = formData.get('capacity');
// 			 const image_url = formData.get('image_url');
			 
// 			 const rooms = JSON.parse(localStorage.getItem('meetingRooms') || '[]');
// 			 const image_url = ''; //실제 서버에서 반환된 url
			 
// 			 rooms.push({
// 				room_id: Date.now().toString(),
// 				room_name: room_name,
// 				capacity: capacity,
// 				image_url: image_url
// 			 });
// 			 localStorage.setItem('meetingRooms', JSON.stringify(rooms));
			 
// 			 //폼 초기화
// 			 roomForm.reset();
// 			 preview.style.display = 'none';
// 			 previewText.style.display = 'block';
			 
// 			 alert('회의실이 등록되었습니다.');
// 			 location.reload();
// 			}
// 	 	});
		 
// 		 //회의실 목록 로드 함수
// 		 function loadRoomList(){
// 			 const roomList = document.querySelector('.room_List');
			 
// 			 fetch('./roomList.do')
// 			 .then(response => response.json())
// 			 .then(data => {
// 				 renderRooList(data);
// 			 })
// 			 .catch(error => {
// 				 console.log('Error:', error);
// 			 });
// // 			 const rooms = JSON.parse(localStorage.getItem('meetingRooms') || '[]');
// // 				renderRoomList(rooms);
// 		 }
		 
// 		// 회의실 목록 렌더링 함수
// 		function renderRoomList(rooms){
// 			const roomList = document.querySelector('.room_List');
// 			roomList.innerHTML = '';
// 		}
		 
		 
		 
		 
		 
	</script>
</body>
</html>