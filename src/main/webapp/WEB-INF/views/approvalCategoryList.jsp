<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 목록</title>

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content">
			<div class="pagetitle">
				<h1>카테고리 목록</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
						<li class="breadcrumb-item">문서양식관리</li>
						<li class="breadcrumb-item active">카테고리 목록</li>
					</ol>
				</nav>
			</div>
			<c:if test="${loginDto.auth eq 'A' }">
			<button type="button" class="btn btn-info" onclick="location.href='./managerCategoryForm.do'">카테고리등록</button>
			</c:if>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>이름</th>
						<th>약어</th>
						<th>생성일</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${categoryList}" var="cate">
						<tr>
							<td>${cate.category_name}</td>
							<td>${cate.category_yname}</td>
							<td>${cate.create_date}</td>
							<td>
								<div class="form-check form-switch">
			                      <input class="form-check-input" type="checkbox" value="${cate.category_id}" ${cate.use_yn eq 'Y' ?'checked':''}>
			                    </div>
							</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</main>
	<script type="text/javascript">
		document.querySelectorAll(".form-check-input").forEach( async (checkbox) => {
			checkbox.addEventListener("change", async (event)=>{
				console.log("id ", event.target.value);
				console.log(event.target);
				let useYn = event.target.checked ? 'Y' : 'N';
				console.log(useYn)
				let data = await changeUseYn(useYn, event.target.value);
				console.log(data);
			})
		})
		async function changeUseYn(useYn, value){
			let response = await fetch("./categoryUseChange.do",{
				method:"post",
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify({
					use_yn:useYn,
					id:value
				})
			})
			if(!response.ok){
				throw new Error(error);
			}
			return await response.json();
		}
	</script>
</body>
</html>
