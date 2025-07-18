<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%@ include file="/views/include/sidebar.jsp" %>
	<form id="signUp">
		
		<!-- 이름 -->
		<input type="text" id="member_name" name="member_name" placeholder="이름"><br>
		<p id="member_name_msg"></p>
		<!--주민번호 -->
		<input type="text" id="member_rrn" name="member_rrn" placeholder="주민번호"><br>
		<p id="member_rrn_msg"></p>
		<!-- 학년 입력 -->
		<select id ="member_seat" name="member_seat">
			<option value="0">공용좌석</option>
			<option value="1">지정좌석</option>
		</select>
		<p id ="member_seat_msg"></p>
		<br>
		<input type="submit" value="등록">
	</form>
	
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
								alert(data.res_msg);
							}else{
								 alert(data.res_msg);
								 location.href ="<%=request.getContextPath()%>/login/view";
							}					
						}
						
					});
			} 
		});
	
	</script>
</body>
</html>