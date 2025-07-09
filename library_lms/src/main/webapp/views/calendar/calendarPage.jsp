<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>       
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학습 플래너</title>
	 <!-- FullCalendar CSS -->
  	<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/main.min.css' rel='stylesheet' />
  	<!-- FullCalendar JS -->
  	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
  	
  	
  	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  	
  	<!-- Google 머티리얼 아이콘 -->
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=close" />
  	
  	<style>
	    body {
	      margin: 40px 10px;
	      padding: 0;
	      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	      font-size: 14px;
	    }
	    
	    body h1 {
	    	width: 500px;
	    	margin: 0 auto 50px;
	    	text-align: center;
	    }
	
	    #calendar {
	      max-width: 1100px;
	      margin: 0 auto;
	    }
	    
	    .container-burger {
	    	width: 150px;
	    	margin: 200px auto 0px;
	    	text-align: center;
	    }
   
   
   	
   		/* --------------------- 모달 --------------------- */
		.modal {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
		  z-index: 9999;
		  background: rgba(0, 0, 0, 0.5);
		  display: none;
		  justify-content: center;
		  align-items: center;
		}
		
		.modal .modal-content {
		  width: 25%;
		  height: 50%;
		  background-color: #fff;
		  border-radius: 15px;
		  display: flex;
		  flex-direction: column;
		}
		
		.modal .modal-header {
		  background-color: #FFFFFF;
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  padding: 10px 30px;
		  border-radius: 15px 15px 0 0;
		}
		
		.modal .modal-header span {
		  cursor: pointer;
		  transition: 0.3s;
		}
		
		.modal .modal-header span:hover {
		  transform: scale(1.4);
		}
		
		.modal .modal-content .modal-body p {
		  margin: 10px 20px;
		}
		/* --------------------- 모달 --------------------- */
		
		
		
  	</style>
</head>
<body>
	<h1>학습 플래너</h1>
	
	<div id='calendar'></div>

	  <script>
	    document.addEventListener('DOMContentLoaded', function () {
	      var calendarEl = document.getElementById('calendar');
	
	      var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'timeGridWeek', // 주간 뷰만 보기
	        headerToolbar: {
	          left: 'prev,next today',
	          center: 'title',
	          right: '' // 다른 뷰 버튼 제거
	        },
	        locale: 'ko',
	        editable: false,
	        selectable: true,
	        allDaySlot: false,
	        events: [
	          {
	            title: '자바 공부',
	            start: '2025-07-10T10:00:00',
	            end: '2025-07-10T14:00:00',
	            description: '5장까지 마무리하기'
	          },
	          {
	            title: '운동',
	            start: '2025-07-11T15:00:00',
	            end: '2025-07-11T16:00:00'
	          }
	        ],
	        eventDidMount: function(info) {
	            // 설명 추가
	            if (info.event.extendedProps.description) {
	              var descriptionEl = document.createElement('div');
	              descriptionEl.innerText = info.event.extendedProps.description;
	              descriptionEl.style.fontSize = '0.8em';
	              descriptionEl.style.marginTop = '4px';
	              descriptionEl.style.color = '#555';

	              // FullCalendar가 만들어준 카드에 추가
	              info.el.querySelector('.fc-event-title').appendChild(descriptionEl);
	            }
	          }
	      });
	
	      calendar.render();
	    });
	  </script>
	  
	  
	  
	  
	  <div class="container-burger">
	  	<div>
	  		<button type="button" class="btn-atd">출석</button>	
	  	</div>
	  	<div>
	  		<button type="button" class="btn-add">작성</button>
	  	</div>
	  	<div>
			<button type="button" class="btn-burger">햄버거</button>	  	  	
	  	</div>
	  </div>
	  
	  
	  
    <div class="modal modal-1">
    	<div class="modal-content">
      		<div class="modal-header font-en">
      			<span></span>
        		<span class="material-symbols-outlined btn-add-close">close</span>
      		</div>
     		 <div class="modal-body">
     		 	<form id="todo-input">
	        		<p>할 일 목록</p>
	        		<input type="text" class="todo-input-title">
	        		<br>
	        		<p>날짜</p>
	        		<input type="date" class="todo-input-date">
	        		<br>
	        		<p>상세 내용</p>
	        		<textarea rows="10" cols="20" class="todo-input-detail"></textarea>
	        		<br>
	        		<button type="submit">할 일 목록 추가</button>     		 	
     		 	</form>
      		</div>
    	</div>
  	</div>
  	
  	<script>
	  	const readmeBtn1 = document.querySelector('.btn-add');
	  	const readmePopUp1 = document.querySelector('.modal.modal-1');
	  	const readmeClose1 = document.querySelector('.modal.modal-1 .btn-add-close');
	  	const todoForm = document.querySelector('#todo-input');
	  	readmeBtn1.addEventListener('click', () => {
	  		readmePopUp1.style.display = 'flex';
	  	});
	  	readmeClose1.addEventListener('click', () => {
	  		readmePopUp1.style.display = 'none';
	  	});
	  	todoForm.addEventListener('submit', () => {
	  		readmePopUp1.style.display = 'none';
	  	})
  	</script>
	<script>
		
		$('#todo-input').on('submit', (e) => {
			
			e.preventDefault();
			
			const todoTitle = $('.todo-input-title').val();
			const todoDate = $('.todo-input-date').val();
			const todoDetail = $('.todo-input-detail').val();
			
			if (!todoTitle) {
				window.alert('제목은 필수 항목입니다.');
			} else if (!todoDate) {
				window.alert('날짜는 필수 항목입니다.');
			} else {
				console.log(todoTitle);
				console.log(todoDate);
				console.log(todoDetail);
				
				$.ajax({
					
					url: '/calendar/view',
					type: 'post',
					data: {
						todoTitle: todoTitle,
						todoDate: todoDate,
						todoDetail: todoDetail
					},
					dataType: 'json',
					success: (data) => {
						console.log(data);
					},
					error: () => {
						
					}					
					
				})
			}
			
		})
		
	
	</script>
	  
	 
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
</body>
</html>