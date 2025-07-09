<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>

</head>
<body>
	<%@ include file="/views/include/sidebar.jsp" %>
	<%@ include file="/views/include/header.jsp" %>

	<a href="/calendar/view">준하님</a>
	<a href="/tablet/view">두현님</a>
	<a href="<c:url value='/calendar/view' />">준하님</a>
	<a href="채워주세요!">두현님</a>
	<a href="채워주세요!">준수님</a>
	<a href="채워주세요!">은빈님</a>
	<a href="채워주세요!">길훈님</a>
	<a href="/qna/view">혜원님</a>

</body>
</html>