<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<% 
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>

<h2 style="text-align: center; font-size: 27px;"><%= currentYear %>년 ${scores['0'].examTypeName}월 모의고사</h2>
	<!-- 선택된 과목 목록 표시 영역 -->
	<div id="selected-subjects" style="height: 50px">
		<c:forEach items="${scores}" var="g" varStatus="st">
		    <span style="font-weight : 400">${g.subjectName}</span>
		    <c:if test="${!st.last}">  |  </c:if>
		</c:forEach>
	</div>


<div>
  <table id="score-table">
    <thead>
      <tr>
        <th>과목</th>
        <th>원점수</th>
        <th>등급</th>
        <th>백분위</th>
        <th>학교 석차</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${scores}" var="a">
        <tr>
          <td>${a.subjectName}</td>
          <td>${a.actualScore}</td>
          <td>${a.actualLevel}</td>
          <td>
            <c:choose>
              <c:when test="${a.subjectName == '영어' || a.subjectName == '한국사' || a.subjectName == '독일어' || a.subjectName == '프랑스어' || a.subjectName == '스페인어' || a.subjectName == '중국어' || a.subjectName == '일본어' || a.subjectName == '러시아어' || a.subjectName == '아랍어' || a.subjectName == '베트남어' || a.subjectName == '한문'}">
                -
              </c:when>
              <c:otherwise>${a.actualPercentage}</c:otherwise>
            </c:choose>
          </td>
          <td>
            <c:choose>
              <c:when test="${a.subjectName == '국어' || a.subjectName == '수학'}">${a.actualRank}</c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
