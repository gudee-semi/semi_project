<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>       
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학습 플래너</title>
	 <!-- FullCalendar 라이브러리 -->
  	<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/main.min.css' rel='stylesheet' />
  	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
  	<!-- jquery -->
  	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  	<!-- Google 머티리얼 아이콘 -->
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=close" />
  	<!-- CSS -->
  	<link rel="stylesheet" type="text/css" href="/css/calendar/calendar.css">
</head>
<body>
	<h1>학습 플래너</h1>
	
	<div id='calendar'></div>

	<script>
	  
	  	let calendar;
	  	
	  	const todoList = [
	  		<c:forEach var="todo" items="${todoList}">
		  	  {
		  	    title: '${todo.title}',
		  	    start: '${todo.dueDate}',
		  	    extendedProps: {
		  	      planner_id: '${todo.plannerId}',
		  	      description: '${todo.detail}',
		  	      is_completed: ${todo.isCompleted}
		  	    }
		  	  },
		  	</c:forEach>
	  	  ];
	  	
	  	console.log(todoList);
	  	
	  	function addSmartEvent(todo) {
	  	  const todoDate = todo.start.split('T')[0]; // '2025-07-10'

	  	  const existingEvents = calendar.getEvents().filter(event => {
	  	    return event.startStr.startsWith(todoDate);
	  	  });

	  	  let startTime = todoDate + 'T00:00:00';
	  	  let endTime = todoDate + 'T04:00:00';

	  	  if (existingEvents.length > 0) {
	  	    existingEvents.sort((a, b) => a.end - b.end);
	  	    const lastEventEnd = existingEvents[existingEvents.length - 1].end;
	  	    const nextStart = new Date(lastEventEnd);
	  	    const nextEnd = new Date(nextStart);
	  	    nextEnd.setHours(nextEnd.getHours() + 4);
	  	    startTime = nextStart.toISOString();
	  	    endTime = nextEnd.toISOString();
	  	  }

	  	  calendar.addEvent({
	  	    title: todo.title,
	  	    start: startTime,
	  	    end: endTime,
	  	    extendedProps: {
	  	      planner_id: todo.extendedProps.planner_id,
	  	      description: todo.extendedProps.description,
	  	      is_completed: todo.extendedProps.is_completed
	  	    }
	  	  });
	  	}
	  	

	    document.addEventListener('DOMContentLoaded', function () {
      	var calendarEl = document.getElementById('calendar');
	
      	calendar = new FullCalendar.Calendar(calendarEl, {
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
	          },
	          eventClick: (info) => {
	        	  // 기존 팝업 제거
	        	  $('.event-popup').remove();

	        	  const event = info.event;
	        	  const plannerId = event.extendedProps.planner_id;
	        	  const eventEl = info.el;
	        	  const offset = $(eventEl).offset(); // 클릭한 이벤트 위치

	        	  // 1. HTML 먼저 만듦 (style 없음)
	        	  const popup = $(`
	        	    <div class="event-popup">
	        	      <button class="edit-btn">수정</button>
	        	      <button class="delete-btn">삭제</button>
	        	    </div>
	        	  `);

	        	  // 2. CSS 스타일은 JS로 따로 설정
	        	  popup.css({
	        	    position: 'absolute',
	        	    top: offset.top,
	        	    left: offset.left + $(eventEl).outerWidth() + 10,
	        	    background: 'white',
	        	    border: '1px solid #ccc',
	        	    padding: '8px',
	        	    borderRadius: '8px',
	        	    zIndex: 9999,
	        	    boxShadow: '0px 2px 10px rgba(0,0,0,0.1)'
	        	  });

	        	  // 3. 페이지에 붙이기
	        	  $('body').append(popup);

	        	  // 4. 이벤트 바인딩
	        	  popup.find('.edit-btn').on('click', () => {
        		  	readmePopUp2.style.display = 'flex';
        		  	
        		  	const editTitle = event.title;
        		  	const editDate = event.startStr.split('T')[0];
        		  	const editDetail = event.extendedProps.description;
        		  	
        		  	$('.todo-update-title').val(editTitle);
        		  	$('.todo-update-date').val(editDate);
        		  	$('.todo-update-detail').val(editDetail);
        		  	
        		  	$('#todo-update').off('submit').on('submit', (e) => {
        				e.preventDefault();
        				const todoTitle = $('.todo-update-title').val();
        				const todoDate = $('.todo-update-date').val();
        				const todoDetail = $('.todo-update-detail').val();
        				
        				if (!todoTitle) {
        					window.alert('제목은 필수 항목입니다.');
        				} else if (!todoDate) {
        					window.alert('날짜는 필수 항목입니다.');
        				} else {
        					$.ajax({
        						url: '/calendar/update',
        						type: 'post',
        						data: {
        							todoTitle: todoTitle,
        							todoDate: todoDate,
        							todoDetail: todoDetail,
        							plannerId: plannerId
        						},
        						dataType: 'json',
        						success: (data) => {
        							console.log(data.res_msg);
        							if (data.res_code == '200') {
        								window.alert('할 일 목록이 수정되었습니다.');
        								
     							
     								  	event.remove();

     								  // 새로 만든 todo 객체로 스마트하게 다시 추가
	     								const newTodo = {
	     								    title: todoTitle,
	     								    start: todoDate,
	     								    extendedProps: {
	     								    	planner_id: plannerId,
	     								    	description: todoDetail,
	     								    	is_completed: event.extendedProps.is_completed
	     								  	}
	     								};
	     								event.remove();

     								    addSmartEvent(newTodo); // ✅ 우리가 만든 시간 배치 함수로 등록

     								    readmePopUp2.style.display = 'none'; // 모달 닫기
        							} else {
        								window.alert('오류!');
        							}
        						}
        					})
        				}
        			})
        		  	
	        	    console.log('수정:', plannerId);
	        	    popup.remove();
	        	  });

	        	  popup.find('.delete-btn').on('click', () => {
	        		  $.ajax({
	        			  
        				url: '/calendar/delete',
	  					type: 'post',
	  					data: {
	  						plannerId: plannerId 
	  					},
	  					dataType: 'json',
	  					success: (data) => {
							console.log('삭제:', plannerId);
							console.log(data.res_msg);
							if (data.res_code == '200') {
								window.alert('할 일 목록이 삭제되었습니다.');
				        	    event.remove();
							} else {
								window.alert('오류!');
							}
	  					}
	        		  })    		  
	        	    popup.remove();
	        	  });
	        	}

	      });
	
	      calendar.render();
	      
	      todoList.forEach(todo => {
	          addSmartEvent(todo);
	        });
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
  	
	<div class="modal modal-2">
    	<div class="modal-content">
      		<div class="modal-header font-en">
      			<span></span>
        		<span class="material-symbols-outlined btn-add-close">close</span>
      		</div>
     		 <div class="modal-body">
     		 	<form id="todo-update">
	        		<p>할 일 목록</p>
	        		<input type="text" class="todo-update-title">
	        		<br>
	        		<p>날짜</p>
	        		<input type="date" class="todo-update-date">
	        		<br>
	        		<p>상세 내용</p>
	        		<textarea rows="10" cols="20" class="todo-update-detail"></textarea>
	        		<br>
	        		<button type="submit">할 일 목록 수정</button>     		 	
     		 	</form>
      		</div>
    	</div>
  	</div>
  	
  	<script>
	  	const readmeBtn1 = document.querySelector('.btn-add');
	  	const readmePopUp1 = document.querySelector('.modal.modal-1');
	  	const readmePopUp2 = document.querySelector('.modal.modal-2');
	  	const readmeClose1 = document.querySelector('.modal.modal-1 .btn-add-close');
	  	const readmeClose2 = document.querySelector('.modal.modal-2 .btn-add-close');
	  	const todoForm = document.querySelector('#todo-input');
	  	const updateForm = document.querySelector('#todo-update');
	  	readmeBtn1.addEventListener('click', () => {
	  		readmePopUp1.style.display = 'flex';
	  	});
	  	readmeClose1.addEventListener('click', () => {
	  		$('.todo-input-title').val('');
			$('.todo-input-date').val('');
			$('.todo-input-detail').val('');
	  		readmePopUp1.style.display = 'none';
	  	});
	  	readmeClose2.addEventListener('click', () => {
	  		readmePopUp2.style.display = 'none';
	  	});
	  	todoForm.addEventListener('submit', () => {
	  		readmePopUp1.style.display = 'none';
	  	});
	  	updateForm.addEventListener('submit', () => {
	  		readmePopUp2.style.display = 'none';
	  	});
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
						console.log(data.res_msg);
						console.log(data.planner_id);
						if (data.res_code == '200') {
							
							window.alert('할 일 목록 등록 성공');
							
							const existingEvents = calendar.getEvents().filter(event => {
								  return event.startStr.startsWith(todoDate); // '2025-07-09' 같은 날짜로 필터
								});
							
						    let startTime = todoDate + 'T00:00:00';
						    let endTime = todoDate + 'T04:00:00';
						    
						    if (existingEvents.length > 0) {
						    	  // 끝나는 시간 기준으로 정렬 (latest 끝 시간 찾기)
						    	  existingEvents.sort((a, b) => a.end - b.end);
						    	  const lastEventEnd = existingEvents[existingEvents.length - 1].end;

						    	  // 3. 다음 이벤트의 시작 시간 = 마지막 끝나는 시간
						    	  const nextStart = new Date(lastEventEnd);
						    	  const nextEnd = new Date(nextStart);
						    	  nextEnd.setHours(nextEnd.getHours() + 4);

						    	  startTime = nextStart.toISOString();
						    	  endTime = nextEnd.toISOString();
						    	}
						    
						    
					        calendar.addEvent({
				          		title: todoTitle,
				          		start: startTime,
				          		end: endTime,
					        	allDay: false,
					        	extendedProps: {
					          		description: todoDetail,
					          		planner_id: data.planner_id
					        	}
				      		});	
							
						} else {
							window.alert('오류!');
						}
					},
					error: () => {
						
					}					
					
				})
				
				
			}
			
		})
		
	</script>
	
	 
</body>
</html>