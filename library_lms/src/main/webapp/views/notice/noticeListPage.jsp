<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
	
	td.title {
		text-align: left;
	}
</style>
</head>
<body>
	<h1>공지사항</h1>
		
	<div class="searchBox">
		<form method="get" action="<c:url value='/notice/list' />">
			<select name="category" id="category_crate">
				<option value="">전체</option>
				<option value="일반공지">일반공지</option>
				<option value="중요공지">중요공지</option>
				<option value="시설공지">시설공지</option>
			</select>
			<input type="text" name="keyword" placeholder="검색 기준 선택" value="${ paging.keyword }">
			<input type="submit" value="검색">
		</form>
	</div>
	
	<script>
		$("#category_crate").val("${paging.searchCategory}").attr("selected","selected");	
	</script>

	<table style="border-collapse: collapse; width: 100%">
		<thead>
			<tr>
				<th style="width: 5%">No</th>
				<th style="width: 20%">분류</th>
				<th style="width: 40%">제목</th>
				<th style="width: 10%">작성자</th>
				<th style="width: 15%">작성일</th>			
				<th style="width: 10%">조회수</th>			
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${ noticeList }">
				<tr class="row" onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'">
					<td class="no">${ notice.noticeId }</td>
					<td class="category">${ notice.category }</td>
					<td class="title">${ notice.title }</td>
					<td class="writer">관리자</td>
					<td class="regDate">${ notice.createAt }</td>
					<td class="count">${ notice.viewCount }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		
	<c:if test="${ not empty noticeList }">
		<div>
			<c:if test="${ paging.prev }">
				<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
					&laquo;
				</a>
			</c:if>
			<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
				<a href="<c:url value='/notice/list?nowPage=${ i }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
					${ i }
				</a>	
			</c:forEach>
			<c:if test="${ paging.next }">
				<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarEnd + 1 }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
					&raquo;
				</a>
			</c:if>
		</div>
	</c:if>
		
	<c:if test="${ memberNo eq 1 }">
		<button onclick="location.href='<c:url value="/notice/write" />'">공지사항 작성</button>
	</c:if>
</body>
</html>