<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/calendar/calendar.css">
<!-- 팝업 캘린더 라이브러리 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
	/* 세로 그리드 라인 부드럽게 */
	.fc .fc-timegrid-col {
	  border-left: 1px solid #eee;
	  border-right: 1px solid #eee;
	}
	
	.fc-toolbar-title,
	.fc-col-header-cell-cushion {
		font-weight: normal;
	}
	
	.fc-day-today .fc-col-header-cell-cushion {
		font-weight: bold;
		color: #205DAC;
	}

	.sidebars {
		width: 300px;
		height: 1000px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
  		column-gap: 100px;
	}
	
	.container {
		width: 70%;
		height: 1200px;
	}
	
	.sidebar {
		height: 1200px !important;
	}
	
	.calendar-icon {
		font-size: 30px;
	}
	
	/* modal... */
	.todo-input-title,
	.todo-update-title,
	.todo-detail-title {
	    width: 90%;
	    height: 30px;
	    margin: 0 auto;
	    display: block;
	    box-sizing: border-box;
	    padding-left: 10px;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    background-color: #fff;
	    font-size: 15px;
	    transition: box-shadow 0.3s ease, border-color 0.3s ease;
	    outline: none;
	}
	
	/* 포커스 효과 */
	.todo-input-title:focus,
	.todo-update-title:focus {
	    border-color: #66afe9;
	    box-shadow: 0 2px 10px rgba(102, 175, 233, 0.4);
	}
	
	.todo-input-date,
	.todo-update-date,
	.todo-detail-date {
	    height: 30px;
	    margin: 0 auto;
	    display: block;
	    box-sizing: border-box;
	    padding-left: 10px;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    background-color: #fff;
	    font-size: 14px;
	    transition: box-shadow 0.3s ease, border-color 0.3s ease;
	    outline: none;
	    width: 90%;
	}
	
	/* 포커스 시 효과 */
	.todo-input-date:focus,
	.todo-update-date:focus {
	    border-color: #66afe9;
	    box-shadow: 0 2px 10px rgba(102, 175, 233, 0.4);
	}
	
	.todo-input-detail,
	.todo-update-detail,
	.todo-detail-detail {
	    width: 90%;
	    margin: 0 auto;
	    display: block;
	    box-sizing: border-box;
	    resize: none;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    padding-left: 12px;
	    padding-top: 12px;
	    padding-bottom: 12px;
	    background-color: #fff;
	    transition: box-shadow 0.3s ease, border-color 0.3s ease;
	    outline: none;
	}
	
	.todo-input-add,
	.todo-input-update,
	.todo-input-delete {
	    width: 90%;
	    margin: 0 auto;
	    display: block;
	    color: white;
	    background-color: #205DAC;
	    border-color: transparent;
	    border-radius: 6px;
	    height: 40px;
	    font-size: 18px;
	    cursor: pointer;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    transition: background-color 0.3s ease;
	}
	
	.todo-input-add:hover,
	.todo-input-update:hover,
	.todo-input-delete:hover {
		background-color: #3E7AC8;
	}
	
	input[type="date"]::-webkit-calendar-picker-indicator {
	  position: relative;
	  left: -5px; /* ← 이 값으로 왼쪽으로 밀 수 있어 */
	  cursor: pointer;
	  filter: invert(0.5);
	  transform: scale(1.5); /* ← 아이콘 자체 크기 키우기 */
	}

	/* 포커스 효과 */
	.todo-input-detail:focus,
	.todo-update-detail:focus {
	    border-color: #66afe9;
	    box-shadow: 0 4px 12px rgba(102, 175, 233, 0.4);
	}
	
	.edit-btn,
	.detail-btn {
		border-color: transparent;
    	background-color: #205DAC;
    	color: white;
    	border-radius: 3px;
    	cursor: pointer;
	}
	
	.delete-btn {
	    border-color: transparent;
    	border-radius: 3px;
    	cursor: pointer;
	}
	
	.my-div::-webkit-scrollbar {
	  width: 8px; /* 세로 스크롤바 너비 */
	}
	
	.my-div::-webkit-scrollbar-thumb {
	  background-color: #ccc;  /* 스크롤 손잡이 색 */
	  border-radius: 4px;
	}
	
	.my-div::-webkit-scrollbar-track {
	  background-color: transparent;  /* 스크롤바 배경 */
	  border-radius: 4px;
	}
	
	/*  하...   */
	header {
		margin: 0 !important;
	}
	
	h1 {
		margin-top: 50px;
	}
	
	footer {
		margin-top: 0px !important;
	}
	
	.nav-item {
		padding: 5px;
	}
	
	.time-cover {
		position: absolute;
	    top: 289px;
	    left: 0px;
	    height: 816px;
	    background-color: #fff;
	    z-index: 10;
	    pointer-events: none;
	}
	
	.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr {
		margin-left: 77px;
	}
	
	.fc-event-time {
		display: none;
	}	
	
	.fc-event-title.fc-sticky {
		margin-top: 16px !important;
		margin-left: 5px !important;
		font-size: 16px !important;
	}
	
	.flatpickr-day.selected.attendance {
		background: #4582EC !important;
		color: white !important;
		border-radius: 50% !important;
		border-color: #4582EC !important;
		z-index: 2;
	}
	
	.flatpickr-day.selected.today.attendance {
		background: #4582EC !important;
		color: white !important;
		border-radius: 50% !important;
		border-color: #4582EC !important;
		z-index: 2;
	}
	
	.flatpickr-day.today {
    	border-color: transparent !important;
	}
	
</style>
</head>
<body>
	<jsp:include page="/views/include/header.jsp" />
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>학습 플래너</h1>
			<div id='calendar' style="margin-left: 100px;"></div>
			<div class="time-cover"></div>
			
			<script>
				function updateCoverWidth() {
				  const cover = document.querySelector('.time-cover');
				  const screenWidth = window.innerWidth;

				  const baseScreen = 1350; // 기준 화면 너비
				  const baseWidth = 576;   // 기준 커버 width

				  let newWidth = baseWidth;

				  if (screenWidth < baseScreen) {
				    const diff = baseScreen - screenWidth;
				    const shrinkRatio = 0.3; // ← 줄어드는 속도 조절 (0.5 = 2px 줄면 1px 줄어듦)

				    newWidth = baseWidth - (diff * shrinkRatio);

				    // 최소 너비 제한
				    if (newWidth < 200) newWidth = 200;
				  }

				  cover.style.width = newWidth + 'px';
				}

				// 초기 실행
				updateCoverWidth();
				// 리사이즈 이벤트에 연결
				window.addEventListener('resize', updateCoverWidth);
				
				
			</script>
			
			
			
			
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
			
				function addSmartEvent(todo) {
				    const todoDate = todo.start.split('T')[0]; // '2025-07-10'
			
				    const existingEvents = calendar.getEvents().filter(event => {
				        return event.startStr.startsWith(todoDate);
				    });
			
				    let startTime = todoDate + 'T00:00:00';
				    let endTime = todoDate + 'T03:00:00';
			
				    if (existingEvents.length > 0) {
				        existingEvents.sort((a, b) => a.end - b.end);
				        const lastEventEnd = existingEvents[existingEvents.length - 1].end;
				        const nextStart = new Date(lastEventEnd);
				        const nextEnd = new Date(nextStart);
				        nextEnd.setHours(nextEnd.getHours() + 3);
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
				            left: 'title',
				            center: '',
				            right: 'prev,next' // 다른 뷰 버튼 제거
				        },
				        locale: 'ko',
				        editable: false,
				        selectable: true,
				        allDaySlot: false,
				        windowResize: false,
				        scrollTime: 0,
				        eventTimeFormat: {
				            month: 'short',
				            day: 'numeric',
				            weekday: 'short',
				            locale: 'ko'
				        },
				        buttonText: {
				        	  today: '이번 주',
			        	},
				        eventDidMount: function (info) {
			
				            const event = info.event;
				            const el = info.el;
				            const titleEl = el.querySelector('.fc-event-title');
				            const timeEl = el.querySelector('.fc-event-time');
			
				            const eventDate = event.start;
				            const formattedDate = eventDate.getMonth() + 1 + '월 ' + eventDate.getDate() + '일';
				            timeEl.style.color = '#000000';
			
				            el.style.backgroundColor = 'transparent';
				            titleEl.style.fontWeight = 'bold';
				            titleEl.style.fontSize = '14px';
				            if (event.extendedProps.is_completed === 1) {
				                el.style.border = '3px solid #205DAC';
				                el.style.backgroundColor = 'rgba(209, 224, 255, 0.15)';
				                titleEl.style.color = '#205DAC';
				                if (descriptionEl) {
				                    descriptionEl.style.color = '#205DAC';
				                }
				            } else if (event.extendedProps.is_completed === 0) {
				                el.style.border = '3px solid grey';
				                titleEl.style.color = 'grey';
				                if (descriptionEl) {
				                    descriptionEl.style.color = 'grey';
				                }
				            }
			
			
				            // 체크박스 생성
				            const checkbox = document.createElement('input');
				            checkbox.type = 'checkbox';
				            checkbox.checked = event.extendedProps.is_completed === 1;
			
				            checkbox.addEventListener('change', () => {
				                const plannerId = info.event.extendedProps.planner_id;
				                const isCompleted = checkbox.checked ? 1 : 0;
			
				                // 여기에 AJAX 보내는 코드 넣으면 됨!
				                $.ajax({
				                    url: '/calendar/check',
				                    type: 'post',
				                    data: {
				                        plannerId: plannerId,
				                        isCompleted: isCompleted
				                    },
				                    dataType: 'json',
				                    success: (data) => {
				                        // (1) is_completed UI 반영
				                        if (isCompleted === 1) {
				                            el.style.border = '3px solid #205DAC';
				                            el.style.backgroundColor = 'rgba(209, 224, 255, 0.15)';
				                            titleEl.style.color = '#205DAC';
				                            if (descriptionEl) {
				                                descriptionEl.style.color = '#205DAC';
				                            }
				                        } else {
				                            el.style.border = '3px solid grey';
				                            titleEl.style.color = 'grey';
				                            if (descriptionEl) {
				                                descriptionEl.style.color = 'grey';
				                            }
				                        }
			
				                        // (2) 이벤트 객체 값 업데이트
				                        event.setExtendedProp('is_completed', isCompleted);
				                    }
				                })
				            });
			
				            checkbox.addEventListener('click', (e) => {
				                e.stopPropagation();
				            });
			
				            // 스타일: 우측 상단 고정
				            checkbox.style.position = 'absolute';
				            checkbox.style.top = '4px';
				            checkbox.style.right = '6px';
				            checkbox.style.zIndex = '10';
				            checkbox.style.transform = 'scale(1.2)';
				            checkbox.title = '완료 체크';
			
				            // 카드에 체크박스 추가
				            info.el.appendChild(checkbox);
			
				            // 설명 추가
				            if (info.event.extendedProps.description) {
				                var descriptionEl = document.createElement('div');
				                descriptionEl.className = 'my-div';
				                descriptionEl.innerText = info.event.extendedProps.description;
				                descriptionEl.style.fontSize = '0.7em';
				                descriptionEl.style.marginTop = '4px';
				                descriptionEl.style.maxHeight = '90px';
				                descriptionEl.style.overflowY = "auto";
			
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
					        	    <button class="detail-btn">상세</button>
					        	    <br>
					        	    <button class="edit-btn" style="margin-top: 5px;">수정</button>
					        	    <br>
					        	    <button class="delete-btn" style="margin-top: 5px;">삭제</button>
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
				            
				            // 팝업 외부를 클릭 시 닫기
				            setTimeout(() => {
					            $(document).on('click', (e) => {
					            	if ($(e.target).closest('.event-popup').length === 0) {
					            		popup.remove();
					            		$(document).off('click');
					            	}
					            });
			            	}, 0);
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
				                    const dateToRearrange = editDate;
				                    const todoTitle = $('.todo-update-title').val();
				                    const todoDate = $('.todo-update-date').val();
				                    const todoDetail = $('.todo-update-detail').val();
			
				                    if (!todoTitle) {
				        				Swal.fire({
				        					title: "제목은 필수 항목입니다.",
				        					icon: "error",
				        					confirmButtonText: '확인',
				        					confirmButtonColor: '#205DAC'
				        				});
				                    } else if (!todoDate) {
				        				Swal.fire({
				        					title: "날짜는 필수 항목입니다.",
				        					icon: "error",
				        					confirmButtonText: '확인',
				        					confirmButtonColor: '#205DAC'
				        				});
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
				                                if (data.res_code == '200') {
				        		                	Swal.fire({
														title: " ",
														text: "할 일 목록이 수정되었습니다.",
														icon: "success",
														confirmButtonText: '확인',
														confirmButtonColor: '#205DAC'
				      	                			});
				        		                	
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
			
				                                    addSmartEvent(newTodo); // 우리가 만든 시간 배치 함수로 등록
			
				                                    const date = dateToRearrange;
				                                    const eventsToReAdd = [];
			
				                                    calendar.getEvents().forEach(e => {
				                                        if (e.startStr.startsWith(date)) {
				                                            eventsToReAdd.push({
				                                                title: e.title,
				                                                start: date,
				                                                extendedProps: e.extendedProps
				                                            });
				                                            e.remove();
				                                        }
				                                    });
			
				                                    // 재정렬해서 다시 추가
				                                    eventsToReAdd.forEach(todo => addSmartEvent(todo));
				                                } else {
				                                	Swal.fire({
								                		  title: " ",
								                		  text: "할 일 목록 수정이 실패했습니다.",
								                		  icon: "error",
								                		  confirmButtonText: '확인',
								                		  confirmButtonColor: '#205DAC'
							                		});
				                                }
				                            }
				                        })
				                    }
				                });
				                popup.remove();
				            });
				            
				            popup.find('.detail-btn').on('click', () => {
				                readmePopUp4.style.display = 'flex';
			
				                const editTitle = event.title;
				                const editDate = event.startStr.split('T')[0];
				                const editDetail = event.extendedProps.description;
			
				                $('.todo-detail-title').val(editTitle);
				                $('.todo-detail-date').val(editDate);
				                $('.todo-detail-detail').val(editDetail);
				                
				                popup.remove();
				            });
			
				            popup.find('.delete-btn').on('click', () => {
				            	popup.remove();
				            	
				                const deleteTitle = event.title;
				                const deleteDate = event.startStr.split('T')[0];

				                Swal.fire({
				                  title: " ",
				                  text: '[' + deleteDate + '] ' + deleteTitle + ' 을(를) 삭제하시겠습니까?',
			                	  showCancelButton: true,
			                	  confirmButtonText: "삭제",
			                	  cancelButtonText: `취소`,
			                	  confirmButtonColor: '#205DAC'
			                	}).then((result) => {
			                		if (result.isConfirmed) {
						                $.ajax({
						                    url: '/calendar/delete',
						                    type: 'post',
						                    data: {
						                        plannerId: plannerId
						                    },
						                    dataType: 'json',
						                    success: (data) => {
						                        if (data.res_code == '200') {
						                        	Swal.fire({
								                		  title: " ",
								                		  text: "할 일 목록 삭제가 성공했습니다.",
								                		  icon: "success",
								                		  confirmButtonText: '확인',
								                		  confirmButtonColor: '#205DAC'
							                		}).then(() => {
							                            event.remove();
							                            location.reload();										                			
							                		});
						                        } else {
								                	Swal.fire({
								                		  title: " ",
								                		  text: "할 일 목록 삭제가 실패했습니다.",
								                		  icon: "error",
								                		  confirmButtonText: '확인',
								                		  confirmButtonColor: '#205DAC'
							                		});
						                        }
						                    }
						                });
						                popup.remove();
			                		}
			                	})
				         
				            	
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
			  <div class="floating-buttons">
			    <div>
			      <button type="button" class="btn-atd">
			        <span class="material-symbols-outlined calendar-icon">event_available</span>
			      </button>
			    </div>
			    <div>
			      <button type="button" class="btn-add">
			        <span class="material-symbols-outlined calendar-icon">assignment_add</span>
			      </button>
			    </div>
			  </div>
			  <div>
			    <button type="button" class="btn-burger">
			      <span class="material-symbols-outlined calendar-icon">menu</span>
			    </button>
			  </div>
			</div>
			
			<script>
			  const burgerBtn = document.querySelector('.btn-burger');
			  const container = document.querySelector('.container-burger');
			
			  burgerBtn.addEventListener('click', () => {
			    container.classList.toggle('active');
			  });
			</script>
			
			<input type="text" id="calendarPop" style="opacity: 0; position: absolute;" readonly="readonly" />
		
		    <div class="modal modal-1">
		    	<div class="modal-content">
		      		<div class="modal-header font-en">
		      			<span></span>
		        		<span class="material-symbols-outlined btn-add-close">close</span>
		      		</div>
		     		 <div class="modal-body">
		     		 	<form id="todo-input">
			        		<p>할 일 목록</p>
			        		<input type="text" class="todo-input-title" required oninvalid="setCustomMessage(this, '제목은 필수항목입니다.')" oninput="setCustomMessage(this, '')">
			        		<br>
			        		<p>날짜</p>
			        		<input type="date" class="todo-input-date" required oninvalid="setCustomMessage(this, '날짜는 필수항목입니다.')" oninput="setCustomMessage(this, '')">
			        		<br>
			        		<p>상세 내용</p>
			        		<textarea rows="10" cols="20" class="todo-input-detail"></textarea>
			        		<br>
			        		<button type="submit" class="todo-input-add">할 일 목록 추가</button>     		 	
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
			        		<input type="text" class="todo-update-title" required oninvalid="setCustomMessage(this, '제목은 필수항목입니다.')" oninput="setCustomMessage(this, '')">
			        		<br>
			        		<p>날짜</p>
			        		<input type="date" class="todo-update-date" required oninvalid="setCustomMessage(this, '날짜는 필수항목입니다.')" oninput="setCustomMessage(this, '')">
			        		<br>
			        		<p>상세 내용</p>
			        		<textarea rows="10" cols="20" class="todo-update-detail"></textarea>
			        		<br>
			        		<button type="submit" class="todo-input-update">할 일 목록 수정</button>     		 	
		     		 	</form>
		      		</div>
		    	</div>
		  	</div>
		  	
			<div class="modal modal-3">
		    	<div class="modal-content">
		      		<div class="modal-header font-en">
		      			<span></span>
		        		<span class="material-symbols-outlined btn-add-close">close</span>
		      		</div>
		     		 <div class="modal-body">
		     		 	<form id="todo-delete">
							<p class="todo-delete-title"></p>
			        		<button type="submit" class="todo-input-delete">삭제하기</button>     		 	
		     		 	</form>
		      		</div>
		    	</div>
		  	</div>
		  	
			<div class="modal modal-4">
		    	<div class="modal-content">
		      		<div class="modal-header font-en">
		      			<span></span>
		        		<span class="material-symbols-outlined btn-add-close">close</span>
		      		</div>
		     		 <div class="modal-body">
		        		<p>할 일 목록</p>
		        		<input type="text" class="todo-detail-title" readonly="readonly">
		        		<br>
		        		<p>날짜</p>
		        		<input type="date" class="todo-detail-date" readonly="readonly">
		        		<br>
		        		<p>상세 내용</p>
		        		<textarea rows="10" cols="20" class="todo-detail-detail" readonly="readonly"></textarea>
		      		</div>
		    	</div>
		  	</div>
		  	
		  	
		  	<script>
			  	const readmeBtn1 = document.querySelector('.btn-add');
			  	const readmePopUp1 = document.querySelector('.modal.modal-1');
			  	const readmePopUp2 = document.querySelector('.modal.modal-2');
			  	const readmePopUp3 = document.querySelector('.modal.modal-3');
			  	const readmePopUp4 = document.querySelector('.modal.modal-4');
			  	const readmeClose1 = document.querySelector('.modal.modal-1 .btn-add-close');
			  	const readmeClose2 = document.querySelector('.modal.modal-2 .btn-add-close');
			  	const readmeClose3 = document.querySelector('.modal.modal-3 .btn-add-close');
			  	const readmeClose4 = document.querySelector('.modal.modal-4 .btn-add-close');
			  	const todoForm = document.querySelector('#todo-input');
			  	const updateForm = document.querySelector('#todo-update');
			  	const deleteForm = document.querySelector('#todo-delete');
			  	readmeBtn1.addEventListener('click', () => {
					const today = new Date().toISOString().split('T')[0];
					document.querySelector('.todo-input-date').value = today;
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
			  	readmeClose3.addEventListener('click', () => {
			  		readmePopUp3.style.display = 'none';
			  	});
			  	readmeClose4.addEventListener('click', () => {
			  		readmePopUp4.style.display = 'none';
			  	});
			  	todoForm.addEventListener('submit', () => {
			  		readmePopUp1.style.display = 'none';
			  	});
			  	updateForm.addEventListener('submit', () => {
			  		readmePopUp2.style.display = 'none';
			  	});
			  	deleteForm.addEventListener('submit', () => {
			  		readmePopUp3.style.display = 'none';
			  	});
		  	</script>
		  	
			<script>
				$('#todo-input').on('submit', (e) => {
				    e.preventDefault();
			
				    const todoTitle = $('.todo-input-title').val();
				    const todoDate = $('.todo-input-date').val();
				    const todoDetail = $('.todo-input-detail').val();
			
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
				                if (data.res_code == '200') {	                	
				                	Swal.fire({
				                		  title: " ",
				                		  text: "할 일 목록이 등록되었습니다.",
				                		  icon: "success",
				                		  confirmButtonText: '확인',
				                		  confirmButtonColor: '#205DAC'
			                		});
				                    
				                    $('.todo-input-title').val('');
				                    $('.todo-input-date').val('');
				                    $('.todo-input-detail').val('');
			
				                    const existingEvents = calendar.getEvents().filter(event => {
				                        return event.startStr.startsWith(todoDate); // '2025-07-09' 같은 날짜로 필터
				                    });
			
				                    let startTime = todoDate + 'T00:00:00';
				                    let endTime = todoDate + 'T03:00:00';
			
				                    if (existingEvents.length > 0) {
				                        // 끝나는 시간 기준으로 정렬 (latest 끝 시간 찾기)
				                        existingEvents.sort((a, b) => a.end - b.end);
				                        const lastEventEnd = existingEvents[existingEvents.length - 1].end;
			
				                        // 3. 다음 이벤트의 시작 시간 = 마지막 끝나는 시간
				                        const nextStart = new Date(lastEventEnd);
				                        const nextEnd = new Date(nextStart);
				                        nextEnd.setHours(nextEnd.getHours() + 3);
			
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
				                            planner_id: data.planner_id,
				                            is_completed: 0
				                        }
				                    });
				                } else {
				                	Swal.fire({
				                		  title: " ",
				                		  text: "할 일 목록이 등록이 실패했습니다.",
				                		  icon: "error",
				                		  confirmButtonText: '확인',
				                		  confirmButtonColor: '#205DAC'
			                		});
				                }
				            }
				        });
				});
			</script>
			 
			<script>
				const attendanceDates = [];
			
				<c:forEach var="atd" items="${useLog}">
				    attendanceDates.push('${atd}');
				</c:forEach>
			
			
				const fp = flatpickr("#calendarPop", {
				    clickOpens: false,
				    allowInput: false,
				    closeOnSelect: false,
				    defaultDate: null,
				    locale: 'ko',
				    onDayCreate: function (dObj, dStr, fp, dayElem) {
				        const date = dayElem.dateObj.toLocaleDateString('sv-SE');
				        if (attendanceDates.includes(date)) {
				            dayElem.classList.add('attendance');
				            dayElem.title = '출석 완료';
				        }
				    },
				    onReady: updateCalendarTitle,       // 달력 처음 렌더링
				    onMonthChange: updateCalendarTitle  // 월 이동 시
				});
			
				// 버튼 누르면 달력 열기
				document.querySelector('.btn-atd').addEventListener('click', () => {
				    fp.open();
				});
			
				function updateCalendarTitle(selectedDates, dateStr, instance) {
				    const calendar = instance.calendarContainer;
				    if (!calendar) return;
			
				    const monthIndex = instance.currentMonth;
				    const yearIndex = instance.currentYear;
				    const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
				    const label = yearIndex + '년 ' + monthNames[monthIndex] + ' 출석표';
			
				    // 중복 방지
				    const existing = calendar.querySelector('.calendar-title');
				    if (existing) existing.remove();
			
				    const title = document.createElement('div');
				    title.className = 'calendar-title';
				    title.innerText = label;
				    calendar.insertBefore(title, calendar.firstChild);
				}
			</script>
			
			<script>
				function setCustomMessage(input, message) {
				  input.setCustomValidity(message);
				}
			</script>
			
			<script>
			  const today = new Date().toISOString().split('T')[0];
			  document.querySelector('.todo-input-date').value = today;
			</script>
			
			<script>
			function responsiveLeft() {
				  const baseWidth = 1920; // 기준 화면 너비
				  const baseLeft = 500;   // 기준 left 값
				  const cover = document.querySelector('.time-cover');

				  if (cover) {
				    const currentWidth = window.innerWidth;
				    const ratio = currentWidth / baseWidth;
				    const newLeft = baseLeft * ratio;
				    cover.style.left = `${newLeft}px`;
				  }
				}

				window.addEventListener('resize', responsiveLeft);
				window.addEventListener('DOMContentLoaded', responsiveLeft);
			</script>
		
		</div>
	</div>
	
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>