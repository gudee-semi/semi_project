<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="text" id="member_id" placeholder="아이디">
	<input type="text" id="member_pw_check" placeholder="비밀번호">
	<input type="text" id="member_pw" placeholder="비밀번호 확인">
	<p id="member_id_msg"></p>
	<p id="member_pw_msg"></p>
	<p id="member_pw_check_msg"></p>
	
	
	
<script>

	$("#member_id").on("blur",function(){
		const memberId = $("#member_id").val().trim();
		
		if(member_id==""){
			$("member_id_msg").text("아이디를 입력해주세요.").css('color','red');
			return;
		}
		
		$.ajax({
			url: ''
			
		});
	});

</script>
</body>
</html>