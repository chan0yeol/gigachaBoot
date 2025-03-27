<%@page import="com.giga.gw.dto.RoomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>항상 보이는 Datepicker</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<style>
.btn-container { /* 추가: 부모 요소 클래스 */
	display: flex;
}

.btn_bg {
	align-items: center;
	justify-content: center;
	width: 100px;
	height: 40px;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	box-sizing: border-box;
	margin: 10px 20px;
	line-height: 40px; /* 추가: 세로 가운데 정렬 */
}
#content > div {
    display: inline-block;
}

.nocheck:hover {
	border: 1px solid red;
}

.nocheck {
	background-color: #E9F3FF;
	color: #2D8CFF;
}

.check {
	background-color: #2388FF;
	color: #E4FAFF;
}

/* 캘린더 스타일 조정 */
#datepicker {
	position: absolute;
	top: 0px;
	left: 100%; 
 	margin-left:90px; 
  	transform: translateX(110%); /* 오른쪽 정렬 보정 */
}
.ui-datepicker {
    width: 350px; /* 달력 너비 조정 */
    height: 300px; /* 달력 높이 조정 */
    font-size: 20px; /* 글꼴 크기 조정 */
    padding: 0px; /* 패딩 조정 */
}
.date-picker-container {
	position: absolute;
	top: 0; /* 달력의 상단 위치 조정 */
    left: 50%; /* 달력의 왼쪽 위치 조정 (테이블 너비에 따라 조정 필요) */
/* 	display: inline-block; */
/* 	vertical-align: top; */
	margin-left: 20px; /* 달력과 테이블 간 간격 조정 */
}
.modal-backdrop {
	background-color: transparent !important; /* 배경 투명하게 설정 */
	/* 또는 */
	opacity: 0.5 !important; /* 배경 투명도 조절 */
}
.reservation-table {
	width: auto; /* 테이블 너비 자동 조정 */
	border-collapse: collapse;
	margin-right: 20px; /* 테이블과 캘린더 간격 조정 */
}
 .reservation-table th, .reservation-table td { 
 	border: 1px solid #ddd; 
 	padding: 8px; 
 	text-align: center; 
 } 
.reservation-table th {
	background-color: #f2f2f2;
}
 .reservation-status { 
 	display: inline-block; 
	align-items: center;  
 	margin: 10px; 
 } 
 .content_title { 
 	margin-bottom: 20px; 
 } 
.disableBtn{
	background-color: #cccccc !important;
    cursor: not-allowed !important;
    opacity: 0.7 !important;
    border-color: #cccccc !important;
    color: #666666 !important;
}
</style>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="container mt-5"></div>
		<!-- 항상 보이는 달력 -->
		<div id="content">

			<h3 class="content_title">예약하기</h3>
			<table>
				<thead>
					<tr>
						<th class="text-center">회의실명</th>
						<th class="text-center" colspan="4">예약상태</th>
						<td rowspan="5" style="position: relative;" width="270">
							<div style="position: relative;">
								<div id="datepicker"></div>
							</div>
						</td>
					</tr>
				</thead>
				<tbody>
				
				<!-- 회의실 목록과 시간대를 분리하여 구현 -->
<!-- 				<div style="display: flex;"> -->
					<table class="reservation-table">
						<thead>
							<tr>
							<th></th>
								<th>회의실명</th>
								<c:forEach var="timeSlot" items="${timeSlots}">
									<th>${timeSlot}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="room" items="${rooms}" varStatus="roomStatus">
								<tr>
									<td><img src="/GroupWare/storage/${room.image_url}?v=${timestamp}" width="100px" height="100px"></td>
									<td class="room_name" data-room_id="${room.room_id}">${room.room_name}</td>
									<c:forEach var="timeSlot" items="${timeSlots}"
										varStatus="timeStatus">
										<c:set var="isReserved" value="false" />
										<!-- 예약 데이터 반복문 -->
										<c:forEach var="res" items="${reservation}">
											<c:if
												test="${res.room_id == room.room_id and res.reservation_time == timeSlot}">
												<c:set var="isReserved" value="true" />
											</c:if>
										</c:forEach>

										<td>
											<div
												class="btn_bg nocheck text-center ${isReserved ? 'disableBtn' : ''}"
												data-image_url="${room.image_url}"
												data-room_id="${room.room_id}"
												data-room_name="${room.room_name}"
												data-time-slot="${timeSlot}"
												data-slot-num="${timeStatus.index + 1}"
												name="${isReserved ? '' : 'reserBtn'}"
												onclick="toggleCheck(this)">${timeStatus.index + 1}</div>
										</td>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>

					</table>
				</tbody>
			</table>
			</div>
		<!-- 예약 모달 창 -->
		<!-- tabindex="-1": 키보드를 통해 모달을 닫을 수 없도록 -->
		<!-- Modal -->
		<div class="modal fade" id="reservationModal"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실 예약</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="room_id">
						<input type="text" id="room_name">
						<input type="text" id="reservation_date">
						<input type="text" id="reservation_time">
						<div class="mb-3">
							<label for="reserver" class="form-label">예약자</label> 
							<input type="text" class="form-control required" id="reserver" value="${loginDto.empno}" readonly>
						</div>
						<div class="mb-3">
							<label for="capacity" class="form-label">예약인원수</label> 
							<input type="number" class="form-control required" id="capacity" value="1" min="1" max="15">
						</div>
						<div class="mb-3">
							<label for="member" class="form-label">참여자</label> 
							<div id="member" class="form-control required"></div>
						</div>
						<div class="mb-3">
							<label for="purpose" class="form-label">회의 사유</label> 
							<input type="text" class="form-control required" id="purpose">
						</div>
						<div id="organization">
							<h2>조직도</h2>
							<input type="text" id="searchInput" placeholder="검색"> <br>
							<div id="organizationTree"></div>
							<div id="approvalList"></div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal" id="cancelBtn">취소</button>
						<button type="button" id="reserSend" 
							class="btn btn-primary">예약</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
    	
		var approvalLine = [];
		
		var d;
		
		$(document).ready(function() {
			
			var date = new Date();
			console.log(date.toISOString().split('T')[0]);
			document.getElementById("reservation_date").value = date.toISOString().split('T')[0];
			const paramdate = '${date}';
			console.log(paramdate);
			if(paramdate.length==0){
				document.getElementById("reservation_date").value = date.toISOString().split('T')[0];
			}else{
				document.getElementById("reservation_date").value = paramdate;
			}
			
			
			// 데이터 피커 날짜 선택
			$("#datepicker").datepicker({
				inline : true, // 항상 보이도록 설정
				dateFormat : "yy-mm-dd", // 날짜 형식 설정
				changeYear : true, // 연도 변경 가능
				changeMonth : true, // 월 변경 가능
				showOtherMonths : true, // 이전/다음 달 날짜도 표시
				selectOtherMonths : true, // 다른 달 날짜도 선택 가능
				dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
			    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
			    monthNames: [
			        "1월", "2월", "3월", "4월", "5월", "6월",
			        "7월", "8월", "9월", "10월", "11월", "12월"
			    ],
			    monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
                    "7월", "8월", "9월", "10월", "11월", "12월"],
                currentText: "오늘",
  				prevText: "이전 달",
  				nextText: "다음 달",
  				yearSuffix: "년",
  				showMonthAfterYear: true, // 연도 뒤에 월 표시
				onSelect : function(dateText) {
					console.log("선택한 날짜: " + dateText);
					document.getElementById("reservation_date").value = dateText;
					location.href="./reservation.do?date="+dateText;
				}
			});
			
			//  예약 모달  show
			var reservationModal;
			var reserBtn = document.getElementsByName("reserBtn");
		    console.log("예약버튼 갯수 :", reserBtn.length);
	    	
		   	for(let i=0; i<reserBtn.length; i++){
	    		reserBtn[i].onclick =function(){
	    		
	    		d = this;
	    		
	    		var parent = this.closest("tr");
	    		console.log(parent.children[0].textContent.trim())
	    			
	    		console.log("선택된 예약 시간 : ",this.textContent, typeof this.textContent);
	    		var choice_time = Number(this.textContent);
	    		var choice_temp = "";
	    		switch (choice_time) {
				    case 1:choice_temp ="08:00-10:00";break;
				    case 2:choice_temp ="10:00-12:00";break;
				    case 3:choice_temp ="13:00-15:00";break;
				    case 4:choice_temp ="15:00-17:00";break;  
				}
	    		console.log("선택된 예약 시간 : ", choice_temp)
	    		document.getElementById("reservation_time").value = choice_temp;
	    		
	    		document.getElementById("room_id").value = this.dataset.roomId; // data-room_id 속성 값 사용
	    		document.getElementById("room_name").value = parent.children[1].textContent.trim();
	    		
	    			
	   			reservationModal = new bootstrap.Modal(document.getElementById("reservationModal"));
    			reservationModal.show();
    		
	   			}
    		}
		    
		   	// 예약전송 send submit
		   	document.getElementById("reserSend").onclick=function(){
		   		event.preventDefault();
		   		let requiredFields = document.querySelectorAll(".required");
		   		let isValid = true;
		   		
		   		requiredFields.forEach(function(field){
		   			if(field.value === ""){ //빈칸 확인
		   				isValid = false;
		   			}else{
		   				field.style.border = ""; // 값이 있으면 원래대로
		   			}
		   		});
		   		
		   		if(!isValid){
		   			alert("모든 항목을 입력하세요.");
		   			return;
		   		}
		   		
		   		console.log("send 작동");
		   		//예약 버튼 비활성화
		   		console.log(d);
		   		
// 		   		var room_id = document.getElementById("room_id").value;
		   		var room_name = document.getElementById("room_name").value;
// 		   		var room_id = findRoomIdByName(room_name);
		   		var reservation_date = document.getElementById("reservation_date").value;
		   		var reservation_time = document.getElementById("reservation_time").value;
		   		var reserver = document.getElementById("reserver").value;
		   		var capacity = document.getElementById("capacity").value;
		   		var member = document.getElementById("member").textContent;
		   		var purpose = document.getElementById("purpose").value;
		   		
		   		console.log("예약 정보 :",reserver, capacity, member.replace("✖","/") , purpose)
		   		const ids = approvalLine.map(item => item.id).join('/');

				console.log(ids)
		   		var reservationDto = {
// 		   			room_id:room_id,
		   			room_name:room_name,
		   			reservation_date:reservation_date,
		   			reservation_time:reservation_time,
		   			reserver:reserver,
		   			capacity:capacity,
// 		   			member:member.replace("✖","/") ,
		   			member:ids,
		   			purpose:purpose,
		   		};
		   		
		   		console.log(JSON.stringify(reservationDto));
		   		
		   		fetch("./api/reservation.do", {
	                method: "POST",
	                headers: {
	                    "Content-Type": "application/json"
	                },
	                body: JSON.stringify(reservationDto)
	                })
	                .then(response => {
	                    if (!response.ok) {
	                        response.text().then(text => {
	                             console.error("서버 응답 오류:", response.status, text);
	                        });
	                        throw new Error("서버 응답 오류: " + response.status);
	                    }
	                    return response.json(); // JSON 형식의 응답을 파싱
	                })
	                .then(data => {
	                    if(data){ //성공 시 
	                        alert('예약이 완료되었습니다.');
	                        reservationModal.hide();
	                        location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
	                        d.style.backgroundColor = "#ccc";
	                        d.onclick = '';
	                    }else{
	                        alert('에약에 실패했습니다.');
	                    }

	                })
	                .catch(error => { //실패 시
	                    if (error.response && error.response.status === 500) {
	                        error.response.text().then(errorMessage => {
	                        console.error('예약 중 오류:', error);                        
	                        alert('예약 중 오류가 발생했습니다: ' + errorMessage);
	                        });
	                    } else {
	                        alert('예약 중 오류가 발생했습니다.');
	                    }
	                });
		   		
		   	};
		   	document.getElementById("cancelBtn").addEventListener("click", function() {
		   	    var requiredFields = document.querySelectorAll(".required");
		   	    
		   	    requiredFields.forEach(function(field) {
		   	     if (field.id !== "reserver" && field.id !== "capacity") {
		   	        field.value = ""; // 입력값 초기화
		   	     }
		   	        field.style.border = ""; // 테두리 원래대로
		   	    });
		   	});
		  
		   	
	    	
		    	// 조직도 jstress 조회 출력
		        $('#organizationTree').jstree({
		        	'plugins' : ["search"],
		        	"search":{
		                "show_only_matches": true // 검색 결과만 표시
		        	},
		            'core': {
		                'data': function (node, cb) {
		                    $.ajax({
		                        url: "${pageContext.request.contextPath}/approval/treeAjax.do",
		                        type: "GET",
		                        dataType: "json",
		                        success: function (data) {
		                        	console.log(data);
		                            cb(data);
		                        }
		                    });
		                }
		            }
		        });
		        
		        $("#searchInput").keyup(function () {
		            let searchText = $(this).val();
		            $("#organizationTree").jstree(true).search(searchText);
		        }); // search end

		        // 사원 선택 이벤트 (결재선 추가)
		        $('#organizationTree').on("select_node.jstree", function (e, data) {
		            let selectedNode = data.node;
		            let empNo = selectedNode.id;
		            let empName = selectedNode.text;
		    		
		            if (!empNo.startsWith("D") && !empNo.startsWith("HQ")) { // 부서가 아닌 사원만 추가
		                addToApprovalLine(empNo, empName);
		            	return;
		            }
		        }); // organizationTree end
		    	
		}); //$(document).ready
		
		
		
		
 // 결재선 추가 함수
    function addToApprovalLine(empNo, empName) {
        // 중복 방지
        if (approvalLine.some(emp => emp.id === empNo)) {
            alert("이미 추가된 사원입니다.");
            return;
        }
        // 3명 체크
        if(approvalLine.length == 300) {
        	alert("결재선은 3명까지 지정 가능합니다.");
        	return;
        }

        // 결재선 목록에 추가
        approvalLine.push({ id: empNo, name: empName});
        updateApprovalList();
    }

    // 결재선 리스트 업데이트
    function updateApprovalList() {
        $("#member").empty();
		console.log("선택 참여자 : ",approvalLine);
		let html = "";
		approvalLine.forEach( (emp , i) => { 
				console.log(emp.name,emp.id);
				html += "<div>";
				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
				html += "<span class='remove-btn' onclick='removeFromApprovalLine(\""+emp.id+"\")'>✖</span>"
				html += "</div>";
				console.log(html);
		})
		$("#member").html(html);
    }

    // 결재선에서 삭제
    function removeFromApprovalLine(empNo) {
        approvalLine = approvalLine.filter(emp => emp.id !== empNo);
        updateApprovalList();
    }

 
	</script>


</body>
</html>
