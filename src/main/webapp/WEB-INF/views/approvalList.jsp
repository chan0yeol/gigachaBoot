<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재요청함/임시저장요청함</title>

<%@ include file="layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/> -->
</head> 
<style type="text/css">
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
</style>
<body>
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">결재요청함</h3>
			<div class="card">
	            <div class="card-body">
					<div id="wrapper" class="list">
			            <table id="example"  class="table table-hover">
			                <thead>
			                    <tr>
			                        <th>문서번호</th>
			                        <th>양식번호</th>
			                        <th>작성자</th>
			                        <th>제목</th>
			                        <th>상태</th>
			                        <th>작성일</th> 
			                        <th>마감기한</th> 
			                        <th>임시저장</th> 
			                    </tr>
			                </thead>
			            </table>
			        </div>
		        </div>
	        </div>
		</div>
	</div>
</main>
<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	    	
	      <div class="modal-header">
<!-- 	      	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button> -->
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
	<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable({
	    	// 샘플 데이터
	        ajax: {
	            url: './approvalList.json',
	            method:'get',
	            dataType: 'json',
	            dataSrc: function(json) {
	                console.log("서버 응답 데이터:", json); // JSON 데이터 확인
	                return json.data || json; // dataSrc가 없을 경우 전체 반환
	            }
	        },
	        columns: [
	            { data: 'approval_id' },
	            { data: 'form_id' },
	            { data: 'empno' },
	            { data: 'approval_title' },
	            { data: 'approval_status' },
	            { data: 'create_date' },
	            { data: 'approval_deadline' },
	            { data: 'temp_save_yn' }
	        ],
	        // 행 선택
	        lengthMenu: [10, 20, 30],
	        search: {
	            return: true
	        },
	        rowCallback: function(row, data) {
	        	$(row).find('td').on('click', async function() {
//	                 window.location.href = './approvalDetail.do?id='+data.approval_id;
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
//						$(".modal-body").html(data.approval_content);
					 // 				 let html = "<div class='approval-item'>결<br>재</div>";
				 	let html = '';
					 data1.approvalLineDtos.forEach((emp, i) => {
			                console.log(emp.name, emp.approver_empno);
			                html += "<div class='approval-item'>";
			                html += "<div id='" + emp.approver_empno + "' class='text-center'>" + emp.approver_empno + "</div>";
			                html += "</div>";
			            });
					 document.getElementById("approvalLine").innerHTML = html;
					 
					 if(data1.approval_status === 'ST02' || data1.approval_status === 'ST01'){
						 html = '<button id="updateFormBtn" class="btn btn-secondary btn-sm" onclick="location.href=\'./approvalUpdateForm.do?id=' + data1.approval_id + '\'">문서수정</button>';
						 $(".modal-header").append(html);	
					 } 
					 if(data1.approval_status === 'ST02'){
						 html = '<button id="recallBtn" class="btn btn-secondary btn-sm" onclick="recall(event)" value="'+data1.approval_id+'">문서회수</button>'
						 $(".modal-header").append(html);
					 }
					 if(data1.approval_status === 'ST01'){
						 html = '<button id="approvalBtn" class="btn btn-secondary btn-sm" value="'+data1.approval_id+'" onclick="approvalBtn(event)">결재 요청</button>'
						 $(".modal-header").append(html);
					 }
					 if(data1.approval_status === 'ST01'){
						 html = '<button id="approvalBtn" class="btn btn-secondary btn-sm" value="'+data1.approval_id+'" onclick="approvalBtn(event)">결재 요청</button>'
						 $(".modal-header").append(html);
					 }
					 
					$("#myModal").show();
	            }).css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
	        }
	    });
	    
		$(".modalBtn").on('click', function(){
			$(".modal-header").html('');
			$("#myModal").hide();
		})
	    
	});
	
	function recall(event) {
// 		let id = document.querySelector(".content_title").textContent;
		 id = event.target.value
		fetch("./approvalRecall.json",{
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
	
	</script>
</body>
</html>
