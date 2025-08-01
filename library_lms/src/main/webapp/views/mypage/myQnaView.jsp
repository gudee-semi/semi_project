<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의내역</title>

<style>
	.container {
		width: 70%;
		margin-top: 50px;
	}
	.search-row {
		padding-left: 15px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.total-count {
		display: block;
		font-size: 16px;
		margin-left: 20px;
		margin-bottom: 10px;
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
	.btn, input[type="submit"].table-bottom {
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
		width: 250px;
		height: 1000px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
 		column-gap: 150px;
	}
	
	.container {
		width: 70%;
	}
	
	header {
		margin: 0 !important;
	}
	
	h1 {
		margin-left: 20px;
		margin-top: 50px;
		margin-bottom: 32px;
	}
	
	footer {
		margin-top: 0px !important;
	}
	.new_reply{
    	display: inline-block;
    	color : Green;
    	font-size: 14px;
    	font-weight: 600;
    }
</style>

</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
	
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>나의 문의 내역</h1>
			<div class="total-count">총 ${totalData } 건</div>
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
					<c:set var="i" value="${paging.totalData - (paging.numPerPage * (paging.nowPage - 1))}"/>
					<c:forEach var="q" items="${qnaList }">
					<tr class="row" onclick="location.href='<c:url value="/myqna/detail?no=${q.qnaId }&myQnaNo=${i }"/>'">
						<td>${i}</td>
						<c:set var="i" value="${i - 1}" />
						<td>${q.category }</td>
						
						<td style="text-align: left">
							<span>${q.title }</span>
						
							<c:forEach var = "r" items= "${qnaReply}">
								<c:if test="${(q.qnaId eq r.qnaId) and (r.replyCheck eq 1)}">
									<span class="new_reply">N</span>
								</c:if>
							</c:forEach>
							
						</td>
						
						<td>${q.memberName }</td>
						<td>${q.regDate }</td>
						<td>${q.viewCount }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<c:if test="${not empty qnaList }">
				<div class="table-bottom">
					<form action="/qna/write" method="get">
						<button class="btn">작성</button>
					</form>
					
					<div class="paging-pages">
						<c:choose>
							<c:when test="${ paging.prev }">
								<a href="<c:url value='/myqna/view?nowPage=${paging.pageBarStart-1}'/>">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:when>
							<c:otherwise>
									<a href="<c:url value='/myqna/view?nowPage=${paging.pageBarStart-1}'/>" class="disabled">
										<span class="material-symbols-outlined">chevron_left</span>
									</a>
							</c:otherwise>
						</c:choose>	
						
						<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
							<c:choose>
								<c:when test="${ i eq paging.nowPage }">
									<a href="<c:url value='/myqna/view?nowPage=${i}'/>" class="current-page">
										${i}
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/myqna/view?nowPage=${i}'/>">
										${i}
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${ paging.next }">
								<a href="<c:url value='/myqna/view?nowPage=${paging.pageBarEnd+1}'/>">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/myqna/view?nowPage=${paging.pageBarEnd+1}'/>" class="disabled">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>