<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 관리자 페이지</title>
</head>
<body>

	<style>
.search-row {
	padding-left: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.search-icon {
	width: 60px;
	height: 36px;
	display: flex;
	align-items: center;
	justify-content: center;
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
	overflow: hidden; /* 넘치는 텍스트 숨김 */
	text-overflow: ellipsis; /* ... 처리 */
}

.center {
	width: 70vw;
	margin: 0 auto;
	text-align: center;
}

td.title {
	text-align: left;
}

.searchBox select, .searchBox input[type="text"] {
	height: 36px;
	font-size: 14px;
	box-sizing: border-box;
	margin: 0; /* ✅ 기본 margin 제거 */
	border: 1px solid #ccc;
	border-radius: 4px 0 0 4px;
	height: 36px; /* 예시: 모양 다듬기 */
}

.searchBox input[type="text"] {
	border-radius: 0;
}

.btn:hover {
	background-color: #3E7AC8;
}

button {
	display: block;
	border: none;
	background-color: #205DAC;
	color: #fff;
	border-radius: 0 4px 4px 0;
	font-size: 15px;
	cursor: pointer;
	transition: 0.2s;
}

.button:hover {
	background-color: #3E7AC8;
}

.search {
	text-align: end;
	padding: 30px;
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

.disableddd {
	pointer-events: none;
	opacity: 0.2;
}

.paging-pages a.current-page {
	color: #205DAC;
	text-decoration: underline;
}

body>form {
	transform: translate(380px, 0);
}

.paging-pages {
	padding: 60px;
}

.sidebars {
	width: 300px;
	height: 770px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
	column-gap: 100px;
}
</style>

	<jsp:include page="/views/include/header.jsp" />

	<div class="flex-container">
		<div class="sidebars">
			<%@ include file="/views/include/sidebar.jsp"%>
		</div>

		<div>
			<h1>QnA 관리자 페이지</h1>


			<%-- 검색 영역 --%>
			<div class="searchBox">
				<form action="${pageContext.request.contextPath}/qna/list/admin" method="get" class="search">

					<!-- 카테고리 셀렉트 -->
					<select name="category">
						<option value="">전체</option>
						<option value="시설" <c:if test="${param.category == '시설'}">selected</c:if>>시설</option>
						<option value="좌석" <c:if test="${param.category == '좌석'}">selected</c:if>>좌석</option>
						<option value="환불" <c:if test="${param.category == '환불'}">selected</c:if>>환불</option>
						<option value="기타" <c:if test="${param.category == '기타'}">selected</c:if>>기타</option>
					</select>

					<!-- 검색 타입 셀렉트 -->
					<select name="searchType">
						<option value="title" <c:if test="${param.searchType == 'title'}">selected</c:if>>제목</option>
						<option value="content" <c:if test="${param.searchType == 'content'}">selected</c:if>>내용</option>
						<option value="memberName" <c:if test="${param.searchType == 'memberName'}">selected</c:if>>작성자이름</option>
					</select>

					<!-- 키워드 입력창 -->
					<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" />

					<!-- 검색 버튼 -->
					<button type="submit" class="search-icon">
						<span class="material-symbols-outlined search-icon" style="display: flex;">search</span>
					</button>
				</form>
			</div>

			<!-- 리스트 영역 -->
			<table class="center" style="border-collapse: collapse;">
				<thead>
					<tr>
						<th style="width: 5%">No</th>
						<th style="width: 15%">분류</th>
						<th style="width: 35%">제목</th>
						<th style="width: 10%">작성자</th>
						<th style="width: 25%">작성일</th>
						<th style="width: 10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${qnaAdminList}">
						<tr style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/qna/detail/admin?qnaId=${t.qnaId}'">
							<td>${t.qnaId}</td>
							<td>${t.category}</td>
							<td style="text-align: left;">${t.title}</td>
							<td>${t.memberName}</td>
							<td>${t.regDate}</td>
							<td>${t.viewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- 페이징 영역 -->
			<div class="paging-pages">
				<c:if test="${ not empty qnaAdminList }">
					<div>
						<c:choose>
							<c:when test="${ paging.prev }">
								<a href="<c:url value='/qna/list/admin?page=${ paging.pageBarStart - 1 }&category=${ category }&searchType=${ searchType }&keyword=${ keyword }' />">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:when>
							<c:otherwise>
								<a class="disableddd">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
							<c:choose>
								<c:when test="${ i eq paging.nowPage }">
									<a href="<c:url value='/qna/list/admin?page=${ i }&category=${ category }&searchType=${ searchType }&keyword=${ keyword }' />" class="current-page">${ i }</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/qna/list/admin?page=${ i }&category=${ category }&searchType=${ searchType }&keyword=${ keyword }' />"> ${ i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:choose>
							<c:when test="${ paging.next }">
								<a href="<c:url value='/qna/list/admin?page=${ paging.pageBarEnd + 1 }&category=${ category }&searchType=${ searchType }&keyword=${ keyword }' />">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:when>
							<c:otherwise>
								<a class="disableddd">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
			</div>
		</div>
	</div>






	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>