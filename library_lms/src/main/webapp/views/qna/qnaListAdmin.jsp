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

    <h2>QnA 관리자 리스트</h2>
    <table border="1">
        <tr>
            <th>No</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>관리</th>
        </tr>
        <c:forEach var="q" items="${qnaAdminList}">
            <tr>
                <td>${q.qna.qnaId}</td>
                <td>${q.qna.title}</td>
                <td>${q.qna.memberNo}</td>
                <td>${q.qna.regDate}</td>
                <td>
                    <!-- 1. 상세보기/수정 등 서버로 qnaId를 넘길 때 사용 -->
                    <form action="/qnaDetailAdmin" method="get">
                        <!-- 여기! 해당 QnA의 번호를 숨김값으로 서버에 전송 -->
                        <input type="hidden" name="qnaId" value="${q.qnaId}">
                        <button type="submit">상세보기</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
	

</body>
</html>