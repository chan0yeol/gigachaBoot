var ws,url,nick, pageClosed;

window.onload = function () {
    url = location.href;
    url = window.location.pathname; // 현재 페이지의 경로
    var contextPath = "/" + url.split("/")[1]; // 첫 번째 경로 추출
    var wsUrl = "ws://" + location.host +"/ws/notification";
    console.log(wsUrl);

    ws = new WebSocket(wsUrl);
    console.log("생성 소켓 객체 ", ws);

    ws.onopen = function () {
        console.log("소켓 오픈");
        // ws.send("hello");
    }

    // TODO 00206 Socket - 서버에서 웹소켓 Handler가 메세지 전송하면 받아서 이벤트 창 js
    ws.onmessage = event => {
        var msg = event.data;


        var toastContainer = document.getElementById("toast-container");

        // 새로운 Toast 요소 생성
        var toastId = "toast-" + new Date().getTime(); // 고유 ID 부여
        var toastHTML = `
	        <div id="${toastId}" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
	            <div class="toast-header">
	                <strong class="me-auto">알림내역</strong>
	                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
	            </div>
	            <div class="toast-body">${msg}</div>
	        </div>`;

        // Toast 컨테이너에 추가
        toastContainer.innerHTML += toastHTML;

        // Bootstrap Toast 초기화 및 표시
        var newToastEl = document.getElementById(toastId);
        var newToast = new bootstrap.Toast(newToastEl, { autohide: false });
        newToast.show();
    }

    ws.onclose = () =>{
        // alert("연결 종료");
        console.log("연결종료");
    }


}