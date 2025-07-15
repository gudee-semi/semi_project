<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="change_pw">
	<input type="password" id="member_pw" name="member_pw" placeholder="비밀번호"><br>
	<input type="password" id="member_pw_check" placeholder="비밀번호 확인"><br>
	<p id="member_pw_msg"></p>
  <input type="submit" value="변경하기"/>
</form>

<script>
const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
let memberPw="";
let member_pw_check="";
let pwStatus = false;
const memberId = '${param.memberId}';
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
	if(!memberPw || memberPw===""||!member_pw_check || member_pw_check ===""){
		$("#member_pw_msg").text("비밀번호는 필수 정보 입니다.").css('color','red');
	}
	if(pwStatus){
		$.ajax({
			url : "/login/changePw/view",
			type : "post",
			data : {member_pw : memberPw,
					memberId : memberId},
			dataType : "json",
			success : function(data){
				if(data.res_code == "200"){
					alert("비밀번호 변경 성공")
					location.href ="<%=request.getContextPath()%>/login/view";
				}else{
					alert("서버오류 발생");
				}
			}
		});
	}
		
});
</script>
</body>
</html>