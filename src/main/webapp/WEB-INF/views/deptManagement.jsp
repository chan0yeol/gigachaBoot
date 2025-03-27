<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>
<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

<style type="text/css">
* {
    box-sizing: border-box;
}
.card-body{
	flex: 1 1 auto;
    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
    color: var(--bs-card-color);
}

.card-body pt-3{
	padding-top: 1rem ;
}

td {
    padding: 10px;
    border: 1px solid black;
}

/* ------------------------------------   */

.modal {
	display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 50%;
    max-width: 500px;
    height: 60%;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    padding: 20px;
    z-index: 1050;
}

table{

}

th{
	width: 30%;
	background-color: #f8f9fa; /* 연한 회색 */
    color: #333; /* 글자색 (진한 회색) */
    border: 1px solid #ddd; /* 테두리 */
    text-align: center; /* 텍스트 가운데 정렬 */
}

td {
	padding: 10px;
	border: 1px solid black;
  }

#departmentInfo {
    display: none; /* 초기에는 숨김 */
  }
  
 
</style>


</head>

<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h2 class="content_title">부서관리</h2>
		
      <div class="row">
        <div class="col-4">
          <div class="card">
            <div>
            	<div>
            		<h5 class="card-title">조직도</h5>
          			<button id="addDept" class="btn btn-sm btn-primary">부서 추가</button>
            	</div>
            	<!-- 모달 -->
            	<div id="deptAddModal" class="modal">
            		<div class="modal-content">
	            			<span class="close" onclick="closeModal()">&times;</span>
				            <h4>부서 추가</h4>
				            <div class="mb-3">
				            <label for="deptType" class="form-label">부서 유형</label>
				            	<select id="deptType" class="form-select">
					                <option value="HQ">본부</option>
					                <option value="D">부서</option>
				              	</select>
							   	<label for="deptname">부서 이름:</label>
							    <input type="text" id="deptname" name="deptname" required class="form-control"> 
							   	<button class="btn btn-secondary btn-sm mt-1" type="button" onclick="duplicate()">중복검사</button><br>
							   	<select name="parentDeptNo">
	    							<option value="">본부 선택</option>
	    							<c:forEach var="dto" items = "${hqList}">
       									  <option value="${dto.deptno}"><c:out value="${dto.deptname}"/></option>
							    	</c:forEach>
								</select>
				            </div>
				            <div class="modal-footer">
				                <button type="button" id="submit" class="btn btn-primary" onclick="savedept()">등록</button>
				                <button type="button" class="btn btn-outline-danger close" onclick="closeModal()">닫기</button>
				            </div>
            		</div>
            	</div>
            	<!-- 모달 END -->
            	
				<input type="text" id="searchInput" placeholder="검색">
				<br>
				<div id="organizationTree"></div>
				<hr>
            </div>
          </div>
        </div>
        <div class="col-8">
          <div class="card">
            <div class="card-body pt-3">
              <div class="tab-content pt-2">
                  <h5 class="card-title">부서 정보</h5>
                  <button id="modifyDept" class="btn btn-primary btn-sm">부서 수정</button>
                  <button id="deleteDept" class="btn btn-secondary btn-sm">부서 삭제</button>
                  <div class = "departmentInfo">
                  	<table class="table table-bordered text-center">
                  		<tr>
                  			<th>부서명</th>
                  			<td id="getDeptname"></td>
                  			<th>부서코드</th>
                  			<td id="getDeptno"></td>
                  		</tr>
                  		<tr>
                  			<th>본부</th>
                  			<td id="getParent_deptname"></td>
                  			<th>본부코드</th>
                  			<td id="getParent_deptno"></td>
                  		</tr>
                  		<tr> 
                  			<th>생성일</th>
                  			<td id="getCreate_date"></td>
                  			<th>최근 수정일</th>
                  			<td id="getUpdate_date"></td>
                  		</tr>
                  		<tr>
                  			<th>최근 수정자</th>
                  			<td colspan="3" id="getUpdate_emp"></td>
                 		</tr>
                  	</table>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
     </div>
	</div>
</main>
	
</body>
<script>
     	var approvalLine = [];
        $(document).ready(function () {
            $('#organizationTree').jstree({
            	'plugins' : ["search"],
            	"search":{
                    "show_only_matches": true // 검색 결과만 표시
            	},
                'core': {
                    'data': function (node, cb) {
                        $.ajax({
                            url: "./tree.do",
                            type: "GET",
                            dataType: "json",
                            success: function (data) {
                            	console.log(data);
                                cb(data);
                            }
                        });
                    }
                }
            });
            $("#searchInput").keyup(function () {
                let searchText = $(this).val();
                $("#organizationTree").jstree(true).search(searchText);
            }); // search end

            // 사원 선택 이벤트 (결재선 추가)
            $('#organizationTree').on("select_node.jstree", function (e, data) {
                let selectedNode = data.node;
                let empNo = selectedNode.id;
                let empName = selectedNode.text;
				
                    addToApprovalLine(empNo, empName);
            }); // organizationTree end
        });
        
        var tableData;
        
     	// 부서 상세 조회
        function addToApprovalLine(deptno, deptname) {

			fetch("./deptGet.do?seq="+ deptno)
             .then(response => response.json())
             .then(data => {
             	console.log(data.deptname);
             	
			document.getElementById("getDeptname").textContent=data.deptname;
			document.getElementById("getDeptno").textContent=data.deptno;
			document.getElementById("getParent_deptname").textContent=data.parent_deptname;
			document.getElementById("getParent_deptno").textContent=data.parent_deptno;
			document.getElementById("getCreate_date").textContent=data.create_date;
			document.getElementById("getUpdate_date").textContent=data.update_date;
			document.getElementById("getUpdate_emp").textContent=data.update_emp;
     		
             })
             .catch(error => {
                 console.error('데이터 가져오기 실패', error);
                 alert('부서 정보를 가져오는데 실패했습니다..');
             });
     		
        }

    // 모달 열기
    document.getElementById("addDept").onclick = function() {
        document.getElementById("deptAddModal").style.display = "block";
        document.getElementById('submit').disabled = "disabled";
        console.log("모달");
    }
    
    function closeModal() {
    	document.getElementById("deptAddModal").style.display = "none";
    }

    // 부서명 중복 검사
    function duplicate() {
        const deptname = document.getElementById('deptname').value;
        if (!deptname) {
            alert("부서명을 입력해주세요.");
            return;
        }
        
        fetch("./deptCheck.do?deptname="+ deptname)
        .then(response => response.text())
        .then(data => {
        	console.log(data);
            if (data === "false") {
                alert('이미 존재하는 부서명입니다.');
                document.getElementById('deptname');
                document.getElementById('submit').disabled = "disabled";
                
            } else {
                alert('사용 가능한 부서명입니다.');
                document.getElementById('submit').disabled = "";
            }
        })
        .catch(error => {
            console.error('중복 검사 중 오류 발생:', error);
            alert('중복 검사 중 오류가 발생했습니다.');
        });
    }
    
   // Select박스 활성, 비활성화
    $(document).ready(function() {
        $('#deptType').change(function() {
            let parentDeptSelect = $('select[name="parentDeptNo"]');
            
            if ($(this).val() === "HQ") {
                parentDeptSelect.prop('disabled', true).val(""); // 비활성화 및 값 초기화
            } else {
                parentDeptSelect.prop('disabled', false);
            }
        });

        // 페이지 로드 시 초기 상태 설정
        $('#deptType').trigger('change');
    });
   
 // 수정하기
    document.getElementById('modifyDept').addEventListener('click', function(){
        console.log("수정하기", tableData);
        
        // 부서명 입력 필드로 변경
        var input = document.createElement("input");
        input.type = "text";
        input.id = "editDeptName";
        input.className = "form-control";
        input.value = document.getElementById("getDeptname").textContent;
        
        var deptname = document.getElementById("getDeptname");
        deptname.textContent = "";
        deptname.appendChild(input);
        
        // 기존 본부명이 표시된 td 요소
        var tdElement = document.getElementById("getParent_deptname");
        // 기존 본부코드 값
        var currentDeptNo = document.getElementById("getParent_deptno").textContent;
        // 현재 부서 번호 저장
        var deptNo = document.getElementById("getDeptno").textContent;
        
        fetch("./api/hqList.do", {
            method: "GET",
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            // select 요소 생성
            const selectElement = document.createElement('select');
            selectElement.id = 'hqSelect';
            selectElement.className = 'form-control';
            
            // 본부 목록으로 option 추가
            data.forEach(dept => {
                const option = document.createElement('option');
                option.value = dept.deptno;
                option.textContent = dept.deptname;
                
                // 현재 선택된 본부와 일치하는 경우 selected 속성 추가
                if (dept.deptno == currentDeptNo) {
                    option.selected = true;
                }
                
                selectElement.appendChild(option);
            });
            
            // td 내용을 select 요소로 교체
            while (tdElement.firstChild) {
                tdElement.removeChild(tdElement.firstChild);
            }
            tdElement.appendChild(selectElement);
            
            // select 값이 변경되면 deptno 값도 업데이트
            document.getElementById('hqSelect').addEventListener('change', function() {
                document.getElementById('getParent_deptno').textContent = this.value;
            });
        })
        .catch(error => console.error("데이터 가져오기 오류:", error));
        
        // 저장 버튼 생성
        var saveButton = document.createElement("button");
        saveButton.id = "saveButton";
        saveButton.className = "btn btn-success btn-sm";
        saveButton.textContent = "저장";
        saveButton.style.marginRight = "5px";
        
        // 취소 버튼 생성
        var cancelButton = document.createElement("button");
        cancelButton.id = "cancelButton";
        cancelButton.className = "btn btn-secondary btn-sm";
        cancelButton.textContent = "취소";
        
        // 버튼을 담을 컨테이너 생성
        var buttonContainer = document.createElement("div");
        buttonContainer.id = "editButtons";
        buttonContainer.style.marginTop = "10px";
        buttonContainer.appendChild(saveButton);
        buttonContainer.appendChild(cancelButton);
        
        // 버튼 컨테이너를 페이지에 추가 (수정 버튼이 있는 요소의 부모에 직접 추가)
        var modifyButton = document.getElementById('modifyDept');
        var parentElement = modifyButton.parentNode;
        
        // 이미 존재하는 버튼 컨테이너가 있다면 제거
        var existingButtonContainer = document.getElementById("editButtons");
        if (existingButtonContainer) {
            existingButtonContainer.parentNode.removeChild(existingButtonContainer);
        }
        
        // 부모 요소에 버튼 컨테이너 추가
        parentElement.appendChild(buttonContainer);
        
        // 콘솔에 확인 메시지 출력
        console.log("버튼 컨테이너 추가됨", buttonContainer);
        
        // 수정 버튼 숨기기
        document.getElementById('modifyDept').style.display = "none";
        
        // 저장 버튼 클릭 이벤트
        saveButton.addEventListener('click', function() {
            // 수정된 값 가져오기
            var newDeptName = document.getElementById('editDeptName').value;
            var newParentDeptNo = document.getElementById('hqSelect').value;
            
            // 입력값 검증
            if (!newDeptName.trim()) {
                alert("부서명을 입력해주세요.");
                return;
            }
            
            console.log("수정된 정보:", {
                deptno: deptNo,
                deptname: newDeptName,
                parent_deptno: newParentDeptNo
            });
            
            // 서버에 수정된 데이터 전송
            fetch("./deptUpdate.do", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    deptno: deptNo,
                    deptname: newDeptName,
                    parent_deptno: newParentDeptNo
                })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답이 올바르지 않습니다.');
                }
                return response.json();
            })
            .then(data => {
                console.log("저장 성공:", data);
                
                // 서버에서 반환된 데이터로 UI 업데이트
                if (data.deptname) document.getElementById("getDeptname").textContent = data.deptname;
                if (data.parent_deptname) document.getElementById("getParent_deptname").textContent = data.parent_deptname;
                if (data.update_date) document.getElementById("getUpdate_date").textContent = data.update_date;
                if (data.update_emp) document.getElementById("getUpdate_emp").textContent = data.update_emp;
                if (data.create_date && !document.getElementById("getCreate_date").textContent) {
                    document.getElementById("getCreate_date").textContent = data.create_date;
                }
                
                // 버튼 컨테이너 제거
                var buttonContainer = document.getElementById("editButtons");
                if (buttonContainer) {
                    buttonContainer.parentNode.removeChild(buttonContainer);
                }
                
                // 수정 버튼 다시 표시
                document.getElementById('modifyDept').style.display = "";
                
                // 상세 정보 다시 조회 (필요한 경우)
                if (typeof addToApprovalLine === 'function') {
                    addToApprovalLine(deptNo, data.deptname || newDeptName);
                }
                
                // 성공 메시지 표시
                alert("부서 정보가 성공적으로 수정되었습니다.");
            })
            .catch(error => {
                console.error("저장 실패:", error);
                alert("부서 정보 수정에 실패했습니다.");
            });
        });
        
        // 취소 버튼 클릭 이벤트
        cancelButton.addEventListener('click', function() {
            console.log("취소 버튼 클릭");
            restoreOriginalUI();
        });
        
        // 원래 UI로 되돌리는 함수
        function restoreOriginalUI() {
            // 부서명 원래대로 되돌리기
            var deptname = document.getElementById("getDeptname");
            var originalDeptName = document.getElementById("editDeptName").value;
            deptname.textContent = originalDeptName;
            
            // 본부명 원래대로 되돌리기
            var tdElement = document.getElementById("getParent_deptname");
            var selectedOption = document.getElementById("hqSelect").options[document.getElementById("hqSelect").selectedIndex];
            tdElement.textContent = selectedOption.textContent;
            
            // 버튼 컨테이너 제거
            var buttonContainer = document.getElementById("editButtons");
            if (buttonContainer) {
                buttonContainer.parentNode.removeChild(buttonContainer);
            }
            
            // 수정 버튼 다시 표시
            document.getElementById('modifyDept').style.display = "";
        }
    });
   
   // 부서 등록
    function savedept() {
    	const deptType = document.getElementById('deptType').value;
        const deptname = document.getElementById('deptname').value;
        const parent_deptno = document.querySelector('select[name="parentDeptNo"]').value;
    	
        console.log(deptType)
        console.log(deptname)
        console.log(parent_deptno)

        const data = {
            deptType: deptType,
            deptname: deptname,
            parent_deptno: parent_deptno
        };
        
        console.log("부서 등록 데이터:", data);
        
        // 서버로 데이터 전송
        fetch('./deptManagement.do', {
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
            throw new Error('부서 등록에 실패했습니다.');
        })
        .then(data => {
            alert("부서가 성공적으로 등록되었습니다.");
            closeModal();
             // 트리 새로고침
             $('#organizationTree').jstree(true).refresh();
         })
        .catch(error => {
            console.error("Error:", error);
            alert("부서 등록 중 오류가 발생했습니다.");
        });
    }
	
	
</script>

</html>
