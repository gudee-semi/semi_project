<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  // 상위 페이지에서 setAttribute로 넘겨준 studentGrade 값 가져오기
  int studentGrade = (request.getAttribute("studentGrade") != null)
                     ? (Integer) request.getAttribute("studentGrade")
                     : 1; // 기본값: 1학년
%>

    
<!-- dday.js cdn -->
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/locale/ko.js"></script>

<style>
	.dday-container {
    display: flex;
    gap: 30px;
    margin: 40px auto;
    justify-content: center;
    font-family: 'Pretendard', sans-serif;
  }

  .dday-card {
    background: #fff;
    padding: 20px 28px;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    min-width: 400px;
    max-width: 400px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

	.dday-top, .dday-main {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  margin-bottom: 4px;
	}

  .dday-title {
  	font-size: 17px;
 	 font-weight: bold;
	}

  .dday-value {
	  font-size: 22px;
	  font-weight: bold;
	  color: #dc2626;
	}
	
</style>


<!-- 카드가 추가될 위치 -->
<div class="dday-container" id="dday-wrapper"></div>

<!-- 분리된 JS 파일 연결 -->
<script src="../../js/dday.js"></script>
