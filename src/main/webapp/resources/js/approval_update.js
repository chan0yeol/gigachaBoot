editor.setData(document.querySelector('#editor').innerHTML);
if(document.querySelector("input[name=form_id]").value.startsWith("BC")){
    console.log("참");
    $("#dateRange").show();
}

editor.setData(document.querySelector('#editor').innerHTML);
if(document.querySelector("input[name=form_id]").value.startsWith("BC")){
    console.log("참");
    $("#dateRange").show();
}
$(".modalBtn").on('click',()=>{
    $("#linePickBtn").hide();
    $("#formPickBtn").hide();
    $("#documentForm").hide();
    $("#organization").hide();
    $("#myModal").hide();
})
// 문서 작성
document.querySelector("#saveBtn").addEventListener('click', async () => {
    let formData = new FormData(document.forms[0]);
    let jsonData = {};
    formData.forEach((value, key) => {
        jsonData[key] = value;
    });
    jsonData["approval_content"] = editor.getData();
    let d = approvalLine.map(item => ({approver_empno:item.id}));

    jsonData["approvalLineDtos"] = d;

    console.log(jsonData);

    let data = await fetchJsonPost('./approvalUpdateForm.json', jsonData);

    if(data == true) {
        Swal.fire("작성성공").then(()=>{
            location.href="./approvalDetail.do?id="+jsonData["approval_id"];
        });
    } else{
        Swal.fire("작성실패");
    }



    /*fetch('./approvalUpdateForm.json',{
        method:'POST',
        headers:{
            'Content-Type':'application/json'
        },
        body:JSON.stringify(jsonData)
    })
        .then(resp => resp.json())
        .then(data => {
            if(data == true) {
                Swal.fire("작성성공").then(()=>{
                    location.href="./approvalDetail.do?id=${approval.approval_id}"
                });
            } else{
                Swal.fire("작성실패");
            }
        })
        .catch(err => console.log(err));*/
});