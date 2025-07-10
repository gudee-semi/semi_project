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
<form id = "signUp" >
	<input type="text" id="member_id" placeholder="아이디"><br>
	<p id="member_id_msg"></p>
	<input type="text" id="member_pw" placeholder="비밀번호"><br>
	<input type="text" id="member_pw_check" placeholder="비밀번호 확인"><br>
	<p id="member_pw_msg"></p>
	<br>
	<input type="text" id="member_name" placeholder="이름"><br>
	<p id="member_name_msg"></p>
	<input type="text" id="member_rrn" placeholder="주민번호"><br>
	<p id="member_rrn_msg"></p>
</form>
	
	
	
<script>
	let idStatus =false;
	let pwStatus =false;
	let isStatus =true;
	let nameStatus = false;
	let rrnStatus = false;
	const idReg = /^[a-zA-Z0-9]{6,12}$/;
	const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
	const rrnReg = /^[0-9]{13}$/;
	
	// 아이디 값이 비어있는지 , 유효한 값인지 ,입력한 값이 중복인지 체크
	$("#member_id").on("input",function(){
		idStatus=false;
		const memberId = $("#member_id").val().trim();
		if(memberId==""){
			$("#member_id_msg").text("아이디를 입력해주세요.").css('color','red');
		}else if (!idReg.test(memberId)){	
			$("#member_id_msg").text("아이디:6~12자의 영문 소문자,숫자만 사용가능합니다. ").css('color','red');
		}else{
			$.ajax({
				url : "/member/repeatcheck",
				type : "post",
				data : {memberId : memberId},
				dataType :"json",
				success : function(data) {
					if(data.idCheck=="no"){
					$("#member_id_msg").text("중복된 아이디 입니다.").css('color','red');
					}else{
					$("#member_id_msg").text("").css('color','red');
						idStatus=true;
					}
				}
			})
			
		}
	});
		
	//비밀번호 정규식 검사 , 비밀번호 재확인 
	$("#member_pw, #member_pw_check").on("input",function(){
		pwStatus=false;
		const memberPw = $("#member_pw").val().trim();
		const member_pw_check = $("#member_pw_check").val().trim();
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
	
	//이름 입력받기
	$("#member_name").on("input",function(){
		nameStatus=false;
		const memberName = $("#member_name").val().trim();
		if(memberName === ""){
			$("#member_name_msg").text("이름을 입력해주세요.").css('color','red');
		}else if (memberName.length>20){
			$("#member_name_msg").text("정확한 이름을 입력해주세요").css('color','red');
		}		
		else{
			$("#member_name_msg").text("").css('color','red');
			nameStatus=true;
		}
	});
	
	//주민 번호 입력받기
	
	$("#member_rrn").on("input",function(){
		rrnStatus=false;
		const memberRrn = $("#member_rrn").val().trim();
		if(memberRrn === ""){
			$("#member_rrn_msg").text("주민등록번호를 입력해주세요.").css('color','red');
		}else if (!rrnReg.test(memberRrn)){
			$("#member_rrn_msg").text("13자리의 주민번호를 입력해주세요").css('color','red');
		}
		else{
			$.ajax({
				url : "/member/repeatcheck",
				type : "post",
				data : {memberRrn  : memberRrn},
				dataType :"json",
				success : function(data) {
					if(data.rrnCheck=="no"){
					$("#member_rrn_msg").text("올바르지 않은 주민등록 번호 입니다.").css('color','red');
					}else{
					$("#member_rrn_msg").text("").css('color','red');
						rrnStatus=true;
					}
				}
			})
		}
	});
	
	
	
	
	

</script>
</body>
</html>