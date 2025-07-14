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

	<!-- JSTL로 반복하며 사용 가능 개수 세기 -->
	<c:set var="usableCount" value="0"/>	
	<c:forEach var="t" items="${tabletList}">
	    <c:if test="${t.tabletAvailable == 1}">
	        <c:set var="usableCount" value="${usableCount + 1}"/>
	    </c:if>
	</c:forEach>
	<p>사용 가능 대수</p>
	<p>${usableCount}대</p>
	
	<!-- 버튼에 클래스, 태블릿 ID 등 부여 -->
	<c:forEach var="t" items="${tabletList}">
		<tr>
			<td>${t.tabletId}</td>
			<td><span class="tablet-status" id="status-${t.tabletId}">
					<c:choose>
						<c:when test="${t.tabletAvailable == 0}">
    					사용 가능<br>
  						</c:when>
						<c:otherwise>
    					사용 중<br>
  					</c:otherwise>
					</c:choose>
			</span></td>
		</tr>
	</c:forEach>
	
	<%-- 1. 먼저 전체 리스트 중 사용 가능한게 있는지 변수 선언 --%>
	<c:set var="canUse" value="false"/>
	
	<%-- 2. 리스트 전체에서 사용 가능한 게 있으면 canUse를 true로 --%>
	<c:forEach var="t" items="${tabletList}">
		<c:if test="${t.tabletAvailable == 0}">
			<c:set var="canUse" value="true"/>
		</c:if>	
	</c:forEach>
	
	<%-- 3. 버튼 하나만 보여주기 (상태에 따라 활성/비활성) --%>
	<c:choose>
		<%-- 4. 하나라도 사용 가능하면 활성화 --%>
		<c:when test="${canUse}">
			<form action="/tablet/view" method="post" style="display: inline;">
				<button id="use-btn" type="submit">사용하기</button>
			</form>
		</c:when>

		<%-- 5. 모두 사용 중이면 비활성화 --%>
    <c:otherwise>
        <button id="use-btn" disabled>사용 불가</button>
    </c:otherwise>  
	</c:choose>

</body>		
</html>