<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려문서함</title>

<%@ include file="layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- 	<link rel="stylesheet" type="text/css"href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" /> -->
<style type="text/css">
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
</style>
</head>
<body>
	<%@ include file="layout/newNav.jsp"%>
	<%@ include file="layout/newSide.jsp"%>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">반려문서함</h3>
			<table id="documentsTable"
					class="display nowrap dataTable dtr-inline collapsed"
					style="width: 100%;">
					<thead>
						<tr>
							<th>문서번호</th>
							<th>기안자</th>
							<th>제목</th>
							<th>상태</th>
							<th>작성일</th>
							<th>반려사유</th>
						</tr>
					</thead>
				</table>
		</div>
	</div>
</main>
	<!-- 모달  -->
	<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	    	
	      <div class="modal-header">
	      	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button>
	      </div>
	      <div class="modal-body row">
	      	<div class="col-8">
	      		<table border="1" class="table">
					<tbody>
						<tr>
							<th>문서번호</th>
							<td id="approval_id"></td>
							<th>기안일자</th>
							<td id="create_date">자동입력</td>
						</tr>
	
						<tr>
							<th>기안자</th>
							<td id="empno"></td>
							<th>부서</th>
							<td id="deptno"></td>
						</tr>
						<tr>
							<th>참조자</th>
							<td><span>참조자선택버튼</span></td>
							<th>마감기한</th>
							<td id="approval_deadline"></td>
						</tr>
						<tr id="dateRange" style="display: table-row;">
							<th>시작날짜</th>
							<td id="start_date"></td>
							<th>종료날짜</th>
							<td id="end_date"></td>
						</tr>
						<tr>
							<th>문서제목</th>
							<td colspan="3" id="approval_title"></td>
						</tr>
	
					</tbody>
				</table>
	      	</div>
	      	<div id="approvalLine" class="mt-3 col-4"></div>
	      	<div id="modal-content"></div>
	      </div>
	
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    let table = $('#documentsTable').DataTable({
        ajax: {
            url: './selectApprovalRejected.json',
            type: 'POST',
            dataType: 'json',
            dataSrc: function(json) {
                console.log("서버 응답 데이터:", json);
                return json || [];
            }
        },
        columns: [
            { data: 'approval_id' },
            { data: 'approval_content' },
            { data: 'approval_title' },
            { data: 'approval_status' },
            { data: 'create_date' },
            { data: 'approval_deadline' }
        ],
        lengthMenu: [10, 20, 30],
        search: {
            return: true
        },
        rowCallback: function(row, data) {
            $(row).find('td').on('click', async function() {
//                 window.location.href = './approvalDetail.do?id='+data.approval_id;
				console.log(data.approval_id);
				let data1 = await getDetail(data.approval_id);
				console.log(data1);
				if(!data1.form_id.startsWith('BC')){
					$("#dateRange").hide();
				}else {
	                $("#dateRange").show();
	            }
				$("#approval_id").text(data1.approval_id); // 결재 문서 ID
	            $("#form_id").text(data1.form_id); // 양식 ID
	            $("#approval_status").text(data1.approval_status); // 결재 상태
	            $("#approval_title").text(data1.approval_title); // 제목
	            $("#approval_content").html(data1.approval_content); // 본문 (HTML이므로 .html() 사용)
	            $("#approval_deadline").text(data1.approval_deadline); // 마감 기한
	            $("#create_date").text(data1.create_date); // 생성 날짜
	            $("#update_date").text(data1.update_date); // 수정 날짜
	            $("#start_date").text(data1.start_date); // 시작 날짜
	            $("#end_date").text(data1.end_date); // 종료 날짜
	            $("#empno").text(data1.empno); // 작성자 사번
	            $("#update_empno").text(data1.update_empno); // 수정한 사번
				$("#modal-content").html(data1.approval_content);
//					$(".modal-body").html(data.approval_content);
				 // 				 let html = "<div class='approval-item'>결<br>재</div>";
				 let html = '';
				 data1.approvalLineDtos.forEach((emp, i) => {
		                console.log(emp.name, emp.approver_empno);
		                html += "<div class='approval-item'>";
		                html += "<div id='" + emp.approver_empno + "' class='text-center'>" + emp.approver_empno + "<br>"
		                console.log(emp.signature);
		                if(typeof emp.signature != 'undefined'){
		                	html += "<img src='"+ emp.signature+"' width=50, height=50>";	
		                } else{
		                	if(emp.status_id == 'ST04'){
		                		html += "<img src='https://cdn3.iconfinder.com/data/icons/miscellaneous-80/60/check-512.png' width=50, height=50>";
		                	} else if(emp.status_id == 'ST05'){
		                		html += "<img src='https://cdn3.iconfinder.com/data/icons/flat-actions-icons-9/792/Close_Icon_Circle-512.png' width=50, height=50>";
		                	}
		                	
		                }
		                html += "</div>";
		                html += "</div>";
		            });

		            document.getElementById("approvalLine").innerHTML = html;
				$("#myModal").show();
            }).css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
        }
    });
	$(".modalBtn").on('click', function(){
		$("#myModal").hide();
	})
	
	
// 	async function getDetail(id){
// 		let response = await fetch("./approvalDetail.json?id="+id);
// 		let data = await response.json(); 
//         console.log("서버 응답 데이터:", data); 
//         return data;
// 	}
});
</script>
</html>
