<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="./layout/header.jsp"%>
<!-- TOAST UI Calendar v1.x (tui.Calendar 사용) -->
<link rel="stylesheet" type="text/css"
	href="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.css" />
<link rel="stylesheet" type="text/css"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.dom/v3.0.0/tui-dom.js"></script>
<script
	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.js"></script>


<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}

#calendar {
	height: 800px;
	margin: 20px;
}
</style>
</head>
<body>
	<%@ include file="./layout/nav.jsp"%>
<%-- 	<%@ include file="./layout/sidebar.jsp"%> --%>
	<div id="content">
		<h3 class="content_title">제목</h3>
		<!-- 캘린더 영역 -->
		<div class="calendar-controls">
			<button class="prev">⬅️ 이전</button>
			<button class="today">📆 오늘</button>
			<button class="next">➡️ 다음</button>
		</div>
		<div id="calendar"></div>
	</div>
</body>
<script>
document.addEventListener("DOMContentLoaded", function () {
    console.log(":흰색_확인_표시: 캘린더 초기화 시작");
    // :일: TOAST UI Calendar v1.x 인스턴스 생성
    const calendar = new tui.Calendar("#calendar", {
        defaultView: "month",
        taskView: true,
        useDetailPopup: true,
        useCreationPopup: true,
        month: {
            visibleWeeksCount: 6,
        },
    });
    console.log(":압정: 캘린더 객체 생성 완료:", calendar);
    // :둘: 캘린더 ID 등록 (v1.x에서는 필수!)
    calendar.setCalendars([
        {
            id: "cal1",
            name: "개인 일정",
            color: "#FFFFFF",
            bgColor: "#9E5FFF",
            dragBgColor: "#9E5FFF",
            borderColor: "#9E5FFF",
        },
        {
            id: "cal2",
            name: "업무 일정",
            color: "#FFFFFF",
            bgColor: "#00A9FF",
            dragBgColor: "#00A9FF",
            borderColor: "#00A9FF",
        },
    ]);
    // :셋: 일정 추가 (v1.x는 `createSchedules` 사용)
    calendar.createSchedules([
        {
            id: "event1",
            calendarId: "cal1",
            title: "팀 미팅",
            category: "time", // :불: v1.x에서는 반드시 추가해야 함
            start: "2025-02-25T10:00:00",
            end: "2025-02-25T11:00:00",
        },
        {
            id: "event2",
            calendarId: "cal2",
            title: "클라이언트 미팅",
            category: "time", // :불: v1.x에서는 반드시 추가해야 함
            start: "2025-03-13T14:00:00",
            end: "2025-03-15T15:30:00",
        },
    ]);
    console.log(":압정: 일정 추가 완료!");
    // 일정 추가 이벤트
    calendar.on('beforeCreateSchedule', function(event) {
        var newSchedule = {
            id: String(new Date().getTime()), // 고유 ID
            calendarId: 'cal2',
            title: event.title,
            category: 'time',
            start: event.start.toDate(),
            end: event.end.toDate()
        };
        console.log(newSchedule);
    });
    // :넷: 일정 클릭 이벤트 리스너 추가 (v1.x는 `clickSchedule` 사용)
    calendar.on("clickSchedule", function (e) {
        console.log(":버튼_세_개_마우스: 일정 클릭됨:", e.schedule.title);
        console.log(e.schedule);
    });
    calendar.on('beforeCreateEvent', (eventObj) => {
    	  console.log(":버튼_세_개_마우스: 일정 클릭됨:")
    	  calendar.createEvents([
    	    {
    	      ...eventObj,
    	      id: uuid(),
    	    },
    	  ]);
    	});
    console.log(":흰색_확인_표시: 이벤트 리스너 등록 완료!");

    // ✅ 날짜 이동 버튼 이벤트 리스너 추가
    document.querySelector(".prev").addEventListener("click", function () {
        calendar.prev();
        console.log("⬅️ 이전 달로 이동:", calendar.getDateRangeStart(), "~", calendar.getDateRangeEnd());
    });

    document.querySelector(".next").addEventListener("click", function () {
        calendar.next();
        console.log("➡️ 다음 달로 이동:", calendar.getDateRangeStart(), "~", calendar.getDateRangeEnd());
    });

    document.querySelector(".today").addEventListener("click", function () {
        calendar.today();
        console.log("📆 오늘 날짜로 이동:", calendar.getDateRangeStart(), "~", calendar.getDateRangeEnd());
    });
});
</script>
</html>
