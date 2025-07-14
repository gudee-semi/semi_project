<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 상세 페이지</title>
</head>
<body>
	<p>카테고리 : ${qna.category }</p>
	<p>제목 : ${qna.title }</p>
	<p>작성자 : ${qna.memberId } </p>
	
	<p>공개여부 : ${qna.visibility } </p>
	<p>내용 : ${qna.content } </p>
	<p>작성일 : ${qna.regDate } </p>
	
		<c:if test="${not empty attach }">
		    <h4>첨부파일</h4>
		    <img src="<c:url value='/filePath?no=${attach.qnaAttachId }'/>"><br>
		    <a href="<c:url value='/fileDownload?no=${attach.qnaAttachId }'/>">다운로드</a>
	    </c:if>
	<br>
	<form action="/qna/view" method="get">
		<button>목록</button>
	</form>
	
	<form action="/qna/update" method="get">
		<input type="hidden" name="no" value="${qna.qnaId}">
		<button>수정</button>
	</form>
	
	<form action="/qna/delete" method="get">
		<input type="hidden" name="no" value="${qna.qnaId}">
		<button>삭제</button>
	</form>
	
	<!--
	<p>제목 : ${qna.title }</p>
	<p>작성자 : ${qna.memberId } </p>
	<p>내용 : ${qna.content } </p>
	<p>작성일 : ${qna.regDate } </p>
	
		<c:if test="${not empty attach }">
		    <h4>첨부파일</h4>
		    <img src="<c:url value='/filePath?no=${attach.qnaAttachId }'/>"><br>
		    <a href="<c:url value='/fileDownload?no=${attach.qnaAttachId }'/>">다운로드</a>
	    </c:if>
	<br>
	<form action="/qna/view" method="get">
		<button>목록</button>
	</form>
	-->
</body>
</html>