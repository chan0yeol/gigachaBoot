<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식 카테고리 등록</title>

<%@ include file="layout/header.jsp"%>
</head>
<body>
	<%@ include file="layout/newNav.jsp"%>
	<%@ include file="layout/newSide.jsp"%>
<main id="main" class="main">
	<div class="row">
		<div id="content">
			<h3 class="content_title">문서양식 카테고리 등록</h3>
				<div class="col">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">카테고리 등록</h5>
							<form>
								<div class="mb-3">
									<label class="col-form-label">카테고리이름</label>
									<div>
										<input type="text" class="form-control" name="category_name" placeholder="이름을 입력하세요">
									</div>
								</div>
								<div class="mb-3">
									<label class="col-form-label">카테고리약어</label>
									<div>
										<input type="text" class="form-control" name="category_yname" placeholder="ex) HR">
									</div>
								</div>
								<div class="text-center">
									<button type="submit" class="btn btn-primary">Submit</button>
									<button type="reset" class="btn btn-secondary">Reset</button>
									<button type="button" class="btn btn-info" onclick="history.back()">cancle</button>
								</div>
							</form>
	
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script type="text/javascript">
		window.onload = function() {
			document.querySelector("input[name=category_yname]").addEventListener('input',(event) => {
				console.log("체인지~~~~");
				let yname = document.querySelector("input[name=category_yname]").value;
				let ynamePattern = /^[a-zA-Z]+$/;
				if(yname.length > 0 && !ynamePattern.test(yname)){
					Swal.fire("영어만 입력 가능합니다.");
					document.querySelector("input[name=category_yname]").value = yname.replace(/[^a-zA-Z]/g, '');
					return;
				}
				if (yname.length > 2) {
					Swal.fire("2자리 까지 입력 가능합니다.");	
					document.querySelector("input[name=category_yname]").value = yname.substring(0,2);
					return;
				}
				
			})
			
			document.querySelector("button[type=submit]").addEventListener('click', (event) => {
				event.preventDefault();
				let name = document.querySelector("input[name=category_name]").value;
				let yname = document.querySelector("input[name=category_yname]").value;
				let ynamePattern = /[a-zA-Z]/;
				console.log(name, yname);
				if(name.length == 0 || yname.length == 0) {
					Swal.fire("모든 값을 입력해주세요");
					return;
				}
				if(yname.length > 2) {
					Swal.fire("약어는 2자리 까지만 입력 가능합니다.");
					return;
				}
				if(!ynamePattern.test(yname)){
					Swal.fire("약어는 영어만 입력 가능합니다.");
					return;
				}
				
				fetch('./categoryCheck.json?yname='+yname)
				.then(resp => resp.json())
				.then(data => {
					if(data === false){
						Swal.fire("이미 존재하는 약어입니다. 변경해주세요");
					} else{
						let frm = document.forms[0];
						let formData = new FormData(frm);
						let jsonData = {};
						formData.forEach((value, key) => {
							jsonData[key] = value;
						});
						fetch("./categorySave.json",{
							method:'post',
							headers:{
								'Content-Type':'application/json'
							},
							body:JSON.stringify(jsonData)
						})
						.then(resp => resp.json())
						.then(data => {
							if(data === true) {
								Swal.fire("가입 성공").then(()=>{
									location.href = '${pageContext.request.contextPath}/approval/category.do';
								})
								
							}
						})
						.catch(err => console.log(err));
					}
				})
				.catch(err => console.log(err));
			})
		}
	</script>
</body>
</html>
