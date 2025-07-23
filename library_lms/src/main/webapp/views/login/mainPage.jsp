<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main/main.css">
<style>
	
	.sidebars {
		width: 300px;
		height: 100vh;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
	}
	
	.container {
		flex: 1;
	}
	
	header {
		margin: 0 !important;
	}
	
	footer {
		margin-top: 0px !important;
	}
	
	.background-image {
		display: flex;
		align-items: flex-end;
		justify-content: center;
	}
	
	.notice-section, .qna-section {
		width: 35%;
		height: 235px;
		background-color: rgba(0, 0, 0, 0.5);
		padding: 20px;
		color: white;
		margin: 50px;
	}
	
	.section-header {
		display: flex;
		justify-content: space-between;
		border-bottom: 1px solid #fff;
		margin: 5px 40px 15px 40px;
		
	}
	.section-header strong {
		font-size: 25px;
		margin-bottom: 15px;
		margin-left: 15px;
	}
	.section-plus {
		font-size: 24px;
		margin-right: 15px;
		cursor: pointer;
	}
	.section-plus:hover {
		text-decoration: underline;
	}
	
	.section-row {
		display: flex;
		font-size: 18px;
		justify-content: space-between;
		margin: 8px 45px;
	}
	.link {
		cursor: pointer;
	}
	.link:hover {
		text-decoration: underline;
	}

</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<div class="background-image" style="background-image: url('<%= request.getContextPath() %>/images/wallpaper.gif'); background-repeat: no-repeat; height: 850px; background-size: cover;">
			    <!-- 공지사항 -->
			    <div class="notice-section">
			        <div class="section-header">
			            <strong>공지사항</strong>
			            <span class="section-plus" onclick="location.href='<c:url value="/notice/list"/>'">+</span>
			        </div>
			        <c:forEach var="notice" items="${noticeList}" varStatus="status" begin="0" end="4">
			            <div class="section-row">
			                <span onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'" class="link">${notice.title}</span>
			                <span>${notice.createAt}</span>
			            </div>
			        </c:forEach>
			    </div>
			
			    <!-- 질의응답 영역 -->
			    <div class="qna-section">
			        <div class="section-header">
			            <strong>질의응답</strong>
			            <span class="section-plus" onclick="location.href='<c:url value="/qna/view"/>'">+</span>
			        </div>
			        <c:forEach var="qna" items="${qnaList}" varStatus="status" begin="0" end="4">
			            <div class="section-row">
			                <span onclick="location.href='<c:url value="/qna/detail?no=${qna.qnaId }"/>'" class="link">${qna.title}</span>
			                <span>${qna.regDate}</span>
			            </div>
			        </c:forEach>
			    </div>
			    
			</div>
		</div>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>