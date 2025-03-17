

	// 문서 작성
	document.querySelector("#saveBtn").addEventListener('click', async () => {
		let formData = new FormData(document.forms[0]);
		let jsonData = {};
//		formData.forEach((value, key) => {
//			jsonData[key] = value;
//		});
//		jsonData["approval_content"] = editor.getData();

		// 빈값 체크 부분
		if(formData.get("form_id").trim().length == 0) {
			Swal.fire("문서양식을 선택해주세요").then(()=>{
				$("#formBtn").click()
			});
			
			return;
		}
		if(approvalLine.length == 0) {
			Swal.fire('결재선을 선택해주세요').then(()=>{
				$("#lineBtn").click()
			});
			return;
		}
		if(formData.get("approval_deadline").trim().length == 0){
			Swal.fire("마감기한을 설정해주세요");
			return;
		}
		if(formData.get("approval_title").trim().length == 0) {
			Swal.fire("제목을 입력해주세요");
			return;
		}
		
		let d = approvalLine.map((item)=> ({approver_empno:item.id})); 
	    for(let i = 0; i<d.length; i++){
			formData.append("approvalLineDtos["+i+"].approver_empno",d[i].approver_empno)
		}

//	    jsonData["approvalLineDtos"] = d; 
//	    console.log(jsonData);

		let refData = referenceLine.map((item)=> ({empno:item.id}));
		for(let i = 0; i<refData.length; i++){
			formData.append("approvalReferenceDtos["+i+"].empno",refData[i].empno);
		}
	    formData.append("approval_content", editor.getData());
	    console.log([...formData]);
	    
//	    let response = await fetch("./approvalDocumentSave.json", {
//			method:'POST',
//			body:formData
//		})
//		if(!response.ok) throw new Error ("저장실패");
		console.log(formData.get("approval_deadline"));
		
		let data = await approvalDocumentSave('./approvalDocumentSave.json',formData);
// 		let data = await approvalDocumentSave('./approvalDocumentSaveReg.json',formData);
		if(data == true){
            Swal.fire({
		        title: "작성 성공!",
		        text: "결재 문서가 성공적으로 작성되었습니다.",
		        icon: "success",
		        confirmButtonText: "확인"
		    }).then(()=>{
				location.href='./approvalList.do'
			});
        } else{
            Swal.fire({
		        title: "작성 실패!",
		        text: "문서를 저장하는 중 오류가 발생했습니다. 다시 시도해 주세요.",
		        icon: "error",
		        confirmButtonText: "확인"
		    });
        }
		
//        let data = await approvalDocumentSave('./approvalDocumentSave.json',jsonData);
        
//		
	});

	document.querySelector("#tempBtn").addEventListener('click', async () => {
		let formData = new FormData(document.forms[0]);
		let jsonData = {};
		formData.forEach((value, key) => {
			jsonData[key] = value;
		});

		if(jsonData["form_id"] == '') {
			Swal.fire("문서양식을 선택해주세요").then(()=>{
				$("#formBtn").click();
			});
			return;
		}

		jsonData["approval_content"] = editor.getData();
		
		if( approvalLine.length != 0){
			let d = approvalLine.map(item => ({approver_empno:item.id}));
		    jsonData["approvalLineDtos"] = d; 
		}		

	    console.log(jsonData);
		let isc = await Swal.fire({
				title: "임시저장",
				text:"임시저장시 파일은 저장되지 않습니다.",
		        showCancelButton: true,
		        confirmButtonText: "저장",
		        cancelButtonText: "취소",
			});
			console.log();
		if(!isc.isConfirmed){
			 return;
		}
		
        let data = await fetchJsonPost('./approvalDocumentSaveTemp.json',jsonData);
        if(data == true){
            Swal.fire("작성성공");
        } else{
            Swal.fire("작성실패");
        }
	})

	document.querySelector("#getContent").addEventListener('click',() => {
		$(".ck-editor").hide();
		$("#fileDiv").show();
		let contentDiv = document.querySelector("#editor")
		contentDiv.style.display = 'block';
		contentDiv.innerHTML = editor.getData();
		let content = document.querySelector("#contentHtml");
		document.querySelector(".modal-body").innerHTML = content.innerHTML;
	});
	