<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재대기함</title>

<%@ include file="./layout/header.jsp"%>

<style type="text/css">
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
					<h1>결재대기함</h1>
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
							<li class="breadcrumb-item">전자결재</li>
							<li class="breadcrumb-item">결재</li>
							<li class="breadcrumb-item active">결재대기함</li>
						</ol>
					</nav>
				</div>
				<div class="card">
					<div class="card-body">
						<table id="documentsTable"
							class="display nowrap dataTable dtr-inline collapsed"
							style="width: 100%;">
							<thead>
								<tr>
									<th>문서번호</th>
									<th>작성자</th>
									<th>제목</th>
									<th>상태</th>
									<th>작성일</th>
									<th>마감기한</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
		</div>
	</div>
</main>
<!-- 모달 -->
	<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	    	
	      <div class="modal-header">
  			<button class="btn btn-info" id="acceptBtn">승인</button>
	         <button type="button" class="btn btn-success" id="rejectBtn">반려</button>
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
	      </div>
		      <div id="fileDiv">
	      		<ul id="fileUl">
	      			
	      		</ul>
	      	</div>
	      	<div id="modal-content"></div>
	      	
	      	<button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      	
	      </div>
	    </div>
	  </div>


<script id="approval-template" type="text/x-handlebars-template">
<div class="modal-content">
    <div class="modal-header">
        <button class="btn btn-info" id="acceptBtn" value="{{approval_id}}">승인</button>
        <button class="btn btn-success" id="rejectBtn" value="{{approval_id}}">반려</button>
        <button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body row">
        <div class="col-8">
            <table border="1" class="table">
                <tbody>
                    <tr>
                        <th>문서번호</th>
                        <td id="approval_id">{{approval_id}}</td>
                        <th>기안일자</th>
                        <td>{{create_date}}</td>
                    </tr>
                    <tr>
                        <th>기안자</th>
                        <td>{{empno}}</td>
                        <th>부서</th>
                        <td>{{deptno}}</td>
                    </tr>
                    <tr>
                        <th>참조자</th>
                        <td><span>참조자선택버튼</span></td>
                        <th>마감기한</th>
                        <td>{{approval_deadline}}</td>
                    </tr>
                    {{#if showDateRange}}
                    <tr>
                        <th>시작날짜</th>
                        <td>{{start_date}}</td>
                        <th>종료날짜</th>
                        <td>{{end_date}}</td>
                    </tr>
                    {{/if}}
                    <tr>
                        <th>문서제목</th>
                        <td colspan="3">{{approval_title}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="approvalLine" class="mt-3 col-4">
            <h4>결재 라인</h4>
            {{#each approvalLineDtos}}
            <div class="approval-item">
                <div class="text-center">{{approver_empno}}</div>
				{{#if signature}}
                	<img src="{{signature}}" width="50" height="50">
          	 	 {{else}}
            	    {{#if (eq status_id "ST04")}}
                    <img src="https://cdn3.iconfinder.com/data/icons/miscellaneous-80/60/check-512.png" width="50" height="50">
              		  {{else if (eq status_id "ST05")}}
               		     <img src="https://cdn3.iconfinder.com/data/icons/flat-actions-icons-9/792/Close_Icon_Circle-512.png" width="50" height="50">
             	   {{/if}}
            	{{/if}}

            </div>
            {{/each}}
        </div>
    </div>

    <div id="fileDiv">
        <h4>첨부 파일</h4>
        <ul id="fileUl">
            {{#each fileData}}
            <li>
                {{origin_name}}
                <button class="btn btn-sm btn-success download-btn"  value="{{file_id}}" onclick="download(this)"">다운로드</button>
            </li>
            {{/each}}
        </ul>
    </div>

    <div id="modal-content">
        {{{approval_content}}} <!-- HTML 포함 출력 -->
    </div>

    <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
</div>
</script>

</body>
	<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
<script type="text/javascript">
	Handlebars.registerHelper("eq", function (a, b) {
	    return a === b;
	});
	$(document).ready(function(){
		var table = $('#documentsTable').DataTable({
			// 샘플 데이터
	        ajax: {
	            url: './approvalRequestListAjax.do',
	            method:'get',
	            dataType: 'json',
	            dataSrc: function(json) {
	                console.log("서버 응답 데이터:", json); // JSON 데이터 확인
	                return json.data || json; // dataSrc가 없을 경우 전체 반환
	            }
	        },
	        columns: [
	            { data: 'approval_id' },
	            { data: 'name' },
	            { data: 'approval_title' },
	            { data: 'approval_status' },
	            { data: 'create_date' },
	            { data: 'approval_deadline' }
	        ],
	        columnDefs: [
	            { orderable: false, targets: [0,1,2,3] }  // 특정 컬럼(2번째, 4번째)의 정렬 비활성화
	        ],
	        // 행 선택
	        lengthMenu: [10, 20, 30],
	        order: [[4, 'desc']],
	        autoWidth: false,    
	        responsive: true,
	        search: {
	            return: true
	        },
	        scrollX: true ,
	        language: {
	            "decimal": "",
	            "emptyTable": "데이터가 없습니다.",
	            "info": "총 _TOTAL_건 중 _START_부터 _END_까지 표시",
	            "infoEmpty": "총 0건 중 0부터 0까지 표시",
	            "infoFiltered": "(_MAX_건의 데이터에서 필터링됨)",
	            "infoPostFix": "",
	            "thousands": ",",
	            "lengthMenu": "_MENU_ 개씩 보기",
	            "loadingRecords": "로딩 중...",
	            "processing": "처리 중...",
	            "search": "검색:",
	            "zeroRecords": "일치하는 데이터가 없습니다.",
	            "paginate": {
	            	"first": "<<",
	                "last": ">>",
	                "next": ">",
	                "previous": "<"
	            },
	            "aria": {
	                "sortAscending": ": 오름차순 정렬",
	                "sortDescending": ": 내림차순 정렬"
	            }
	        },
	        rowCallback: function(row, data) {
	            $(row).find('td:first').on('click', async function() {
					let data1 = await getDetail(data.approval_id);
                    let fileData = await getFile(data1.approval_id);
					
                    console.log("결재 상세 데이터:", data1);
                    console.log("첨부 파일 데이터:", fileData);
 				$.get("${pageContext.request.contextPath}/resources/template/approval-template.hbs", function(templateSource) {
                    let template = Handlebars.compile(templateSource);
                    let context = {
                        approval_id: data1.approval_id,
                        form_id: data1.form_id,
                        approval_status: data1.approval_status,
                        approval_title: data1.approval_title,
                        approval_content: data1.approval_content,
                        approval_deadline: data1.approval_deadline,
                        create_date: data1.create_date,
                        start_date: data1.start_date,
                        end_date: data1.end_date,
                        empno: data1.empno,
                        deptno: data1.deptno,
                        update_empno: data1.update_empno,
                        showDateRange: data1.form_id?.startsWith('BC'), // 날짜 범위 표시 여부
                        approvalLineDtos: data1.approvalLineDtos,
                        fileData: fileData
                    };
                    $("#myModal .modal-dialog").html(template(context));
                    
					$("#myModal").show();
 				})
	            })
	            .css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
	        }
	    });

	  	$(document).on("click", ".modalBtn", function() {
	        $("#myModal").hide();
	    });
	  	$(document).on("click", "#acceptBtn",async function() {
	  		console.log('클릭',$("#acceptBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#acceptBtn").val();
			console.log(jsonData);
		
			let data = await fetchJsonPost("./acceptApprovalLineAjax.do", jsonData)
			if(data == true) {
				Swal.fire("결재승인").then(()=>{
					table.ajax.reload();
					$("#myModal").hide();
				});
			} else{
				Swal.fire("결재승인실패");
			}
	        $("#myModal").hide();
	    });
	  	
	  	$(document).on("click", "#rejectBtn",async function() {
	  		console.log('클릭',$("#rejectBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#rejectBtn").val();

			console.log(jsonData);
			
			Swal.fire({
				title: "반려사유를 입력하세요",
		        input: "text",
		        inputPlaceholder: "반려 사유를 입력하세요",
		        showCancelButton: true,
		        confirmButtonText: "확인",
		        cancelButtonText: "취소",
		        inputValidator: (value) => {
		            if (!value) {
		                return "반려 사유를 입력해야 합니다!";
		            }
		        } 
			}).then(async (result) => {
				console.log(result);
				jsonData["reject_reason"] = result.value;
				console.log(jsonData);
				
				let data = await fetchJsonPost("./rejectApprovalLineAjax.do", jsonData)
				if(data == true) {
					Swal.fire("반려성공").then(() => {
						table.ajax.reload();
						$("#myModal").hide();
					});
				} else{
					Swal.fire("반려실패");
				}
			})
	        $("#myModal").hide();
	    });
	  	
	  	
		$(".modalBtn").on('click', function() {
			$("#myModal").hide();
			$("#acceptBtn").val('');
			$("#rejectBtn").val('');	
		});
		
		$("#acceptBtn").on('click', function (event) {
			console.log('클릭',$("#acceptBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#acceptBtn").val();
			console.log(jsonData);
		
			fetch("./acceptApprovalLineAjax.do",{
				method:"POST",
				headers:{
					"Content-Type":"application/json"
				},
				body:JSON.stringify(jsonData)
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true) {
					Swal.fire("결재승인").then(()=>{
						table.ajax.reload();
						$("#myModal").hide();
					});
				} else{
					Swal.fire("결재승인실패");
				}
			})
			.catch(err => console.log(err));
		});
		
		$("#rejectBtn").on('click', function (event) {
			console.log('클릭',$("#rejectBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#rejectBtn").val();

			console.log(jsonData);
			
			Swal.fire({
				title: "반려사유를 입력하세요",
		        input: "text",
		        inputPlaceholder: "반려 사유를 입력하세요",
		        showCancelButton: true,
		        confirmButtonText: "확인",
		        cancelButtonText: "취소",
		        inputValidator: (value) => {
		            if (!value) {
		                return "반려 사유를 입력해야 합니다!";
		            }
		        } 
			}).then((result) => {
				console.log(result);
				jsonData["reject_reason"] = result.value;
				console.log(jsonData);
				fetch("./rejectApprovalLineAjax.do",{
					method:"POST",
					headers:{
						'Content-Type':'application/json'
					},
					body:JSON.stringify(jsonData)
				})
				.then(resp => resp.json())
				.then(data => {
					if(data == true) {
						Swal.fire("반려성공").then(() => {
							table.ajax.reload();
							$("#myModal").hide();
						});
					} else{
						Swal.fire("반려실패");
					}
				})
				.catch(err => console.log(err));
			})
		});
	});
</script>
</html>

