<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 조회 및 분석</title>

 	<!-- jQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    /* 기본 스타일 설정 */
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
<h1>성적 조회 및 분석</h1>

<!-- 로그인 정보 숨겨서 JS에서 참조 -->
<%-- <input type="hidden" id="memberNo" value="<%= memberNo %>">
<input type="hidden" id="studentGrade" value="<%= studentGrade %>"> --%>

<!-- 시험 분류 체크박스 동적 생성 -->
<div class="checkbox-group" id="exam-options">
  <span style="font-weight: 500;">시험 분류</span>
 <c:forEach var="exam" items="${examTypeList}">
  <label>
    <input type="checkbox" name="exam" class="exam-type" value="${exam.examTypeId}" />
    ${exam.examType}월
  </label>
 </c:forEach>
</div>

<!-- 선택된 시험 제목 표시 영역 -->
<div id="exam-title"></div>

<!-- 선택된 과목 목록 표시 영역 -->
<div id="selected-subjects"></div>


<button id="delete-submit" class="btn">삭제하기</button>


<!-- 별도 JS 파일 불러오기 -->
<script src="../../js/analysis_score.js"></script>



</body>
</html>