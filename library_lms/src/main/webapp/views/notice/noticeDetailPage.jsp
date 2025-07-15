<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
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
	
	<c:if test="${ not empty attach }">
	    <h4>첨부파일</h4>
	    <img src="<c:url value='/notice/filePath?id=${ notice.noticeId }' />"><br>
	    <a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName } 다운로드</a>
	</c:if>
	
	<c:if test="${ memberNo eq 2 }">
		<a href="/notice/update?id=${ notice.noticeId }">수정</a>	
	</c:if>
</body>
</html>