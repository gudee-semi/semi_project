<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${not empty tabletList}">
		<p>리스트 있음</p>
	</c:if>
	<c:if test="${empty tabletList}">
		<p>리스트 없음</p>
	</c:if>

	<table border="1">
	
		<tr>
			<th>tabletId</th>
			<th>memberNo</th>
			<th>사용여부</th>
			<th>수정</th>
		</tr>

		<c:forEach var="t" items="${tabletList}">
			<tr id="row-${t.tabletId}">
				<td>${t.tabletId}</td>
				<td>${t.memberNo}</td>
				<td class="available-status">${t.tabletAvailable}</td>
				<td>
					<button class="update-btn" data-tablet-id="${t.tabletId}"
						data-available="${t.tabletAvailable == 'Y' ? 'N' : 'Y'}">
						상태 변경</button>
				</td>
			</tr>
		</c:forEach>
	</table>



</body>
</html>