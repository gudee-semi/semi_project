<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<style>
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
</style>

	<%-- 1. 검색 폼 추가 (카테고리 + 검색어) --%>
	<form action="${pageContext.request.contextPath}/qna/list/admin" method="get" style="margin-bottom: 20px;">
    <select name="category">
        <option value="">전체</option>
        <option value="시설" <c:if test="${param.category == '시설'}">selected</c:if>>시설</option>
        <option value="좌석" <c:if test="${param.category == '좌석'}">selected</c:if>>좌석</option>
        <option value="환불" <c:if test="${param.category == '환불'}">selected</c:if>>환불</option>
        <option value="기타" <c:if test="${param.category == '기타'}">selected</c:if>>기타</option>
    </select>
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
    <select name="searchType">
        <option value="title" <c:if test="${param.searchType == 'title'}">selected</c:if>>제목</option>
        <option value="content" <c:if test="${param.searchType == 'content'}">selected</c:if>>내용</option>
        <option value="memberId" <c:if test="${param.searchType == 'memberId'}">selected</c:if>>작성자ID</option>
        <option value="memberName" <c:if test="${param.searchType == 'memberName'}">selected</c:if>>작성자이름</option>
    </select>
    <button type="submit">검색</button>
</form>

	<h2>QnA 관리자 리스트</h2>
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
					<td>${t.qnaReplyId}</td> <!-- 답글 번호 -->
					<td>${t.qna.category}</td> <!-- 원글 분류 -->
					<td>${t.qna.title}</td> <!-- 원글 제목 -->
					<td>${t.qna.memberName}</td> <!-- 작성자(원글) -->
					<td>${t.qna.viewCount}</td> <!-- 조회수(원글) -->
					<td>${t.qna.modDate}</td> <!-- 원글 수정일 -->
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


</body>
</html>