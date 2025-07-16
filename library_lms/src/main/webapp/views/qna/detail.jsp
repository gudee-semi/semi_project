<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 상세 페이지</title>
</head>
<body>
	<p>제목 : ${qna.title }</p>
	<p>작성자 : ${qna.memberId } </p>
	<p>내용 : ${qna.content } </p>
	<p>작성일 : ${qna.regDate } </p>
	
		<c:if test="${not empty attach }">
		    <h4>첨부파일</h4>
		    <img src="<c:url value='/filePath?no=${attach.qnaAttachId }'/>"><br>
		    <a href="<c:url value='/fileDownload?no=${attach.qnaAttachId }'/>">다운로드</a>
	    </c:if>
	<style>
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
	background-color: #f0f0f0;
	width: 120px;
	text-align: center;
	
	font-weight: normal;
	}
	/* 긴 내용 셀 */
	.content-text {
		height: 150px;
		vertical-align: top;
		background-color: #fafafa;
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
	<section class="content">
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
				<th>내용</th>
				<td colspan="3">${qna.content }</td>
			</tr>
			<c:if test="${not empty attach }">
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<img src="<c:url value='/filePath?no=${attach.qnaAttachId }'/>"><br>
				    	<a href="<c:url value='/fileDownload?no=${attach.qnaAttachId }'/>">${attach.oriName} </a>
					</td>
				</tr>
			</c:if>
			
			<c:if test ="${qna.memberId eq loginMember.memberId}">
				<a href="/qna/update?no=${qna.qnaId }">수정</a>
			
				<a href="/qna/delete?no=${qna.qnaId }">삭제</a>
			</c:if>
			
			<form action="<c:url value='/qna/view'/>" method="get">
				<button class="btn blue">목록</button>
			</form>
		</table>
	</section>
</body>
</html>