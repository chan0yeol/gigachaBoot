<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<%@ include file="./layout/header.jsp"%>
	<style type="text/css">
		/* 예약 관련 섹션 */
		.reservation-section {
			width: 100%;
			background-color: white;
			color: black;
			padding: 20px;
			border-radius: 10px;
			text-align: center;
			margin-top: 20px;
		}

		.reservation-title {
			font-size: 24px;
			font-weight: bold;
		}
		.dt-paging {
			font-size: 10px !important; /* 폰트 크기를 10px로 설정 */
		}
		.dataTables_wrapper td, .dataTables_wrapper th {
			text-align: center;
		}
		.dt-container .dt-empty-footer .dt-layout-row:first-child {
			display: none !important;
		}
	</style>
</head>
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<a href="./login.do" class="btn btn-info">로그인</a><br>
	<a href="./logout.do" class="btn btn-danger">로그아웃</a>
	<div class="row">
		<div class="col-12">
			<div class="reservation-section card">
				<div class="reservation-title">나의 예약현황</div>
				<p>현재 예약된 일정이 없습니다.</p>
				<button class="btn btn-reservation" onclick="window.location.href='${pageContext.request.contextPath}/rooms/reservation.do'">예약하기</button>
				<button class="btn btn-reservation" onclick="window.location.href='${pageContext.request.contextPath}/rooms/reservationList.do'">예약내역조회</button>
			</div>
		</div>
		<div class="col-6">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">공지사항</h5>
							<table id="boardList" class="table text-center">
								<thead>
									<tr class="text-center">
										<th>번호</th>
	<%--									<th>작성자</th>--%>
										<th>제목</th>
										<th>작성일</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">
							<a href="./approval/selectApprovalReference.do">
								참조문서함
							</a>
						</h5>
						<table id="refDocument"
							   class="table text-center">
							<thead>
							<tr>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								<th>마감기한</th>
							</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="col-6">
			<!--         	<div class="row"> -->
			<!--         		<div class="col-xxl-12"> -->
			<!-- 	        		<div class="card"> -->
			<!-- 						<div class="card-body row" style="margin-bottom:10px;"> -->
			<!-- 			        		<div class="col-lg-2"> -->
			<!-- 			        			<canvas id="approvalLineChart"></canvas> -->
			<!-- 			        		</div> -->
			<!-- 			        		<div class="col-xxl-6"> -->
			<!-- 					        	<canvas id="approvalChart"></canvas> -->
			<!-- 			        		</div> -->
			<!-- 			        	</div> -->
			<!-- 			        </div> -->
			<!-- 			    </div> -->
			<!--         	</div> -->

			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<h5 class="card-title">
									<a href="./approval/myApproval.do">내문서함</a>
								</h5>
<%--								<div class="col-lg-4">--%>
<%--									<canvas id="approvalChart" width="80" height="80"></canvas>--%>
<%--								</div>--%>
								<!-- 							<div> -->
								<!-- 								<label><input type="checkbox" class="filter-status form-check-input" value="임시저장" checked> 임시저장</label>  -->
								<!-- 								<label><input type="checkbox" class="filter-status form-check-input" value="결재대기" checked> 결재대기</label>  -->
								<!-- 								<label><input type="checkbox" class="filter-status form-check-input" value="진행중" checked> 진행중</label> -->
								<!-- 								<label><input type="checkbox" class="filter-status form-check-input" value="결재완료" checked> 결재완료</label>  -->
								<!-- 								<label><input type="checkbox" class="filter-status form-check-input" value="결재반려" checked> 결재반려</label> -->
								<!-- 							</div> -->
								<div class="col-lg-12">
									<table id="myDocument" class="table text-center">
										<thead>
										<tr>
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
				</div>
			</div>
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">
							<a href="./approval/approvalRequestList.do">결재대기함</a>
						</h5>
						<div class="row">
<%--							<div class="col-lg-4">--%>
<%--								<canvas id="approvalLineChart" width="80" height="80"></canvas>--%>
<%--							</div>--%>
							<div class="col-lg-12">
								<table id="requestDocument"
									   class="table text-center">
									<thead>
									<tr>
										<th>작성자</th>
										<th>제목</th>
										<th>작성일</th>
										<th>마감기한</th>
									</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<!-- 			<h3 class="content_title">제목trestest</h3> -->
<!-- 			<table class="table table-hover"> -->
<!-- 				<thead> -->
<!-- 					<tr> -->
<!-- 						<th>라이브러리</th> -->
<!-- 					</tr> -->
<!-- 				</thead> -->
<!-- 		<div id="content" class="col"> -->
<%-- 		${sessionScope.loginDto} --%>
<!-- 			<h3 class="content_title">제목trestest</h3> -->
<!-- 			<table class="table table-hover"> -->
<!-- 				<thead> -->
<!-- 					<tr> -->
<!-- 						<th>라이브러리</th> -->
<!-- 					</tr> -->
<!-- 				</thead> -->

<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./approval/index.do">jsTree / Editor / signaturepad</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./grid.do">그리드페이지</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./droppable.do">드래그앤드롭</a></td> -->
<!-- 					</tr> -->
<%-- 						<td><a href="${pageContext.request.contextPath}/calendar/calendar.do">캘린더</a></td> --%>
<!-- 	      			</tr> -->
<!-- 	      			<tr> -->
<!-- 						<td><a href="./rooms/reservation.do">예약</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./rooms/roomList.do">회의실 리스트(등록,수정)[관리자]</a></td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table> -->

</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let myDocumentTable = $('#myDocument').DataTable({
			ajax: {
				url: './approval/myApprovalDataAjax.do',
				type: 'POST',
				dataType: 'json',
				dataSrc: function(json) {
					console.log("서버 응답 데이터 내문서함:", json);
					return json.data || [];
				}
			},
			searching: false,
			columns: [
				{ data: 'APPROVAL_TITLE' },    // 제목
				{ data: 'APPROVAL_STATUS' },   // 상태
				{ data: 'CREATE_DATE' },       // 작성일
				{ data: 'APPROVAL_DEADLINE' }  // 마감기한
			],
			columnDefs: [
				{ orderable: false, targets: [0, 1] },
				{ targets: [0, 1, 2, 3], className: 'text-center' } // 제목, 상태 컬럼 정렬 비활성화
			],
			order: [[2, 'desc']], // 작성일 기준 내림차순 정렬
			pageLength: 4,
			autoWidth: false,
			responsive: true,
			scrollX: true,
			scrollY: "200px",
			language: {
				"decimal": "",
				"emptyTable": "데이터가 없습니다.",
				"info": "",
				"infoEmpty": "",
				"infoFiltered": "",
				"lengthMenu": "",
				"loadingRecords": "로딩 중...",
				"processing": "처리 중...",
				"search": "",
				"zeroRecords": "일치하는 데이터가 없습니다.",
				"paginate": {
					"first": "<<",
					"last": ">>",
					"next": ">",
					"previous": "<"
				}
			}
		});

		let requestDocument = $('#requestDocument').DataTable({
			ajax: {
				url: './approval/approvalRequestListAjax.do',
				type: 'get',
				dataType: 'json',
				dataSrc:""
			},
			searching: false,

			columns: [
				{ data: 'name' },
				{ data: 'approval_title' },
				{ data: 'create_date' },
				{ data: 'approval_deadline' }
			],
			columnDefs: [
				{ orderable: false, targets: [0, 1] },
				{ targets: [0, 1, 2, 3], className: 'text-center' }   // 제목, 상태 컬럼 정렬 비활성화
			],
			order: [[2, 'desc']], // 작성일 기준 내림차순 정렬
			pageLength: 4,
			autoWidth: false,
			responsive: true,
			scrollX: true,
			scrollY: "200px",
			language: {
				"decimal": "",
				"emptyTable": "데이터가 없습니다.",
				"info": "",
				"infoEmpty": "",
				"infoFiltered": "",
				"lengthMenu": "",
				"loadingRecords": "로딩 중...",
				"processing": "처리 중...",
				"search": "",
				"zeroRecords": "일치하는 데이터가 없습니다.",
				"paginate": {
					"first": "<<",
					"last": ">>",
					"next": ">",
					"previous": "<"
				}
			}
		});

		let refDocument = $('#refDocument').DataTable({
			ajax: {
				url: './approval/selectApprovalReferenceAjax.do',
				type: 'get',
				dataType: 'json',
				dataSrc: function(json) {
					console.log("서버 응답 데이터 참조문서함:", json);
					return json.data || [];
				}
			},
			searching: false,
			columns: [
				{ data: 'NAME' },
				{ data: 'APPROVAL_TITLE' },
				{ data: 'CREATE_DATE' },
				{ data: 'APPROVAL_DEADLINE' },
			],
			columnDefs: [
				{ orderable: false, targets: [0, 1] },
				{ targets: [0, 1, 2, 3], className: 'text-center' }   // 제목, 상태 컬럼 정렬 비활성화
			],
			order: [[2, 'desc']], // 작성일 기준 내림차순 정렬
			pageLength: 4,
			autoWidth: false,
			responsive: true,
			scrollX: true,
			scrollY: "200px",
			language: {
				"decimal": "",
				"emptyTable": "데이터가 없습니다.",
				"info": "",
				"infoEmpty": "",
				"infoFiltered": "",
				"lengthMenu": "",
				"loadingRecords": "로딩 중...",
				"processing": "처리 중...",
				"search": "",
				"zeroRecords": "일치하는 데이터가 없습니다.",
				"paginate": {
					"first": "<<",
					"last": ">>",
					"next": ">",
					"previous": "<"
				}
			}
		});

// 		async function getChartData() {
// 			try {
// 				let response = await fetch('./approvalChartDataAjax.do');
// 				let data = await response.json();
// 				console.log(" 차트 데이터:", data);
// 				return data;
// 			} catch (error) {
// 				console.error(" 차트 데이터 로드 실패:", error);
// 				return null;
// 			}
// 		}
//
// 		function drawPieChart(canvasId, chartData, label) {
// 			const ctx = document.getElementById(canvasId).getContext('2d');
// 			new Chart(ctx, {
// 				type: 'pie',
// 				data: {
// 					labels: ['대기', '진행' ,'반려'
// //                 	'완료', '반려'
// 					],
// 					datasets: [{
// 						label: label,
// 						backgroundColor: ['#FF6384', '#36A2EB', '#4BC0C0', '#FFCE56'],
// 						data: [
// 							chartData.WAIT,
// 							chartData.PRE,
// //                         chartData.COMPLETED,
// 							chartData.REJECTED
// 						]
// 					}]
// 				},
// 				options: {
// //                 responsive: true,
// 					plugins: {
// 						legend: {
// 							display: true,
// 							position: 'middle',
// 							labels: {
// //                             boxWidth: 15,
// //                             usePointStyle: true,
// //                            padding: 15,
// //                             font: {
// //                                 size: 12
// //                             }
// 							} },
// 						title: { display: true, text: label },
// 						datalabels: {
// 							color: '#fff',
// 							font: {
// 								weight: 'bold',
// 								size: 14
// 							},
// 							anchor: 'center',
// 							align: 'center',
// 							formatter: (value) => {
// 								return value > 0 ? value : '';
// 							}
// 						}
// 					}
// 				},
// 				plugins: [ChartDataLabels]
// 			});
// 		}
//
// 		(async function () {
// 			let chartData = await getChartData();
// 			if (chartData) {
// 				 drawPieChart('approvalLineChart', chartData.approvalLine, '결재문서');
// 				drawPieChart('approvalChart', chartData.approval, '기안문서');
// 			}
// 		})();

		$('#boardList').DataTable({
			ajax: {
				url: './notice/boardList.do',
				dataSrc: ''
			},
			columns: [
				{
					data: null,
					render: function (data, type, row, meta) {
						return meta.row + 1; // 1부터 시작하는 순차 번호
					}
				},
				// { data: 'name' },
				{ data: 'title' },
				{
					data: 'create_date',
					// 날짜 포맷팅 옵션 추가 가능
					render: function(data) {
						return new Date(data).toLocaleDateString(); // 날짜 형식 지정
					}
				}
			],
			order: [[2, 'desc']], // 작성일 열(인덱스 3)을 내림차순으로 정렬 (최근 날짜 먼저)
			pageLength: 4,
			searching: false,
			info: false,
			autoWidth: false,
			responsive: true,
			scrollX: true,
			scrollY: "200px",
			language: {
				"decimal": "",
				"emptyTable": "데이터가 없습니다.",
				"info": "",
				"infoEmpty": "",
				"infoFiltered": "",
				"lengthMenu": "",
				"loadingRecords": "로딩 중...",
				"processing": "처리 중...",
				"search": "",
				"zeroRecords": "일치하는 데이터가 없습니다.",
				"paginate": {
					"first": "<<",
					"last": ">>",
					"next": ">",
					"previous": "<"
				}
			}

		});
	});
</script>
</html>
