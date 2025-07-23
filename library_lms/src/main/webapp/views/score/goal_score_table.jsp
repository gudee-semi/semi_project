<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<% 
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>


 
<h3><%= currentYear%>년 ${scores['0'].examType}월 모의고사</h3>
	<!-- 선택된 과목 목록 표시 영역 -->
	<div id="selected-subjects" style="height: 50px">
		<c:forEach items="${scores}" var="g" varStatus="st">
		    <span style="font-weight : 400">${g.subjectName}</span>
		    <c:if test="${!st.last}">  |  </c:if>
		</c:forEach>
	</div>
<table>
	<tr>
		<th>과목</th>
		<th>원점수</th>
		<th>등급</th>
	</tr>

<c:forEach items="${scores}" var="g">
	<tr>
		<td>${g.subjectName}</td>
		<td>${g.targetScore}</td>
		<td>${g.targetLevel}</td>
	</tr>
	
	
</c:forEach>
</table>
