<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="change_pw">
	<input type="hidden" name="memberId" value="${memberId}">
	<input type="text" id="member_pw" name="member_pw" placeholder="비밀번호"><br>
	<input type="text" id="member_pw_check" placeholder="비밀번호 확인"><br>
	<p id="member_pw_msg"></p>
  <input type="submit" value="변경하기"/>
</form>

<script>
const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
let memberPw="";
let member_pw_check="";

//비밀번호 정규식 검사 , 비밀번호 재확인 
$("#member_pw, #member_pw_check").on("input blur",function(){
	pwStatus=false;
	memberPw = $("#member_pw").val().trim();
	member_pw_check = $("#member_pw_check").val().trim();
	if(memberPw === ""){
		$("#member_pw_msg").text("비밀번호를 입력해주세요.").css('color','red');
	}else if (!pwReg.test(memberPw)){
		$("#member_pw_msg").text("비밀번호:6~12자의 영문 소문자,숫자 특수기호(!@#$%^&*?)만 사용가능합니다.").css('color','red');
	}else if(memberPw!==member_pw_check){
		$("#member_pw_msg").text("비밀번호가 일치하지 않습니다.").css('color','red');
	}else{
		$("#member_pw_msg").text("").css('color','red');
		pwStatus=true;
	}
});
$("#change_pw").on("submit",function(e){
	e.preventDefault();
	memberPw = $("#member_pw").val().trim();
	member_pw_check = $("#member_pw_check").val().trim();
	if(memberPw === ""){
		$("#member_pw_msg").text("비밀번호를 입력해주세요.").css('color','red');
	}else if (!pwReg.test(memberPw)){
		$("#member_pw_msg").text("비밀번호:6~12자의 영문 소문자,숫자 특수기호(!@#$%^&*?)만 사용가능합니다.").css('color','red');
	}else if(memberPw!==member_pw_check){
		$("#member_pw_msg").text("비밀번호가 일치하지 않습니다.").css('color','red');
	}else{
		$("#member_pw_msg").text("").css('color','red');
	}
});
</script>
</body>
</html>