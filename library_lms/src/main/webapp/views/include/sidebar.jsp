<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.sidebar {
  position: fixed;
  top: 100px; /* ✅ 헤더 높이만큼 아래로 */
  left: 0;
  width: 300px;
 height: calc(100vh - 0px); /* ← 그냥 고정 */
  background-color: #ffffff;
  color: #000;
  padding: 20px;
  font-family: sans-serif;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
  z-index: 1000;
  overflow-y: auto; /* ✅ 내용이 넘치면 스크롤 가능 */
}

  .sidebar .profile {
    text-align: center;
    margin-bottom: 20px;
    margin-top: 20px;
  }

  .sidebar .profile img {
    width: 95px;
    height: 100px;
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
  
  .check-buttons input[type="submit"] {
    background: none;
    border: none;
    color: #007bff;
    font-weight: bold;
    cursor: pointer;
    padding: 0;
    font-size: 16px;
    transition: color 0.2s;
  }

  .check-buttons input[type="submit"]:hover:not(:disabled) {
    color: #0056b3;
  }

  .check-buttons input[type="submit"]:disabled {
    color: gray;
    opacity: 0.5;
    text-decoration: none;
    cursor: default;
    font-weight: normal;
  }
  
  .status-text {
  	font-size: 13px;
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
    <c:if test="${ useStatus.status eq 0 }"><p class="status-text">현재 퇴실 상태입니다.</p></c:if>
    <c:if test="${ useStatus.status eq 1 }"><p class="status-text">현재 입실 상태입니다.</p></c:if>
    <c:if test="${ useStatus.status eq 2 }"><p class="status-text">현재 외출 상태입니다.</p></c:if>
  </div>
  
  <div class="check-buttons" style="display: flex; gap: 10px; justify-content: space-evenly; margin-bottom: 15px;">
	  <form id="check-in">
	    <c:if test="${ useStatus.status eq 0 }">
	      <input type="submit" value="입실" id="check-in-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 1 }">
	      <input type="submit" value="입실" id="check-in-input" disabled>
	    </c:if>
   	    <c:if test="${ useStatus.status eq 2 }">
	      <input type="submit" value="입실" id="check-in-input" disabled>
	    </c:if>
	  </form>
	
	  <form id="check-out">
	    <c:if test="${ useStatus.status eq 1 }">
	      <input type="submit" value="퇴실" id="check-out-input">
	    </c:if>
	    <c:if test="${ useStatus.status eq 0}">
	      <input type="submit" value="퇴실" id="check-out-input" disabled>
	    </c:if>
   	    <c:if test="${ useStatus.status eq 2}">
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
  
	<div class="logout-text" style="text-align: center; margin-top: 12px; margin-bottom: 20px;">
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
	    <a href="#">성적 관리<span class="material-symbols-outlined" style="vertical-align: middle;">arrow_drop_down</span></a>
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
	    <a href="#">마이페이지<span class="material-symbols-outlined" style="vertical-align: middle;">arrow_drop_down</span></a>
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
	  <div class="nav-item"><a href="<c:url value='/admin/tablet' />">태블릿</a></div>
	  <div class="nav-item"><a href="<c:url value='/qna/list/admin' />">질의응답 답변</a></div>
  	  <div class="nav-item"><a href="<c:url value='/notice/list' />">공지사항</a></div>
  
  </c:if>

  
  <div class="nav-item"><a href="<c:url value='/weatherservlet' />">날씨</a></div>
</div>

<script>
  window.addEventListener('scroll', function () {
    const sidebar = document.querySelector('.sidebar');
    const scrollY = window.scrollY || window.pageYOffset;

    // 100px 아래에 있다가 스크롤하면 점점 위로 올라오고, 최대 top: 0까지
    const newTop = Math.max(100 - scrollY, 0);
    sidebar.style.top = newTop + 'px';
    
    // height는 더 이상 조정하지 않음! ← 이게 핵심
  });
</script>


<c:set var="memberNo" value="${ loginMember.memberNo }"/>
		
<script>
$('#check-in').on('submit', (e) => {
	e.preventDefault();

    Swal.fire({
      title: '입실하시겠습니까?',
	  showCancelButton: true,
	  confirmButtonText: "입실",
	  cancelButtonText: `취소`,
	  confirmButtonColor: '#205DAC'
	}).then((result) => {
		if (result.isConfirmed) {
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
            	   Swal.fire({
                		  title: "입실 처리되었습니다.",
                		  icon: "success",
                		  confirmButtonText: '확인',
                		  confirmButtonColor: '#205DAC'
             		});
	               	if (data.res_code == 200) {
	                	$('#check-in-input').attr("disabled", true); 
	                	$('#check-out-input').removeAttr("disabled");
	                	$('#temp-input').removeAttr("disabled");
	                	$('.seat').toggleClass("disabled");
	                	$('.tablet').toggleClass("disabled");
	                	$(".status-text").text("현재 입실 상태입니다");
	               	}
	               }
			});	
		}
	});
});

$('#check-out').on('submit', (e) => {
	e.preventDefault();
	Swal.fire({
      title: '퇴실하시겠습니까?',
	  showCancelButton: true,
	  confirmButtonText: "퇴실",
	  cancelButtonText: `취소`,
	  confirmButtonColor: '#205DAC'
	}).then((result) => {
		if (result.isConfirmed) {
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
            	   Swal.fire({
                		  title: "퇴실 처리되었습니다.",
                		  icon: "success",
                		  confirmButtonText: '확인',
                		  confirmButtonColor: '#205DAC'
             		});
	               	if (data.res_code == 200) {
	                	$('#check-in-input').removeAttr("disabled");
	                	$('#check-out-input').attr("disabled", true);
	                	$('#temp-input').attr("disabled", true);
	                	$('.seat').toggleClass("disabled");
	                	$('.tablet').toggleClass("disabled");
	                	$(".status-text").text("현재 퇴실 상태입니다");
	               	}
	               }
			});		
		}
	});
});

$('#temp').on('submit', (e) => {
	e.preventDefault();
	const tempValue = $('#temp-input').val();
	if (tempValue === '외출') {
		const memberNo = ${ loginMember.memberNo };
		const check = 2;
		Swal.fire({
	      title: '외출하시겠습니까?',
		  showCancelButton: true,
		  confirmButtonText: "외출",
		  cancelButtonText: `취소`,
		  confirmButtonColor: '#205DAC'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: '/use/tempOut',
	                type: 'post',
	                data: {
	                    memberNo: memberNo,
	                    check: check
	                },
	                dataType: 'json',
	                success: (data) => {
	                	Swal.fire({
	                		  title: "외출 처리되었습니다.",
	                		  icon: "success",
	                		  confirmButtonText: '확인',
	                		  confirmButtonColor: '#205DAC'
	             		});
	                	if (data.res_code == 200) {
		                	$('#check-in-input').attr("disabled", true);
		                	$('#check-out-input').attr("disabled", true);
		                	$('#temp-input').removeAttr("disabled");	
		                	$('#temp-input').val('재입실');
		                	$(".status-text").text("현재 외출 상태입니다");
	                	}
	                }
				});	
			}
		});
	} else {
		const memberNo = ${ loginMember.memberNo };
		const check = 1;
		Swal.fire({
	      title: '재입실하시겠습니까?',
		  showCancelButton: true,
		  confirmButtonText: "재입실",
		  cancelButtonText: `취소`,
		  confirmButtonColor: '#205DAC'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: '/use/tempIn',
	                type: 'post',
	                data: {
	                    memberNo: memberNo,
	                    check: check
	                },
	                dataType: 'json',
	                success: (data) => {
	                	Swal.fire({
                		  title: "재입실 처리되었습니다.",
                		  icon: "success",
                		  confirmButtonText: '확인',
                		  confirmButtonColor: '#205DAC'
	             		});
	                	if (data.res_code == 200) {
		                	$('#check-in-input').attr("disabled", true);
		                	$('#check-out-input').removeAttr("disabled");
		                	$('#temp-input').removeAttr("disabled");	
		                	$('#temp-input').val('외출');	
		                	$(".status-text").text("현재 입실 상태입니다");
	                	}
	                }
				});
			}
		});
		
	}
});
</script>