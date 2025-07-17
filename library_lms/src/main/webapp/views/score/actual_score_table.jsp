<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<% 
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>

<h3><%= currentYear %>년 ${scores['0'].examTypeName}월 모의고사</h3>

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
          <td>${a.actualPercentage}</td>
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
