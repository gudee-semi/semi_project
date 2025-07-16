<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<title>QnA 관리자 상세</title>
	<style>
table {
	border-collapse: collapse;
	width: 700px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px 12px;
}

th {
	background: #f4f4f4;
}
</style>



</head>
<body>

	<h2>QnA 상세</h2>
    <table>
        <tr>
            <th>No</th>
            <td>${qna.qnaId}</td>
            <th>작성일</th>
            <td>${qna.regDate}</td>
        </tr>
        <tr>
            <th>카테고리</th>
            <td>${qna.category}</td>
            <th>작성자</th>
            <td>${qna.memberName}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${qna.title}</td>
            <th>공개여부</th>
<%--             <td>
                <c:choose>
                    <c:when test="${qna.isOpen eq 1}">공개</c:when>
                    <c:otherwise>비공개</c:otherwise>
                </c:choose>
            </td> --%>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="3">${qna.content}</td>
        </tr>
<%--         <tr>
            <th>첨부파일</th>
            <td colspan="3">
                <c:if test="${not empty qna.fileName}">
                    <img src="/upload/${qna.fileName}"
						style="max-width:60px; vertical-align:middle;">
                    <a href="/upload/${qna.fileName}" download>${qna.fileName}</a>
                </c:if>
            </td>
        </tr> --%>
    </table></body>


</html>