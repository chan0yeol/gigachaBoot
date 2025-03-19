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
			<h3 class="content_title">소켓테스트123</h3>
			<div>
				<i class="bi bi-exclamation-circle text-warning"></i><span>알림 1234</span>
			</div>
			<a href="./login.do" class="btn btn-info">로그인</a><br>
			<a href="./logout.do" class="btn btn-danger">로그아웃</a>
		</div>
	</div>
</main>
<script src="${pageContext.request.contextPath}/resources/js/notificationWebSocket.js"></script>
</body>
</html>
