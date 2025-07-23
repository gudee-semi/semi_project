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
	width: 70%;
}
h1 {
	margin-left: 20px;
   }
.search-row {
	padding-left: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.total-count {
	font-size: 16px;
	margin-left: 5px;
}
.searchBox form {
	display: flex;
	gap: 5px; /* 검색창 요소들 사이 간격 */
}
.searchBox {
	text-align: right;
	margin-bottom: 10px;
}
.searchBox form {
	display: inline-flex;
	align-items: center;
	gap: 0; /* 완전히 붙이기 */
}
table {
   	width: 100%;
	table-layout: fixed; /* 셀 너비 고정 */
	border-collapse: collapse;
	margin-top: 20px;
}
tr.row {
	cursor: pointer;
}
th {
	border-top: 1px solid #CCCCCC;
	height: 40px;
	background: #FAFAFA;
}
th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
	white-space: nowrap; /* 줄바꿈 방지 */
	overflow: hidden;    /* 넘치는 텍스트 숨김 */
	text-overflow: ellipsis; /* ... 처리 */
}
.center {
	width: 50vw;
	margin: 0 auto;
	text-align: center;
}
td.title {
	text-align: left;
}
.searchBox select,
.searchBox input[type="text"] {
	height: 36px;
	font-size: 14px;
	box-sizing: border-box;
	margin: 0;       /* ✅ 기본 margin 제거 */
	border: 1px solid #ccc;
	border-radius: 4px 0 0 4px; /* 예시: 모양 다듬기 */
}
.searchBox input[type="text"] {
   	border-radius: 0;
}
/* 버튼만 오른쪽 둥글게 */
.searchBox .search {
	border-radius: 0 4px 4px 0;
	background-color: #205DAC;
	width: 60px;
	color: white;
	border: none;
	cursor: pointer;
	height: 36px; /* 높이 통일 */
   	font-size: 14px; /* 글자 크기 통일 */
}
.btn:hover {
	background-color: #3E7AC8;
}
.sidebar {
	width: 250px;
	height: 100vh;
	background-color: #3b82f6;
}
.table-bottom {
	display: flex;
	flex-direction: column;
	align-items: flex-end; /* 작성 버튼을 우측 정렬 */
	gap: 10px; /* 버튼과 페이징 사이 간격 */
	margin-top: 20px;
}
.paging-pages {
    align-self: center; /* 페이징은 중앙 정렬 */
	display: flex;
	justify-content: center;
	gap: 6px;
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
	width: 90px;
	margin-right: 10px;
	transition: .2s;
	font-size: 16px;
}

/*  하...   */
.sidebars {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
		column-gap: 100px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

h1 {
	margin-top: 50px;
}

footer {
	margin-top: 0px !important;
}

.nav-item {
	padding: 5px;
}
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
		
			<h1>공지사항</h1>
			<div class="search-row">
				<span class="total-count">총 ${totaldata} 건</span>
				<div class="searchBox">
					<form method="get" action="<c:url value='/notice/list' />">
					
						<select name="category" id="category_crate">
							<option value="">전체</option>
							<option value="일반공지">일반공지</option>
							<option value="중요공지">중요공지</option>
							<option value="시설공지">시설공지</option>
						</select>
						
						<input type="text" name="keyword" placeholder=" 검색어를 입력해주세요." value="${paging.keyword }">
						<button type="submit" class="btn search">검색</button>
						<!-- <input type="submit" value="검색"> -->
					</form>
				</div>
			</div>
			
			<script>
				$("#category_crate").val("${paging.searchCategory}").attr("selected","selected");	
			</script>
		
			<table class="center" style="border-collapse: collapse; width: 100%">
				<thead>
					<tr>
						<th style="width: 5%">No</th>
						<th style="width: 15%">분류</th>
						<th style="width: 45%">제목</th>
						<th style="width: 10%">작성자</th>
						<th style="width: 15%">작성일</th>			
						<th style="width: 10%">조회수</th>			
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="notice" items="${ noticeList }">
						<tr class="row" onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'">
							<td>${ notice.noticeId }</td>
							<td>${ notice.category }</td>
							<td>${ notice.title }</td>
							<td>관리자</td>
							<td>${ notice.createAt }</td>
							<td>${ notice.viewCount }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
				
			<c:if test="${ not empty noticeList }">
				<div class="table-bottom">
					<c:if test="${ memberNo eq 1 }">
						<form action="/notice/write" method="get">
							<button class="btn">작성</button>
						</form>
					</c:if>
				
					<div class="paging-pages">
						<c:choose>
							<c:when test="${ paging.prev }">
								<a href="<c:url value='/notice/list?nowPage=${paging.pageBarStart-1}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:when>
							<c:otherwise>
									<a href="<c:url value='/notice/list?nowPage=${paging.pageBarStart-1}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>" class="disabled">
										<span class="material-symbols-outlined">chevron_left</span>
									</a>
							</c:otherwise>
						</c:choose>	
						
						<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
							<c:choose>
								<c:when test="${ i eq paging.nowPage }">
									<a href="<c:url value='/notice/list?nowPage=${i}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>" class="current-page">
										${i }
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/notice/list?nowPage=${i}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>">
										${ i }
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${ paging.next }">
								<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }&category=${paging.searchCategory }'/>" class="disabled">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:if>
		
	</div>
	</div>
	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>