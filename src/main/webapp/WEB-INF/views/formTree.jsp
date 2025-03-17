<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식 선택 (jsTree)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<style>
    .approval-item {
        display: inline-block;
        width: 200px;
        padding: 5px;
        border-bottom: 1px solid #ddd;
    }
    .remove-btn {
        color: red;
        cursor: pointer;
        margin-left: 10px;
    }
</style>
</head>
<body>
    <h2>문서양식 선택</h2>
    <input type="text" id="searchInput" placeholder="검색">
    <br>
    <div id="documentTree"></div>
    <hr>
    <h3>선택한 양식</h3>
    <div id="approvalList"></div>
    <button onclick="ok()">양식 선택 완료</button>
    <button onclick="window.close()">취소</button>

    <script>
        var approvalLine = [];

        $(document).ready(function () {
            $('#documentTree').jstree({
                'plugins': ["search"],
                "search": {
                    "show_only_matches": true // 검색 결과만 표시
                },
                'core': {
                    'data': function (node, cb) {
                        $.ajax({
                            url: "./formTree.json", // 데이터를 JSON 형태로 가져오는 API
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
                $("#documentTree").jstree(true).search(searchText);
            });

            // 문서 선택 이벤트
            $('#documentTree').on("select_node.jstree", function (e, data) {
                let selectedNode = data.node;
                let formId = selectedNode.id;
                let formName = selectedNode.text;

                if (!formId.startsWith("CATE")) { // 카테고리가 아닌 경우만 추가
                    addToApprovalLine(formId, formName);
                }
            });
        });

        // 선택한 문서 추가
        function addToApprovalLine(formId, formName) {
            // 중복 방지
            if (approvalLine.some(form => form.id === formId)) {
                alert("이미 추가된 문서입니다.");
                return;
            }

            // 최대 3개까지만 추가 가능
            if (approvalLine.length >= 1) {
                alert("1개의 양식만 선택 가능합니다.");
                return;
            }

            // 리스트에 추가
            approvalLine.push({ id: formId, name: formName });
            updateApprovalList();
        }

        // 선택한 문서 리스트 업데이트
        function updateApprovalList() {
            $("#approvalList").empty();
            let html = "";

            approvalLine.forEach((form, i) => {
                html += "<div class='approval-item'>";
                html += "<span id='" + form.id + "'>" + (i + 1) + ". " + form.name + " (" + form.id + ")</span>";
                html += "<span class='remove-btn' onclick='removeFromApprovalLine(\"" + form.id + "\")'>✖</span>";
                html += "</div>";
            });

            $("#approvalList").html(html);
        }

        // 선택한 문서 삭제
        function removeFromApprovalLine(formId) {
            approvalLine = approvalLine.filter(form => form.id !== formId);
            updateApprovalList();
        }

        // 선택 완료
        function ok() {
            if (approvalLine.length === 0) {
                alert("양식을 선택하세요.");
                return;
            }

            console.log(approvalLine);
            window.opener.form(approvalLine); // 부모 창으로 데이터 전달
            window.close();
        }
    </script>
</body>
</html>
