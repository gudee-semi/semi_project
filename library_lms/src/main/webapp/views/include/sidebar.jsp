<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>    
<script>
window.onpageshow = function(event){   // onpageshow는 page 호출되면 캐시든 아니든 무조건 호출된다.
    if (event.persisted || (window.performance && window.performance.navigation.type == 2)){
        // 사파리 or 안드로이드에서 뒤로가기로 넘어온 경우 캐시를 이용해 화면을 보여주는데, 
        // 이때 사파리의 경우 event.persisted 가 ture다. 
        // 그외 브라우저(크롬 등)에서는 || 뒤에 있는 조건으로 뒤로가기인지 체크가 가능하다!
        window.location.reload();
    }
};
</script>
   <style>



    body {
    
      font-weight: bolder;
    }

    body a {
      color: inherit !important;
    }

    .dropdown-menu {
      position: static !important;
      display: none;
      margin-top: 10px;
    }
    .dropdown-menu.show {
      display: block;
      transform: none !important;
    }
    .dropdown-item {
      text-align: center;
    }

    .use {
      width: 20%;
      border-radius: 50%;
    }

    body > div > div:nth-child(3) {
      width: 50% !important;
    }
    
    .disabled {
    	pointer-events: none;
    	opacity: 0.6;
    }


  </style>
</head>

<body>
	<div class="container text-center">

	    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" class="img-fluid use" alt="...">
	
	    <div class="col">${ loginMember.memberName }</div>
	
		<div class="container text-center">
			<div class="row align-items-start">
			    <div class="col">
			    	<form id="check-in">
			    		<c:if test="${ useStatus.status eq 0 }"><input type="submit" value="입실" id="check-in-input"></c:if>
			    		<c:if test="${ useStatus.status eq 1 }"><input type="submit" value="입실" id="check-in-input" disabled="disabled"></c:if>
			    		<c:if test="${ useStatus.status eq 2 }"><input type="submit" value="입실" id="check-in-input" disabled="disabled"></c:if>
			    	</form>
			    </div>
   			    <div class="col">
			    	<form id="check-out">
			    		<c:if test="${ useStatus.status eq 0 }"><input type="submit" value="퇴실" id="check-out-input" disabled="disabled"></c:if>
			    		<c:if test="${ useStatus.status eq 1 }"><input type="submit" value="퇴실" id="check-out-input"></c:if>
			    		<c:if test="${ useStatus.status eq 2 }"><input type="submit" value="퇴실" id="check-out-input" disabled="disabled"></c:if>
			    	</form>
			    </div> 
    			<div class="col">
			    	<form id="temp">
			    		<c:if test="${ useStatus.status eq 0 }"><input type="submit" value="외출" id="temp-input" disabled="disabled"></c:if>
			    		<c:if test="${ useStatus.status eq 1 }"><input type="submit" value="외출" id="temp-input"></c:if>
	    			    <c:if test="${ useStatus.status eq 2 }"><input type="submit" value="재입실" id="temp-input"></c:if>			    		
			    	</form>	    			    
			    </div>			    
		    </div>			
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

     	<div class="container text-center">
  			<div class="row align-items-start">
    			<div class="col">로그아웃</div>
  			</div>
		</div>    
		
		<ul class="nav flex-column">
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/calendar/view' />">학습플래너</a>
	        </li>
	        
		    <li class="nav-item dropdown">
		    	<a class="nav-item dropdown-toggle" href="#" role="button" aria-expanded="false" data-bs-toggle="dropdown" data-bs-auto-close="false">성적 관리</a>
		    	<ul class="dropdown-menu">
			        <li><a class="dropdown-item" href="<c:url value='/goal_score/view' />">목표 성적 입력</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/goal_score_view/view' />">목표 성적 조회</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/actual_scorePage/view' />">성적 입력</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/analysis_scorePage/view' />">성적 조회 및 분석</a></li>
		    	</ul>
		    </li>
		    
		    <c:if test="${ useStatus.status eq 0 }">
	   	        <li class="nav-item">
		        	<a class="dropdown-item disabled seat" href="<c:url value='/seat/view' />">좌석</a>
		        </li>            		    
		    </c:if>
   		    <c:if test="${ (useStatus.status eq 1) or (useStatus.status eq 2) }">
	   	        <li class="nav-item">
		        	<a class="dropdown-item seat" href="<c:url value='/seat/view' />">좌석</a>
		        </li>            		    
		    </c:if>
		    
		    <c:if test="${ useStatus.status eq 0 }">
		        <li class="nav-item">
		        	<a class="dropdown-item disabled tablet" href="<c:url value='/tablet/view' />">태블릿</a>
		        </li>		    
		    </c:if>
   		    <c:if test="${ (useStatus.status eq 1) or (useStatus.status eq 2) }">
		        <li class="nav-item">
		        	<a class="dropdown-item tablet" href="<c:url value='/tablet/view' />">태블릿</a>
		        </li>		    
		    </c:if>
		    
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/notice/list' />">공지사항</a>
	        </li>
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/qna/view' />">질의응답</a>
	        </li>
	        
	       	<li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/qna/list/admin' />">질의응답 관리자페이지</a>
	        </li>
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/weatherservlet' />">날씨</a>
	        </li>
	        
     	    <li class="nav-item">
	        	<a class="nav-item dropdown-toggle" href="#" role="button" aria-expanded="false" data-bs-toggle="dropdown" data-bs-auto-close="false">마이페이지</a>
	        	<ul class="dropdown-menu">
			        <li><a class="dropdown-item" href="<c:url value='/mypage/password/input' />">개인정보 수정</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/myqna/view' />">나의 문의 내역</a></li>
			   
		    	</ul>
	        </li>
        </ul>
	</div>
	
</body>
