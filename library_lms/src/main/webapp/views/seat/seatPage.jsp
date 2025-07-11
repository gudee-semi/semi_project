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






button {
	background-color: #D9D9D9;
	border-radius: 10px;
	cursor: pointer;
	opacity: 0.3;
	margin-right: 70px;
	width: 123px;
	height: 47px;
	pointer-events: none;

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
			 <div class="publicSeat"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox2">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			 <div class="publicSeat"></div>
			<%
			}
			%>
			</div>

		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat"></div>
			<%
			}
			%>
		</div>

		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat"></div>
			<%
			}
			%>
		</div>
		
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat"></div>
			<%
			}
			%>
			</div>
			
		<div class="publicSeatBox">
			<%
			for (int i = 0; i < 6; i++) {
			%>
			 <div class="publicSeat"></div>
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
