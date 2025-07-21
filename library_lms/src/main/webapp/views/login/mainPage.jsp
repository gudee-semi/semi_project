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
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<div class="background-image" style="background-image: url('<%= request.getContextPath() %>/images/wallpaper.gif'); background-repeat: no-repeat; height: 945px">
				<div style="width: 50%; height: 300px; background-color: rgba(0, 0, 0, 0.3);"><span>공지사항</span></div>
				<div style="width: 50%; height: 300px; background-color: rgba(0, 0, 0, 0.3);"><span>질의응답</span></div>
			</div>
		</div>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>