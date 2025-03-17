<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="teal">
                <button class="" onclick="sidebar()">
                    <img src="https://cdn3.iconfinder.com/data/icons/arrow-outline-8/32/left-24.png" alt="">
                </button>
            </div>
            <!-- <a class="navbar-brand" href="#">HOME</a> -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}">홈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">인사관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">근태관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">캘린더</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            전자결재
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/approval/approvalDocument.do">기안 작성</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/approval/approvalRequestList.do">결재목록</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/approval/approvalList.do">결재요청함</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/approval/approvalFormList.do">문서양식관리(관리자)</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" 
                        	aria-expanded="false">
                        	예약
                        </a>
                        <ul class="dropdown-menu">
                        	<li><a class="dropdown-item" href="#">회의실 예약</a></li>
                        	<li><a class="dropdown-item" href="#">회의실 취소</a></li>
                        	<li><a class="dropdown-item" href="#">회의실 예약내역</a></li>
                        	<li><a class="dropdown-item" href="#">회의실 등록(관리자)</a></li>
                        	<li><a class="dropdown-item" href="#">회의실 정보 수정 및 삭제(관리자)</a></li>
                        	<li><a class="dropdown-item" href="#">회의실 예약내역 조회(관리자)</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div>
        </nav>
</body>
</html>