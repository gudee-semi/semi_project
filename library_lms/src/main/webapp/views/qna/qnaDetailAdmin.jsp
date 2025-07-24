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
.center {
	width: 50vw;
	margin: 0 auto;
	text-align: center;
	padding: 5px;
}

.inputtype-text {
	width: 70%;
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

button {
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

.qnaadmin {
	display:inline-block;
     padding:10px 25px;
     background:#205DAC;
     color:white;
     border-radius:7px;
     font-size:16px;
     text-decoration:none;
     font-weight:bold;
     box-shadow:0 2px 8px rgba(32,93,172,0.07);
     transition:background 0.2s;
}

</style>

	<jsp:include page="/views/include/header.jsp" />

	<h2><a href="${pageContext.request.contextPath}/qna/list/admin" class="qnaadmin" onmouseover="this.style.background='#3E7AC8';"
   onmouseout="this.style.background='#205DAC';">QnA 관리자 페이지</a></h2>
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
			<th><c:choose>
					<c:when test="${qna.visibility eq 1}">공개</c:when>
					<c:otherwise>비공개</c:otherwise>
				</c:choose></th>
		</tr>
		<tr>
			<th>첨부파일</th>
			<th><c:if test="${not empty attach.qnaAttachId}">
					<img src="<c:url value='/filePath?no=${attach.qnaAttachId}'/>"
						style="max-width: 100%; height: auto;" alt="첨부 이미지">
					<br>
                ${attach.oriName}
            </c:if> <c:if test="${empty attach.qnaAttachId}">
                첨부파일 없음
            </c:if></th>
		</tr>
		<tr>
			<th>내용</th>
			<th>${qna.content}</th>
		</tr>
	</table>



	<!-- 답글 리스트 영역 -->
	<h3>답글</h3>
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
				<td>${fn:replace(r.modDate, 'T', ' ')}</td>

			</tr>
		</c:forEach>
		<c:if test="${empty replyList}">
			<tr>
				<td colspan="3">아직 답글이 없습니다.</td>
			</tr>
		</c:if>
	</table>

	<!-- 답글 작성 폼 -->
	<h3>답글 남기기</h3>
	<form class="center" action="/qna/reply/admin/insert" method="post">
		<input class="center" type="hidden" name="qnaId" value="${qna.qnaId}" />
		<textarea class="center" name="content" rows="3" cols="60" required
			placeholder="답글을 입력하세요"></textarea>
		<br>
		<button class="center" type="submit">답글 등록</button>
	</form>

	<c:forEach var="reply" items="${replyList}">
		<div class="center">
			<b>답글&nbsp;&nbsp;</b>
			<!-- 수정 폼(수정 버튼 포함) -->
			<form
				action="${pageContext.request.contextPath}/qna/reply/admin/update"
				method="post" style="display: inline;">
				<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
				<input type="hidden" name="qnaId" value="${reply.qnaId}" /> <input
					type="text" class="inputtype-text" name="content"
					value="${reply.content}" />
				<button type="submit">수정</button>
			</form>

			<!-- 삭제 폼(삭제 버튼 포함, 바로 옆에) -->
			<form
				action="${pageContext.request.contextPath}/qna/reply/admin/delete"
				method="post" style="display: inline; margin-left: 8px;">
				<input type="hidden" name="qnaReplyId" value="${reply.qnaReplyId}" />
				<input type="hidden" name="qnaId" value="${reply.qnaId}" />
				<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
			</form>
		</div>
	</c:forEach>

	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>