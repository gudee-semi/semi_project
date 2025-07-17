<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	
	<table style="border-collapse: collapse; width: 100%">
		<thead>
			<tr>
				<th>No</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
		</thead>

    <tbody>
        <c:forEach var="t" items="${qnaList}">
            <tr style="cursor:pointer;"
                onclick="location.href='/qna/detail/admin?no=${t.qna.qnaId}'">
                <td>${t.qna.qnaId}</td>
                <td>${t.qna.category}</td>
                <td>${t.qna.title}</td>
                <td>${t.qna.memberId}</td>
                <td>${t.qna.viewCount}</td>
                <td>${t.modDate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>



<style>
table {
	border-collapse: collapse;
}

th, td {
	border: none;
	border-bottom: 1px solid #cccccc;
	padding: 8px 12px;
	text-align: center;
}

th {
	border-bottom: 2px solid #666666;
	background: #fafafa;
}

tr:last-child td {
	border-bottom: none;
}
</style>

</body>
</html>