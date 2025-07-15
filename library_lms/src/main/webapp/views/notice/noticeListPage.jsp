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
	.container {
    	width: 80vw;
    	padding: 10px;
    }
    .searchBox {
    	
    }
    .row {
    	border: 0.5px solid black;
    	width: 900px;
    	padding: 10px;
    	margin: 2px;
    }
    .no {
    	text-align: center;
    	width: 40px;
    	display: inline-block;
    }
    .category {
    	text-align: center;
    	width: 110px;
    	display: inline-block;
    }
    .title {
    	text-align: center;
    	width: 400px;
    	display: inline-block;
    }
    .writer {
    	text-align: center;
    	width: 120px;
    	display: inline-block;
    }
    .count {
    	text-align: center;
    	width: 70px;
    	display: inline-block;
    }
    .regDate {
    	text-align: center;
    	width: 130px;
    	display: inline-block;
    }
</style>
</head>
<body>
	<div class="container">
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
		
		<div class="row">
			<div class="no">No</div>
			<div class="category">분류</div>
			<div class="title">제목</div>
			<div class="writer">작성자</div>
			<div class="count">조회수</div>
			<div class="regDate">작성일</div>
		</div>
		
		<c:forEach var="notice" items="${ noticeList }">
			<div  class="row" onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'">
				<div class="no">${ notice.noticeId }</div>
				<div class="category">${ notice.category }</div>
				<div class="title">${ notice.title }</div>
				<div class="writer">관리자</div>
				<div class="count">${ notice.viewCount }</div>
				<div class="regDate">${ notice.createAt }</div>
			</div>
		</c:forEach>
		
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
			<button onclick="location.href='<c:url value="/notice/write" />'">글쓰기</button>
		</c:if>
	</div>
</body>
</html>