<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form id = "search_pw">
		<label for="search_pw">비밀번호를 입력하세요</label>
		<input type= "password" id= "input_pw" name = "input_pw">
		<p id= "search_pw_msg"></p>
		<input type= "submit" value= "입력">
	</form>

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