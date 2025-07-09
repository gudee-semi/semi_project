<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.seatBox {
	background-color: #EFEFEF;
	margin-top: 10vh;
	margin-bottom: 20vh;
	margin-left: 30vh;
	margin-right: 20vh;
	
}

.privateSeat {
	background-color: #9EA0A1;
	height: 20px;
	width: 20px;
	margin-bottom: 15px;
	
}

.publicSeat1 {
	background-color: #4582EC;
	height: 20px;
	width: 20px;
	margin-bottom: 15px;
	margin-right: 15px;
}

button {
	background-color: #D9D9D9;
	border-radius: 5px;
	cursor: pointer;
	opacity: 0.3;
	margin-right: 70px;
	margin-bottom: 100px;
}

.privateSeatBox {
	height: 80vh;
	margin-right: 60px;
	margin-top: 50px;
	position: relative;
}

.publicSeatBox2 {
	margin-top: 50px;
	margin-right: 70px;
	position: relative;
}

.publicSeatBox{
	margin-top: 50px;
	position: relative;
}

.buttonBox{
	align-self: flex-end;
	margin-left: 70px;
	margin-bottom: 50px;
}
.seatBox2{


	background-color: #EFEFEF;
	display: flex;
	margin-left: 70px;
	margin-top: 60px;
}


</style>

<body>
	<div class="seatBox">
		<div class="seatBox2">
		
		<div class="privateSeatBox">
			<%
			for (int i = 0; i < 10; i++) {
			%>
			 <div class="privateSeat"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox2">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
			</div>

		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>
			</div>
			
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat1"></div>
			<%
			}
			%>	
		</div>
		
		
		</div>
		
		<div class="buttonBox">
			<button>사용하기</button>
			<button>변경하기</button>
			<button>취소하기</button>
		</div>
		
	</div>
	
</body>
