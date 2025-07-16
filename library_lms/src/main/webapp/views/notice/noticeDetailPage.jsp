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
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
	
	<a href="/notice/list">목록</a>
	
	<c:if test="${ memberNo eq 1 }">
		<a href="/notice/update?id=${ notice.noticeId }">수정</a>	
		
		<form id="noticeDeleteFrm">
			<input type="submit" value="삭제">
		</form>
	</c:if>	
	<c:set var="noticeId" value="${ notice.noticeId }"/>
	
	<script>
		$("#noticeDeleteFrm").on('submit', (e) => {
			e.preventDefault();
			
			const check = confirm('정말로 게시물을 삭제하시겠습니까?');
			
			if (check) {
				const noticeId = ${noticeId}
				
				$.ajax({
					 url: '/notice/delete',
	                 type: 'post',
	                 data: {
	                     noticeId: noticeId
	                 },
	                 dataType: 'json',
	                 success: (data) => {
	                	window.alert(data.res_msg);
	 					if (data.res_code == 200) {
	 						location.href = "<%= request.getContextPath() %>/notice/list";
	 					} else {						
	 						location.href = "<%= request.getContextPath() %>/notice/list";
	 					}
	                 }
				});
			}
		});
	</script>
</body>
</html>