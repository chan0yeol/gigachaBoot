<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재문서 상세</title>

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content">
			<h3 class="content_title">${approval.approval_id}</h3>
			<c:if test='${approval.empno eq loginDto.empno and (approval.approval_status eq "ST02" or approval.approval_status eq "ST01")}'>
				<button id="updateFormBtn" onclick='location.href="./approvalUpdateForm.do?id=${approval.approval_id}"'>문서수정</button>
			</c:if>
			<c:if test='${approval.empno eq loginDto.empno and approval.approval_status eq "ST02"}'>
				<button id="recallBtn" onclick="recall()">문서회수</button>
			</c:if>
			<c:if test='${approval.approval_status eq "ST01"}'>
				<button id="approvalBtn" onclick="approvalBtn()">결재 요청</button>	
			</c:if>

			<div class="col-lg-8">
				${approval.approval_content}
			</div>
		</div>
	</div>
</main>
</body>
<script type="text/javascript">
// 		document.querySelector("#updateFormBtn").addEventListener('click', () => {
// 			location.href="./approvalUpdateForm.do?id=${approval.approval_id}";
// 		});
		
		function recall(){
			let id = document.querySelector(".content_title").textContent;
			console.log(id);
			fetch("./approvalRecallAjax.do",{
				method:"POST",
				headers:{
					"Content-Type":"plain/text"
				},
				body:id
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true){
					Swal.fire("문서가 회수되었습니다.").then(()=>{
						location.href="./approvalList.do";
					})
				} else{
					Swal.fire("문서회수가 실패하였습니다.");
				}
			})
			.catch(err => console.log(err));
		}
		
		function approvalBtn(){
			let approval_id = document.querySelector(".content_title").textContent;
			fetch("./approvalRequestAjax.do",{
				method:"POST",
				headers:{
					"Content-Type":"application/json"
				},
				body:approval_id=approval_id
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true){
					Swal.fire("결재요청 되었습니다.").then(()=>{
						location.href="./approvalList.do";
					})
				} else{
					Swal.fire("결재선을 지정해 주세요");
				}
			})
			.catch(err => console.log(err));
		}
// 		document.querySelector("#approvalBtn").addEventListener('click', ()=> {
			
// 		});
	
</script>
</html>
