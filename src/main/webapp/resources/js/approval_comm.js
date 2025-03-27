var approvalForm = [];

$(".modalBtn").on('click',()=>{
	$("#lineSaveBtn").hide();
	$("#linePickBtn").hide();
    $("#formPickBtn").hide();
    $("#refPickBtn").hide();
    $("#documentForm").hide();
	$("#organization").hide();
//	$(".ck-editor").show();
//	$("#fileDiv").hide();
	$("#referece").hide();
	
	$("#myModal").hide();
});

// -- 문서양식 트리 시작 ----------------------------

	
 $('#documentTree').on("select_node.jstree", function (e, data) {
        let selectedNode = data.node;
        let formId = selectedNode.id;
        let formName = selectedNode.text;

        if (!formId.startsWith("CATE")) { // 카테고리가 아닌 경우만 추가
       	 addToApprovalForm(formId, formName);
        }
   });
 $("#searchInputDocumentTree").keyup(function () {
        let searchText = $(this).val();
        $("#documentTree").jstree(true).search(searchText);
	}); // search end
 
// 양식 가져오기 
if(document.querySelector("#formBtn")) {
	document.querySelector("#formBtn").addEventListener('click', () => {
		$('#documentTree').jstree({
	        'plugins': ["search"],
	        "search": {
	            "show_only_matches": true // 검색 결과만 표시
	        },
	        'core': {
	            'data': function (node, cb) {
	                $.ajax({
	                    url: "./formTreeAjax.do", // 데이터를 JSON 형태로 가져오는 API
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
	//		window.open('./formTreeView.do',"popupWindow","width=400,height=600,top=150,left=300");	
		$("#documentForm").show();
		$("#formPickBtn").show();
		$("#myModal").show();
		
	});
}

function addToApprovalForm(formId, formName) {
	console.log("aaaa")
    // 중복 방지
    if (approvalForm.some(form => form.id === formId)) {
    	Swal.fire("이미 추가된 문서입니다.");
        return;
    }

    // 최대 3개까지만 추가 가능
    if (approvalForm.length >= 1) {
        Swal.fire("1개의 양식만 선택 가능합니다.");
        return;
    }
	
    // 리스트에 추가
    approvalForm.push({ id: formId, name: formName });
    updateApprovalForm();
}

function updateApprovalForm() {
    $("#approvalForm").empty();
    let html = "";

    approvalForm.forEach((form, i) => {
        html += "<div>";
        html += "<span id='" + form.id + "'>" + (i + 1) + ". " + form.name + " (" + form.id + ")</span>";
        html += "<span class='remove-btn' onclick='removeFromApprovalForm(\"" + form.id + "\")'>✖</span>";
        html += "</div>";
    });

    $("#approvalForm").html(html);
}

// 선택한 문서 삭제
function removeFromApprovalForm(formId) {
	approvalForm = approvalForm.filter(form => form.id !== formId);
    updateApprovalForm();
}

async function selectForm(){
    try {
        const response = await fetch("./selectFormAjax.do", {
            method:'post',
            headers:{
                'Content-Type':'text/plain'
            },
            body:approvalForm[0].id
        });
        if(!response.ok)  throw new Error('에러발생');
        return await response.json(); 
    } catch (error) {
     console.log(err);   
    }
}

async function selForm(){
    console.log(approvalForm[0].id);
    let data = await selectForm();
    
    document.querySelector("input[name=form_id]").value = data.FORM_ID;
		if(data.FORM_ID.startsWith("BC")){
//				document.querySelector("#dateRange").style.display = 'table-row';
 			$("#dateRange input[type=date]").val(setDate());
			$("#dateRange").show();
		}
		if(data.FORM_ID.startsWith("EC")){
			$("#ocrDiv").show();
		}
//			editor.setHTML(data.FORM_CONTENT);
		editor.setData(data.FORM_CONTENT);
		$("#myModal").hide();
		$("#documentForm").hide();
		$("#formPickBtn").hide();
}

$("#formPickBtn").on('click',()=>{
	selForm();
})

// 문서양식 tree 끝 ---------------------------------------------------
// 결재선 tree 시작 ---------------------------------------------------
var approvalLine = [];

$("#searchInputOrganizationTree").keyup(function () {
    let searchText = $(this).val();
    $("#organizationTree").jstree(true).search(searchText);
}); // search end

// 사원 선택 이벤트 (결재선 추가)
$('#organizationTree').on("select_node.jstree", function (e, data) {
    let selectedNode = data.node;
    let empNo = selectedNode.id;
    let empName = selectedNode.text;
	
    if (!empNo.startsWith("D") && !empNo.startsWith("HQ")) { // 부서가 아닌 사원만 추가
        addToApprovalLine(empNo, empName);
    	return;
    }
}); // organizationTree end

// 결재선 추가 함수
function addToApprovalLine(empNo, empName) {
    // 중복 방지
    if (approvalLine.some(emp => emp.id === empNo)) {
        alert("이미 추가된 사원입니다.");
        return;
    }
    // 3명 체크
    if(approvalLine.length == 3) {
    	alert("결재선은 3명까지 지정 가능합니다.");
    	return;
    }

    // 결재선 목록에 추가
    approvalLine.push({ id: empNo, name: empName});
    updateApprovalList();
}

// 결재선 리스트 업데이트
function updateApprovalList() {
    $("#approvalList").empty();
	console.log(approvalLine);
	let html = "";
	approvalLine.forEach( (emp , i) => { 
			console.log(emp.name,emp.id);
			html += "<div>";
			html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
			html += "<span class='remove-btn' onclick='removeFromApprovalLine(\""+emp.id+"\")'>✖</span>"
			html += "</div>";
			console.log(html);
	})
	$("#approvalList").html(html);
}

// 결재선에서 삭제
function removeFromApprovalLine(empNo) {
    approvalLine = approvalLine.filter(emp => emp.id !== empNo);
    updateApprovalList();
}

	async function saveApprovalLine() {
	    if (approvalLine.length === 0) {
	        Swal.fire("결재선을 선택하세요.");
	        return;
	    }
	
	    try {
	        // 사용자 입력 받기
	        const { value: lineName } = await Swal.fire({
	            title: "이름을 입력하세요",
	            input: "text",
	            inputPlaceholder: "이름을 입력하세요",
	            showCancelButton: true,
	            confirmButtonText: "확인",
	            cancelButtonText: "취소",
	            inputValidator: (value) => !value ? "반려 사유를 입력해야 합니다!" : null
	        });
	
	        if (!lineName) return; // 입력이 없을 경우 종료
	
	        // 결재선 데이터 생성
	        const approvalJson = {
	            line_name: lineName,
	            line_data: approvalLine.map(item => ({ approver_empno: item.id }))
	        };
	
	        console.log("결재선 저장:", approvalJson);
	
	        // 서버에 저장 요청
	        const response = await fetch("./insertSaveLineAjax.do", {
	            method: "POST",
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify(approvalJson)
	        });
	
	        const result = await response.text();
	        console.log(result);
	    } catch (error) {
	        console.error("결재선 저장 오류:", error);
	    }
	}

var selectSaveLines = [];
var organizationData = [];
if(document.getElementById("lineBtn")){
	
	document.getElementById("lineBtn").addEventListener('click', async () => {
		try {
			$('#organizationTree').jstree({
			    	'plugins' : ["search"],
			    	"search":{
			            "show_only_matches": true // 검색 결과만 표시
			    	},
			        'core': {
			            'data': function (node, cb) {
			                $.ajax({
			                    url: "./treeAjax.do",
			                    type: "GET",
			                    dataType: "json",
			                    success: function (data) {
			                    	console.log(data);
			                    	organizationData = data; 
			                        cb(data);
			                    }
			                });
			            }
			        }
			    });
				
			let data = await selectSaveLine();
			console.log("저장된 결재선 데이타 값 ",data);
			selectSaveLines = data;
			console.log("selectSaveLines", selectSaveLines);
			let lineHtml = '저장된 결재선 <ul>';
			data.map((line,index) => {
				console.log(line);
				lineHtml += '<li class="line-item" data-index="'+index+'">'+line.LINE_NAME+"</li>"	
//				lineHtml += line.LINE_DATA+"<br>"	
			})		
			lineHtml += '</ul>';
			
			$("#saveLine").html(lineHtml);
			$(".line-item").on("click", function() {
				approvalLine = [];
			    let index = $(this).data("index"); // 클릭한 항목의 index 가져오기
			    let selectedLine = selectSaveLines[index]; // 해당 index의 데이터 가져오기
			    console.log(index);
			    console.log(typeof selectedLine.LINE_DATA);  
			   try {
			        let lineDataStr = selectedLine.LINE_DATA
			            .replace(/=/g, ":")  // `=`을 `:`로 변경
			            .replace(/(\w+):/g, '"$1":') // 키를 따옴표로 감싸기 (`approver_empno:` → `"approver_empno":`)
			            .replace(/'/g, '"'); // 작은따옴표를 큰따옴표로 변경
			
			        console.log("변환된 LINE_DATA 문자열:", lineDataStr); // 디버깅용
			
			        let lineData = JSON.parse(lineDataStr); // JSON 변환
			        console.log("변환된 LINE_DATA (JSON):", lineData);
			
			       lineData.forEach(d => {
			            let empInfo = organizationData.find(emp => emp.id == d.approver_empno);
			            if (empInfo) {
			                addToApprovalLine(empInfo.id, empInfo.text); // 사원명 포함
			            } else {
			                console.warn("해당 사원을 찾을 수 없음:", d.approver_empno);
			            }
			        });
			        updateApprovalList();
			
			    } catch (error) {
			        console.error("JSON 변환 오류:", error);
			    }
				
			});
			$("#linePickBtn").show();
			$("#lineSaveBtn").show();
			$("#organization").show();
			$("#myModal").show();
		} catch (e) {
			console.log("에러 발생");
		}
		
	
	});
}
	
	
	async function selectSaveLine(){
	    try {
	        let response = await fetch("./selectSaveLineAjax.do");
	        if(!response.ok) throw new Error("에러발생");
	        return await response.json();
	    } catch (error) {
	        console.log(error);
	    }
	}
	
	$("#linePickBtn").on('click',()=>{
		console.log("선택한 결재선", approvalLine);
		let html = "";
		html += "<div class='approval-item'>";
		html += "결<br>재";
		html += "</div>";
		approvalLine.forEach( (emp , i) => { 
				console.log(emp.name,emp.id);
				html += "<div class='approval-item'>";
// 				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
				html += "<div id='"+emp.id+"' class='text-center'>"+emp.name.substr(0,emp.name.lastIndexOf("("))+"</div>";
				html += "</div>";
				console.log(html);
		});
		document.getElementById("approvalLine").innerHTML = html;
		$("#linePickBtn").hide();
		$("#lineSaveBtn").hide();
		$("#organization").hide();
		$("#myModal").hide();
	})

	
//    async function approvalDocumentSave(url ,jsonData) {
//        try {
//            let response = await fetch(url,{
//                method:'POST',
//                headers:{
//                    'Content-Type':'application/json'
//                },
//                body:JSON.stringify(jsonData)
//            });
//            if(!response.ok) throw new Error ("저장실패");
//
//            return await response.json();
//        } catch (error) {
//            
//        }
//    }
	/** fetch post요청 (요청주소,json데이터) */
     async function fetchJsonPost(url, jsonData){
		try {
            let response = await fetch( url, {
			method:'POST',
			headers:{
				"Content-Type": "application/json"
			},
			body:JSON.stringify(jsonData)
			})
			
            if(!response.ok) throw new Error ("저장실패");

            return await response.json();
        } catch (error) {
            
        }
	}
     async function approvalDocumentSave(url ,formData) {
        try {
            let response = await fetch( url, {
			method:'POST',
			body:formData
			})
			
            if(!response.ok){
				let errorMessage = await response.text();
				throw new Error (errorMessage);
			}

            return await response.json();
        } catch (error) {
            
        }
    }
    
	async function getDetail(id){
		let response = await fetch("./approvalDetailAjax.do?id="+id);
		let data = await response.json(); 
	    console.log("서버 응답 데이터:", data); 
	    return data;
	}

	async function getFile(id){
		let response = await fetch("./fileListAjax.do?id="+id);
		let data = await response.json(); 
        console.log("서버 응답 데이터:", data); 
        return data;
	}
	
	
	async function download(event) {
	    let file_id = event.value;
	    let approval_id = $("#approval_id").text();
	    console.log("다운로드 요청:", file_id, approval_id);
	
	    let jsonData = {
	        file_id: file_id,
	        approval_id: approval_id
	    };
	
	    try {
	        let response = await fetch("./downloadAjax.do", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify(jsonData)
	        });
	
	        if (!response.ok) {
	            throw new Error("파일 다운로드 실패: " + response.statusText);
	        }
	
	        let blob = await response.blob();
	        console.log("받은 파일 Blob:", blob);
	
	        let filename = "downloaded_file"; // 기본값 설정
	        let contentDisposition = response.headers.get("Content-Disposition");
	        console.log("응답 헤더 Content-Disposition:", contentDisposition);
	
	        if (contentDisposition) {
	            let matches = contentDisposition.match(/filename\*?=(UTF-8'')?"?([^"]+)"?/);
	            if (matches) {
	                filename = matches[2] ? decodeURIComponent(matches[2]) : decodeURIComponent(matches[1]); // 파일명 URL 디코딩 적용
	            }
	        }
	
	        let link = document.createElement("a");
	        link.href = window.URL.createObjectURL(blob);
	        link.download = filename;
	        document.body.appendChild(link);
	        link.click();
	        document.body.removeChild(link);
	        URL.revokeObjectURL(link.href); // 메모리 해제
	
	        console.log("파일 다운로드 완료:", filename);
	    } catch (error) {
	        console.error("다운로드 중 오류 발생:", error);
	        alert("파일 다운로드에 실패했습니다.");
	    }
	}

// -- 참조자
    var referenceLine = []; // 참조자 목록

// 참조자 선택 이벤트 (조직도에서 선택)
$('#refereceTree').on("select_node.jstree", function (e, data) {
    let selectedNode = data.node;
    let empNo = selectedNode.id;
    let empName = selectedNode.text;

    if (!empNo.startsWith("D") && !empNo.startsWith("HQ")) { // 부서가 아닌 사원만 추가
        addToReferenceLine(empNo, empName);
    }
});

// 참조자 추가 함수
function addToReferenceLine(empNo, empName) {
    // 중복 방지
    if (referenceLine.some(emp => emp.id === empNo)) {
        alert("이미 추가된 참조자입니다.");
        return;
    }

    // 최대 5명 제한 (필요 시 변경 가능)
    if (referenceLine.length >= 5) {
        alert("참조자는 최대 5명까지 지정 가능합니다.");
        return;
    }

    // 참조자 목록에 추가
    referenceLine.push({ id: empNo, name: empName });
    updateReferenceList();
}

// 참조자 리스트 업데이트 (UI 업데이트)
function updateReferenceList() {
    $("#referenceList").empty(); // 기존 리스트 초기화
    let html = "";

    referenceLine.forEach((emp, i) => {
        html += "<div>";
        html += "<span id='" + emp.id + "'>" + (i + 1) + ". " + emp.name + " (" + emp.id + ")</span>";
        html += "<span class='remove-btn' onclick='removeFromReferenceLine(\"" + emp.id + "\")'>✖</span>";
        html += "</div>";
    });

    $("#referenceList").html(html);
}

// 참조자 리스트에서 삭제
function removeFromReferenceLine(empNo) {
    referenceLine = referenceLine.filter(emp => emp.id !== empNo);
    updateReferenceList();
}

$("#refBtn").on("click", function (event) {
    event.preventDefault(); // 기본 이벤트 방지
 
    $('#refereceTree').jstree({
        'plugins': ["search"],
        "search": { "show_only_matches": true }, // 검색 결과만 표시
        'core': {
            'data': function (node, cb) {
                $.ajax({
                    url: "./treeAjax.do",
                    type: "GET",
                    dataType: "json",
                    success: function (data) {
                        console.log("조직도 데이터:", data);
                        cb(data);
                    }
                });
            }
        }
    });

    // 모달 표시
    $("#refPickBtn").show();
    $("#referece").show();
    $("#myModal").show();
});

// ✅ 참조자 선택 완료 버튼 (refPickBtn) 클릭 시 모달 닫기
$("#refPickBtn").on("click", function () {
    console.log("선택된 참조자 목록:", referenceLine);
    $("#referece").hide();
    $("#refPickBtn").hide();
    $("#myModal").hide(); // 모달 닫기
});

function setDate(){
	// date 값 오늘날짜 설정
	const today = new Date();
	
	// 년, 월, 일 가져오기
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, "0"); // 월(0~11) → +1 (01~12)
	const day = String(today.getDate()).padStart(2, "0"); // 일 (01~31)
	// 최종 출력
	const todayString = `${year}-${month}-${day}`;
	console.log(todayString);
	return todayString;
}
