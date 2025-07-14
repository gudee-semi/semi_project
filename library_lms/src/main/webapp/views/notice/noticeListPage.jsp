<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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
					<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}' />">
						&laquo;
					</a>
				</c:if>
				<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
					<a href="<c:url value='/notice/list?nowPage=${ i }' />">
						${ i }
					</a>	
				</c:forEach>
				<c:if test="${ paging.next }">
					<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarEnd + 1 }' />">
						&raquo;
					</a>
				</c:if>
			</div>
		</c:if>
	</div>
</body>
</html>