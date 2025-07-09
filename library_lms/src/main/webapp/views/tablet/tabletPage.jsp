<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table border="1">
	
		<tr>
			<th>tabletId</th>
			<th>memberNo</th>
			<th>사용여부</th>
			<th>수정</th>
		</tr>

		<!-- tabletList.jsp -->
		<c:forEach var="t" items="${tabletList}">
			<tr>
				<td>${t.tabletId}</td>
				<td>${t.memberNo}</td>
				<td>${t.tabletAvailable}</td>
				<td>
					<form action="/tablet/update" method="post">
						<input type="hidden" name="tabletId" value="${t.tabletId}" /> <input
							type="hidden" name="available"
							value="${t.tabletAvailable == 'Y' ? 'N' : 'Y'}" />
						<button type="submit">변경</button>
					</form>
				</td>
			</tr>
		</c:forEach>
		
</body>		
</html>