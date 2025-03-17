<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>
<%@ include file="layout/header.jsp"%>
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
<%@ include file="layout/newNav.jsp" %>
<%@ include file="layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-12">
			<h2 class="content_title">부서관리</h2>
		
      <div class="row">
        <div class="col-4">
          <div class="card">
            <div>
            	<div>
            		<h5 class="card-title">조직도</h5>
          			<button id="addDept" class="btn btn-sm btn-primary">부서 추가</button>
          			<button id="settingtDept" class="btn btn-sm btn-secondary">부서 관리</button>
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
                            url: "./tree.json",
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

			fetch("./deptGet.json?seq="+ deptno)
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
        
        $('#modifyDept').click(function(){
        	console.log("수정하기", tableData);
        	
//         	var getDept= document.querySelector(".table ")
//      		console.log(getDept);
//      		getDept.innerHTML=""
        	
//      			for(let i=0; i<tableData.length; i++){
//     				var tr= document.createElement("tr");
    				
//     				for(let j=0; j<tableData[i].length; j++){
//     					var item = tableData[i][j];
    					
//     					var th = document.createElement("th");
    					
//     					th.textContent = item.header;
//     					tr.append(th);
    					
//     					var td = document.createElement("td");
//     					var input=document.createElement("input");
    					
//     					if(td = ename){
//     						input.value=item.value
//     						td.append(input);
    						
//     					}else if(td = parent_deptname){
//     						input.value=item.value
//     						td.append(input);
//     					}
    					
//     					/////
//                         if (item.colspan) {
//                             td.setAttribute("colspan", item.colspan);
//                         }
//                         tr.append(td);
//                     }
//                     	getDept.append(tr);
//                 }
        	
        })

     			var input = document.createElement("input");
        		var GetDeptname = document.getElementById("getDeptname")
        		
        		GetDeptname.inner
        		
     			var selctBox = document.createElement("select");
        		var hqDeptname = document.getElementById("getParent_deptname")
        		
        		

    });

    
   // 부서 등록
    function savedept() {
    	const deptType = document.getElementById('deptType').value;
        const deptname = document.getElementById('deptname').value;
        const parent_deptno = document.querySelector('select[name="parentDeptNo"]').value;
    	
        console.log(deptType)
        console.log(deptname)
        console.log(parent_deptno)
        
        // 입력값 검증
//         if (!deptname || !parent_deptno) {
//             alert("모든 필드를 입력해주세요.");
//             return;
//         }
        
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
