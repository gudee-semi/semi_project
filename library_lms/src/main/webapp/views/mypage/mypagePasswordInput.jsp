<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<style>
	.container_box{
		display:flex;
	}
	.search_pw_box{
		margin : 200px auto;
		border : 1px solid #ccc;
		padding: 50px;
		border-radius:5px;
	}
	#search_pw{
		display:flex;
		justify-content: center;
		flex-direction: column;
		align-items: center;
	}
	.search_pw_box label{
		line-height: 50px;
		margin-bottom : 10px;
	}
	.search_pw_box input{
		border: 1px solid #ccc;
		border-radius: 5px;
		box-sizing: border-box;
	}
	.search_pw_box input[type="password"]{
		width:300px;
		height:50px;
		
	}
	.search_pw_box input[type="password"]:focus{
		border-color:#205DAC;
		
	}
	.search_pw_box input[type="submit"]{
		box-sizing: border-box;
		width:70px;
		height:50px;
		background-color: #D8E5F4;
		cursor:pointer;
		color:black;
		transition: background-color 0.3s;
	}
	.search_pw_box input[type="submit"]:hover{
		background-color: #205DAC;
		color:white;
	}
	


</style>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class = "container_box">
		<div>
			<%@ include file="/views/include/sidebar.jsp" %>
		</div>
		
		<div class="search_pw_box">
			<form id = "search_pw">
				<label for="search_pw">비밀번호를 입력하세요</label>
				<input type= "password" id= "input_pw" name = "input_pw">
				<p id= "search_pw_msg"></p>
				<input type= "submit" value= "입력">
			</form>
		</div>
	</div>
<script >
	$("#search_pw").on("submit",function(e){
		e.preventDefault();
		const memberPw = $("#input_pw").val().trim();
		if(memberPw==""){
			$("#search_pw_msg").text("비밀번를 입력하세요 ").css('color','red');
			return;
		}
			
		$.ajax({
			url : "/mypage/password/input",
			type : "post",
			data : {member_pw : memberPw},
			dataType : "json",
			success : function(data){
				if(data.res_code==200){
					location.href ="<%=request.getContextPath()%>/mypage/view";
				}else if(data.res_code==500){
					$("#search_pw_msg").text("비밀번호가 틀렸습니다.").css('color','red');
				}else{
					alert("서버 오류 입니다.");
				}
				
			},
			
		});
	});
	
	
</script>
</body>
</html>