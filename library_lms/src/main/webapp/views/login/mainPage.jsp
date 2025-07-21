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
 		column-gap: 150px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

footer {
	margin-top: 0px !important;
}
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">메인페이지</div>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>