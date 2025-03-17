<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>

<%@ include file="layout/header.jsp"%>
<style type="text/css">
.profile img {
  width: 120px;  /* 원하는 크기로 조정 */
  height: 120px; /* 비율을 맞추기 위해 동일하게 설정 */
  object-fit: cover; /* 이미지를 비율에 맞게 잘라서 채우기 */
}
</style>
</head> 
<body>
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-12">
			<div class="pagetitle">
		    	<h1>사원 등록</h1>
		    	<nav>
			        <ol class="breadcrumb">
			        	<li class="breadcrumb-item"><a href="index.html">Home</a></li>
			          	<li class="breadcrumb-item">Users</li>
			          	<li class="breadcrumb-item active">Profile</li>
			        </ol>
		    	</nav>
	    	</div>
	    	<div class="row">
		        <div class="col-xl-4">
		        	<div class="profile">
                      <label for="profileImage">Profile Image</label>
                      <div class="col-md-8 col-lg-9">
                        <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="Profile">
                        <div class="pt-2">
                          <button class="btn btn-primary btn-sm">사진 등록</button>
                          <button class="btn btn-danger btn-sm">기본사진으로 되돌리기</button>
                        </div>
                      </div>
                    </div>
        		</div>
               	<div class="col-xl-4">
	        		<div>
	                	<form>
	                    	<div class="row mb-3">
	                      		<label for="empNumber" class="col-md-4 col-lg-3 col-form-label">사번</label>
	                      		<div class="col-md-8 col-lg-9">
	                        		<input name="empNumber" type="text" class="form-control" id="empNumber">
	                      		</div>
	                    	</div>
		                    <div class="row mb-3">
		                    	<label for="name" class="col-md-4 col-lg-3 col-form-label">이름</label>
		                      	<div class="col-md-8 col-lg-9">
		                        	<input name="name" type="text" class="form-control" id="name">
		                      	</div>
		                    </div>
		                    <div class="row mb-3">
		                    	<label for="birthday" class="col-md-4 col-lg-3 col-form-label">생년월일</label>
		                      	<div class="col-md-8 col-lg-9">
			                        <select class="box" id="birth-year">
			                        	<option disabled selected>출생 연도</option>
			                        </select>
			                        <select class="box" id="birth-year">
			                        	<option disabled selected>월</option>
			                        </select>
			                        <select class="box" id="birth-year">
			                        	<option disabled selected>일</option>
			                        </select>
		                      	</div>
		                    </div>
	                    <div class="row mb-3">
	                      <label for="degree" class="col-md-4 col-lg-3 col-form-label">최종학력</label>
	                      <div class="col-md-8 col-lg-9">
	                        <input name="degree" type="text" class="form-control" id="degree">
	                      </div>
	                    </div>
	                    <div class="row mb-3">
	                      <label for="gender" class="col-md-4 col-lg-3 col-form-label">성별</label>
	                      <div class="col-md-8 col-lg-9">
	                        <input type="radio" name="gender" value="male">남성
	                        <input type="radio" name="gender" value="femail">여성
	                      </div>
	                    		</div>
	                  		</form>
	               		</div>
	               	</div>
	               	<div class="col-xl-4">
		              	<div>
		                  <form>
		                  	<div class="row mb-3">
		                      <label for="empNumber" class="col-md-4 col-lg-3 col-form-label">내선번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="empNumber" type="text" class="form-control" id="empNumber">
		                      </div>
		                    </div>
		                    <div class="row mb-3">
		                      <label for="name" class="col-md-4 col-lg-3 col-form-label">휴대전화번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="name" type="text" class="form-control" id="name">
		                      </div>
		                    </div>
		                    <div class="row mb-3">
		                      <label for="birthday" class="col-md-4 col-lg-3 col-form-label">이메일</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="birthday" type="text" class="form-control" id="birthday">
		                      </div>
		                    </div>
		                    <div class="row mb-3">
		                      <label for="degree" class="col-md-4 col-lg-3 col-form-label">학교</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="degree" type="text" class="form-control" id="degree">
		                      </div>
		                    </div>
		                    <div class="row mb-3">
		                      <label for="gender" class="col-md-4 col-lg-3 col-form-label">주소</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="adress" type="text" class="form-control" id="adress">
		                      </div>
		                    </div>
		                  	</form>
		                  </div>
	               		</div>
	               		
	                    <div class="text-center">
	                      <button type="submit" class="btn btn-primary">Save Changes</button>
	                    </div>
       		</div>
    	</div>
	</div>
</main>
</body>


</html>
