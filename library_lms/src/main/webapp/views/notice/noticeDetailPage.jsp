<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
	<p>제목 : ${ notice.title }</p>
	<p>작성자 : 관리자</p>
	<p>내용 : ${ notice.content } </p>
	<p>작성일 : ${ notice.createAt } </p>
</body>
</html>