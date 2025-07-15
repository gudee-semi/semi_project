<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  int studentGrade = (session.getAttribute("studentGrade") != null) ? (Integer) session.getAttribute("studentGrade") : 1;
  int memberNo = (session.getAttribute("memberNo") != null) ? (Integer) session.getAttribute("memberNo") : -1;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>목표 성적 조회</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    body { font-family: 'Pretendard', sans-serif; margin: 40px; background: #fff; }
    h1 { text-align: center; font-size: 22px; font-weight: bold; margin-bottom: 30px; }
    .checkbox-group {
      display: flex; flex-wrap: wrap; gap: 15px 30px; margin: 0 10%;
      align-items: center;
    }
    label { font-size: 16px; }
    .exam-type { margin: 0 10px; }

    table { margin: 0 auto; border-collapse: collapse; font-size: 16px;}
    th, td { border: 1px solid #d1d5db; padding: 10px 18px; text-align: center;}
    #exam-title { text-align: center; margin-top: 42px; font-size: 18px;}
    #selected-subjects { text-align: center; margin-bottom: 20px; font-size: 16px;}
    #score-table { margin: 30px auto 0 auto; width: 70%; min-width: 520px; border-collapse: collapse; font-size: 17px; background: #fff; }
    #score-table th, #score-table td { border: 1px solid #bbb; padding: 20px 0; text-align: center; }
    #modal { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.32); z-index: 999; }
    .modal-content { background: #fff; padding: 24px; margin: 22% auto 0; width: 320px; border-radius: 10px; text-align: center; box-shadow: 0 6px 30px #2222; }
    #modal-close-btn { margin-top: 18px; padding: 7px 22px; border: none; background: #3b82f6; color: #fff; border-radius: 4px; font-size: 16px;}
  </style>
</head>
<body>

<h1>목표 성적</h1>

<!-- 💡 자바 변수 JS로 넘기기: 숨겨진 필드 -->
<input type="hidden" id="memberNo" value="<%= memberNo %>">
<input type="hidden" id="studentGrade" value="<%= studentGrade %>">

<!-- 시험 분류 체크박스 -->
<div>
  <label class="exam-type"><input type="checkbox" name="exam" value="3"> 3월</label>
  <label class="exam-type"><input type="checkbox" name="exam" value="6"> 6월</label>
  <label class="exam-type"><input type="checkbox" name="exam" value="9"> 9월</label>
  <label class="exam-type"><input type="checkbox" name="exam" value="11"> 11월(수능)</label>
</div>

<!-- 시험 제목 -->
<div id="exam-title"></div>
<div id="selected-subjects"></div>

<!-- 점수/등급 테이블 -->
<table id="score-table" style="display:none;">
  <thead>
    <tr><th>과목</th><th>원점수</th><th>등급</th></tr>
  </thead>
  <tbody id="score-body"></tbody>
</table>

<!-- 삭제 버튼 (비활성 상태) -->
<button id="delete-btn" disabled>삭제하기</button>

<!-- 외부 JS -->
<script src="../../js/goal_score_view.js"></script>

</body>
</html>
