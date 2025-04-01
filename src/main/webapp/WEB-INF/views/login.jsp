<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<%@ include file="./layout/header.jsp"%>
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
</style>
</head>
<body>
	<main>
    <div class="container">
      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">GIGACHA</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">GIGACHA</h5>
                  </div>

                  <form class="row g-3 needs-validation" action="/login.do" method="POST" novalidate="">

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">사원번호</label>
                      <div class="input-group has-validation">
                        <input type="text" name="empno"  class="form-control" id="yourUsername" required="">
                        <div class="invalid-feedback">사원번호 입력해주세요</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" required="">
                      <div class="invalid-feedback">비밀번호 입력해주세요</div>
                    </div>
					  <div class="col-12">
						  <div class="form-check">
							  <input class="form-check-input" type="checkbox" name="remember-me" value="true" id="rememberMe">
							  <label class="form-check-label" for="rememberMe">Remember me</label>
						  </div>
					  </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Login</button>
                    </div>
						<div class="col-12" style="display: flex;justify-content: center; align-items: center;">
						<button type="button" class="btn btn-link small mb-0" 
							onclick="location.href=#">비밀번호 재설정</button>
							<button type="button" class="btn btn-link small mb-0" id="findEmpnoBtn" data-bs-toggle="modal" data-bs-target="#findEmpno">사원번호 찾기
              </button>
					</div>
                  </form>

                </div>
              </div>
            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
	<!-- 사원번호 조회 -->
	<div class="modal fade" id="findEmpno" tabindex="-1" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">사원번호 조회</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="findForm" action="./findEmpno.do" method="POST">
						<div class="col-12">
							<label for="yourUsername" class="form-label">이름</label>
							<div class="input-group has-validation">
								<input type="text" name="name" class="form-control"
									id="name" placeholder="이름을 입력해주세요">
							</div>
						</div>
						<div class="col-12">
							<label for="inputEmail" class="form-label">Email</label>
							<div class="input-group has-validation">
								<span class="input-group-text" id="inputGroupPrepend">@</span> <input
									type="text" name="email" class="form-control"
									id="email" placeholder="이메일을 입력해주세요">
							</div>
						</div>
						 <span id="empnoResult"></span>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="findBtn">조회</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$("#findEmpnoBtn").on('click', function() {
		
		 $("#findEmpnoModal").modal('show');
    });
// });
	   
	$("#findBtn").on('click', function(){
		 	var name = $("#name").val();
		    var email = $("#email").val();
			var msg = $('#empnoResult');
		    // 이메일 형식 체크
		    const emailRegex = /^[a-zA-Z0-9,_%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		    if (email.match(emailRegex)) {
		        // AJAX 요청을 통해 사원번호를 찾기
		        $.ajax({
		            url: "./findEmpno.do",
		            type: "POST",
		            data: { "name": name, "email": email },
		            success: function(data) {
		                console.log("🎉 성공 응답:", data.msg);
//	 	                if (data && data.empno) {
		                    msg.text("사원번호는 [" + data.msg + "]입니다.");
//	 	                } else {
//	 	                	msg.text("사원번호를 찾을 수 없습니다.");
//	 	                }
		            },
		            error: function(err) {
		                console.log("🚨 에러 발생:", err);
		                alert("관리자에게 문의하세요.");
		            }
		        });
		    } else {
		    	msg.text("잘못된 이메일 형식입니다.");
		    }
		});
		    // "닫기" 버튼 또는 모달 종료 시 입력값 & 결과 초기화
		    $("#findEmpno").on("hidden.bs.modal", function() {
		    	$("#findForm")[0].reset(); // 폼 전체 초기화
		        $("#empnoResult").text(""); // 결과 메시지 초기화
		    });
	
	</script>
</body>

</html>
