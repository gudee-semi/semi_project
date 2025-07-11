<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<input type="button" id = "addressBtn" value="주소검색"><br>
	<input type="text" id="member_address"  placeholder="주소" readonly><br>
	<input type="text" id="member_address_detail" placeholder="상세주소">
	
	<div id="layer" style="display:none;background-color:white;position :absolute;overflow:hidden;
	z-index:1;border:1px solid;width:500px;height:400px;left:20px;top:200px; ">
		<div style="background-color:blue; position:relative; height:35px; z-index:2;">
	
		 <button type="button" id ="addressCloseBtn"style=" position :absolute; top:3px;
		 right:3px; z-index:2;">닫기</button>
	
	
	
		</div>
		<div id="addressWindow" style="width :100%; height : 100%;">
		</div>
	</div>
	<p id= "member_address_msg"></p>
	
	<input type="button" id = "member_schul_search" value="학교검색"><br>
	<input type="text" id="member_schul"  placeholder="학교이름"><br>
	<p id = "member_schul_msg">
	<input type="submit" value="제출하기">
	
	
	<div id="schul_modal">
		
		<div id = "modal_title">
		
			<button type= "button" id ="modal_close_btn">닫기</button>
		
		</div>
		<div id = "modal_content">
			<div id = "search_field"></div>
				<input id = "shcul_name" type="text" placeholder="학교이름 입력"> 
				<button type= "button" id = "shcul_search"></button>
			</div>
			<div id = "result_field">
				<ul>
					<c:forEach var="data" items="">
					
						<li>${data.shulName}</li>
					
					</c:forEach>
				
				</ul>
			</div>
			
		</div>
	
	</div>
</form>
<script>
	let idStatus =false;
	let pwStatus =false;
	let nameStatus = false;
	let rrnStatus = false;
	let addressStatus = false;
	const idReg = /^[a-zA-Z0-9]{6,12}$/;
	const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
	const rrnReg = /^[0-9]{13}$/;
	let memberId="";
	let memberPw="";
	let member_pw_check="";
	let memberName="";
	let memberRrn="";
	let memberAddress="";
	// 아이디 값이 비어있는지 , 유효한 값인지 ,입력한 값이 중복인지 체크
	$("#member_id").on("input blur",function(){
		idStatus=false;
		memberId = $("#member_id").val().trim();
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
	
	//이름 입력받기
	$("#member_name").on("input blur",function(){
		nameStatus=false;
		memberName = $("#member_name").val().trim();
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	//주소찾기
	$("#addressCloseBtn").on("click",function(){
	
	    document.getElementById('layer').style.display = 'none';
	});
	$("#addressBtn").on("click",function(){
		let element_layer = document.getElementById('layer');
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                    addressStatus = true;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                    addressStatus = true;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr =   data.buildingName;
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                } 

	                //주소 정보를 해당 필드에 넣는다.
	                memberAddress=addr+extraAddr;
	                document.getElementById("member_address").value = memberAddress;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("member_address_detail").focus();
	                element_layer.style.display = 'none';
	                
	            }
	        }).embed(document.getElementById('addressWindow'));
	        element_layer.style.display = 'block';
	});
	    
	    
	
	</script>
	
	
	
	<script>
		$("#schulsearch").on("click",function(){
			$.ajax({
				url : 
			});
		});
	</script>
	<script>
	 $("#signUp").submit(function(e){
		e.preventDefault();
		
		// 입력 값들 가져오기
		if(!memberId || memberId===""){
			$("#member_id_msg").text("아이디는 필수정보 입니다.").css('color','red');
		}
		if(!memberPw || memberPw===""||!member_pw_check || member_pw_check ===""){
			$("#member_pw_msg").text("비밀번호는 필수 정보 입니다.").css('color','red');
		}
		if(!memberName || memberName===""){
			$("#member_name_msg").text("이름은 필수 정보 입니다.").css('color','red');
		}
		if(!memberRrn || memberRrn===""){
			$("#member_rrn_msg").text("주민등록번호는 필수 정보 입니다.").css('color','red');
		}
		if(!memberAddress || memberAddress===""){
			$("#member_address_msg").text("주소는 필수 정보 입니다.").css('color','red');
		}

		
		//모든 유효성 검사가 완료 되었을 시
	/* 	if(idStatus && pwStatus && nameStatus && rrnStatus && addressStatus){
			$.ajax({
				url :
				
			});
		} */
		
		
	});
	
	</script>
	
	

</body>
</html>