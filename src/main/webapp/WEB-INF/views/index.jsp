<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<div id="content" class="col">
		${sessionScope.loginDto}
			<h3 class="content_title">제목trestest</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>라이브러리</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td><a href="./approval/index.do">jsTree / Editor / signaturepad</a></td>
					</tr>
					<tr>
						<td><a href="./grid.do">그리드페이지</a></td>
					</tr>
					<tr>
						<td><a href="./droppable.do">드래그앤드롭</a></td>
					</tr>
						<td><a href="${pageContext.request.contextPath}/calendar/calendar.do">캘린더</a></td>
	      			</tr>
	      			<tr>
						<td><a href="./rooms/reservation.do">예약</a></td>
					</tr>
					<tr>
						<td><a href="./rooms/roomList.do">회의실 리스트(등록,수정)[관리자]</a></td>
					</tr>
				</tbody>
			</table>
			<a href="./login.do" class="btn btn-info">로그인</a><br>
			<a href="./logout.do" class="btn btn-danger">로그아웃</a>
		</div>
	</div>
</main>
	
</body>
</html>
