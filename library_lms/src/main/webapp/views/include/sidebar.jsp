<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>    

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

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


  </style>
</head>

<body>
	<div class="container text-center">

	    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" class="img-fluid use" alt="...">
	
	    <div class="col">홍길동</div>
	
		<div class="container text-center">
			<div class="row align-items-start">
			    <div class="col">입실</div>
			    <div class="col">퇴실</div>
			    <div class="col">외출</div>
		    </div>
		</div>

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
			        <li><a class="dropdown-item" href="<c:url value='/goal_score/view' />">목표성적</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/write_score/view' />">성적입력</a></li>
			        <li><a class="dropdown-item" href="<c:url value='/analysis_score/view' />">성적분석</a></li>
		    	</ul>
		    </li>
		    
   	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/seat/view' />">좌석</a>
	        </li>            
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/tablet/view' />">태블릿</a>
	        </li>
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/notice/list' />">공지사항</a>
	        </li>
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/qna/view' />">질의응답</a>
	        </li>
	        
	       	<li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/qna/view/admin' />">질의응답 관리자페이지</a>
	        </li>
	        
	        <li class="nav-item">
	        	<a class="dropdown-item" href="<c:url value='/admin/fixed-seat' />">좌석관리 관리자페이지</a>
	        </li>
	        
     	    <li class="nav-item">
	        	<a class="dropdown-item" href="#">마이페이지</a>
	        </li>
        </ul>
	</div>
	
</body>
