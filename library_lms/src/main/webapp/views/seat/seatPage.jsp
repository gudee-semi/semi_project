<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.seatBox {
	background-color: #EFEFEF;
	margin-top: 110px;
	margin-bottom: 140px;
	margin-left: 460px;
	margin-right: 200px;
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

	background-color: FF9500;

}


button {
	background-color: #D9D9D9;
	border-radius: 10px;
	cursor: pointer;
	opacity: 0.3;
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
}
.seatBox2{


	background-color: #EFEFEF;
	display: flex;
	margin-left: 70px;

}


</style>

<body>





	<div class="seatBox">
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
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox2">
			<%
			for (int i = 16; i < 21; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
			</div>

		<div class="publicSeatBox">
			<%
			for (int i = 21; i < 27; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 27; i < 33; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 33; i < 39; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 39; i < 45; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>
			</div>
			
		<div class="publicSeatBox">
			<%
			for (int i = 45; i < 51; i++) {
			%>
			 <div class="publicSeat" data-seat-no="<%= i%>"></div>
			<%
			}
			%>	
		</div>
		
		
		</div>
		
		<div class="buttonBox">
			<button id="useButton" disabled>사용하기</button>
			<button id="changeButton" disabled>변경하기</button>
			<button id="cancelButton" disabled>취소하기</button>
		</div>
		
	</div>
	
	<script>
	
	const publicSeat = document.querySelectorAll('.publicSeat');
	const useButton = document.getElementById('useButton');
	const changeButton = document.getElementById('changeButton');
	const cancelButton = document.getElementById('cancelButton');
	let selectedSeat = null;
	
	
	publicSeat.forEach(seatEl => {
		seatEl.addEventListener('click', () => {
			publicSeat.forEach(seat => {
				seat.classList.remove('active');
			});
			seatEl.classList.add('active');
			
			selectedSeat = seatEl;
			
			// 버튼 활성화
			useButton.disabled = false;
		});
	});
	
	useButton.addEventListener('click', () => {
		const isYes = confirm('이 좌석으로 하시겠습니까?');
		if(isYes) {
			selectedSeat.classList.add('used');
			selectedSeat.classList.remove('active');
			
			useButton.disabled = true;
			cancelButton.disabled = false;
		} 
	});
	
	
	cancelButton.addEventListener('click', () => {
		const isYes = confirm('정말 취소 하시겠습니까?')
		if(isYes){
			selectedSeat.classList.remove('used');
			
			cancelButton.disabled = true;
		}
	})
	
	</script>
	
	
</body>
