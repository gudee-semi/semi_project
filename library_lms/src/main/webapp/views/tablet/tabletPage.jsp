<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<c:forEach var="t" items="${tabletList}">
		<tr>
			<td>${t.tabletId}</td>
<%-- 			<td>${t.memberNo}</td> --%>
			<td>${t.tabletAvailable}</td>
		</tr>
		<br>
	</c:forEach>

	<!-- JSTL로 반복하며 사용 가능 개수 세기 (조금 복잡) -->
	<c:set var="usableCount" value="0"/>
	<c:forEach var="t" items="${tabletList}">
	    <c:if test="${t.tabletAvailable == 1}">
	        <c:set var="usableCount" value="${usableCount + 1}"/>
	    </c:if>
	</c:forEach>
	<p>사용 가능한 태블릿: ${usableCount}개</p>



</body>		
</html>