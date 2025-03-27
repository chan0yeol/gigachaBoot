<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
      <a href="${pageContext.request.contextPath}" class="logo d-flex align-items-center">
        <img src="assets/img/logo.png" alt="">
        <span class="d-none d-lg-block">GIGACOMPANY</span>
      </a>
      <div class="icon">
<!-- 	      <i class="bi bi-list toggle-sidebar-btn"> -->
	      <img class="toggle-sidebar-btn" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAQNJREFUWEftlTFOxEAMRed7U0JyBrhKlEkLRbotEaeIQCLH2G7bVFBlZg4DV0h2W2yUggalcGEpFDP16Pvr2V8fbueHnee7bCATyAQ2CTRN8wjg7Jy7MYrpFcAxhPD+V2/TQNu2JxF5Mhr+K3OKMT6rDHjv75i5J6JbCxPMfCmKYpim6UtlwGKoViOnYJNA13WHeZ69iJikAMC1qqo4juO36ga894NzrtfuUfMPwBBCeNnNgIi8pZReVQbWFSzL0jCzSQyJ6FKWZVKvQIPU6k+O4SaBuq7viagHYBJDEVnLaIgxfqqO8D+U0QMzny3LaK3jlNKHioDVhWt0cgoygUxgdwI/M3dcIRArV8sAAAAASUVORK5CYII=">
<!-- 	      </i> -->
      </div>
    </div>
    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
        <li class="nav-item dropdown pe-3">
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="d-none d-md-block dropdown-toggle ps-2">인사관리</span> 
          </a><!-- End Profile Iamge Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile" style="">
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/deptManagement/deptManagement.do"> 
				<span>부서 관리</span></a></li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/notice/notice.do"> 
				<span>공지사항</span></a></li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/hrManagement/employeeAdd.do"> 
				<span>인사등록</span></a></li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/hrManagement/mypage.do"> 
				<span>마이페이지</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
          </ul>
        </li>
        <li class="nav-item pe-3">
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="d-none d-md-block dropdown-toggle ps-2">근태관리</span>
          </a><!-- End Profile Iamge Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile" style="">
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/attendance/myattendance.do"> 
				<span>나의 근태 현황</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/attendance/attendance.do"> 
				<span>부서 근태 현황</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/attendance/leaveattendance.do"> 
				<span>부서 연차 현황</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
          </ul>
        </li>
        <li class="nav-item pe-3">
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="${pageContext.request.contextPath}/calendar/calendar.do" aria-expanded="false">
            <span class="d-none d-md-block">캘린더</span>
          </a><!-- End Profile Iamge Icon -->
        </li>
        <li class="nav-item dropdown pe-3">
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="d-none d-md-block dropdown-toggle ps-2">전자결재</span>
          </a><!-- End Profile Iamge Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile" style="">
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/approval/approvalDocument.do"> 
				<span>기안 작성</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/approval/approvalRequestList.do"> 
				<span>결재목록</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/approval/approvalList.do"> 
				<span>결재요청함</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <c:if test="${loginDto.auth eq 'A'}">
	            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/approval/formList.do"> 
					<span>문서양식</span></a></li>
	            <li> <hr class="dropdown-divider"> </li>
           </c:if>
          </ul>
        </li>
        <li class="nav-item dropdown pe-3">
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="d-none d-md-block dropdown-toggle ps-2">예약</span>
          </a><!-- End Profile Iamge Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile" style="">
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/rooms/reservation.do"> 
				<span>회의실 예약</span></a></li>
            <li> <hr class="dropdown-divider"> </li>
            <li><a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/rooms/reservationList.do"> 
				<span>예약내역조회</span></a></li>
            <li> <hr class="dropdown-divider"> </li>         
          </ul>
        </li>      
        <c:if test="${loginDto.auth == 'A'}">
<!--          <li class="nav-item dropdown pe-3"> -->
         		<a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" aria-expanded="false">
            		<span class="d-none d-md-block dropdown-toggle ps-2">관리자</span>
          		</a><!-- End Profile Iamge Icon -->
          	<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile" style="">
            <li>
            	<a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/rooms/roomList.do"> 
					<span>회의실정보 리스트</span>
				</a>
				<a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/rooms/reservationList.do"> 
					<span>전체회의실내역조회</span>
				</a>
			</li>
      		</ul>
		</c:if>
    </nav>

  </header>
  <!-- TODO 00207 Socket - 웹소켓 알림 표시될 Div   -->
  <div id="toast-container" style="
    position: absolute;
    bottom: 15px;
    right: 15px;
    z-index: 1050;
"></div>
<!--   <div class="toast" style=" -->
/*     position: absolute; */
/*     bottom: 15px; */
/*     right: 15px; */
<!-- "> -->
<!--   <div class="toast-header"> -->
<!--     <strong class="me-auto">알림내역</strong> -->
<!--     <button type="button" class="btn-close" data-bs-dismiss="toast"></button> -->
<!--   </div> -->
<!--   <div class="toast-body"> -->
<!--     <p id="toast-text"></p> -->
<!--   </div> -->
<!-- </div> -->

  <script src="https://bootstrapmade.com/assets/js/demo.js?v=42"></script>
  <script src="${pageContext.request.contextPath}/resources/js/notificationWebSocket.js"></script>
  <script type="text/javascript">
  	var sideIsc = true;
  	document.querySelector(".toggle-sidebar-btn").addEventListener('click',() => {
  		console.log("클릭");
  		if(sideIsc == true) {
  			document.body.className= "toggle-sidebar";
  			sideIsc = false;
  		} else{
  			document.body.className= "";
  			sideIsc = true;
  		}
  		
  	});
  </script>
</body>

</html>