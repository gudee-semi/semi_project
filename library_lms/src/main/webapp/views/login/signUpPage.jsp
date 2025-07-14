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
<form id="signUp" method="post" enctype="multipart/form-data" >
	<!--아이디   -->
	<input type="text" id="member_id" name="member_id" placeholder="아이디"><br>
	<p id="member_id_msg"></p>
	
	<!--비밀번호 -->
	<input type="text" id="member_pw" name="member_pw" placeholder="비밀번호"><br>
	<input type="text" id="member_pw_check" placeholder="비밀번호 확인"><br>
	<p id="member_pw_msg"></p>
	
	<br>
	<!-- 이름 -->
	<input type="text" id="member_name" name="member_name" placeholder="이름"><br>
	<p id="member_name_msg"></p>
	
	<!-- 전화번호 -->
	<input type="text" id="member_phone" name="member_phone" placeholder="전화번호"><br>
	<p id="member_phone_msg"></p>
	
	<!--주민번호 -->
	<input type="text" id="member_rrn" name="member_rrn" placeholder="주민번호"><br>
	<p id="member_rrn_msg"></p>
	
	<!--주소 검색  -->
	<input type="button" id = "addressBtn" value="주소검색"><br>
	<input type="text" id="member_address" name="member_address" placeholder="주소" readonly><br>
	<input type="text" id="member_address_detail" name="member_address_detail" placeholder="상세주소">
	<!--주소 모달창  -->
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
	
	
	<!-- 학교 검색  -->
	<input type="button" id = "member_schul_search" value="학교검색"><br>
	<input type="text" id="member_schul" name="member_schul" placeholder="학교이름" readonly><br>
	<p id = "member_schul_msg">
	
	<!-- 학교 검색 모달 -->
	<div id="schul_modal">
		
		<div id = "modal_title">
		
			<button type= "button" id ="modal_close_btn">닫기</button>
		
		</div>
		<div id = "modal_content">
			<div id = "search_field"></div>
				<input id = "schul_name" type="text" placeholder="학교이름 입력" > 
				<button type= "button" id = "schul_search">검색</button>
		</div>
			<div id = "result_field">
			    <ul>
				</ul>
			</div>
	</div>
	
	<!-- 학년 입력 -->
	<select id ="member_grade" name="member_grade">
		<option value="0">미지정</option>
		<option value="1">1학년</option>
		<option value="2">2학년</option>
		<option value="3">3학년</option>
	</select>
	<p id ="member_grade_msg"></p>
	<br>
	
	<!-- 프로필 이미지 첨부 -->
	<input type="file" id = "member_profile" name = "member_profile">
	<p id ="member_profile_msg"></p>
	<img id="previewImg"width="200px" height="200px" hidden>

	<!-- 독서실 정보 동의 -->
	<input type="checkbox" id = "member_check" name ="member_check">독서실 정보 동의
	<p id ="member_check_msg"></p>
	<input type="submit" value="제출하기">
</form>
<script>
 	// 변수 설정, 정규식 설정
	let idStatus =false;
	let pwStatus =false;
	let nameStatus = false;
	let phoneStatus = false;
	let rrnStatus = false;
	let addressStatus = false;
	let schulStatus= false;
	let gradeStatus= false;
	let profileStatus = false;
	let checkStatus= false;
	const idReg = /^[a-zA-Z0-9]{6,12}$/;
	const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
	const rrnReg = /^[0-9]{13}$/;
	const phoneReg = /^[0-9]{11}$/;
	const nameReg = /^[가-힣]{2,20}$/;
	const imgReg = /\.(jpg|png)$/i;
	let memberId="";
	let memberPw="";
	let member_pw_check="";
	let memberPhone = "";
	let memberName="";
	let memberRrn="";
	let memberAddress="";
	let memberSchul="";
	let memberGrade=0;
	let memberProfile="";
</script>
<script>
	
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
	
	//전화번호 정규식 
	$("#member_phone").on("input blur",function(){
		phoneStatus=false;
		memberPhone = $("#member_phone").val().trim();
		if(memberPhone === ""){
			$("#member_phone_msg").text("전화번호를 입력해주세요.").css('color','red');
		}else if (!phoneReg.test(memberPhone)){
			$("#member_phone_msg").text("전화번호: - 제외하고 입력해주세요 ").css('color','red');
		}else{
			$("#member_phone_msg").text("").css('color','red');
			phoneStatus=true;
		}
	});
	
	//이름 입력받기
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
	
	//주소 모달닫기
	$("#addressCloseBtn").on("click",function(){
	
	    document.getElementById('layer').style.display = 'none';
	});
	
	//주소검색 버튼 클릭
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
	            	$("#member_address_msg").text("");
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("member_address_detail").focus();
	                element_layer.style.display = 'none';
	                
	            }
	        }).embed(document.getElementById('addressWindow'));
	        element_layer.style.display = 'block';
	});
	</script>

	<script>
	//서울시 학교 검색
		$("#schul_search").on("click",function(){
			
			let schulName = $("#schul_name").val().trim();
			let url = "http://openapi.seoul.go.kr:8088/4f584c4c61776a6433375a44634f47/json/neisSchoolInfoHs/1/318";
			let rows=[];
			let name =[];
			let result="";
				// 1. 비동기 통신으로 서울시 학교 데이터 전부를 가져와서 rows에 저장
				// 2. rows에서 검색 키워드가 포함된 학교정보를 name에 저장
				// 3. name값을 전부 가져와서 li태그로 result_field에 뿌려줌
				
			if(schulName!==""){
				$.ajax({
					url : url,
					type: "get",
					dataType: "json",
					success : function(data){
				
						if(data.neisSchoolInfoHs.row){
							rows= data.neisSchoolInfoHs.row
						}
						
						
						for(const da of rows){
							if (da.SCHUL_NM.includes(schulName)) {
								name.push(da.SCHUL_NM);
						      }
						}
						
						
						if(name.length===0){
							$("#result_field").text("없는 학교입니다.");
						}else{
							for(let i = 0 ; i <name.length; i++){
								result+="<li class = 'schul_list'>"+name[i]+"</li>";
							}
							$("#result_field").html(result);
						}	
					},
					error: function(){
						alert("요청실패");
					}
					
				});
			}else{
				$("#result_field").html(result);
			}
				
			});
	
	
		// 클릭한 요소 뿌려주기 이때 모든 class 이름이 shcul_list이므로 그 중 하나를 선택해 값을 넘겨준다면 this를사용
		// 이벤트 위임을 사용해 동적으로 추가된 요소에 이벤트를 연결함 
		// 문서가 처음 로딩될때만 이벤트가 붙는다 하지만 schul_list는 동적으로 생기기 떄문에 이벤트가 붙지않음 그래서 그부모한테 붙여놓고  
		// 자식이 생겨났을때 자식한테 위임함
		$("#result_field").on("click",".schul_list",function(){
			const text = $(this).text();
			$("#member_schul").val(text);
			memberSchul=text;
			$("#member_schul_msg").text("");
			schulStatus=true;
			
		})
		
			
	</script>
	<script >
		//학년 선택
		$("#member_grade").on("change",function(){
			memberGrade= $("#member_grade").val();
			if(memberGrade=="0"){
				gradeStatus=false;
			}else{
				gradeStatus=true;
				$("#member_grade_msg").text("").css('color','red');
			}
		});
	
	</script>
	
	<script>
		//프로필 이미지
	$("#member_profile").on("change",function(){
		profileStatus=false;
		$("#member_profile_msg").text("");
		$("#previewImg").removeAttr("src").hide();
		const file = this.files[0];
		if(!file){
			$("#member_profile_msg").text("파일을 선택해주세요").css('color','red');
		}else if(!imgReg.test(memberProfile=file.name)){
			$("#member_profile").val("");
			$("#member_profile_msg").text("지원하지 않는 확장자입니다.(jpg ,png 파일만 첨부가능합니다)").css('color','red');
		}else{
			const reader = new FileReader();
			reader.onload = function(e){
				$("#previewImg").attr("src", e.target.result).show();
			};
			 reader.readAsDataURL(file);
			 profileStatus=true;
			
		}
		
	});
	</script>
	<script >
		//정보동의 값
		$("#member_check").on("change",function(){
			checkStatus=$(this).is(":checked");
			if(checkStatus){
				$("#member_check_msg").text("");
			}else{
				$("#member_check_msg").text("약관에 동의해주세요").css('color','red');
			}
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
		}if(!memberPhone || memberPhone===""){
			$("#member_phone_msg").text("전화번호는 필수 정보 입니다.").css('color','red');
		}
		if(!memberRrn || memberRrn===""){
			$("#member_rrn_msg").text("주민등록번호는 필수 정보 입니다.").css('color','red');
		}
		if(!memberAddress || memberAddress===""){
			$("#member_address_msg").text("주소는 필수 정보 입니다.").css('color','red');
		}if(!memberSchul || memberSchul===""){
			$("#member_schul_msg").text("학교명은 필수 정보 입니다.").css('color','red');
		}if (!gradeStatus) {
			 $("#member_grade_msg").text("학년을 선택해주세요").css("color", "red");
		}	
		if(!memberProfile || memberProfile ===""){
			$("#member_profile_msg").text("프로필 이미지는 필수 정보 입니다.").css('color','red');
		}if(!checkStatus){
			$("#member_check_msg").text("약관에 동의해주세요").css('color','red');
		}
		
		
		//모든 유효성 검사가 완료 되었을 시
		if(idStatus && pwStatus && nameStatus && phoneStatus &&rrnStatus && addressStatus && schulStatus && gradeStatus &&
			profileStatus && checkStatus){
				const form = $("#signUp")[0];
				const formData = new FormData(form);
				$.ajax({
					url : "/login/signup",
					type : "post",
					data : formData ,
					enctype : "multipart/form-data",
					contentType : false,
					processData : false,
					cache : false,
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