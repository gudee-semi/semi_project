<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태블릿 사용현황</title>

<style>
table {
	border-collapse: collapse;
}
th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
}
th {
	border-bottom: 2px solid #666666;
	background: #FAFAFA;
}
tr:last-child td {
	border-bottom: none;
}
</style>

</head>
<body>
	<h1>태블릿 반납</h1>
	<table style="border-collapse: collapse; width: 100%">
		<thead>
			<tr>
				<th>태블릿 No</th>
				<th>사용자</th>
				<th></th>
			</tr>
		</thead>
	    <tbody>
	        <c:forEach var="t" items="${tabletList}" varStatus="status">
				<tr>
				<td>${t.tablet_id}</td>
				<c:forEach var="tl" items="${tabletLogList}">
					<c:if test="${t.memberNo eq tl.memberNo and tl.tablet_status == 1}">
						<td>${t.memberName}</td>
						<td><input type="checkbox" id="using" name="using" value="${t.memberNo}"></td>
					</c:if>
					<c:if test="${t.memberNo ne tl.memberNo and tl.tablet_status == 0}">
						<td></td>
						<td></td>
					</c:if>
				</c:forEach>
			</c:forEach>
	    </tbody>
	</table>
	
</body>
</html>