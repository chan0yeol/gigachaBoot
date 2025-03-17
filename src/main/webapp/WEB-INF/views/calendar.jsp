<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>

<%@ include file="layout/header.jsp"%>
<!-- fullCalendar -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar"></script>
<!-- jQuery 및 jQuery UI -->
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 구글캘린더 -->

<style type="text/css">
.fc-col-header-cell-cushion, .fc-daygrid-day-number {
	text-decoration: none;
}

.fc-scrollgrid-sync-inner>.fc-col-header-cell-cushion, .fc-day-mon .fc-daygrid-day-number,
	.fc-day-tue .fc-daygrid-day-number, .fc-day-wed .fc-daygrid-day-number,
	.fc-day-thu .fc-daygrid-day-number, .fc-day-fri .fc-daygrid-day-number
	{
	color: black;
}

.fc-day-sun .fc-col-header-cell-cushion, .fc-day-sun a {
	color: red;
}

.fc-day-sat .fc-col-header-cell-cushion, .fc-day-sat a {
	color: blue;
}

.fc-toolbar-title {
	display: inline-block;
}

.ko_event {
	background-color: lightblue !important; /* 한국 기념일 일정 스타일 */
}

.personal-events {
	background-color: lightgreen !important; /* 개인 일정 스타일 */
}

#calendar {
	min-width: 800px;
	margin: 10px auto;
	height: auto;
	max-width: 1200px auto;
}
</style>
</head>
<body>
	<%-- <%@ include file="./layout/nav.jsp" %> --%>
	<%@ include file="layout/newNav.jsp"%>
	<%-- <%@ include file="./layout/sidebar.jsp" %> --%>
	<%@ include file="layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Calendar</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}">Home</a></li>
					<li class="breadcrumb-item active">Calendar</li>
				</ol>
			</nav>
		</div>
		<div class="row">
			<div id="content" class="col-6 mt-3">

				<!-- 캘린더 생성 위치 -->
				<div id='calendar-container'>
					<div id='calendar'></div>
				</div>

				<!-- 모달 -->
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="card-body">
								<h3 class="card-title" id="modal-title">일정 추가</h3>
								<!-- General Form Elements -->
								<form id="eventForm">
									<div class="row mb-3">
										<label for="empname" class="col-sm-2 col-form-label">등록자</label>
										<div class="col-sm-10">
											<input type="text" name="empname" class="form-control"
												id="empname" value="${loginDto.name}" readonly>
										</div>
									</div>
									<div class="row mb-3">
										<label for="empno" class="col-sm-2 col-form-label">사원번호</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="empno"
												name="empno" value="${loginDto.empno}" readonly> <input
												type="hidden" id="event_id">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_title" class="col-sm-2 col-form-label">제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control is-invalid"
												id="sch_title" name="sch_title">
											<div class="invalid-feedback">제목을 입력하세요.</div>
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_startdate" class="col-sm-2 col-form-label">시작</label>
										<div class="col-sm-10">
											<input type="datetime-local" class="form-control"
												name="sch_startdate" id="sch_startdate">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_enddate" class="col-sm-2 col-form-label">종료</label>
										<div class="col-sm-10">
											<input type="datetime-local" class="form-control"
												name="sch_enddate" id="sch_enddate">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_color" class="col-sm-2 col-form-label">색상</label>
										<div class="col-sm-10">
											<input type="color" class="form-control form-control-color"
												id="sch_color" value="#3788d8" title="일정 배경색 선택"
												name="sch_color">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_content" class="col-sm-2 col-form-label">내용</label>
										<div class="col-sm-10">
											<textarea class="form-control" id="sch_content"
												style="height: 100px" name="sch_content"></textarea>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col-sm-10 offset-sm-2" id="button-container">
											<button type="button" class="btn btn-outline-secondary me-2"
												data-bs-dismiss="modal">취소</button>
											<button type="button" class="btn btn-outline-success"
												id="saveChanges">추가</button>
										</div>
									</div>
								</form>
								<!-- End General Form Elements -->
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>
	</main>
</body>
<script>
   let calendar;
 
    
    $(function() {
      // DOM 요소 캐싱
      const $calendar = $('#calendar');
      const $modal = $('#exampleModal');
      const $modalTitle = $('#modal-title');
      const $eventForm = $('#eventForm');
      const $buttonContainer = $('#button-container');
      const $saveChanges = $('#saveChanges');
      
      // 폼 입력 요소 캐싱
      const $eventId = $('#event_id');
      const $empName = $('#empname');
      const $empNo = $('#empno');
      const $schTitle = $('#sch_title');
      const $schStartDate = $('#sch_startdate');
      const $schEndDate = $('#sch_enddate');
      const $schColor = $('#sch_color');
      const $schContent = $('#sch_content');
      // calendar element 취득
      const calendarEl = $calendar[0];
      
      // FullCalendar 초기화
      calendar = new FullCalendar.Calendar(calendarEl, {
        height: '700px',
        expandRows: true,
        slotMinTime: '08:00',
        slotMaxTime: '20:00',
        customButtons: {
          addSchedule: {
            text: "일정 추가하기",
            click: function() {
              // 새 일정 모달 열기
              openAddEventModal();
            }
          }
        },
        headerToolbar: {
          start: "dayGridMonth,dayGridWeek,dayGridDay",
          center: "prevYear,prev,title,next,nextYear",
          end: "addSchedule"
        },
        initialView: 'dayGridMonth',
        navLinks: true,
        editable: true,
        selectable: true,
        nowIndicator: true,
        dayMaxEvents: true,
        locale: 'ko',
        
        // 이벤트 클릭 핸들러
        eventClick: function(info) {
          openViewEventModal(info.event);
        },
        
        // 서버 이벤트 소스
        eventSources: [
          // 일정 데이터 소스
          {
            events: function(info, successCallback, failureCallback) {
              fetchEvents(info.startStr, info.endStr, successCallback, failureCallback);
            }
          },
          // 구글 캘린더 공휴일 데이터 소스
          {
            googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
            googleCalendarApiKey: 'AIzaSyCRs4PJQrTEOivYLaBKVB9lZVCbG64D7KE', // 실제 운영에서는 서버에서 처리하도록 변경 권장
            backgroundColor: 'red'
          }
        ]
      });
      
      // 서버에서 이벤트 데이터 가져오기
      function fetchEvents(startStr, endStr, successCallback, failureCallback) {
        console.log("📢 요청할 날짜 범위:", startStr, " ~ ", endStr);
        
        fetch(`${pageContext.request.contextPath}/calendar/loadSchedule.do?start=${startStr}&end=${endStr}`)
          .then(response => {
            if (response.status === 401) {
            	Swal.fire({
            		  icon: "error",
            		  title: "인증 오류",
            		  text: "로그인이 필요합니다",
            		  footer: '<a href="${pageContext.request.contextPath}/login.do">로그인 하러가기</a>'
            		});	
            	 return Promise.reject("인증 오류");
            } else if (response.status === 403) {
              Swal.fire("권한 오류", "접근 권한이 없습니다.", "error");
              return Promise.reject("권한 오류");
            } else if (response.status === 204) {
              console.log('📌 조회된 일정이 없습니다.');
              successCallback([]); // 빈 배열 전달
              return Promise.reject("일정 없음");
            } else if (!response.ok) {
              throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
          })
          .then(eventData => {
            console.log("📢 서버에서 받아온 데이터:", eventData);
            
            // 데이터 변환
            const eventArray = eventData.map(res => ({
              id: res.SCH_ID,
              title: res.SCH_TITLE,
              start: new Date(res.SCH_STARTDATE).toISOString(),
              end: new Date(res.SCH_ENDDATE).toISOString(),
              backgroundColor: res.SCH_COLOR || "#3788d8",
              extendedProps: { 
                empno: res.EMPNO,     
                empname: res.NAME,   
                sch_content: res.SCH_CONTENT,
              }
            }));
            
            console.log("📌 변환된 이벤트 데이터:", eventArray);
            successCallback(eventArray);
          })
          .catch(error => {
            if (error === "일정 없음") return; // 이미 처리됨
            
            console.error("❌ 데이터 처리 중 오류 발생:", error);
//             Swal.fire({
//               icon: "error",
//               title: "Oops...",
//               text: "일정을 불러오는 중 오류가 발생했습니다."
//             });
//             failureCallback(error);
          });
      }
      
      // 새 일정 추가 모달 열기
      function openAddEventModal() {
        resetForm();
        $modalTitle.text('일정 추가');
        $saveChanges.text('추가').show();
        
        // 삭제, 수정 버튼 제거
        $('#updateEvent, #deleteEvent').remove();
        
        // 제목 필드에 유효성 검사 클래스 적용
        $schTitle.removeClass('form-control').addClass('form-control is-invalid');
        
        $modal.modal('show');
      }
      
      // 이벤트 조회 모달 열기
      function openViewEventModal(event) {
        resetForm();
        $modalTitle.text('일정 조회');
        
        // 이벤트 데이터 설정
        $eventId.val(event.extendedProps.id || event.id);
        $empName.val(event.extendedProps.empname || '');
        $empNo.val(event.extendedProps.empno || '');
        $schTitle.val(event.title);
        
        // 날짜 포맷팅
//         let startDate = event.start ? event.start.toISOString().slice(0, 16) : '';
//         let endDate = event.end ? event.end.toISOString().slice(0, 16) : '';
//         let startDate = new Date(event.start - (new Date().getTimezoneOffset() * 60000)).toISOString()
//         let endDate = new Date(event.end - (new Date().getTimezoneOffset() * 60000)).toISOString()
let startDate = new Date(event.start - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 16);
let endDate = new Date(event.end - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 16);
        
        $schStartDate.val(startDate);
        $schEndDate.val(endDate);
        $schColor.val(event.backgroundColor || '#3788d8');
        $schContent.val(event.extendedProps.sch_content || '');
        
        // 버튼 상태 변경
        $saveChanges.hide();
        
        // 삭제 버튼 제거 후 다시 추가
        $('#deleteEvent, #updateEvent').remove();
        
        // 버튼 추가
        $buttonContainer.append(`
          <button type="button" class="btn btn-outline-primary me-2" id="updateEvent">수정</button>
          <button type="button" class="btn btn-outline-danger" id="deleteEvent">삭제</button>
        `);
        
        // 제목 필드 유효성 검사 클래스 제거
        $schTitle.removeClass('is-invalid is-valid').addClass('form-control');
        
        // 이벤트 핸들러 등록
        setupEventHandlers(event);
        
        // 모달 표시
        $modal.modal('show');
      }
      
      function formatTimeString(dateObj) {
  		const hours = dateObj.getHours().toString().padStart(2, '0');
  		const minutes = dateObj.getMinutes().toString().padStart(2, '0');
  		const seconds = dateObj.getSeconds().toString().padStart(2, '0');

  		return `${hours}:${minutes}:${seconds}`;
  	}
      
      // 이벤트 핸들러 설정
      function setupEventHandlers(event) {
        // 수정 버튼 클릭 핸들러
        $('#updateEvent').off('click').on('click', function() {
          // 유효성 검사
          if (!validateForm()) return;
          
          const updatedData = {
            id: $eventId.val(),
            empno: $empNo.val(),
            sch_title: $schTitle.val(),
            start: $schStartDate.val(),
            end: $schEndDate.val(),
            color: $schColor.val(),
            sch_content: $schContent.val()
          };
          
          updateEvent(updatedData, event);
        });
        
        // 삭제 버튼 클릭 핸들러
        $('#deleteEvent').off('click').on('click', function() {
          deleteEvent(event);
        });
      }
      
      
      // 폼 초기화
      function resetForm() {
        $eventId.val('');
        $empName.val('${loginDto.name}');
        $empNo.val('${loginDto.empno}');
        $schTitle.val('');
        $schStartDate.val('');
        $schEndDate.val('');
        $schColor.val('#3788d8');
        $schContent.val('');
      }
      
      // 폼 유효성 검사
      function validateForm() {
        const title = $schTitle.val().trim();
        const start = $schStartDate.val();
        const end = $schEndDate.val();
        
        if (title === '') {
          Swal.fire("제목을 입력해주세요.");
          return false;
        }
        
        if (start === '') {
          Swal.fire("시작 시간을 입력해주세요.");
          return false;
        }
        
        if (end === '') {
          Swal.fire("종료 시간을 입력해주세요.");
          return false;
        }
        
        if (start > end) {
          Swal.fire("시작 시간이 종료 시간보다 늦을 수 없습니다.");
          return false;
        }
        
        return true;
      }
      
      // 이벤트 저장
      function saveEvent(eventData) {
        console.log("저장할 이벤트:", eventData);
        let formData = new FormData(document.forms[0]);
        let jsonData = {};
        formData.forEach((value, key) => {
            jsonData[key] = value;
        });
        console.log(jsonData);
        fetch('./saveSchedule.do', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
        	  events: Array.isArray(eventData) ? eventData : [eventData] // 배열이면 그대로, 단일 데이터면 배열로 변환
          })
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.text();
        })
        .then(data => {
          console.log("저장 완료!", data);
          Swal.fire("저장 완료!", "일정이 추가되었습니다.", "success");
          
          // 캘린더 새로고침
          calendar.refetchEvents();
        })
        .catch(err => {
          console.error("에러 발생:", err);
          Swal.fire("오류 발생", "일정을 저장하는 중 문제가 발생했습니다.", "error");
        });
      }
      
      // 이벤트 업데이트
      function updateEvent(eventData, originalEvent) {
        console.log("업데이트할 이벤트:", eventData);
        
        fetch('./updateSchedule.do', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(eventData)
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.text();
        })
        .then(data => {
          console.log("업데이트 완료!", data);
          Swal.fire("수정 완료!", "일정이 수정되었습니다.", "success");
          
          // 모달 닫기
          $modal.modal('hide');
          
          // 캘린더 새로고침
          calendar.refetchEvents();
        })
        .catch(err => {
          console.error("에러 발생:", err);
          Swal.fire("오류 발생", "일정을 수정하는 중 문제가 발생했습니다.", "error");
        });
      }
      
      // 이벤트 삭제
      async function deleteEvent(event) {
        const result = await Swal.fire({
          title: "정말 삭제하시겠습니까?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#d33",
          cancelButtonColor: "#3085d6",
          confirmButtonText: "삭제",
          cancelButtonText: "취소"
        });
        
        if (!result.isConfirmed) return;
        
        try {
          // 모달 닫기
          $modal.modal('hide');
          
          // 캘린더에서 이벤트 제거
          event.remove();
          
          // 서버에서 삭제
          const response = await fetch('./deleteSchedule.do', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: event.extendedProps.id || event.id, empno: event.extendedProps.empno || event.empno })
          });
          
          if (!response.ok) {
            throw new Error("서버 응답 오류: " + response.status);
          }
          
          // 성공 알림
          Swal.fire("삭제 완료!", "일정이 삭제되었습니다.", "success");
          
          // 캘린더 새로고침 (이벤트가 실제로 삭제되었는지 확인)
          calendar.refetchEvents();
        } catch (error) {
          console.error("삭제 오류:", error);
          Swal.fire("오류 발생", "일정을 삭제하는 중 문제가 발생했습니다.", "error");
          
          // 오류 발생 시 캘린더 새로고침
          calendar.refetchEvents();
        }
      }
      
      // 모달이 닫힐 때 처리
      $modal.on('hidden.bs.modal', function() {
        resetForm();
        $('#updateEvent, #deleteEvent').remove();
        $saveChanges.show();
        $schTitle.removeClass('form-control').addClass('form-control is-invalid');
        $modalTitle.text('일정 추가');
      });
      
      // 제목 입력 필드 유효성 검사
      $schTitle.on('input', function() {
        if ($(this).val().trim() !== '') {
          $(this).removeClass('is-invalid').addClass('is-valid');
        } else {
          $(this).removeClass('is-valid').addClass('is-invalid');
        }
      }).on('blur', function() {
        if ($(this).val().trim() === '') {
          $(this).addClass('is-invalid');
        }
      });
      
      // 저장 버튼 클릭 핸들러
      $saveChanges.on('click', function() {
        // 유효성 검사
        if (!validateForm()) return;
        
        // 이벤트 데이터 구성
        const eventData = {
          empno: $empNo.val(),
          sch_title: $schTitle.val(),
          start: $schStartDate.val(),
          end: $schEndDate.val(),
          color: $schColor.val(),
          sch_content: $schContent.val()
        };
        
        // 모달 닫기
        $modal.modal('hide');
        
        // 이벤트 저장
        saveEvent(eventData);
      });
      
      // 캘린더 렌더링
      calendar.render();
      
      // 연차 불러오기
      loadLeaveData();

      
    });
    
    // 연차 데이터 불러오기
//     function loadLeaveData() {
//       fetch('${pageContext.request.contextPath}/approval/postLeaveToCalendar.json', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json'
//         }
//       })
//       .then(resp => resp.json())
//       .then(data => {
//         console.log("연차 데이터:", data);
//         // 연차 데이터 처리 로직 추가
//         if (data && Array.isArray(data) && data.length > 0) {
//           const leaveEvents = data.map(leave => ({
//             title: '연차: ' + leave.title || '연차',
//             start: leave.start,
//             end: leave.end,
//             backgroundColor: '#FFD700', // 연차 색상 (금색)
//             borderColor: '#FFA500',
//             allDay: true,
//             extendedProps: {
//               isLeave: true,
//               details: leave.details || ''
//             }
//           }));
          
//           calendar.addEventSource({
//             events: leaveEvents,
//             color: '#FFD700',
//             textColor: 'black'
//           });
//         }
//       })
//       .catch(error => {
//         console.error("연차 데이터 불러오기 오류:", error);
//       });
//     }
    
    
 async function loadLeaveData() {
  if (!calendar) {
    console.error("calendar가 아직 초기화되지 않았습니다.");
    return;
  }

  try {
    const response = await fetch('${pageContext.request.contextPath}/approval/postLeaveToCalendar.json', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' }
    });

    if (!response.ok) {
      throw new Error(`HTTP 오류! 상태 코드: ${response.status}`);
    }

    const data = await response.json();
    console.log("연차 데이터:", data);
    
    

    if (data && Array.isArray(data) && data.length > 0) {
      const leaveEvents = data.map(leave => ({
        // empno: leave.empno, // extendedProps 안으로 이동
        title: leave.title ? '연차: ' + leave.title : '연차', // sch_title -> title
        start: leave.START_DATE,
        end: leave.END_DATE, // 
        backgroundColor: '#FFD700',  // color -> backgroundColor
        //sch_content: leave.details || '', // extendedProps 안으로 이동
        extendedProps: {  // extendedProps 객체 추가
          isLeave: true,
          empno: leave.EMPNO,
          sch_content: leave.details || '',
          empname : leave.NAME //이름도 추가
        }
      }));

      console.log("🎆🎆연차 데이터:", leaveEvents);
      // 기존 연차 이벤트 소스 제거 (v6 방식)
      calendar.getEventSources().forEach(source => {
          if (source.internalEventSource.meta.isLeaveSource) {
              source.remove();
          }
      });


      // 연차 이벤트 소스 추가
      calendar.addEventSource({
          events: leaveEvents,  // 이벤트 배열을 events 속성에 할당
          id: 'leaveSource', // 고유한 ID (선택 사항이지만 권장)
          isLeaveSource: true // 커스텀 속성 (선택 사항)
      });
    }
  } catch (error) {
    console.error("연차 데이터 불러오기 오류:", error);
  }
}

  
</script>
</html>