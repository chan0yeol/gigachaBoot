<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="./layout/header.jsp"%>

<style type="text/css">
#profile-img {
    width: 200px; /* 이미지 너비 조정 */
    height: 200px; /* 이미지 높이 조정 */
    display: block; /* 블록 요소로 변경 */
    margin: 0 auto; /* 가운데 정렬 */
    object-fit: cover; /* 이미지 비율 유지 및 영역에 맞춤 */
}
</style>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">마이페이지</h3>
			
			<div class="row">
		        <div class="col-xl-4">
		          <div class="card">
		          	<div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
		            <img id="profile-img" src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="기본이미지">
		              <h4>이름</h4>
		            </div>
		          </div>
		        </div>
		        <div class="col-xl-8">
		
		          <div class="card">
		            <div class="card-body pt-3">
		              <!-- Bordered Tabs -->
		              <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">
		
		                <li class="nav-item" role="presentation">
		                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview" aria-selected="true" role="tab">내 정보</button>
		                </li>
		
		                <li class="nav-item" role="presentation">
		                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit" aria-selected="false" tabindex="-1" role="tab">개인정보 수정하기</button>
		                </li>
		
		                <li class="nav-item" role="presentation">
		                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" tabindex="-1" role="tab">비밀번호 변경하기</button>
		                </li>
		
		              </ul>
		              <div class="tab-content pt-2">
		
		                <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
		                  <h5 class="card-title"></h5>
		
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label ">사번</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">직급</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">부서</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		                  
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">입사일</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		                  
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">재직상태</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">내선번호</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		
		                  <div class="row">
		                    <div class="col-lg-3 col-md-4 label">이메일</div>
		                    <div class="col-lg-9 col-md-8"></div>
		                  </div>
		
		                </div>
		
		                <div class="tab-pane fade profile-edit pt-3" id="profile-edit" role="tabpanel">
		
		                  <!-- Profile Edit Form -->
		                  <form>
		                    <div class="row mb-3">
		                      <label for="empno" class="col-md-4 col-lg-3 col-form-label">사번</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="empno" type="text" class="form-control" id="empno">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="name" class="col-md-4 col-lg-3 col-form-label">성명</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="name" type="text" class="form-control" id="name">
		                      </div>
		                    </div>
		                    
		                    <div class="row mb-3">
		                      <label for="birthday" class="col-md-4 col-lg-3 col-form-label">생년월일</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="birthday" type="text" class="form-control" id="birthday">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="gender" class="col-md-4 col-lg-3 col-form-label">성별</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="gender" type="text" class="form-control" id="gender">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="adress" class="col-md-4 col-lg-3 col-form-label">주소</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="adress" type="text" class="form-control" id="adress">
		                      </div>
		                    </div>
		                    
		                    <div class="row mb-3">
		                      <label for="Address" class="col-md-4 col-lg-3 col-form-label">내선번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="tel" type="text" class="form-control" id="tel">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="Phone" class="col-md-4 col-lg-3 col-form-label">전화번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="phone" type="text" class="form-control" id="Phone">
		                        	<button class="btn btn-secondary btn-sm mt-1" type="button" onclick="verifyPhone()">인증하기</button><br>
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="email" type="email" class="form-control" id="email">
		                        <button class="btn btn-secondary btn-sm mt-1" type="button" onclick="verifyPhone()">인증하기</button><br>
		                      </div>
		                    </div>
		                    
		                    <div class="row mb-3">
		                      <label for="degree" class="col-md-4 col-lg-3 col-form-label">최종학력</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="degree" type="text" class="form-control" id="degree">
		                      </div>
		                    </div>
		                    
		                    <div class="row mb-3">
		                      <label for="school" class="col-md-4 col-lg-3 col-form-label">학교</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="school" type="text" class="form-control" id="school">
		                      </div>
		                    </div>
		                    
		                    <div class="row mb-3">
		                      <label for="major" class="col-md-4 col-lg-3 col-form-label">전공</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="major" type="text" class="form-control" id="major">
		                      </div>
		                    </div>
		
		                    <div class="text-center">
		                      <button type="submit" class="btn btn-primary">변경</button>
		                      <button type="reset" class="btn btn-primary">취소</button>
		                    </div>
		                  </form><!-- End Profile Edit Form -->
		
		                </div>
		
		                <div class="tab-pane fade pt-3" id="profile-settings" role="tabpanel">
		
		                 
		                </div>
		
		                <div class="tab-pane fade pt-3" id="profile-change-password" role="tabpanel">
		                  <!-- Change Password Form -->
		                  <form>
		
		                    <div class="row mb-3">
		                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재 비밀번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="password" type="password" class="form-control" id="currentPassword">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="newpassword" type="password" class="form-control" id="newPassword">
		                      </div>
		                    </div>
		
		                    <div class="row mb-3">
		                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">비밀번호 확인</label>
		                      <div class="col-md-8 col-lg-9">
		                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
		                      </div>
		                    </div>
		
		                    <div class="text-center">
		                      <button type="submit" class="btn btn-primary">Change Password</button>
		                    </div>
		                  </form><!-- End Change Password Form -->
		
		                </div>
		
		              </div><!-- End Bordered Tabs -->
		
		            </div>
		          </div>
		
		        </div>
      </div>
			
		</div>
	</div>
</main>
	
</body>


</html>
