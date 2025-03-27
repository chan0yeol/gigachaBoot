<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일드래그앤드롭</title>
<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
	<style type="text/css">
	#content {
	    margin-right: 30px;
	    margin-left: 230px;
	}
	
	#droppable {
		max-width: 500px;  /* 최대 너비 설정 */
        max-height: 300px; /* 최대 높이 설정 */
        width: 100%;       /* 부모 요소에 맞게 자동 조정 */
        height: auto;      /* 비율을 유지하며 크기 조정 */
        background-color: lightgray; /* 배경색 */
        text-align: center; /* 텍스트 중앙 정렬 */
        padding: 20px;      /* 내부 여백 */
        box-sizing: border-box; /* 패딩 포함 크기 계산 */
}
	
	
	</style>
</head>
<body>
<%-- 	<%@ include file="./layout/nav.jsp" %> --%>
<%-- 	<%@ include file="./layout/sidebar.jsp" %> --%>

	<div id="content" class="content">
		<div id="draggable" class="ui-widget-content">
			<p>Drag me to my target</p>
		</div>
		<div id="droppable" class="ui-widget-header">
			<p>Drop here</p>
		</div>
	
	</div>
</body>
<script>

// 삭제
$("#draggable").remove();

  $( function() {
    $( "#draggable" ).draggable();
    $( "#droppable" ).droppable({
      drop: function( event, ui ) {
        $( this )
          .addClass( "ui-state-highlight" )
          .find( "p" )
            .html( "Dropped!" );
      }
    });
  } );
  </script>

</html>