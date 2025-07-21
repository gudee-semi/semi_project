<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script> 
<style>
	
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
	
	.sidebars {
		width: 250px;
		height: 100vh;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
  		column-gap: 150px;
	}
	
	.container {
		width: 70%;
	}
	
	.btn {
    	border: none;
    	background-color: #205DAC;
   	    color: #fff;
    	border-radius: 6px;
    	cursor: pointer;
    	height: 40px;
    	transition: .2s;
    	margin: 0;
	}
	
	.btn:hover {
		background-color: #3E7AC8;
	}
	
	.conditional {
		display: flex;
		column-gap: 10px;
	}
	
	/*  하...   */
	header {
		margin: 0 !important;
	}
	
	h1 {
		margin-top: 50px;
	}
</style>
</head>
<body>
	<jsp:include page="/views/include/header.jsp" />
	
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<section class="content">
				<h1>공지사항</h1>
				
				<table class="detail-table" style="width: 90%">
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
						    	<img src="<c:url value='/notice/filePath?id=${ notice.noticeId }' /> " style="object-fit: cover; width: 100%; height: 100%"><br>
						    	<a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName } 다운로드</a>						
							</td>
						</tr>
					</c:if>
				</table>
			</section>
			
			<div class="conditional">
				<form action="/notice/list" method="get">
					<button class="btn">목록</button>
				</form>
				
				<c:if test="${ memberNo eq 1 }">
					<div>
						<form action="/notice/update" method="get">
						    <input type="hidden" name="id" value="${ notice.noticeId }">
						    <button type="submit" class="btn">수정</button>
						</form>
					</div>
					
					<form id="noticeDeleteFrm">
						<input type="submit" value="삭제" class="btn">
					</form>
				</c:if>					
			</div>
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
		</div>	
	</div>
	
	<jsp:include page="/views/include/footer.jsp" />
</body>
</html>