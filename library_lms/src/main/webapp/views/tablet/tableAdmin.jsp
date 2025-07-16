<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
				<th>회원 이름</th>
				<th>반납여부</th>
			</tr>
		</thead>
	    <tbody>
	        <c:forEach var="t" items="${tabletList}">
	            <tr style="cursor:pointer;"
	                onclick="location.href='/qna/admin?qnaId=${t.qnaId}'">
	                <td>${t.qnaId}</td>
	                <td>${t.category}</td>
	                <td>${t.modDate}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	
</body>
</html>