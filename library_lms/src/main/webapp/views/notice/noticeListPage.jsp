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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
	table {
		border-collapse: collapse;
		margin-top: 20px;
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
	
	tr.row {
		cursor: pointer;
	}
	
	td.title {
		text-align: left;
	}
	
	.searchBox {
		text-align: right;
	}
	
	.search-submit {
	    background-color: #205DAC;
	    color: white;
	    border-color: transparent;
	    border-radius: 3px;
	    cursor: pointer;
	    width: 50px;
	}
	
	.paging-pages {
	    text-align: center;
    	margin-top: 10px;
	}
	
	.paging-pages a {
		display: inline-block;
		width: 32px; /* 숫자 간격에 맞춰 적당히 조정해도 됨 */
		text-align: center;
		margin-left: 5px;
		margin-right: 5px;
		text-decoration: none;
		color: black;
	}
	
	.material-symbols-outlined {
		display: inline-block;
    	vertical-align: top;
	}
	
    .disabled {
    	pointer-events: none;
    	opacity: 0.2;
    }
    
    .paging-pages a.current-page {
    	color: #205DAC;
    	text-decoration: underline;
    }
    
    .admin-write {
    	margin-top: 80px;
    	text-align: right;
    }
    
   	footer{
		margin-top: 100px !important;
	}
	
	.btn {
    	border: none;
    	background-color: #205DAC;
   	    color: #fff;
    	border-radius: 6px;
    	cursor: pointer;
    	height: 40px;
    	transition: .2s;
    	font-size: 16px;
	}
	
	.btn:hover {
		background-color: #3E7AC8;
	}
	
	.sidebar {
		width: 250px;
		height: 100vh;
		background-color: #3b82f6;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
  		column-gap: 150px;
	}
	
	.container {
		width: 70%;
	}
</style>
</head>
<body>
	<jsp:include page="/views/include/header.jsp" />
	
	<div class="flex-container">
		<div class="sidebar">사이드바</div>
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
					<input type="submit" value="검색" class="search-submit">
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
			
			<div class="admin-write">
				<c:if test="${ memberNo eq 1 }">
					<button onclick="location.href='<c:url value="/notice/write" />'" class="btn">공지사항 작성</button>
				</c:if>	
			</div>	
				
			<c:if test="${ not empty noticeList }">
				<div class="paging-pages">
					<c:choose>
						<c:when test="${ paging.prev }">
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
								<span class="material-symbols-outlined">chevron_left</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" class="disabled">
								<span class="material-symbols-outlined">chevron_left</span>
							</a>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
						<c:choose>
							<c:when test="${ i eq paging.nowPage }">
								<a href="<c:url value='/notice/list?nowPage=${ i }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" class="current-page">
									${ i }
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/notice/list?nowPage=${ i }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" >
									${ i }
								</a>
							</c:otherwise>
						</c:choose>	
					</c:forEach>
					<c:choose>
						<c:when test="${ paging.next }">
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarEnd + 1 }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
								<span class="material-symbols-outlined">chevron_right</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarEnd + 1 }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" class="disabled">
								<span class="material-symbols-outlined">chevron_right</span>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>