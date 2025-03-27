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

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
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
										<td scope="col">${reservation.reservation_id}</td>
										<td scope="col">${reservation.room_name}</td>
										<td scope="col">${reservation.reservation_date}</td>
										<td scope="col">${reservation.reservation_time}</td>
										<td scope="col">${reservation.purpose}</td>
										<td scope="col">
										<c:if test="${not empty sessionScope.loginDto}">
										 <!-- 예약이 존재하는지 확인 -->
    									  <c:if test="${not empty reservation}">
											<c:if test="${sessionScope.loginDto.auth eq 'A'}">
														관리자
													<button class="btn btn-danger" onclick="deleteRev('${reservation.reservation_id}')">
														취소
													</button>
											</c:if>
											<c:if test="${reservation.reserver ne null && reservation.reserver eq sessionScope.loginDto.empno}">
													예약자
												<button class="btn btn-danger" onclick="deleteRev('${reservation.reservation_id}')">
													취소
												</button>
											</c:if>
											<c:if test="${reservation.reserver ne sessionScope.loginDto.empno && sessionScope.loginDto.auth ne 'A'}">
        											참여자
											</c:if>
										  </c:if>
										</c:if>		
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
	    if (confirm("정말 취소하시겠습니까?")) {
	        $.ajax({
	            url: './delReservation.do',
	            type: 'GET',
	            data: { reservation_id: reservation_id },
	            dataType: 'json', // 명시적으로 JSON 응답을 기대함
	            success: function(response) {
	                console.log("서버 응답:", response); // 서버 응답 확인
	                
	                if (response.Message) {
	                    alert(response.Message);
	                    location.reload(); // 성공했을 때만 페이지 새로고침
	                } else if (response.errorMessage) {
	                    alert(response.errorMessage);
	                } else {
	                    alert("알 수 없는 응답입니다.");
	                    console.log("알 수 없는 응답:", response);
	                }
	            },
	            error: function() {
	                alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
	            }
	        });
	    }
	}
	
	</script>
</body>
</html>
