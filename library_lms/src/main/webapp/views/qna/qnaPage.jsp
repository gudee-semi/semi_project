<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 목록 페이지</title>
</head>
<body>
	<h1>질의응답</h1>
	
	<form method="get" action="<c:url value='/qnaSearch'/>">
		<input type="text" name="keyword" placeholder="제목 또는 작성자" value="${paging.keyword }">
		<input type="submit" value="검색">
	</form>
	
</body>
</html>