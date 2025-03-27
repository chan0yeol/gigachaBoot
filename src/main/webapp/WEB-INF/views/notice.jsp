<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice</title>

<%@ include file="./layout/header.jsp"%>

<style type="text/css">


</style>

</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10">
			<h3 class="content_title">공지사항</h3>
			<div style="display: flex; justify-content: center; align-items: center; text-align: center;">
				<table class="table table-hover" style="margin: auto;">
					<thead>
						<tr>
							<td>번호</td>
							<td>작성자</td>
							<td style="width: 40%;">제목</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${notice}" var="dto">
						<tr>
							<td><a href="./approvalDetail.do?id=${dto.approval_id}">${dto.approval_id}</a></td>
							<td>${dto.empno}</td>
							<td>${dto.title}</td>
							<td>${dto.create_date}</td>
							<td>${dto.view_count}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</main>
	
</body>


</html>
