<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 관리자 페이지</title>
</head>

<style>
.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.detail-table th, .detail-table td {
	border: 1px solid #ddd;
	padding: 10px 12px;
	vertical-align: middle;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.detail-table th {
	background-color: #F5F5F5;
	width: 120px;
	text-align: center;
	font-weight: normal;
	vertical-align: middle;
}

.content {
	height: 250px;
}

.content-cell {
	vertical-align: top !important;
	white-space: normal !important;
}

.sidebars {
	width: 300px;
	height: 1100px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
	column-gap: 200px;
}

.container {
	width: 80%;
}

hr {
	border: none;
	border-top: 1.5px dashed #ddd;
	width: 70%;
	margin: 20px 0px 20px 0px;
}

.detail-table {
	width: 70%;
}

.reply-textarea {
	width: 70%;
	resize: none;
}

.inputtype-text {
	width: 60%;
}

.reply {
	margin-bottom: 20px;
}

.qnaadmin {
	padding: 0 0 20px 0;
}
</style>

<body>
	<jsp:include page="/views/include/header.jsp" />

	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp"%></div>
		<div class="container">

			<!-- QnA 상세 정보 영역 -->
			<h2 class="qnaadmin">
				<a href="${pageContext.request.contextPath}/qna/list/admin" style="color: #6666aa; text-decoration: none;">QnA 관리자 페이지로 이동</a>
			</h2>
			<table class="detail-table">
				<tr>
					<th style="width: 15%">No</th>
					<td style="width: 35%">${qna.qnaId}</td>
					<th style="width: 15%">작성일</th>
					<td style="width: 35%">${qna.regDate}</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${qna.category}</td>
					<th>작성자</th>
					<td>${qna.memberName}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${qna.title}</td>
					<th>공개여부</th>
					<td>${qna.visibility == 0 ? '비공개' : '공개'}</td>
				</tr>
				<tr>
					<th class="content">내용</th>
					<td class="content-cell" colspan="3">${qna.content}</td>
				</tr>
				<c:if test="${not empty attach}">
					<tr>
						<th>첨부파일</th>
						<td colspan="3"><c:if test="${not empty attach.qnaAttachId}">
								<img src="<c:url value='/filePath?no=${attach.qnaAttachId}'/>" style="max-width: 100%; height: auto;" alt="첨부 이미지">
								<br>
          ${attach.oriName}
        </c:if> <c:if test="${empty attach.qnaAttachId}">
          첨부파일 없음
        </c:if></td>
					</tr>
				</c:if>
			</table>

			<!-- 관리자 답변 -->
			<hr>
			<h3>관리자 답변</h3>
			<c:forEach var="reply" items="${replyList}">

				<table class="detail-table" style="margin-top: 20px">
					<tr>
						<th colspan="2">관리자 답변</th>
					</tr>
					<tr>
						<th style="height: 120px">답변내용</th>
						<td>${reply.content}</td>
					</tr>
					<tr>
						<th>작성일자</th>
						<td>${fn:replace(reply.modDate, 'T', ' ')}</td>
					</tr>
				</table>
			</c:forEach>
			<c:if test="${empty replyList}">
				<table class="detail-table" style="margin-top: 20px">
					<tr>
						<td colspan="2">아직 답변이 없습니다.</td>
					</tr>
				</table>
			</c:if>

			<!-- 답변 등록 폼 -->
			<hr>
			<h3>답변 남기기</h3>

			<c:if test="${empty replyList}">
				<form class="center" action="/qna/reply/admin/insert" method="post">
					<input class="center" type="hidden" name="qnaId" value="${qna.qnaId}" />
					<textarea class="center" name="content" rows="3" cols="60" required placeholder="답글을 입력하세요"></textarea>
					<br>
					<button class="center" type="submit">답글 등록</button>
				</form>
			</c:if>


			<!-- 답변 수정/삭제 폼 리스트 -->
			<hr>
			<h3>답변 수정 및 삭제</h3>

			<c:forEach var="reply" items="${replyList}">
				<div class="reply">
					<b>답변&nbsp;&nbsp;</b>

					<!-- 수정 폼 -->
					<form action="${pageContext.request.contextPath}/qna/reply/admin/update" method="post" style="display: inline;">
						<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
						<input type="hidden" name="qnaId" value="${reply.qnaId}" />
						<input type="text" class="inputtype-text" name="content" value="${reply.content}" />
						<button type="submit">수정</button>
					</form>

					<!-- 삭제 폼 -->
					<form action="${pageContext.request.contextPath}/qna/reply/admin/delete" method="post" style="display: inline; margin-left: 8px;">
						<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
						<input type="hidden" name="qnaId" value="${reply.qnaId}" />
						<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
					</form>
				</div>
			</c:forEach>

		</div>
	</div>




	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>
