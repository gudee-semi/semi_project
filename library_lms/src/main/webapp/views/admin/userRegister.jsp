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
	padding-top : 100px;
	display:flex;
	flex-direction: column;
	
}
.signup_box{
	margin:20px auto 0 ;
	border : 1px solid #ccc;
	padding : 50px;
	border-radius: 5px;
	
}

 .signup_box input[type="text"] {
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      width:300px;
      height:50px;
      box-sizing: border-box;
    }

 .signup_box input[type="submit"] {
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
    
.signup_box input[type="submit"]:hover {
      background-color: #205DAC;
      color:white;
    }
 .signup_box input:focus{
    	border:1px solid #205DAC;
    	outline:none;
    }
select {
	  width: 200px;
	  padding: 10px;
	  font-size: 14px;
	  border: 1px solid #ccc;
	  border-radius: 5px;
	  background-color: white;
	  color: #333;
	}
	select:focus {
	   border: 1px solid #205DAC !important;
  	outline: none !important;
	  
	}
	.title_box{
		margin:0 auto 30px;
	}
</style>
<body>

	<%@ include file="/views/include/header.jsp" %>
	<div class="container_box">
	
		<div class= "sidesbar">
			<%@ include file="/views/include/sidebar.jsp" %>
		</div>
				<h2 class="title_box">회원 등록</h2>
		<div class="signup_box">
		
			<form id="signUp">
				
				<!-- 이름 -->
				<input type="text" id="member_name" name="member_name" placeholder="이름">
				<p id="member_name_msg"></p>
				<!--주민번호 -->
				<input type="text" id="member_rrn" name="member_rrn" placeholder="주민번호">
				<p id="member_rrn_msg"></p>
				<!-- 학년 입력 -->
				<select id ="member_seat" name="member_seat">
					<option value="0">공용좌석</option>
					<option value="1">지정좌석</option>
				</select>
				<p id ="member_seat_msg"></p>
			
				<input type="submit" value="등록">
			</form>
		</div>
	</div>
	<script>
	//이름 입력받기
	let nameStatus = false;
	let rrnStatus = false;
	const nameReg = /^[가-힣]{2,20}$/;
	const rrnReg = /^[0-9]{13}$/;
	let memberName="";
	let memberRrn="";
	
	
	$("#member_name").on("input blur",function(){
		nameStatus=false;
		memberName = $("#member_name").val().trim();
		if(memberName === ""){
			$("#member_name_msg").text("이름을 입력해주세요.").css('color','red');
		}else if (!nameReg.test(memberName)){
			$("#member_name_msg").text("정확한 이름을 입력해주세요").css('color','red');
		}		
		else{
			$("#member_name_msg").text("").css('color','red');
			nameStatus=true;
		}
	});
	
	//주민 번호 입력받기
	
	$("#member_rrn").on("input blur",function(){
		rrnStatus=false;
		memberRrn = $("#member_rrn").val().trim();
		if(memberRrn === ""){
			$("#member_rrn_msg").text("주민등록번호를 입력해주세요.").css('color','red');
		}else if (!rrnReg.test(memberRrn)){
			$("#member_rrn_msg").text("13자리의 주민번호를 입력해주세요").css('color','red');
		}
		else{
			$.ajax({
				url : "/user/reapeatCheck",
				type : "post",
				data : {member_rrn  : memberRrn},
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
	
	
	 $("#signUp").submit(function(e){
			e.preventDefault();
			
			// 입력 값들 가져오기

			if(!memberName || memberName===""){
				$("#member_name_msg").text("이름은 필수 정보 입니다.").css('color','red');
			}
			if(!memberRrn || memberRrn===""){
				$("#member_rrn_msg").text("주민등록번호는 필수 정보 입니다.").css('color','red');
			}
			//모든 유효성 검사가 완료 되었을 시
			if(nameStatus  &&rrnStatus ){
					const formData = $("#signUp").serialize();
					$.ajax({
						url : "/user/signup",
						type : "post",
						data : formData ,
						dataType :"json",
						success : function(data){
							if(data.res_code==500){
								Swal.fire({
									  title: "회원등록 실패",
									  text: "서버 오류 입니다.",
									  icon: "warning",
									  confirmButtonColor: '#205DAC'
									});
							}else{
								Swal.fire({
									  title: "회원등록 성공",
									  text: "회원 계정을 등록 하였습니다.",
									  icon: "success",
									  confirmButtonColor: '#205DAC'
									}).then(() => {
										  location.href = "<%=request.getContextPath()%>/main";
									});
							}					
						}
						
					});
			} 
		});
	
	</script>
</body>
</html>