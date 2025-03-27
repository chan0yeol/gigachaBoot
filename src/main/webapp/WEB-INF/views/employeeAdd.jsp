<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>

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
            <div class="col-md-4">
                <div class="profile">
                    <div class="col-md-8 col-lg-9">
                       <img id="profile-img" src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="기본이미지">
                        <div class="pt-2">
                            <input class="form-control" type="file" id="formFile">
                            <button class="btn btn-danger btn-sm">기본사진으로 되돌리기</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <form id="myForm">
                    <div>
                        <div class="row mb-3">
                            <label for="empno" class="col-md-4 col-lg-3 col-form-label">사번</label>
                            <div class="col-md-8 col-lg-9">
                                <input id="empno" type="text" name="empno" class="form-control" readonly="readonly">
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
                                </select>년
                                <select class="box" id="birth-month">
                                    <option disabled selected>월</option>
                                </select>월
                                <select class="box" id="birth-day">
                                    <option disabled selected>일</option>
                                </select>일
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="degree" class="col-md-4 col-lg-3 col-form-label">학력</label>
                            <div class="col-md-8 col-lg-9">
                                <select class="box" id="degree">
                                    <option disabled selected>최종학력</option>
                                    <option value="ED01">고등학교 졸업</option>
                                    <option value="ED02">전문학사</option>
                                    <option value="ED03">학사</option>
                                    <option value="ED04">석사</option>
                                    <option value="ED05">박사</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="gender" class="col-md-4 col-lg-3 col-form-label">성별</label>
                            <div class="col-md-8 col-lg-9">
                                <input type="radio" name="gender" value="m">남성
                                <input type="radio" name="gender" value="f">여성
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="adress" class="col-md-4 col-lg-3 col-form-label">주소</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="adress" type="text" class="form-control" id="adress">
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="col-md-4">
                <form id="myForm2">
                    <div>
                        <div class="row mb-3">
                            <label for="tel" class="col-md-4 col-lg-3 col-form-label">내선번호</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="tel" type="text" class="form-control phone-input" id="tel" maxlength="11">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="phone" class="col-md-4 col-lg-3 col-form-label">휴대전화번호</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="phone" type="text" class="form-control phone-input" id="phone" maxlength="13">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="email" type="text" class="form-control" id="email">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="school" class="col-md-4 col-lg-3 col-form-label">학교</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="school" type="text" class="form-control" id="school">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="hiredate" class="col-md-4 col-lg-3 col-form-label">입사일자</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="hiredate" type="date" class="form-control" id="hiredate">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="text-center">
            <button type="button" class="btn btn-primary" onclick="saveEmployee()">등록</button>
            <button type="button" class="btn btn-secondary" onclick="document.getElementById('myForm').reset(); document.getElementById('myForm2').reset();">초기화</button>
        </div>
    </div>
</div>
</main>
</body>
<script>
// 생년월일
document.addEventListener('DOMContentLoaded', function() {
    // 연도 드롭다운
    const yearSelect = document.getElementById('birth-year');
    const currentYear = new Date().getFullYear();
    
    // 연도
    for (let year = currentYear; year >= currentYear - 100; year--) {
        const option = document.createElement('option');
        option.value = year;
        option.textContent = year;
        yearSelect.appendChild(option);
    }
    // 월
    const monthSelect = document.getElementById('birth-month');
    for (let month = 1; month <= 12; month++) {
        const option = document.createElement('option');
        option.value = month;
        option.textContent = month;
        monthSelect.appendChild(option);
    }
    
    // 일
    const daySelect = document.getElementById('birth-day');
    for (let day = 1; day <= 31; day++) {
        const option = document.createElement('option');
        option.value = day;
        option.textContent = day;
        daySelect.appendChild(option);
    }
    
    // 선택한 월과 연도에 따라 일 수 조정
    yearSelect.addEventListener('change', updateDays);
    monthSelect.addEventListener('change', updateDays);
    
    function updateDays() {
        const year = parseInt(yearSelect.value);
        const month = parseInt(monthSelect.value);
        
        if (isNaN(year) || isNaN(month)) return;
        
        // 선택한 월의 일 수 계산
        const daysInMonth = new Date(year, month, 0).getDate();
        
        // 기존 일 옵션 삭제
        while (daySelect.options.length > 1) {
            daySelect.remove(1);
        }
        
        // 정확한 일 수 추가
        for (let day = 1; day <= daysInMonth; day++) {
            const option = document.createElement('option');
            option.value = day;
            option.textContent = day;
            daySelect.appendChild(option);
        }
    }
});

// 전화번호
document.querySelectorAll(".phone-input").forEach(function(input) {
    input.addEventListener("input", function() {
        this.value = this.value
            .replace(/[^0-9]/g, '')  // 숫자만 입력 가능하도록 처리
            .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
    });
});

//페이지 로드 시 초기화 함수
document.addEventListener('DOMContentLoaded', function() {
  // 입사일자 입력 필드 찾기
  const hireDateInput = document.getElementById('hiredate');
  
  // 초기 로드 시 입사일자가 이미 입력되어 있으면 사번 미리보기 조회
  if (hireDateInput && hireDateInput.value) {
    updateEmpno(hireDateInput.value);
  }
  
  // 입사일자 변경 이벤트 리스너 등록
  if (hireDateInput) {
    hireDateInput.addEventListener('change', function() {
      updateEmpno(this.value);
    });
  }
});

// 사번 미리보기 업데이트 함수
function updateEmpno(hiredate) {
  if (!hiredate) return;
  
  // 서버에 사번 미리보기 요청
 	fetch("./nextEmpno.do?hiredate=" + encodeURIComponent(hiredate))
    .then(response => {
      if (!response.ok) {
        throw new Error('사번 미리보기 조회에 실패했습니다.');
      }
      return response.text();
    })
    .then(empno => {
      // 사번 필드에 결과 표시
      const empnoInput = document.getElementById('empno');
      if (empnoInput) {
        empnoInput.value = empno;
      }
    })
    .catch(error => {
      console.error('사번 조회 오류:', error);
      alert('사번 미리보기를 불러오는 데 실패했습니다.');
    });
}

// 폼 제출 전 유효성 검사
document.getElementById('employeeForm').addEventListener('submit', function(event) {
  const empno = document.getElementById('empno');
  
  // 사번이 생성되지 않았으면 제출 방지
  if (!empno || !empno.value) {
    event.preventDefault();
    alert('입사일자를 먼저 선택하여 사번을 생성해주세요.');
    return false;
  }
  
  // 기타 필수 필드 검증 로직 추가 가능
});

//값 보내기
function saveEmployee() {
    
    const empno = document.getElementById('empno').value;
    const name = document.getElementById('name').value;
    
    // 생년월일 값
    const birthYear = document.getElementById('birth-year').options[document.getElementById("birth-year").selectedIndex].value;
    const birthMonth = document.getElementById('birth-month').options[document.getElementById('birth-month').selectedIndex].value;
    const birthDate = document.getElementById('birth-day').options[document.getElementById('birth-month').selectedIndex].value;
    
    const formattedMonth = String(birthMonth).padStart(2, '0');
    const formattedDay = String(birthDate).padStart(2, '0');
    
    const birthday = birthYear +"-"+formattedMonth+"-"+formattedDay;
    
    const degree = document.getElementById('degree').value;
    
    const genderElements = document.getElementsByName('gender');
    let gender;
    for (let i = 0; i < genderElements.length; i++) {
        if (genderElements[i].checked) {
            gender = genderElements[i].value;
            break;
        }
    }
    
    // 주소 가져오기
    const adress = document.getElementById('adress').value;
    
    // 기타 정보 가져오기
    const tel = document.getElementById('tel').value;
    const phone = document.getElementById('phone').value;
    const email = document.getElementById('email').value;
    const school = document.getElementById('school').value;
    const hiredate = document.getElementById('hiredate').value;
    
    
    
    // 유효성 검사
//     if (!name) {
//         alert('이름을 입력해주세요.');
//         return;
//     }
    
//     if (!hiredate) {
//         alert('입사일자를 입력해주세요.');
//         return;
//     }

    const data = {
    	empno : empno,
        name: name,
        email: email || '',
        deptno: '',
        job_id: '',
        password: '', 
        phone: phone || '',
        tel: tel || '',
        hiredate: hiredate,
        birthday: birthday,
        gender: gender || '',
        school: school || '',
        major_code: '',
        degree: degree || '',
        adress: adress || '',
        auth: '',
    };
    
    console.log('전송할 데이터:', data); 
    
    // 서버로 데이터 전송
    fetch('./employeeAdd.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        }
        throw new Error('사원 등록에 실패했습니다.');
    })
    .then(data => {
        alert("사원이 등록되었습니다.");
        // 폼 초기화 또는 리다이렉트
        // document.querySelector('form').reset();
        // window.location.href = "employeeList.do";
    })
    .catch(error => {
        alert(error.message);
        console.error('에러 발생:', error);
    });
}



</script>

</html>
