<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page session="false" %>
<html>
<head>
    <title>세션 만료</title>
    <meta http-equiv="refresh" content="5;url=./loginForm.do">
    <%@ include file="../layout/header.jsp"%>
</head>
<body>
<main>
    <div class="container">
        <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
            <h2>세션이 만료되었습니다.</h2>
            <div class="credits">
                <p>5초 후 로그인 페이지로 이동합니다.</p>
            </div>
            즉시 이동하려면 <a class="btn" href="./loginForm.do">여기를 클릭하세요</a>.
        </section>
    </div>
</main>


</body>
</html>