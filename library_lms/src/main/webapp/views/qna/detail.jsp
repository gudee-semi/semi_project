<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 상세 페이지</title>
<style>
/* 항상 가장 먼저 */
html, body {
	margin: 0;
	padding: 0;
	font-family: 'Arial', sans-serif; /* 선택사항 */
	box-sizing: border-box;
}
	.container {
		width : 70%;
		margin : 0 auto;	
	}
	h1 {
		margin-left: 20px;
    }
	.detail-table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
		border: 1px solid #F5F5F5;
	}
	.detail-table th,
	.detail-table td {
		border: 1px solid #ddd;
		padding: 10px 12px;
		vertical-align: middle;
		white-space: nowrap; /* 줄바꿈 방지 */
		overflow: hidden;    /* 넘치는 텍스트 숨김 */
		text-overflow: ellipsis; /* ... 처리 */
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
		white-space: normal !important; /* 줄바꿈 허용 */
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
	td img {
	  max-width: 100%;
	  height: auto;
	  display: block;
	  margin-top: 10px;
	}
	.btn-wrapper {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		margin-top: 30px;
	}

	/* 가운데 버튼 그룹 */
	.center-btns {
		display: flex;
		justify-content: center;
		margin-top: 15px;
	}

	/* 오른쪽 버튼 */
	.right-btn {
		display: flex;
		justify-content: flex-end;
		margin-top: 20px;
	}

	/* 공통 버튼 스타일 */
	.btn-common {
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
	.center-btns,
	.right-btn {
		display: flex;
		align-items: center;
		gap: 0;
	}
	</style>
</head>
<body>
	<%@include file="/views/include/header.jsp"%>
	<div class="container">
		<h1>질의응답</h1>
		<table class="detail-table">
			<tr>
				<th style="width: 15%">No</th>
				<td style="width: 35%">${qna.qnaId }</td>
				<th style="width: 15%">작성일</th>
				<td style="width: 35%">${qna.regDate }</td>
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
					<td class="content-cell" colspan="3">${qna.content }</td>
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
			<div class="right-btn">
			<form action="<c:url value='/qna/view'/>" method="get">
				<button class="btn-common">목록</button>
			</form>
			</div>
			
			<div class="center-btns">
			<c:if test ="${qna.memberId eq loginMember.memberId}">
				<c:if test ="${qna.answerStatus eq '0'}">
					<form action="<c:url value='/qna/update'/>" method="get">
						<input type="hidden" name="no" value="${qna.qnaId}"/>
						<button class="btn-common">수정</button>
					</form>
				</c:if>
					<form action="<c:url value='/qna/delete'/>" method="get" onsubmit="return confirmDelete();">
						<input type="hidden" name="no" value="${qna.qnaId}"/>
						<button class="btn-common">삭제</button>
					</form>		
			</c:if>
			</div>
		</div>
		
	<script>
	// 삭제 전에 사용자에게 확인 메시지를 띄우는 함수
	function confirmDelete() {
		// confirm 창을 띄우고 결과를 반환
		return confirm("삭제하시겠습니까?");
	}
	</script>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>