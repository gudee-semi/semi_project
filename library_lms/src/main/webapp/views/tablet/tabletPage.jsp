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

	<!-- 사용가능 대수 계산 -->
	<c:set var="usable" value="0" />

	<c:forEach var="t" items="${tabletList}">

		<c:if test="${t.tabletAvailable == 0}">
			<c:set var="usable" value="${usable + 1}" />
		</c:if>

	</c:forEach>

	<%-- 1. 가장 앞에서 버튼이 출력됐는지 체크하는 플래그(초기값 false) --%>
	<c:set var="btnPrinted" value="false" />

	<%-- 2. 태블릿 리스트 반복 --%>
	<c:forEach var="t" items="${tabletList}" varStatus="loop">
		<%-- 3. 아직 버튼이 한 번도 출력되지 않았다면 --%>
		<c:if test="${not btnPrinted}">

			<%-- 3-1. 내가 사용중인 태블릿이면 "사용중" 버튼 --%>
			<c:if test="${usingList[loop.index]}">
				<%-- "반납하기" 버튼: 활성화 상태! --%>
				<form id="returnForm-${t.tabletId}"
					action="${pageContext.request.contextPath}/tablet/return"
					method="post" style="display: inline;"
					onsubmit="return confirmReturn();">
					<input type="hidden" name="tabletId" value="${t.tabletId}" />
					<p>태블릿을 사용중입니다</p>
					<p>사무실에서 수령해주세요</p>
					<button type="submit">반납하기</button>
				</form>


				<c:set var="btnPrinted" value="true" />
			</c:if>

			<%-- 3-2. 내가 사용중이 아니고, 사용 가능한 태블릿(available==0)이면 "사용하기" 버튼 --%>
			<c:if test="${not usingList[loop.index] and t.tabletAvailable == 0}">
				<form id="useForm-${t.tabletId}"
					action="${pageContext.request.contextPath}/tablet/use"
					method="post" style="display: inline;"
					onsubmit="return confirmUse();">
					<input type="hidden" name="tabletId" value="${t.tabletId}" />
					<p>사용 가능 대수</p>
					<p>${usable}대</p>
					<button type="submit">사용하기</button>
				</form>


				<c:set var="btnPrinted" value="true" />
			</c:if>

			<%-- 3-3. 둘 다 아니면 아무것도 출력하지 않음(넘어감) --%>
		</c:if>
	</c:forEach>

	<%-- 4. 반복문 끝나고도 btnPrinted가 false면(즉, 모든 태블릿이 사용중) "사용불가" 버튼 한 번만 --%>
	<c:if test="${not btnPrinted}">
		<button type="button" disabled>사용불가</button>
	</c:if>


	<script>
		function confirmUse() {
    	return confirm("태블릿을 사용하시겠습니까?");
		}
	</script>

	<script>
	function confirmReturn() {
    return confirm("태블릿을 반납하시겠습니까?");
	}
	</script>



</body>		
</html>