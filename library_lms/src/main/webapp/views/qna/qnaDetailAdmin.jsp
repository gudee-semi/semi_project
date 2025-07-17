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

.inputtype-text {
	width: 60%;
}

h3 {
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
</style>

	<h3>QnA 상세</h3>
	<table class="center" style="border-collapse: collapse;">
		<tr>
			<th>No</th>
			<th>${qna.qnaId}</th>
		</tr>
		<tr>
			<th>분류</th>
			<th>${qna.category}</th>
		</tr>
		<tr>
			<th>제목</th>
			<th>${qna.title}</th>
		</tr>
		<tr>
			<th>작성자</th>
			<th>${qna.memberName}</th>
		</tr>
		<tr>
			<th>조회수</th>
			<th>${qna.viewCount}</th>
		</tr>
		<tr>
			<th>등록일</th>
			<th>${qna.regDate}</th>
		</tr>
		<tr>
			<th>공개여부</th>
			<th>
				<%--             <c:choose>
                <c:when test="${qna.isOpen eq 1}">공개</c:when>
                <c:otherwise>비공개</c:otherwise>
            </c:choose> --%>
			</th>
		</tr>
		<tr>
			<th>첨부파일</th>
			<th>
				<%--             <c:if test="${not empty qna.fileName}">
                <a href="/upload/${qna.fileName}" download>${qna.fileName}</a>
            </c:if> --%>
			</th>
		</tr>
		<tr>
			<th>내용</th>
			<th>${qna.content}</th>
		</tr>
	</table>



	<!-- 댓글 리스트 영역 -->
	<h3>댓글</h3>
	<table class="center" style="border-collapse: collapse;">
		<tr>
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="r" items="${replyList}">
			<tr>
				<td>관리자</td>
				<td>${r.content}</td>
				<td>${r.regDate}</td>

			</tr>
		</c:forEach>
		<c:if test="${empty replyList}">
			<tr>
				<td colspan="3">아직 댓글이 없습니다.</td>
			</tr>
		</c:if>
	</table>

	<!-- 댓글 작성 폼 -->
	<h3>답글 남기기</h3>
	<form class="center" action="/qna/reply/admin/insert" method="post">
		<input class="center" type="hidden" name="qnaId" value="${qna.qnaId}" />
		<textarea class="center" name="content" rows="3" cols="60" required
			placeholder="댓글을 입력하세요"></textarea>
		<br>
		<button class="center" type="submit">댓글 등록</button>
	</form>

	<c:forEach var="reply" items="${replyList}">
		<!-- 댓글 내용 -->
		<div class="center">
			<b>수정 목록 : </b>
			<form action="${pageContext.request.contextPath}/qna/reply/admin/update" method="post" style="display: inline;">
				<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
				<input type="hidden" name="qnaId" value="${reply.qnaId}" />
				<input type="text"  class="inputtype-text" name="content" value="${reply.content}" />
				<button type="submit">수정</button>
			</form>
		</div>
	</c:forEach>

	<c:forEach var="reply" items="${replyList}">
		<div class="center">
			<b>삭제 목록 : </b> ${reply.content}
			<form action="${pageContext.request.contextPath}/qna/reply/admin/delete" method="post" style="display: inline;">
				<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
				<input type="hidden" name="qnaId" value="${reply.qnaId}" />
				<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
			</form>
		</div>
	</c:forEach>


</body>
</html>