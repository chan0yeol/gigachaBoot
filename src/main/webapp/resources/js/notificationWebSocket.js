var ws,url,nick, pageClosed;

window.onload = function () {
    url = location.href;
    var wsUrl = "ws://localhost:9797/ws/notification";
    console.log(wsUrl);

    ws = new WebSocket(wsUrl);
    console.log("생성 소켓 객체 ", ws);

    ws.onopen = function () {
        console.log("소켓 오픈");
        // ws.send("hello");
    }

    ws.onmessage = event => {
        var msg = event.data;
         console.log(event.data, msg);
        var toastElList = [].slice.call(document.querySelectorAll('.toast'))
        var toastList = toastElList.map(function(toastEl) {
            return new bootstrap.Toast(toastEl)
        })
        document.getElementById("toast-text").innerHTML = msg;
        toastList.forEach(toast => toast.show());

    }

    ws.onclose = () =>{
        alert("연결 종료");
    }


}