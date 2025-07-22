<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
  .sidebar {
    width: 250px;
    background-color: #ffffff;
    color: #000;
    padding: 20px;
    height: 100%;
    font-family: sans-serif;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
  }

  .sidebar .profile {
    text-align: center;
    margin-bottom: 10px;
  }

  .sidebar .profile img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 5px;
  }

  .sidebar h2 {
    text-align: center;
    margin-bottom: 15px;
    font-size: 18px;
  }

  .divider {
    height: 1px;
    background-color: #ddd;
    margin: 15px 0;
  }

  .nav-item {
    margin-bottom: 10px;
  }

  .nav-item > a {
    color: #000;
    text-decoration: none;
    display: block;
    padding: 10px;
    border-radius: 6px;
    transition: all 0.2s ease-in-out;
  }

  .nav-item > a:hover {
    background-color: #f0f0f0;
    box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.1);
  }

  .dropdown {
    position: relative;
  }

  .dropdown-content {
    display: none;
    margin-top: 5px;
    padding-left: 10px;
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }

  .dropdown-content a {
    background-color: #fff;
    color: #000;
    padding: 8px;
    display: block;
    margin: 3px 0;
    border-radius: 4px;
    font-size: 13px;
    transition: background-color 0.2s ease-in-out;
  }

  .dropdown-content a:hover {
    background-color: #f0f0f0;
  }

  .disabled {
    pointer-events: none;
    opacity: 0.5;
  }
</style>

<div class="sidebar">
  <div class="profile">
  	<c:if test="${ empty useStatus }">
	    <img src="/images/admin.jpg" alt="프로필 이미지">  	
  	</c:if>
  	<c:if test="${ not empty useStatus }">  	
	    <img src="/images/test.jpg" alt="프로필 이미지">  	
  	</c:if>
    <h2>${loginMember.memberName}</h2>
  </div>
  
  <div class="check-buttons" style="display: flex; gap: 10px; justify-content: center; margin-bottom: 15px;">
	  <form id="check-in">
	    <c:if test="${ useStatus.status eq 0 }">
	      <input type="submit" value="입실" id="check-in-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 1 || useStatus.status eq 2 }">
	      <input type="submit" value="입실" id="check-in-input" disabled>
	    </c:if>
	  </form>
	
	  <form id="check-out">
	    <c:if test="${ useStatus.status eq 1 }">
	      <input type="submit" value="퇴실" id="check-out-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 0 || useStatus.status eq 2 }">
	      <input type="submit" value="퇴실" id="check-out-input" disabled>
	    </c:if>
	  </form>
	
	  <form id="temp">
	    <c:if test="${ useStatus.status eq 1 }">
	      <input type="submit" value="외출" id="temp-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 2 }">
	      <input type="submit" value="재입실" id="temp-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 0 }">
	      <input type="submit" value="외출" id="temp-input" disabled>
	    </c:if>
	  </form>
  </div>
  
	<div class="logout-text" style="text-align: center; margin-top: 12px;">
	  <a href="/logout" style="
	    font-size: 13px;
	    color: #555;
	    text-decoration: none;
	    transition: color 0.2s, text-decoration 0.2s;
	  "
	  onmouseover="this.style.textDecoration='underline'; this.style.color='#000';"
	  onmouseout="this.style.textDecoration='none'; this.style.color='#555';"
	  >
	    로그아웃
	  </a>
	</div>

  <div class="divider"></div>
  
  <c:if test="${ not empty useStatus }">
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
	    <a href="<c:url value='/seat/view' />" class="<c:if test='${useStatus.status eq 0 || loginMember.memberSeat == 1}'>disabled</c:if> seat">좌석</a>
	  </div>
	
	  <div class="nav-item">
	    <a href="<c:url value='/tablet/view' />" class="<c:if test='${useStatus.status eq 0}'>disabled</c:if> tablet">태블릿</a>
	  </div>
	
	  <div class="nav-item"><a href="<c:url value='/notice/list' />">공지사항</a></div>
	  <div class="nav-item"><a href="<c:url value='/qna/view' />">질의응답</a></div>
	
	  <div class="nav-item dropdown">
	    <a href="#">마이페이지</a>
	    <div class="dropdown-content">
	      <a href="<c:url value='/mypage/password/input' />">개인정보 수정</a>
	      <a href="<c:url value='/myqna/view' />">나의 문의 내역</a>
	    </div>
	  </div>  
  </c:if>
  <c:if test="${ empty useStatus }">
	  <div class="nav-item dropdown">
  	   <a href="#">회원목록</a>
	  	  <div class="dropdown-content">
	  	  	<a href="<c:url value='/user/signup' />">회원 등록</a>
		   	<a href="<c:url value='/user/delete' />">회원 목록</a>
		   	<a href="<c:url value='/admin/member/delete' />">회원 계정 목록</a>
	  	  </div>
  	  </div>
	  <div class="nav-item"><a href="<c:url value='/admin/abort' />">강제퇴실</a></div>
	  <div class="nav-item"><a href="<c:url value='/admin/fixed-seat' />">좌석지정</a></div>
	  <div class="nav-item"><a href="<c:url value='/qna/list/admin' />">질의응답 답변</a></div>
  	  <div class="nav-item"><a href="<c:url value='/notice/list' />">공지사항</a></div>
  
  </c:if>

  
  <div class="nav-item"><a href="<c:url value='/weatherservlet' />">날씨</a></div>
</div>


<c:set var="memberNo" value="${ loginMember.memberNo }"/>
		
<script>
$('#check-in').on('submit', (e) => {
	e.preventDefault();
	const checker1 = confirm('입실하시겠습니까?');
	if (checker1) {
		const memberNo = ${ loginMember.memberNo };
		const check = 1;
		
		$.ajax({
			url: '/use/checkIn',
               type: 'post',
               data: {
                   memberNo: memberNo,
                   check: check
               },
               dataType: 'json',
               success: (data) => {
               	window.alert(data.res_msg);
               	if (data.res_code == 200) {
                	$('#check-in-input').attr("disabled", true); 
                	$('#check-out-input').removeAttr("disabled");
                	$('#temp-input').removeAttr("disabled");
                	$('.seat').toggleClass("disabled");
                	$('.tablet').toggleClass("disabled");
               	}
               }
		});					
	}
});

$('#check-out').on('submit', (e) => {
	e.preventDefault();
	const checker2 = confirm('퇴실하시겠습니까?');
	if (checker2) {
		const memberNo = ${ loginMember.memberNo };
		const check = 0;
		
		$.ajax({
			url: '/use/checkOut',
               type: 'post',
               data: {
                   memberNo: memberNo,
                   check: check
               },
               dataType: 'json',
               success: (data) => {
               	window.alert(data.res_msg);
               	if (data.res_code == 200) {
                	$('#check-in-input').removeAttr("disabled");
                	$('#check-out-input').attr("disabled", true);
                	$('#temp-input').attr("disabled", true);
                	$('.seat').toggleClass("disabled");
                	$('.tablet').toggleClass("disabled");
               	}
               }
		});					
	}
});

$('#temp').on('submit', (e) => {
	e.preventDefault();
	const tempValue = $('#temp-input').val();
	if (tempValue === '외출') {
		const memberNo = ${ loginMember.memberNo };
		const check = 2;
		const checker3 = confirm('외출하시겠습니까?');
		
		if (checker3) {
			$.ajax({
				url: '/use/tempOut',
                type: 'post',
                data: {
                    memberNo: memberNo,
                    check: check
                },
                dataType: 'json',
                success: (data) => {
                	window.alert(data.res_msg);
                	if (data.res_code == 200) {
	                	$('#check-in-input').attr("disabled", true);
	                	$('#check-out-input').attr("disabled", true);
	                	$('#temp-input').removeAttr("disabled");	
	                	$('#temp-input').val('재입실');	
                	}
                }
			});																	
		}
		
	} else {
		const memberNo = ${ loginMember.memberNo };
		const check = 1;
		const checker3 = confirm('재입실하시겠습니까');
		
		if (checker3) {
			$.ajax({
				url: '/use/tempIn',
                type: 'post',
                data: {
                    memberNo: memberNo,
                    check: check
                },
                dataType: 'json',
                success: (data) => {
                	window.alert(data.res_msg);
                	if (data.res_code == 200) {
	                	$('#check-in-input').attr("disabled", true);
	                	$('#check-out-input').removeAttr("disabled");
	                	$('#temp-input').removeAttr("disabled");	
	                	$('#temp-input').val('외출');	
                	}
                }
			});							
		}
		
	}
});
</script>