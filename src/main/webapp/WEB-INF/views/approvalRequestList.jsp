<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재목록함</title>

<%@ include file="layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/> -->

<style type="text/css">
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
</style>
</head> 
<body>
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">결재목록함</h3>
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
	            url: './approvalRequestList.json',
	            method:'get',
	            dataType: 'json',
	            dataSrc: function(json) {
	                console.log("서버 응답 데이터:", json); // JSON 데이터 확인
	                return json.data || json; // dataSrc가 없을 경우 전체 반환
	            }
	        },
	        columns: [
	            { data: 'approval_id' },
	            { data: 'empno' },
	            { data: 'approval_title' },
	            { data: 'approval_status' },
	            { data: 'create_date' },
	            { data: 'approval_deadline' }
	        ],
	        // 행 선택
	        lengthMenu: [10, 20, 30],
	        search: {
	            return: true
	        },
	        rowCallback: function(row, data) {
	            $(row).find('td:first').on('click', async function() {
// 	            	console.log(data.approval_id);
// 					let data1 = await getDetail(data.approval_id);
// 					console.log(data1);
// 					if(!data1.form_id.startsWith('BC')){
// 						$("#dateRange").hide();
// 					}else {
// 		                $("#dateRange").show();
// 		            }
// 					$("#approval_id").text(data1.approval_id); // 결재 문서 ID
// 		            $("#form_id").text(data1.form_id); // 양식 ID
// 		            $("#approval_status").text(data1.approval_status); // 결재 상태
// 		            $("#approval_title").text(data1.approval_title); // 제목
// 		            $("#approval_content").html(data1.approval_content); // 본문 (HTML이므로 .html() 사용)
// 		            $("#approval_deadline").text(data1.approval_deadline); // 마감 기한
// 		            $("#create_date").text(data1.create_date); // 생성 날짜
// 		            $("#update_date").text(data1.update_date); // 수정 날짜
// 		            $("#start_date").text(data1.start_date); // 시작 날짜
// 		            $("#end_date").text(data1.end_date); // 종료 날짜
// 		            $("#empno").text(data1.empno); // 작성자 사번
// 		            $("#update_empno").text(data1.update_empno); // 수정한 사번
// 					$("#modal-content").html(data1.approval_content);
// //						$(".modal-body").html(data.approval_content);
// 					 let html = "<div class='approval-item'>결<br>재</div>";
// 					 data1.approvalLineDtos.forEach((emp, i) => {
// 			                console.log(emp.name, emp.approver_empno);
// 			                html += "<div class='approval-item'>";
// 			                html += "<div id='" + emp.approver_empno + "' class='text-center'>" + emp.approver_empno + "</div>";
// 			                html += "</div>";
// 			            });

// // 			            document.getElementById("approvalLine").innerHTML = ;
// 			        $("#approvalLine").html(html)
// 					$("#rejectBtn").val(data1.approval_id);	
// 					$("#acceptBtn").val(data1.approval_id);
// 					let fileData = await getFile(data1.approval_id);
// 					console.log(fileData);
// 					let fileHtml = '';
// 					fileData.forEach((file, i) => {
// 						console.log(file.origin_name);
// 						fileHtml += '<li>'+file.origin_name+'<button class="btn btn-sm btn-success" value="'+file.file_id+'" onclick="download(this)">다운로드</button> </li>'
// 					});
// 					$("#fileUl").html(fileHtml);
					
					let data1 = await getDetail(data.approval_id);
                    let fileData = await getFile(data1.approval_id);
					
                    console.log("결재 상세 데이터:", data1);
                    console.log("첨부 파일 데이터:", fileData);
                    
                    
//                     let source = $("#approval-template").html();
//                     let template = Handlebars.compile(source);
					
//                     let context = {
//                         approval_id: data1.approval_id,
//                         form_id: data1.form_id,
//                         approval_status: data1.approval_status,
//                         approval_title: data1.approval_title,
//                         approval_content: data1.approval_content,
//                         approval_deadline: data1.approval_deadline,
//                         create_date: data1.create_date,
//                         start_date: data1.start_date,
//                         end_date: data1.end_date,
//                         empno: data1.empno,
//                         deptno: data1.deptno,
//                         update_empno: data1.update_empno,
//                         showDateRange: data1.form_id?.startsWith('BC'), // 날짜 범위 표시 여부
//                         approvalLineDtos: data1.approvalLineDtos,
//                         fileData: fileData
//                     };
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
// 					openModal(data.approval_id);
// 					console.log(data.approval_id);
	            })
	            .css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
	        }
	    });

// 		function openModal(approval_id){
// 			fetch("./approvalDetail.json?id="+approval_id)
// 			.then(resp => resp.json())
// 			.then(data => {
// 				console.log(data);
// 				 let html = "<div class='approval-item'>결<br>재</div>";
// 		            data.approvalLineDtos.forEach((emp, i) => {
// 		                console.log(emp.name, emp.approver_empno);
// 		                html += "<div class='approval-item'>";
// 		                html += "<div id='" + emp.approver_empno + "' class='text-center'></div>";
// 		                html += "</div>";
// 		            });

// 	            document.getElementById("approvalLine").innerHTML = html;
// 				$("#modal-content").html(data.approval_content);
// 				$("#acceptBtn").val(data.approval_id);
// 				$("#rejectBtn").val(data.approval_id);						
// 				$("#myModal").show();
// 			})
// 			.catch(err => console.log(err));
// 		}
	  	$(document).on("click", ".modalBtn", function() {
	        $("#myModal").hide();
	    });
	  	$(document).on("click", "#acceptBtn",async function() {
	  		console.log('클릭',$("#acceptBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#acceptBtn").val();
			console.log(jsonData);
		
			let data = await fetchJsonPost("./acceptApprovalLine.json", jsonData)
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
				
				let data = await fetchJsonPost("./rejectApprovalLine.json", jsonData)
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
		
			fetch("./acceptApprovalLine.json",{
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
				fetch("./rejectApprovalLine.json",{
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
	
// 	async function getDetail(id){
// 		let response = await fetch("./approvalDetail.json?id="+id);
// 		let data = await response.json(); 
//         console.log("서버 응답 데이터:", data); 
//         return data;
// 	}
	
// 	async function getFile(id){
// 		let response = await fetch("./fileList.json?id="+id);
// 		let data = await response.json(); 
//         console.log("서버 응답 데이터:", data); 
//         return data;
// 	}
	
	
// 	async function download(event) {
// 	    let file_id = event.value;
// 	    let approval_id = $("#approval_id").text();
// 	    console.log("다운로드 요청:", file_id, approval_id);
	
// 	    let jsonData = {
// 	        file_id: file_id,
// 	        approval_id: approval_id
// 	    };
	
// 	    try {
// 	        let response = await fetch("./download.json", {
// 	            method: "POST",
// 	            headers: {
// 	                "Content-Type": "application/json"
// 	            },
// 	            body: JSON.stringify(jsonData)
// 	        });
	
// 	        if (!response.ok) {
// 	            throw new Error("파일 다운로드 실패: " + response.statusText);
// 	        }
	
// 	        let blob = await response.blob();
// 	        console.log("받은 파일 Blob:", blob);
	
// 	        let filename = "downloaded_file"; // 기본값 설정
// 	        let contentDisposition = response.headers.get("Content-Disposition");
// 	        console.log("응답 헤더 Content-Disposition:", contentDisposition);
	
// 	        if (contentDisposition) {
// 	            let matches = contentDisposition.match(/filename\*?=(UTF-8'')?"?([^"]+)"?/);
// 	            if (matches) {
// 	                filename = matches[2] ? decodeURIComponent(matches[2]) : decodeURIComponent(matches[1]); // 파일명 URL 디코딩 적용
// 	            }
// 	        }
	
// 	        let link = document.createElement("a");
// 	        link.href = window.URL.createObjectURL(blob);
// 	        link.download = filename;
// 	        document.body.appendChild(link);
// 	        link.click();
// 	        document.body.removeChild(link);
// 	        URL.revokeObjectURL(link.href); // 메모리 해제
	
// 	        console.log("파일 다운로드 완료:", filename);
// 	    } catch (error) {
// 	        console.error("다운로드 중 오류 발생:", error);
// 	        alert("파일 다운로드에 실패했습니다.");
// 	    }
// 	}
</script>
</html>

