<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태블릿 사용현황</title>

<style>
.container {
		width : 80vw;
		margin : 0 auto;	
	}
table {
	border-collapse: collapse;
	width: 100%;
	max-width: 1000px;
}
th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
}
th {
	border-bottom: 1px solid #666666;
	background: #FAFAFA;
}
tr:last-child td {
	border-bottom: none;
}
</style>

</head>
<body>
<%@ include file="/views/include/header.jsp" %>
	<div class="container">
		<h1>태블릿 사용현황</h1>
		<form action="/tablet/admin" method="post">
			<table style="border-collapse: collapse; width: 100%">
				<thead>
					<tr>
						<th>태블릿 No</th>
						<th>사용자</th>
						<th></th>
					</tr>
				</thead>
				
			    <tbody>
					<tr>
			        <c:forEach var="t" items="${tabletList }">
						<td style="width: 20%">${t.tabletId}</td>
						<c:if test="${t.tabletAvailable eq '1' }">
							<c:forEach var="tm" items="${tabletListm }">
								<c:if test="${t.memberNo eq tm.memberNo }">
									<td style="width: 40%">${tm.memberName}</td>
									<td style="width: 40%"><input type="checkbox" name="penalty" value="${tm.memberNo},${tm.tabletId}"></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${t.tabletAvailable eq '0'}">
							<td>-</td>
							<td><input type="checkbox" disabled></td>
							</tr>
						</c:if>
					</c:forEach>
			    </tbody>
			</table>
			<input type="submit" value="반납하기">
		</form>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>