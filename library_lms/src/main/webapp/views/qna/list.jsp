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
	<h1>질의응답 목록</h1>
	
	<form method="get" action="<c:url value='/qnaSearch'/>">
		<select name="searchBy">
			<option value="">구분</option>
			<option value="제목">제목</option>
			<option value="작성자">작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색 기준 선택" value="">
		<input type="submit" value="검색">
	</form>
	
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="b" items="${boardList }">
				<tr onclick="location.href='<c:url value="/boardDetail?no=${b.boardNo }"/>'">
					<td>${b.boardNo }</td>
					<td>${b.boardTitle }</td>
					<td>${b.memberId }</td>
					<td>${b.regDate }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${not empty boardList }">
		<div>
			<c:if test="${paging.prev }">
				<a href="<c:url value='/boardList?nowPage=$&keyword=${paging.keyword }'/>">
					&laquo;
				</a>
			</c:if>		
			<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
				<a href="<c:url value='/boardList?nowPage=${i }&keyword=${paging.keyword }'/>">
					${i }
				</a>							
			</c:forEach>
			<c:if test="${paging.next }">
				<a href="<c:url value='/boardList?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }'/>">
					&raquo;
				</a>
			</c:if>
		</div>
	</c:if>
	
	<a href="<c:url value='/qnaWrite'/>">
		작성
	</a>
	
</body>
</html>
