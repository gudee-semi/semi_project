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

	<h2>관리자 QnA 상세 (답글 작성/관리)</h2>

	<table border="1" cellpadding="6" cellspacing="0">
		<tr>
			<th>번호</th>
			<td>${qna.qnaId}</td>
			<th>작성자</th>
			<td>${qna.memberId}</td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td>${qna.category}</td>
			<th>등록일</th>
			<td>${qna.regDate}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">${qna.title}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3">${qna.content}</td>
		</tr>
	</table>

	<br>

	<h3>답글 목록</h3>
	<c:forEach var="reply" items="${replyList}">
		<div style="border-bottom: 1px solid #eee; margin-bottom: 5px;">
			<b>관리자</b> (${reply.regDate})<br> ${reply.content}
		</div>
	</c:forEach>

	<!-- 관리자 답글 작성 폼 -->
	<h3>답글 작성</h3>
	<form action="/qna/reply/write" method="post">
		<input type="hidden" name="qnaId" value="${qna.qnaId}" />
		<textarea name="content" rows="4" cols="60"
			placeholder="관리자 답변을 입력하세요"></textarea>
		<br>
		<button type="submit">답글 등록</button>
	</form>

	<br>
	<a href="/qna/view">목록으로</a>

	<c:forEach var="a" items="${qnaAdminList}">
    ${a.qna.qnaId}
	</c:forEach>

</body>
</html>