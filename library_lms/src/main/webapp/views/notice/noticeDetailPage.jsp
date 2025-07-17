<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
		<h1>공지사항</h1>
		
		<table class="detail-table">
			<tr>
				<th>No</th>
				<td>${ notice.noticeId }</td>
				<th>작성일</th>
				<td>${ notice.createAt }</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>${ notice.category }</td>
				<th>작성자</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${ notice.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">${ notice.content }</td>
			</tr>
			<c:if test="${ not empty attach }">
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
				    	<img src="<c:url value='/notice/filePath?id=${ notice.noticeId }' />"><br>
				    	<a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName } 다운로드</a>						
					</td>
				</tr>
			</c:if>
		</table>
	</section>
	
	<a href="/notice/list">목록</a>
	
	<c:if test="${ memberNo eq 1 }">
		<a href="/notice/update?id=${ notice.noticeId }">수정</a>	
		
		<form id="noticeDeleteFrm">
			<input type="submit" value="삭제">
		</form>
	</c:if>	
	<c:set var="noticeId" value="${ notice.noticeId }"/>
	
	<script>
		$("#noticeDeleteFrm").on('submit', (e) => {
			e.preventDefault();
			
			const check = confirm('정말로 게시물을 삭제하시겠습니까?');
			
			if (check) {
				const noticeId = ${noticeId}
				
				$.ajax({
					 url: '/notice/delete',
	                 type: 'post',
	                 data: {
	                     noticeId: noticeId
	                 },
	                 dataType: 'json',
	                 success: (data) => {
	                	window.alert(data.res_msg);
	 					if (data.res_code == 200) {
	 						location.href = "<%= request.getContextPath() %>/notice/list";
	 					} else {						
	 						location.href = "<%= request.getContextPath() %>/notice/list";
	 					}
	                 }
				});
			}
		});
	</script>
</body>
</html>