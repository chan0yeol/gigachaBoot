<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그리드</title>
<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/>

<style type="text/css">
#content {
    margin-right: 30px;
    margin-left: 230px;
}
</style>
</head>

<body>
<%--     <%@ include file="./layout/nav.jsp" %> --%>
<%--     <%@ include file="./layout/sidebar.jsp" %> --%>
    <div id="content" class="content">
        <div class="hero-calout">
            <div id="wrapper" class="list">
                <table id="example" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NAME</th>
                            <th>USERNAME</th>
                            <th>EMAIL</th>
                            <th>CITY</th>
                            <th>PHONE</th> 
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

<script>
$(document).ready(function() {
    $('#example').DataTable({
    	// 샘플 데이터
        ajax: {
            url: 'https://jsonplaceholder.typicode.com/users',
            dataSrc: '' // 배열 형태 -> 객체형식으로 바꿔야함!
        },
        columns: [
            { data: 'id' },
            { data: 'name' },
            { data: 'username' },
            { data: 'email' },
            { data: 'address.city' },
            { data: 'phone' },
            { data: 'website' },
            { data: 'company.name' }
        ],
        // 행 선택
        lengthMenu: [1, 2, 3],
        search: {
            return: true
        }
    });
});
</script>

</body>
</html>