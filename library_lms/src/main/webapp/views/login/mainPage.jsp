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
		width: 250px;
		height: 100vh;
}

.flex-container {
	display: flex;
	align-items: flex-start;
}

.container {
	width: 100%;
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

.background-image span {
	color: #ffffff;
	font-size: 20px;
	opacity: 1;
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
			<div class="background-image" style="background-image: url('<%= request.getContextPath() %>/images/wallpaper.gif'); background-repeat: no-repeat; height: 945px">
			    <!-- 공지사항 -->
			    <div style="width: 50%; height: 230px; background-color: rgba(0, 0, 0, 0.6); padding: 20px; color: white;">
			        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #fff; margin-bottom: 10px;">
			            <strong style="font-size: 20px;">공지사항</strong>
			            <span style="font-size: 24px; cursor: pointer;" onclick="location.href='<c:url value="/notice/list"/>'">+</span>
			        </div>
			        <c:forEach var="notice" items="${noticeList}" varStatus="status" begin="0" end="4">
			            <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
			                <span onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'" style="cursor: pointer;" class="link">${notice.title}</span>
			                <span>${notice.createAt}</span>
			            </div>
			        </c:forEach>
			    </div>
			
			    <!-- 질의응답 영역 -->
			    <div style="width: 50%; height: 230px; background-color: rgba(0, 0, 0, 0.6); padding: 20px; color: white;">
			        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #fff; margin-bottom: 10px;">
			            <strong style="font-size: 20px;">질의응답</strong>
			            <span style="font-size: 24px; cursor: pointer;" onclick="location.href='<c:url value="/qna/view"/>'">+</span>
			        </div>
			        <c:forEach var="qna" items="${qnaList}" varStatus="status" begin="0" end="4">
			            <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
			                <span onclick="location.href='<c:url value="/qna/detail?no=${qna.qnaId }"/>'" style="cursor: pointer;" class="link">${qna.title}</span>
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