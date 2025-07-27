<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하연 : 비밀번호 찾기</title>
</head>
<style>
.container_pw_search {
      border: 1px solid #c5ccd2;
      border-radius: 5px;
      padding: 30px 40px;
      background-color: #fff;
      width: 400px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      margin: 200px auto 100px;
	  box-sizing :border-box;
    }
    .insert_search_data {
 	  margin:20px auto 0;
   	  width:300px;
      box-sizing: border-box;
    }

    .insert_search_data form {
      display: flex;
      flex-direction: column;
      gap: 15px;
      margin:0;
    }


      input[type="password"] {
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      width:300px;
      height:50px;
      box-sizing: border-box;
    }

    input[type="submit"] {
      background-color: #D8E5F4;
      color: black;
      padding: 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
      width:300px;
      height:50px;
      box-sizing: border-box;
    }
    
    input[type="submit"]:hover {
      background-color: #205DAC;
      color:white;
    }

    p {
      font-size: 13px;
      margin-top: 8px;
    }

    #member_pw_msg{
      color: red;
      padding-left: 3px;
    }

    #result_container {
      margin-top: 15px;
      text-align: center;
      font-size: 14px;
    }
  </style>


</style>
<body>
 <%@ include file="/views/include/header.jsp" %>
<div class="container_pw_search">
    <div class="insert_search_data">
		<form id="change_pw">
			<input type="password" id="member_pw" name="member_pw" placeholder="새로운 비밀번호">
			<input type="password" id="member_pw_check" placeholder="비밀번호 확인">
			<p id="member_pw_msg"></p>
		  <input type="submit" value="변경하기"/>
		</form>
  </div>
  </div>











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
					Swal.fire({
						  title: "비밀번호 변경 성공",
						  text: "새로운 비밀번호를 이용하세요!",
						  icon: "success",
						  confirmButtonColor: '#205DAC'
						}).then(() => {
							  location.href = "<%=request.getContextPath()%>/login/view";
						});
				}else{
					Swal.fire({
						  title: "비밀번호 변경 실패",
						  text: "서버오류가 발생했습니다.",
						  icon: "warning",
						  confirmButtonColor: '#205DAC'
						});
				}
			}
		});
	}
		
});
</script>
</body>
</html>