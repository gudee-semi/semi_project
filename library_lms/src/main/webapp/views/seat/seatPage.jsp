<%@page import="com.hy.dto.seat.Seat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>좌석</title>


<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />	
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>

	.seatBox {
		background-color: #EFEFEF;
		width: 787px;
		height: 752px;
	
	}
	
	.privateSeat {
		background-color: #9EA0A1;
		height: 27px;
		width: 27px;
		margin-bottom: 19.5px;
		position: relative;
		
	}
	
	.privateSeat::before {
	  content: "\00d7";
	  position: absolute;
	  top: 40%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  font-size: 35px;
	  color: black;
	}
	
	
	.publicSeat {
		background-color: #4582EC;
		height: 27px;
		width: 27px;
		margin-bottom: 19.5px;
		margin-right: 19.5px;
		cursor: pointer;
	}
	
	.publicSeat:hover{
	
		outline: 4px solid red;
		
	}
	
	.publicSeat.active{
	
		outline: 4px solid red;
		
	}
	
	.publicSeat.used{
	
		background-color: #FF9500;
	
	}
	
	button {
		background-color: #D9D9D9;
		border-radius: 10px;
		cursor: pointer;
		margin-right: 70px;
		width: 123px;
		height: 47px;
		font-weight: 600;
	}
	
	button:disabled{
		cursor: default;
	
	}
	
	
	.privateSeatBox {
		height: 80px;
		
		margin-left: 50px;
		margin-right: 100px;
		margin-top: 100px;
		position: relative;
	}
	
	.publicSeatBox2 {
		margin-top: 100px;
		margin-right: 124.08px;
		position: relative;
	}
	
	.publicSeatBox{
		margin-top: 100px;
		position: relative;
	}
	
	.buttonBox{
		margin-left: 120px;
		margin-bottom: 70px;
		margin-top: 250px;
		position: relative;
		
		
		display:flex;
		flex-wrap: wrap;
	}
	.seatBox2{
	
	
		background-color: #EFEFEF;
		display: flex;
		margin-left: 70px;
			
	}

	.totalBox{
		display:flex;
		flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
	
	}
	footer{
	margin-top: 0 !important;
	
	}
	.check-buttons{
	
		height:30px;
	}
	.profile{
		height:184.94px;
	}
	.logout-text{
		height:24px;
	}
</style>
</head>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>


<body>
<%@ include file="/views/include/header.jsp" %>
	
	<% 
		List<Seat> list = (List<Seat>)request.getAttribute("list");
	%>

  <div class="totalBox">
		<%@ include file="/views/include/sidebar.jsp" %>
	<div class="seatBox" style="margin: 40px 100px 100px 200px;">
		<div class="seatBox2">
		
		<div class="privateSeatBox">
			<%
			for (int i = 1; i < 11; i++) {
			%>
			 <div class="privateSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 11; i < 16; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>

		<div class="publicSeatBox2">
			<%
			for (int i = 16; i < 21; i++) {
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else {
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>	
			<% } } %> 
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 21; i < 27; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 27; i < 33; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 33; i < 39; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 39; i < 45; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>
			
		<div class="publicSeatBox">
			<%
			for (int i = 45; i < 51; i++) { 
				if (list.get(i - 1).getSeatStatus() == 1) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			} else { 
			%>
			 <div class="publicSeat used" data-seat-no="<%= i%>"></div>			
			<% } } %>
		</div>
		
		</div>
		
		<div class="buttonBox">
			<button id="useButton" disabled>사용하기</button>
			<button id="changeButton" disabled>변경하기</button>
			<button id="cancelButton" disabled>취소하기</button>
		</div>
		
		</div>
		
	
	
	</div>
	<%@ include file="/views/include/footer.jsp" %>
	<script>
	
	// 서버에서 전달한 currentUsedSeatNo 값 읽기 (null 체크 포함)
	const currentUsedSeatNo = <%= request.getAttribute("currentUsedSeatNo") 
			!= null ? request.getAttribute("currentUsedSeatNo") : "null" %>;
	
	
	const publicSeat = document.querySelectorAll('.publicSeat');
	const useButton = document.getElementById('useButton');
	const changeButton = document.getElementById('changeButton');
	const cancelButton = document.getElementById('cancelButton');
	let selectedSeat = null;
	let currentUsedSeat = null;
	
	// --- 페이지 로딩 시 현재 사용중인 좌석 있으면 표시 + 버튼 활성화 ---
	if(currentUsedSeatNo !== null) {
		currentUsedSeat = document.querySelector(`.publicSeat[data-seat-no='${currentUsedSeatNo}']`);
		if(currentUsedSeat){
			currentUsedSeat.classList.add('used');
			cancelButton.disabled = false;  // 취소 버튼 활성화
		}
	}
	
	
	publicSeat.forEach(seatEl => {
		seatEl.addEventListener('click', () => {
			
			// 이미 사용 중인 좌석이면 클릭 무시
			if (seatEl.classList.contains('used')) {
				Swal.fire({
					  icon: "error",
					  title: "이미 사용중인 좌석입니다",
					  confirmButtonColor:'#205DAC'
					});
				return;
			}

			publicSeat.forEach(seat => {
				seat.classList.remove('active');
			});
			seatEl.classList.add('active');
			selectedSeat = seatEl;

			// 버튼 활성화
			if (currentUsedSeat && selectedSeat) {
				changeButton.disabled = false;
			} else {
				useButton.disabled = false;
			}
		});
	});
	
	useButton.addEventListener('click', () => {
		if(!selectedSeat) return; 
		
		Swal.fire({
		    text: '이 좌석으로 하시겠습니까?',
		    icon: 'question',
		    showCancelButton: true,
		    confirmButtonText: '네',
		    cancelButtonText: '취소',
		    confirmButtonColor: '#205DAC'
		  }).then((result) => {
		    if (result.isConfirmed) {
		      if (currentUsedSeat) currentUsedSeat.classList.remove('used');
		      selectedSeat.classList.add('used');
		      selectedSeat.classList.remove('active');
		      currentUsedSeat = selectedSeat;

		      const seatNo = selectedSeat.dataset.seatNo;

		      $.ajax({
		        url: '/seat/use',
		        type: 'post',
		        data: { seatNo: seatNo },
		        dataType: 'json',
		        success: (data) => {
		          console.log(data.res_msg);
		          Swal.fire({
		        	  text:'성공',
		        	  icon:'success',
		        	  confirmButtonColor: '#205DAC'
		          });
		        }
		      });

		      selectedSeat = null;
		      useButton.disabled = true;
		      cancelButton.disabled = false;
		    }
		  });
		});
	
	
	changeButton.addEventListener('click', () => {
		if(!selectedSeat) return; 
		
		Swal.fire({
		    text: '좌석을 변경하시겠습니까?',
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonText: '네',
		    cancelButtonText: '취소',
		    confirmButtonColor: '#205DAC'
		  }).then((result) => {
		    if (result.isConfirmed) {
		      const newSeatNo = selectedSeat.dataset.seatNo;
		      const oldSeatNo = currentUsedSeat ? currentUsedSeat.dataset.seatNo : null;

		      $.ajax({
		        url: '/seat/change',
		        type: 'post',
		        data: { oldSeatNo, newSeatNo },
		        dataType: 'json',
		        success: (data) => {
		          if (data.res_code === "200") {
		            if (currentUsedSeat) currentUsedSeat.classList.remove('used');
		            selectedSeat.classList.add('used');
		            selectedSeat.classList.remove('active');

		            currentUsedSeat = selectedSeat;
		            selectedSeat = null;

		            changeButton.disabled = true;
		            cancelButton.disabled = false;

		            
		            Swal.fire({
			        	  text:'변경 완료!',
			        	  icon:'success',
			        	  confirmButtonColor: '#205DAC'
			          });
		          } else {
		            Swal.fire('실패', '좌석 변경 실패: ' + data.res_msg, 'error');
		          }
		        },
		        error: () => {
		          Swal.fire('오류', '서버 오류 발생', 'error');
		        }
		      });
		    }
		  });
		});
	
	
	cancelButton.addEventListener('click', () => {
		if (!currentUsedSeat) {
		    Swal.fire('취소할 좌석이 없습니다.', '', 'info');
		    return;
		  }

		  Swal.fire({
		    text: '좌석을 취소하시겠습니까?',
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonText: '네',
		    cancelButtonText: '유지하기',
		    confirmButtonColor: '#205DAC'
		  }).then((result) => {
		    if (result.isConfirmed) {
		      const seatNo = currentUsedSeat.dataset.seatNo;

		      $.ajax({
		        url: '/seat/cancel',
		        type: 'post',
		        data: { seatNo },
		        dataType: 'json',
		        success: (data) => {
		          console.log(data.res_msg);
		          Swal.fire({
		        	  text:'취소 완료',
		        	  icon:'success',
		        	  confirmButtonColor:'#205DAC'
		          });
		        }
		      });

		      currentUsedSeat.classList.remove('used');
		      currentUsedSeat = null;

		      if (selectedSeat) {
		        selectedSeat.classList.remove('active');
		        selectedSeat = null;
		      }

		      cancelButton.disabled = true;
		      useButton.disabled = true;
		      changeButton.disabled = true;
		    }
		  });
		});

	
	
	</script>
	
	
</body>
</html>