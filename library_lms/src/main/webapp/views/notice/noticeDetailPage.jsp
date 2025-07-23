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
/* 항상 가장 먼저 */
html, body {
	margin: 0;
	padding: 0;
	font-family: 'Arial', sans-serif; /* 선택사항 */
	box-sizing: border-box;
}
.container {
	width : 70%;
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
	display: inline-block; /* ✅ a 태그는 기본 inline이라 block처럼 보이게 */
	text-align: center;     /* ✅ 텍스트 가운데 정렬 */
	text-decoration: none;  /* ✅ 밑줄 제거 */
	
	display: inline-block;
	padding: 10px 20px;
	margin: 0 8px;
	border: none;
	border-radius: 4px;
	font-size: 15px;
	cursor: pointer;
	color: rgba(255, 255, 255, 1);
}
.btn-common:hover {
	background-color: #3E7AC8;
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
   	line-height: 40px;      /* ✅ 버튼 높이에 맞춰 수직 중앙 정렬 */
   	text-align: center;
   	text-decoration: none;
}
.center-btns,
.right-btn {
	display: flex;
	align-items: center;
	gap: 0;
}

/*  하...   */
.sidebars {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
 	column-gap: 100px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

h1 {
	margin-top: 50px;
}

footer {
	margin-top: 0px !important;
}

.nav-item {
	padding: 5px;
}
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp"%>
	
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>	
		<div class="container">
			<h1>공지사항</h1>
			
			<table class="detail-table">
				<tr>
					<th style="width: 15%">No</th>
					<td style="width: 35%">${ notice.noticeId }</td>
					<th style="width: 15%">작성일</th>
					<td style="width: 35%">${ notice.createAt }</td>
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
					<th class="content">내용</th>
					<td class="content-cell" colspan="3">${ notice.content }</td>
				</tr>
				
				<c:if test="${ not empty attach }">
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
					    	<a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName }</a><br>						
					    	<img src="<c:url value='/notice/filePath?id=${ notice.noticeId }'/>"><br>
						</td>
					</tr>
				</c:if>
			</table>
				
				<div class="right-btn" style="margin-bottom: 70px;">
					<form action="<c:url value='/notice/list'/>" method="get">
						<button class="btn-common">목록</button>
					</form>
				</div>
		
			<div class="center-btns" style="margin-bottom: 100px;">
				<c:if test="${ memberNo eq 1 }">
					<a href="/notice/update?id=${ notice.noticeId }" class="btn-common">수정</a>	
					
					
					<form id="noticeDeleteFrm">
						<input type="hidden">
						<button class="btn-common">삭제</button>
					</form>
				</c:if>	
				<c:set var="noticeId" value="${ notice.noticeId }"/>
			</div>			
		</div>
		
	</div>
	
	<%@ include file="/views/include/footer.jsp"%>
	
	<script>
		$("#noticeDeleteFrm").on('submit', (e) => {
			e.preventDefault();
			
			Swal.fire({
              title: '게시글을 삭제하시겠습니까?',
              icon: 'warning',
              text: '삭제한 게시글은 복구할 수 없습니다',
          	  showCancelButton: true,
          	  confirmButtonText: "삭제",
          	  cancelButtonText: `취소`,
          	  confirmButtonColor: '#205DAC'
          	}).then((result) => {
          		if (result.isConfirmed) {
        			const noticeId = ${noticeId}
    				
    				$.ajax({
    					 url: '/notice/delete',
    	                 type: 'post',
    	                 data: {
    	                     noticeId: noticeId
    	                 },
    	                 dataType: 'json',
    	                 success: (data) => {
    	 					if (data.res_code == 200) {
    	 						Swal.fire({
   	 				              title: "게시글이 삭제되었습니다",
   	 				              icon: "success",
   	 				              confirmButtonText: '확인',
   	 				              confirmButtonColor: '#205DAC'
   	 				            }).then(() => {   	 				            	
	    	 						location.href = "<%= request.getContextPath() %>/notice/list";
   	 				            })
    	 					} else {
    	 						Swal.fire({
   	 				              title: "게시글 삭제에 실패했습니다",
   	 				              icon: "error",
   	 				              confirmButtonText: '확인',
   	 				              confirmButtonColor: '#205DAC'
   	 				            }).then(() => {   	 				            	
	    	 						location.href = "<%= request.getContextPath() %>/notice/list";
   	 				            });
    	 					}
    	                 }
    				});
          		}
          	});
		});
	</script>
</body>
</html>