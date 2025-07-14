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

<%-- tabletList/usingList 값 직접 출력 --%>
<c:forEach var="t" items="${tabletList}" varStatus="loop">
    tabletId: ${t.tabletId}, tabletAvailable: ${t.tabletAvailable}, memberNo: ${t.memberNo}, using: ${usingList[loop.index]}<br>
</c:forEach>
usable: ${usable} / btnPrinted: ${btnPrinted}
<hr/>

	<!-- 사용가능 대수 계산 -->
    <c:set var="usable" value="0"/>
    <c:forEach var="t" items="${tabletList}">
        <c:if test="${t.tabletAvailable == 0}">
            <c:set var="usable" value="${usable + 1}"/>
        </c:if>
    </c:forEach>
    <p>사용 가능 태블릿: ${usable}대</p>
    <hr/>

    <!-- 가장 앞의 내가 사용중인 태블릿을 찾으면 "사용중" 버튼만 표시 -->
<c:set var="btnPrinted" value="false"/>
<c:forEach var="t" items="${tabletList}" varStatus="loop">
    <c:if test="${not btnPrinted}">
        <c:choose>
            <%-- 내가 사용중이면 --%>
            <c:when test="${usingList[loop.index]}">
                <button type="button" disabled>사용중</button>
                <c:set var="btnPrinted" value="true"/>
            </c:when>
            <%-- 사용 가능한 태블릿 있으면 "사용하기" --%>
            <c:when test="${t.tabletAvailable == 0}">
                <form action="${pageContext.request.contextPath}/tablet/view" method="post" style="display:inline;">
                    <button type="submit">사용하기</button>
                </form>
                <c:set var="btnPrinted" value="true"/>
            </c:when>
        </c:choose>
    </c:if>
</c:forEach>
<!-- 만약 어떤 버튼도 안 찍혔으면(전부 사용중) "사용불가" -->
<c:if test="${not btnPrinted}">
    <button type="button" disabled>사용불가</button>
</c:if>
    
</body>		
</html>