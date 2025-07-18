<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 상세 페이지</title>
	<style>
	.container {
		width : 80vw;
		margin : 0 auto;	
	}
	.content {
		background-color: #fff;
	}
	.detail-table {
		width: 70%;
		border-collapse: collapse;
		margin-bottom: 20px;
		table-layout: fixed;
	}
	.detail-table th,
	.detail-table td {
		border: 1px solid #ddd;
		padding: 10px 12px;
		vertical-align: top;
		word-wrap: break-word;
	}
	.detail-table th {
		background-color: #F0F0F0;
		width: 120px;
		text-align: center;
		font-weight: normal;
		vertical-align: middle;
	}
	.content {
		height: 250px;
	}
	/* ===== 버튼 ===== */
	.btn {
		display: inline-block;
		padding: 10px 20px;
		margin: 0 8px;
		border: none;
		border-radius: 4px;
		font-size: 15px;
		cursor: pointer;
		color: rgba(255, 255, 255, 1);
	}
	.btn.blue {
		width: 70px;
		background-color: rgba(32, 93, 172, 1);
	}
	</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="container">
		<h1>질의응답</h1>
		<table class="detail-table">
				<tr>
					<th>No</th>
					<td>${qna.qnaId }</td>
					<th>작성일</th>
					<td>${qna.regDate }</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${qna.category }</td>
					<th>작성자</th>
					<td>${qna.memberName }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${qna.title }</td>
					<th>공개여부</th>
					<td>${qna.visibility == 0 ? '비공개' : '공개' }</td>
				</tr>
				<tr>
					<th class="content">내용</th>
					<td colspan="3">${qna.content }</td>
				</tr>
				<c:if test="${not empty attach }">
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
					    	<a href="<c:url value='/fileDownload?no=${attach.qnaAttachId }'/>">${attach.oriName} </a><br>
							<img src="<c:url value='/filePath?no=${attach.qnaAttachId }'/>"><br>
						</td>
					</tr>
				</c:if>
			</table>
			
			<c:if test ="${qna.memberId eq loginMember.memberId}">
				<c:if test ="${qna.answerStatus eq '0'}">
					<a href="/qna/update?no=${qna.qnaId }">수정</a>
				</c:if>
					<a href="/qna/delete?no=${qna.qnaId }">삭제</a>
			</c:if>

			<%-- <form action="<c:url value='/qna/update'/>" method="get">
				<button class="btn blue">수정</button>
			</form>
			
			<form action="<c:url value='/qna/delete'/>" method="get">
				<input type="hidden" name="qnaId" value="${qna.qnaId}"/>
				<button class="btn blue">삭제</button>
			</form>
			 --%>
			<form action="<c:url value='/qna/view'/>" method="get">
				<button class="btn blue">목록</button>
			</form>
	</div>
	
	<script>
		// 삭제 전에 사용자에게 확인 메시지를 띄우는 함수
		function confirmDelete() {
			// confirm 창을 띄우고 결과를 반환
			return confirm("정말로 삭제하시겠습니까?");
		}
	</script>
</body>
</html>