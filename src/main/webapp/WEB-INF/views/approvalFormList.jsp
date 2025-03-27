<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식관리</title>

<%@ include file="./layout/header.jsp"%>
<style type="text/css">
	tbody tr {
	    cursor: pointer;
	}
	.modal-content{
	width: 220mm;
	}
</style>
</head> 
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<div class="pagetitle">
				<h1>문서양식관리</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
						<li class="breadcrumb-item ">전자결재</li>
						<li class="breadcrumb-item active">문서양식관리</li>
					</ol>
				</nav>
			</div>
			<c:if test="${loginDto.auth eq 'A' }">
				<button type="button" class="btn btn-primary mb-3" onclick="location.href='./managerFormCreate.do'">문서양식등록</button>
			</c:if>
			<div class="card">
	            <div class="card-body">
	              <table class="table table-hover">
	                <thead>
	                  <tr>
	                    <th>#</th>
	                    <th>양식아이디</th>
	                    <th>카테고리이름</th>
	                    <th>양식이름</th>
	                    <th>생성일</th>
<%-- 	                    <c:if test="${loginDto.auth eq 'A' }"> --%>
<!-- 		                    <th>수정일</th> -->
<%-- 	                    </c:if> --%>
	                    <c:if test="${loginDto.auth eq 'A' }">
		                    <th>사용여부</th>
	                    </c:if>
	                  </tr>
	                </thead>
	                <tbody>
	                 <c:forEach items="${formList}" var="frm">
	                 	<c:choose>
	                 		<c:when test="${loginDto.auth eq 'A'}">
	                 		<tr>
			                    <td >#</td>
			                    <td >${frm.form_id}</td>
			                    <td >${frm.form_content}</td>
			                    <td class="datailOpen" id="${frm.form_id}">
			                    	${frm.form_name}
			                    </td>
			                    <td >${frm.create_date}</td>
<%-- 			                    <td >${frm.update_date}</td> --%>
			                    <td>
									<div class="form-check form-switch">
				                      <input class="form-check-input" type="checkbox" value="${frm.form_id}" ${frm.use_yn eq 'Y' ?'checked':''}>
				                    </div>
								</td>
			                  </tr>
	                 		</c:when>
	                 		<c:otherwise>
	                 			<c:if test="${frm.use_yn eq 'Y'}">
		                 			<tr>
					                    <td >#</td>
					                    <td >${frm.form_id}</td>
					                    <td >${frm.form_content}</td>
					                    <td class="datailOpen" id="${frm.form_id}">
					                    	${frm.form_name}
					                    </td>
					                    <td >${frm.create_date}</td>
					                  </tr>
	                 			</c:if>
	                 		</c:otherwise>
	                 	</c:choose>
		                 
	                 </c:forEach>
	                </tbody>
	              </table>
	            </div>
	         </div>
		</div>
	</div>
</main>
<div class="modal" id="formDetailModal" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            
            <div class="modal-header">
                <h5 class="modal-title">양식 상세</h5>
                <c:if test="${loginDto.auth eq 'A'}">
					<button id="updateBtn" class="btn btn-secondary mb-3 btn-sm">양식수정</button>
				</c:if>
                <button type="button" class="btn-close modalCloseBtn" data-bs-dismiss="modal"></button>
            </div>
            
            <div class="modal-body">
                <h4 id="modal_form_name"></h4>
                <div id="modal_viewer"></div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger modalCloseBtn" data-bs-dismiss="modal">닫기</button>
            </div>
            
        </div>
    </div>
</div>
</body>
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
			let response = await fetch("./managerFormDeleteAjax.do",{
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
		 document.querySelectorAll("tbody tr").forEach(row => {
		        row.addEventListener("click", async function(event) {
		            let formId = row.querySelector(".datailOpen").id; // form_id 가져오기
		            let lastTd = row.lastElementChild;
		            if (lastTd.contains(event.target)) {
		                console.log("체크박스 포함 마지막 TD 클릭됨, 모달 안 띄움");
		                return; // 마지막 TD 클릭 시 이벤트 중단
		            }
		            console.log("양식 상세 요청 ID:", formId);

		            let formData = await getFormDetails(formId); // 
		            if (formData) {
		                fillModalData(formData); // 
		                $("#formDetailModal").modal("show"); 
		            } else {
		                alert("양식 정보를 불러오는 데 실패했습니다.");
		            }
		        });
		    });

		    document.querySelectorAll(".modalCloseBtn").forEach(btn => {
		        btn.addEventListener("click", function() {
		            $("#formDetailModal").modal("hide");
		        });
		    });

		    async function getFormDetails(formId) {
		        try {
		            let response = await fetch("./formDetailAjax.do?id=" + formId);
		            if (!response.ok) throw new Error("서버 응답 오류");

		            return await response.json();
		        } catch (error) {
		            console.error("양식 데이터 요청 실패:", error);
		            return null;
		        }
		    }

		    function fillModalData(data) {
		        let updateBtn = document.getElementById("updateBtn");
		        if (updateBtn) {
		            updateBtn.setAttribute("onclick", "location.href='./managerFormUpdate.do?id=" + data.form_id + "'");
		        }
		        document.getElementById("modal_form_name").textContent = data.form_name;
		        document.getElementById("modal_viewer").innerHTML = data.form_content;
		    }
	
	</script>
</html>
