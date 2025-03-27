<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<%@ include file="./layout/header.jsp" %>
</head>
<body>
<h2>카테고리</h2>
    
    <input type="text" id="searchInput" placeholder="검색">
    <br>

    <select id="category_id" class="form-select" size="3">
        <c:forEach items="${categoryList}" var="cate" varStatus="status">
            <option value="${cate.category_id}" ${status.index eq 0 ? 'selected' : ''}>
                ${cate.category_name}
            </option>
        </c:forEach>
    </select>
    
    <button id="ok">선택</button>
    <button onclick="window.close()">취소</button>

    <script type="text/javascript">
    window.onload = function() {
        // JSP 데이터를 JSON 배열로 변환하여 JavaScript에서 사용 가능하도록 변경
        let categoryList = [
            <c:forEach items="${categoryList}" var="cate" varStatus="loop">
                { id: "${cate.category_id}", name: "${cate.category_name}" }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        
        let categoryNames = categoryList.map(c => c.name); // 카테고리 이름 배열 생성

        console.log("카테고리 목록:", categoryList); // 디버깅용 콘솔 출력

        // jQuery UI Autocomplete 적용
//         $("#searchInput").autocomplete({
//             source: categoryNames,
//             focus: function(event, ui) {
//                 return false; // 기본 동작 방지
//             },
//             select: function(event, ui) {
//                 let selectedCategory = categoryList.find(c => c.name === ui.item.value);
//                 if (selectedCategory) {
//                     $("#category_id").val(selectedCategory.id);
//                 }
//             },
//             minLength: 1,
//             delay: 100,
//             autoFocus: true
//         });

        // select 박스 변경 이벤트
        document.getElementById("category_id").addEventListener("change", function() {
            let selectedValue = this.value;
            console.log("선택된 카테고리 ID:", selectedValue);
        });

        // 확인 버튼 클릭 시 부모 창에 데이터 전달 후 닫기
        document.querySelector("#ok").addEventListener("click", () => {
            let categoryElement = document.querySelector("#category_id");
            let category_id = categoryElement[categoryElement.selectedIndex].value;
            let category_name = categoryElement[categoryElement.selectedIndex].textContent;
            
            // 부모 창의 categoryPick() 함수 호출하여 값 전달
            window.opener.categoryPick(category_id, category_name);
            window.close();    
        });
    }
    </script>


<!-- 	<h2>카테고리</h2> -->
<!-- 	<input type="text" id="searchInput" placeholder="검색"> -->
<!-- 	<br> -->

<!-- 	<select id="category_id" class="form-select" size="3"> -->
<%-- 		<c:forEach items="${categoryList}" var="cate" varStatus="status"> --%>
<%-- 			<option value="${cate.category_id}" --%>
<%-- 				${status.index eq 0 ? 'selected':''}>${cate.category_name}</option> --%>
<%-- 		</c:forEach> --%>
<!-- 	</select> -->
<!-- 	<button id="ok">선택</button> -->
<!-- 	<button onclick="window.close()">취소</button> -->


	<script type="text/javascript">
// 	window.onload = function() {
// 		var cate = JSON.stringify("${categoryList}")
// 		var categoryNames = [...cate.matchAll(/category_name=([^,]+)/g)].map(match => match[1]);

// 		console.log(categoryNames); 
// 		$("#searchInput").autocomplete({
// 		      source: categoryNames,
// 		      focus: function (event, ui) {
// 		          return false;
// 	        	},
// 		      select: function(event, ui) {
// 		    	  let selectedCategory = categoryList.find(c => c.name === ui.item.value);
// 		    	  if (selectedCategory) {
//                       $("#category_id").val(selectedCategory.id);
//                   }
// 		      },
// 		      minLength: 1,
// 		      delay: 100,
// 		      autoFocus: true,
// 	    });
		
// 		document.getElementById("category_id").addEventListener("change", function() {
// 		    selectValue = this.value;
// 		    console.log("선택된 카테고리 ID: " + selectedValue);
// 		});
// 		document.querySelector("#ok").addEventListener("click", ()=>{
// 			let category_id = document.querySelector("#category_id")[document.querySelector("#category_id").selectedIndex].value;
// 			let category_name = document.querySelector("#category_id")[document.querySelector("#category_id").selectedIndex].textContent;
// 	    	window.opener.categoryPick(category_id, category_name);
// 	    	window.close();	
// 		})
// 	}
</script>
</body>
</html>