<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<% 
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>
 
<h3><%= currentYear%>년 ${scores['0'].examType}월 모의고사</h3>
<table>
	<tr>
		<th>과목</th>
		<th>원점수</th>
		<th>등급</th>
		
	</tr>

<c:forEach items="${scores}" var="s">
	<tr>
		<td>${s.subjectName}</td>
		<td>${s.targetScore}</td>
		<td>${s.targetLevel}</td>
	</tr>
	
	
</c:forEach>
</table>
	<!-- 삭제 버튼 (필요 시) -->
<form action="/goal_score/delete" method="get">
  <button id="delete-submit" class="btn">삭제하기</button>
</form>