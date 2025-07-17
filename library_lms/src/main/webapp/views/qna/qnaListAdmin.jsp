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

<style>

.center {
	width: 50vw;
	margin: 0 auto;
	text-align: center;
}

table {
	border-collapse: collapse;
}
th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
}
th {
	border-bottom: 2px solid #666666;
	background: #FAFAFA;
}
tr:last-child td {
	border-bottom: none;
}

</style>

	<h2>QnA 관리자 리스트</h2>
	<table class="center" style="border-collapse: collapse;">
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
			<c:forEach var="t" items="${qnaAdminList}">
				<tr style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/qna/detail/admin?qnaId=${t.qna.qnaId}'">
					<td>${t.qna.qnaId}</td>
					<td>${t.qna.category}</td>
					<td>${t.qna.title}</td>
					<td>${t.qna.memberId}</td>
					<td>${t.qna.viewCount}</td>
					<td>${t.qna.modDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


</body>
</html>