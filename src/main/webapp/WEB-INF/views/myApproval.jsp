<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의결재함</title>

<%@ include file="layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" -->
<!-- 	src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" -->
<!-- 	href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" /> -->
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
				<h3 class="content_title">내 문서함</h3>

				<div>
					<label><input type="checkbox" class="filter-status form-check-input"
						value="임시저장" checked> 임시저장</label> <label><input
						type="checkbox" class="filter-status form-check-input" value="결재대기" checked>
						결재대기</label> <label><input type="checkbox" class="filter-status form-check-input"
						value="진행중" checked> 진행중</label> <label><input
						type="checkbox" class="filter-status form-check-input" value="결재완료" checked>
						결재완료</label> <label><input type="checkbox" class="filter-status form-check-input"
						value="결재반려" checked> 결재반려</label>
				</div>

				<table id="documentsTable"
					class="display nowrap dataTable dtr-inline collapsed"
					style="width: 100%;">
					<thead>
						<tr>
							<th>문서번호</th>
							<th>양식명</th>
							<th>사원번호</th>
							<th>제목</th>
							<th>카테고리</th>
							<th>상태</th>
							<th>작성일</th>
							<th>마감기한</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		
	</main>
	<!-- 모달 -->
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
            url: './myApprovalData.json',
            type: 'POST',
            dataType: 'json',
            dataSrc: function(json) {
                console.log("서버 응답 데이터:", json);
                return json.data || [];
            }
        },
        columns: [
            { data: 'APPROVAL_ID' },
            { data: 'FORM_ID' },
            { data: 'EMPNO' },
            { data: 'APPROVAL_TITLE' },
            { data: 'CATEGORY_NAME' },
            { data: 'APPROVAL_STATUS' },
            { data: 'CREATE_DATE' },
            { data: 'APPROVAL_DEADLINE' }
        ],
        lengthMenu: [10, 20, 30],
        search: {
            return: true
        },
        rowCallback: function(row, data) {
            $(row).find('td').on('click', async function() {
//                 window.location.href = './approvalDetail.do?id='+data.approval_id;
				console.log(data.APPROVAL_ID);
				let data1 = await getDetail(data.APPROVAL_ID);
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
				 let html = "<div class='approval-item'>결<br>재</div>";
				 data1.approvalLineDtos.forEach((emp, i) => {
		                console.log(emp.name, emp.approver_empno);
		                html += "<div class='approval-item'>";
		                html += "<div id='" + emp.approver_empno + "' class='text-center'>" + emp.approver_empno + "</div>";
		                html += "</div>";
		            });

		            document.getElementById("approvalLine").innerHTML = html;
				$("#myModal").show();
// 				fetch("./approvalDetail.json?id="+data.APPROVAL_ID)
// 				.then(resp => resp.json())
// 				.then(data => {
					
// 				})
// 				.catch(err => console.log(err));
            }).css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
        }
    });
	$(".modalBtn").on('click', function(){
		$("#myModal").hide();
	})
	
    $('.filter-status').on('change', function() {
        let selectedStatuses = [];
        $('.filter-status:checked').each(function() {
            selectedStatuses.push($(this).val());
        });
        table.column(5).search(selectedStatuses.join('|'), true, false).draw();
    });
	
	async function getDetail(id){
		let response = await fetch("./approvalDetail.json?id="+id);
		let data = await response.json(); 
        console.log("서버 응답 데이터:", data); 
        return data;
	}
});
</script>
</html>
