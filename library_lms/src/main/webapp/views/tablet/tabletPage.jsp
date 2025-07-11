<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		
	<table>
	    <tr>
	        <th>tabletId</th>
	        <th>memberNo</th>
	        <th>사용여부</th>
	        <th>수정</th>
	    </tr>
	
	    <c:forEach var="t" items="${tabletList}">
	        <tr>
	            <td>${t.tabletId}</td>
	            <td>${t.memberNo}</td>
	            <td>${t.available}</td>
	            <td><a href="#">수정</a></td>
	        </tr>
	    </c:forEach>
	</table>
		
</body>		
</html>