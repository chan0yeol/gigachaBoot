<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="layout/header.jsp"%>
</head> 
<body>
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10">
			<h3 class="content_title">회의실예약내역조회</h3>
			<div class="card">
					<div class="card-body">
						<table class="table">	
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">회의실명</th>
									<th scope="col">예약날짜</th>
									<th scope="col">예약시간</th>
									<th scope="col">회의사유</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${reservationList}" var="reservation">
									<tr>
										<td scope="col">${reservation.room_id}</td>
										<td scope="col">${reservation.room_name}</td>
										<td scope="col">${reservation.reservation_date}</td>
										<td scope="col">${reservation.reservation_time}</td>
										<td scope="col">${reservation.purpose}</td>
										<td scope="col">
<%-- 											<div class="${room.use_yn eq 'Y' ? 'switch on':'switch'}"> --%>
<!-- 												<div class="slider"></div> -->
<!-- 											</div> -->
										</td>
										<td>
											<button type="button" name="delBtn" class="btn btn-danger" onclick="deleteRev('${reservation.reservation_id}')">취소</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
		</div>
	</div>
</main>

	<script>
	function deleteRev(reservation_id){
// 		if (confirm("정말 취소하시겠습니까?")) {
// 			 $.ajax({
// 	                url: './delReservation.do',  // 권한 확인을 위한 URL
// 	                type: 'GET',
// 	                data: { reservation_id: reservation_id }, // 예약 ID를 서버로 전송
// 	                success: function(response) {
// 	                	if (response.alertMessage) {
// 	                        alert(response.alertMessage);  // 응답에 따라 알림 띄우기
// 	                    }
// 	                },
// 	                error: function() {
		location.href="./delReservation.do?reservation_id="+reservation_id;
// 	                	 alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
// 	                }
// 	            });
// 	        }
	    }
	
	</script>
</body>
</html>
