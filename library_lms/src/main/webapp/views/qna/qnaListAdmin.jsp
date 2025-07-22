<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<style>
h2 {
	text-align: center;
}

.center {
	width: 50vw;
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
	text-align: center;
	padding: 20px;
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
</style>

	<jsp:include page="/views/include/header.jsp" />

	<h2>QnA 관리자 리스트</h2>

	<%-- 1. 검색 폼 추가 (카테고리 + 검색어) --%>
	<form action="${pageContext.request.contextPath}/qna/list/admin"
		method="get" class="search">
		<select name="category">
			<option value="">전체</option>
			<option value="시설"
				<c:if test="${param.category == '시설'}">selected</c:if>>시설</option>
			<option value="좌석"
				<c:if test="${param.category == '좌석'}">selected</c:if>>좌석</option>
			<option value="환불"
				<c:if test="${param.category == '환불'}">selected</c:if>>환불</option>
			<option value="기타"
				<c:if test="${param.category == '기타'}">selected</c:if>>기타</option>
		</select> <select name="searchType">
			<option value="title"
				<c:if test="${param.searchType == 'title'}">selected</c:if>>제목</option>
			<option value="content"
				<c:if test="${param.searchType == 'content'}">selected</c:if>>내용</option>
			<option value="memberName"
				<c:if test="${param.searchType == 'memberName'}">selected</c:if>>작성자이름</option>
		</select> <input type="text" name="keyword" value="${param.keyword}"
			placeholder="검색어 입력">

		<button type="submit" style="display: inline">검색</button>
	</form>


	<table class="center" style="border-collapse: collapse;">
		<thead>
			<tr>
				<th>No</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="t" items="${qnaAdminList}">
				<tr style="cursor: pointer;"
					onclick="location.href='${pageContext.request.contextPath}/qna/detail/admin?qnaId=${t.qna.qnaId}'">
					<td>${t.qna.qnaId}</td>
					<td>${t.qna.category}</td>
					<td>${t.qna.title}</td>
					<td>${t.qna.memberName}</td>
					<td>${t.qna.viewCount}</td>
					<td>${t.qna.modDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

				<c:if test="${ not empty noticeList }">
				<div class="paging-pages">
					<c:choose>
						<c:when test="${ paging.prev }">
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />">
								<span class="material-symbols-outlined">chevron_left</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarStart - 1}&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" class="disableddd">
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
							<a href="<c:url value='/notice/list?nowPage=${ paging.pageBarEnd + 1 }&keyword=${ paging.keyword }&category=${ paging.searchCategory }' />" class="disableddd">
								<span class="material-symbols-outlined">chevron_right</span>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>

	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>