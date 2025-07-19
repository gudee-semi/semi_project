<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
  .sidebar {
    width: 250px;
    background-color: #2c3e50;
    color: white;
    padding: 20px;
    height: 100vh;
  }

  .sidebar h2 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 18px;
  }

  .nav-item {
    margin-bottom: 10px;
  }

  .nav-item > a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 10px;
    background-color: #34495e;
    border-radius: 4px;
    font-size: 14px;
  }

  .nav-item > a:hover {
    background-color: #1abc9c;
  }

  .dropdown {
    position: relative;
  }

  .dropdown-content {
    display: none;
    margin-top: 5px;
    padding-left: 15px;
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }

  .dropdown-content a {
    background-color: #3e5369;
    padding: 8px;
    display: block;
    margin: 4px 0;
    border-radius: 4px;
    font-size: 13px;
  }

  .dropdown-content a:hover {
    background-color: #16a085;
  }

  .disabled {
    pointer-events: none;
    opacity: 0.5;
  }
</style>

<div class="sidebar">
  <h2>${loginMember.memberName}</h2>

  <div class="nav-item"><a href="<c:url value='/calendar/view' />">학습플래너</a></div>

  <div class="nav-item dropdown">
    <a href="#">성적 관리</a>
    <div class="dropdown-content">
      <a href="<c:url value='/goal_score/view' />">목표 성적 입력</a>
      <a href="<c:url value='/goal_score_view/view' />">목표 성적 조회</a>
      <a href="<c:url value='/actual_scorePage/view' />">성적 입력</a>
      <a href="<c:url value='/analysis_scorePage/view' />">성적 분석</a>
    </div>
  </div>

  <div class="nav-item">
    <a href="<c:url value='/seat/view' />" class="<c:if test='${useStatus.status eq 0}'>disabled</c:if> seat">좌석</a>
  </div>

  <div class="nav-item">
    <a href="<c:url value='/tablet/view' />" class="<c:if test='${useStatus.status eq 0}'>disabled</c:if> tablet">태블릿</a>
  </div>

  <div class="nav-item"><a href="<c:url value='/notice/list' />">공지사항</a></div>
  <div class="nav-item"><a href="<c:url value='/qna/view' />">질의응답</a></div>
  <div class="nav-item"><a href="<c:url value='/qna/list/admin' />">QnA 관리자</a></div>
  <div class="nav-item"><a href="<c:url value='/weatherservlet' />">날씨</a></div>
  <div class="nav-item"><a href="<c:url value='/admin/fixed-seat' />">고정좌석 관리자</a></div>
  <div class="nav-item"><a href="<c:url value='/admin/abort' />">강제퇴실</a></div>

  <div class="nav-item dropdown">
    <a href="#">마이페이지</a>
    <div class="dropdown-content">
      <a href="<c:url value='/mypage/password/input' />">개인정보 수정</a>
      <a href="<c:url value='/myqna/view' />">나의 문의 내역</a>
    </div>
  </div>
</div>
