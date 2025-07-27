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
h2 {
	text-align: center;
}

.center {
	width: 60vw;
	margin: 0 auto;
	text-align: center;
}

table {
	border-collapse: collapse;
}

th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
}

th {
	border-bottom: 2px solid #666666;
	background: #FAFAFA;
}

tr:last-child td {
	border-bottom: none;
}

button {
	display: block;
	border: none;
	background-color: #205DAC;
	color: #fff;
	border-radius: 6px;
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

.search-icon {
	transform: translate(5px, -3px);
}

.paging-pages {
	padding: 30px;
}

.sidebars {
	width: 300px;
	height: 770px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
	column-gap: 200px;
}

.container {
	width: 80%;
}

</style>

	<jsp:include page="/views/include/header.jsp" />

	<div class="flex-container">
		<div class="sidebars">
			<%@ include file="/views/include/sidebar.jsp"%>
		</div>

		<div>
			<h2>QnA 관리자 페이지</h2>


			<%-- 검색 영역 --%>
			<form action="${pageContext.request.contextPath}/qna/list/admin" method="get" class="search">

				<%-- 카테고리 셀렉트 --%>
				<select name="category" style="height: 27px;">
					<option value="">전체</option>
					<option value="시설" <c:if test="${param.category == '시설'}">selected</c:if>>시설</option>
					<option value="좌석" <c:if test="${param.category == '좌석'}">selected</c:if>>좌석</option>
					<option value="환불" <c:if test="${param.category == '환불'}">selected</c:if>>환불</option>
					<option value="기타" <c:if test="${param.category == '기타'}">selected</c:if>>기타</option>
				</select>

				<%-- 검색 타입 셀렉트 --%>
				<select name="searchType" style="height: 27px;">
					<option value="title" <c:if test="${param.searchType == 'title'}">selected</c:if>>제목</option>
					<option value="content" <c:if test="${param.searchType == 'content'}">selected</c:if>>내용</option>
					<option value="memberName" <c:if test="${param.searchType == 'memberName'}">selected</c:if>>작성자이름</option>
				</select>

				<%-- 키워드 입력창 --%>
				<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력 " style="height: 20px;" />

				<%-- 검색 버튼 --%>
				<button type="submit" class="search-icon" style="display: inline">
					<span class="material-symbols-outlined">search</span>
				</button>

			</form>

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