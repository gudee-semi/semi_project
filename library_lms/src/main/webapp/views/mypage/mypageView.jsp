<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
</head>
<style>
	p {
      font-size: 13px;
      margin-top: 8px;
      margin-bottom : 5px;
    }
    .update_box input:focus{
    	border:1px solid #205DAC;
    	outline:none;
    }
	#schul_modal{
		display:none;
		position: fixed;
		top:200px;
		background-color:white;
		z-index: 9999;
		margin : 50px auto;
		border:none;
	}
	#schul_modal .modal_box {
		background-color: white;
		width: 400px;
		border-radius: 10px;
		padding: 20px;
		box-shadow: 0 2px 10px rgba(0,0,0,0.3);
		position: relative;
	}
	/* 제목 영역 */
	#modal_title {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: end;
	}
	
	/* 닫기 버튼 */
	#modal_close_btn {
		background-color: #D8E5F4;
		border: none;
		font-size: 16px;
		cursor: pointer;
		color: #333;
		width : 50px;
		border-radius:5px;
		transition: background-color 0.3s;
		
	}
	#modal_close_btn:hover{
		background-color: #205DAC;
		color:white;
	}
	
	/* 검색 필드 */
	#modal_content {
		margin-top: 10px;
		display: flex;
		gap: 10px;
	}
	
	#schul_name {
		flex: 1;
		padding: 5px;
		border-radius: 5px;
		border : 1px solid #D8E5F4;
		outline: none; 
		transition: background-color 0.3s;
		height:40px;
	}
	#schul_name:focus{
		border : 1px solid #205DAC;
	}
	#schul_search {
		border-radius:5px;
		border:none;
		padding: 5px 10px;
		cursor: pointer;
		background-color: #D8E5F4;
		color:black;
		transition: background-color 0.3s;
		height:40px;
	}
	#schul_search:hover{
		background-color: #205DAC;
		color:white;
	}
	
	/* 결과 필드 */
	#result_field {
		margin-top: 15px;
		max-height: 200px;
		overflow-y: auto;
		border-top: 1px solid #ddd;
		padding-top: 10px;
	}
	
	#result_field ul {
		list-style: none !important;
		padding: 0;
		margin: 0;
	}
	
	#result_field ul li {
		padding: 5px 10px;
		border-bottom: 1px solid #eee;
		cursor : pointer;
		transition: background-color 0.3s;
	}
	#result_field ul li:hover{
	 	background-color: #D8E5F4;
	}
	.title_text{
		color: #205dac;
		margin : 20px auto 30px;
		font-size: 20px;
	}
	
	/* 주소 모달 */
	#layer{
		display:none;
		background-color:white;
		position :absolute;
		overflow:hidden;
		z-index:30;
		border:1px solid #888;
		border-radius:5px;
		width:500px;
		height:400px;
		margin :50px auto;
		top:200px;
		
		
		
	}
	#layer>div{
		background-color:#D8E5F4; 
		position:relative; 
		height:35px; 
		z-index:2;
	}
	#addressCloseBtn{
		position :absolute; 
		top:3px;
		right:3px;
		z-index:2;
		background-color: white;
		color: black;
		border-radius: 5px;
		border:none;
		transition: background-color 0.3s;
	}
	#addressCloseBtn:hover{
		background-color: #205DAC;
		color: white;
	}
	.update_title{
		margin:0 auto 30px;
	}
	
	.container_box{
	
		padding-top : 100px;
		display:flex;
		justify-content: start;
		flex-direction: column;
		height:1200px;
	}
	.update_box{
		position:relative;
		margin: 0 auto;
		padding :50px 50px 30px;
		border-radius: 5px;
		border:1px solid #ccc;
	}
	.update_box input{
	  padding: 12px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      column-gap: 5px;
      width:200px;
      height:50px;
      box-sizing: border-box;
	}
	.update_box input[type="button"]{
	  width:80px;
	  height:50px;
	  box-sizing:border-box;
	  background-color: #D8E5F4;
	  color: black;
	  transition: background-color 0.3s;
	  cursor:pointer;
	}
	.update_box input[type="button"]:hover{
	  background-color: #205DAC;
	  color:white;
	}
	.update_box input[type="submit"]{
		position:relative;
		right:-285px;
	  background-color: #D8E5F4;
	  color: black;
	  transition: background-color 0.3s;
	  cursor:pointer;
	}
	.update_box input[type="submit"]:hover{
	  background-color: #205DAC;
	  color:white;
	}
		#member_address{
		width:400px;
	}
	#member_schul{
		width:300px;
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
	.file-label {
	  display: inline-block;
	  padding: 12px;
	  background-color: #D8E5F4;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	  border: 1px solid #ccc;
	  transition: background-color 0.3s;
	  box-sizing:border-box;
	  width:80px;
	  height:50px;
	  font-size: 14px;
	}
	
	.file-label:hover {
	  background-color: #205DAC;
	  color: white;
	}
	
	#file-name {
	  margin-left: 10px;
	  font-size: 14px;
	  color: #555;
	}
	#member_address_detail{
	margin-left: 85px;
	}
	.update_pw{
		
		display:flex;
		flex-direction:column;
		align-items: center;
		border:1px solid #ccc;
		padding:10px;
		border-radius: 5px;
		margin-bottom:20px;
	}
	.update_pw p:first-child{
		font-size:20px;
		font-weight:600;
	}
	.delete_box{
		margin-top: 30px;
	}
	.delete_box input[type="submit"]{
		background-color: #dc2626;
		color: white;
		cursor:pointer;
		}
	.delete_box input[type="submit"]:hover{
		background-color: red;
		color: white;
		}
</style>
<body>

<!--비밀번호 -->
<%@ include file="/views/include/header.jsp" %>
<div class="container_box">
	<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
	<h1 class="update_title">개인정보 수정</h1>
	<div class="update_box">
		<form id="updateAccount">
			<div class="update_pw">
				<p>비밀번호 변경 </p>
				<input type="password" id="member_pw" name="member_pw" placeholder="새로운 비밀번호 입력">
				<input type="password" id="member_pw_check" placeholder="비밀번호 확인">
				<p id="member_pw_msg"></p>
			</div>
			<!-- 전화번호  -->
			<span style="margin:0 11px 0 10px;">전화번호</span>
			<input type="text" id="member_phone" name="member_phone"
					placeholder="전화번호">
					
				<p id="member_phone_msg"></p>
			
			<!--주소 검색  -->
			<input type="button" id = "addressBtn" value="주소검색">
			<input type="text" id="member_address" name="member_address" readonly>
			<p></p>
			<input type="text" id="member_address_detail" name="member_address_detail" placeholder="상세주소">
				<!--주소 모달창  -->
			<div id="layer">
				<div>
				 <button type="button" id ="addressCloseBtn" >닫기</button>
				</div>
				<div id="addressWindow" style="width :100%; height : 100%;">
				</div>
			</div>
			<p id= "member_address_msg"></p>
			
			<!-- 학교 검색  -->
			<input type="button" id = "member_schul_search" value="학교검색">
			<input type="text" id="member_schul" name="member_schul" readonly>
			<p id = "member_schul_msg">
			
			<!-- 학교 검색 모달 -->
			<div id="schul_modal">
				<div class ="modal_box">
					<div id = "modal_title">
						<button type= "button" id ="modal_close_btn">닫기</button>
						<p class="title_text">학교 검색</p>
				
					</div>
				<div id = "modal_content">
					<div id = "search_field"></div>
						<input id = "schul_name" type="text" placeholder="학교이름 입력" > 
						<button type= "button" id = "schul_search">검색</button>
					</div>
					<div id = "result_field">
					 
					</div>
				</div>
			</div>
			<!-- 학년 입력 -->
			<div class="schul_grade_select">
				<span style="margin:0 13px 0 38px;">학년</span>
				<select id ="member_grade" name="member_grade">
				<option value="1">1학년</option>
				<option value="2">2학년</option>
				<option value="3">3학년</option>
			</select>
				<p></p>
			</div>
			
			<!-- 프로필 이미지 첨부 -->
			<label for="member_profile" class="file-label">파일선택</label>
			<input type="file" id = "member_profile" name = "member_profile" hidden>
			<span id="previewImg_msg">선택된 파일 없음</span>
			<p id ="member_profile_msg"></p>
			
			<img id="previewImg"width="200px" height="200px" hidden>
			<p></p>
			<input type="submit" value="수정하기"/>
			
		</form>
		<div class="delete_box">
			<form id="deleteMember" action="/delete/member" method="get">
				<input type="submit" value="계정삭제">
			</form>
		</div>
	</div>
	
</div>
<%@ include file="/views/include/footer.jsp" %>
	<script>
		const memberNo = ${sessionScope.loginMember.memberNo};
		const memberAccountAddress = '${sessionScope.loginMember.memberAddress}';
		const memberAccountSchool ='${sessionScope.loginMember.memberSchool}';
		const memberAccountGrade = '${sessionScope.loginMember.memberGrade}';
		const memberAccountPhone = '${sessionScope.loginMember.memberPhone}';
	</script>
	<script >
	//페이지 들어왔을 때 그 계정의 정보를 뿌려줌
		$(document).ready(function() {
		  $("#member_address").val(memberAccountAddress);
		  $("#member_schul").val(memberAccountSchool);
		  $("#member_grade").val(memberAccountGrade);
		  $("#member_phone").val(memberAccountPhone);
		  $.ajax({
			url : "/file/DealWith?memberNo="+memberNo,
			type : "get",
			dataType : "json",
			success : function(data){
					$("#previewImg").attr("src",'/profile/filePath?filePath='+data.path).show();
					$("#previewImg_msg").text(data.oriname);
			}
		  });
		});
		
	</script>
	<script>
 	// 변수 설정, 정규식 설정
	let pwStatus =true;
	let rrnStatus = true;
	let addressStatus = true;
	let schulStatus= true;
	let gradeStatus= true;
	let profileStatus = true;
	let phoneStatus= true;
	const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
	const imgReg = /\.(jpg|png)$/i;
	const phoneReg = /^010([0-9]{4})([0-9]{4})$/;
	let memberPw="";
	let member_pw_check="";
	let memberAddress="";
	let memberSchul="";
	let memberGrade=0;
	let memberProfile="";
	let memberPhone="";
</script>
	<script>
	//비밀번호 정규식 검사 , 비밀번호 재확인 
	$("#member_pw, #member_pw_check").on("input blur",function(){
		pwStatus=false;
		memberPw = $("#member_pw").val().trim();
		member_pw_check = $("#member_pw_check").val().trim();
		if(memberPw==""&&member_pw_check==""){
			pwStatus=true;
			$("#member_pw_msg").text("").css('color','red');
			return;
		}
		if (!pwReg.test(memberPw)){
			$("#member_pw_msg").text("비밀번호:6~12자의 영문 소문자,숫자 특수기호(!@#$%^&*?)만 사용가능합니다.").css('color','red');
		}else if(memberPw!==member_pw_check){
			$("#member_pw_msg").text("비밀번호가 일치하지 않습니다.").css('color','red');
		}else{
			$("#member_pw_msg").text("").css('color','red');
			pwStatus=true;
		}
	});
	</script>
	<script>
	
	//전화번호 정규식 
	$("#member_phone").on("input blur",function(){
		phoneStatus=false;
		memberPhone = $("#member_phone").val().trim();
		if(memberPhone === ""){
			$("#member_phone_msg").text("전화번호를 입력해주세요.").css('color','red');
			phoneStatus=true;
		}else if (!phoneReg.test(memberPhone)){
			$("#member_phone_msg").text("전화번호 형식이 잘못 되었습니다.(-제외, 010으로 시작)").css('color','red');
		}else if(memberPhone !== memberAccountPhone){
			$.ajax({
				url : "/login/member/repeatcheck",
				type : "post",
				data : {member_phone  : memberPhone},
				dataType :"json",
				success : function(data) {
					if(data.phoneCheck=="no"){
					$("#member_phone_msg").text("이미 등록된 전화번호 입니다.").css('color','red');
					}else{
					$("#member_phone_msg").text("").css('color','red');
						phoneStatus=true;
					}
				}
			});
		}else{
			$("#member_phone_msg").text("").css('color','red');
			memberPhone="";
			phoneStatus=true;
			
		}
	});
	
	</script>
	
	
	
	
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	//주소 모달닫기
	$("#addressCloseBtn").on("click",function(){
	    document.getElementById('layer').style.display = 'none';
	});
	//주소검색 버튼 클릭
	$("#addressBtn").on("click",function(){
		let element_layer = document.getElementById('layer');
		element_layer.style.display = 'block';
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
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
	$("#member_schul_search").on("click",function(){
		  document.getElementById('schul_modal').style.display = 'block';
	})
	$("#modal_close_btn").on("click",function(){
		document.getElementById('schul_modal').style.display = 'none';
		$("#result_field").html("");
		$("#schul_name").val("");
	})
	
	$("#schul_modal").on("keydown", function(e) {
    if (e.key === "Enter") {	
        e.preventDefault(); // 메인 폼 제출 방지
        $("#schul_search").click(); // 원하는 버튼 수동 실행
    }
	});
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
							$("#result_field").text("없는 학교입니다.").css('color','red');
						}else{
							for(let i = 0 ; i <name.length; i++){
								result+="<li class = 'schul_list'>"+name[i]+"</li>";
							}
							$("#result_field").css('color','black').html("<ul>" + result + "</ul>");
						}	
					},
					error: function(){
						Swal.fire({
							  text: "학교정보를 불러올수 없습니다.",
							  icon: "warning",
							  confirmButtonColor: '#205DAC'
							});
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
			document.getElementById('schul_modal').style.display = 'none';
			$("#result_field").html("");
			$("#schul_name").val("");
		})
		
			
	</script>
		<script >
		//학년 선택
		$("#member_grade").on("change",function(){
			memberGrade= $("#member_grade").val();
			gradeStatus=true;
			
		});
	
	</script>
	
	<script>
	//프로필 이미지
		
		
	$("#member_profile").on("change", function () {
	    profileStatus = false;
	    $("#member_profile_msg").text("");
	    $("#previewImg").removeAttr("src").hide();
	    const file = this.files[0];
	    const maxSize = 3 * 1024 * 1024; // 3MB
	
	    if (!file) {
	        $("#member_profile_msg").text("파일을 선택해주세요.").css('color', 'red');
	        profileStatus=true;
	        return;
	    }
	
	    // 확장자 체크
	    if (!imgReg.test(file.name)) {
	        $(this).val("");
	        $("#file-name").text("선택된 파일 없음");
	        $("#member_profile_msg").text("지원하지 않는 확장자입니다.(jpg, png만 허용)").css('color', 'red');
	        profileStatus=true;
	        return;
	    }
	
	    // 용량 체크
	    if (file.size > maxSize) {
	        $(this).val("");
	        $("#file-name").text("선택된 파일 없음");
	        $("#member_profile_msg").text("파일 크기는 3MB 이하만 허용됩니다.").css('color', 'red');
	        profileStatus=true;
	        return;
	    }
	
	    // 해상도 체크
	    const img = new Image();
	    const objectURL = URL.createObjectURL(file);
	    img.onload = function () {
	        if (img.width > 1200 || img.height > 1200) {
	            $("#member_profile_msg").text("이미지 해상도는 1200x1200px 이하만 허용됩니다.").css('color', 'red');
	            $("#member_profile").val("");
	            $("#file-name").text("선택된 파일 없음");
	            URL.revokeObjectURL(objectURL);
	            profileStatus = true;
	            return;
	        }
	
	        // 모두 통과했을 때
	        $("#file-name").text(file.name);
	        memberProfile=file.name;
	        const reader = new FileReader();
	        reader.onload = function (e) {
	            $("#previewImg").attr("src", e.target.result).show();
	        };
	        reader.readAsDataURL(file);
	        profileStatus = true;
	        URL.revokeObjectURL(objectURL);
	    };
	
	    img.onerror = function () {
	        $("#member_profile_msg").text("이미지 파일을 불러올 수 없습니다.").css('color', 'red');
	        $("#member_profile").val("");
	        $("#file-name").text("선택된 파일 없음");
	        URL.revokeObjectURL(objectURL);
	        profileStatus=true;
	    };
	
	    img.src = objectURL;
	});
		
		
		
		
		
	</script>

	
	
	<script>
		$("#updateAccount").on("submit",function(e){
			e.preventDefault();
			if(pwStatus && addressStatus && schulStatus && gradeStatus &&profileStatus&& phoneStatus ){
				const form = document.getElementById("updateAccount");
				const formData = new FormData(form);
				formData.set("member_pw", memberPw);
				formData.set("member_address", memberAddress);
				formData.set("member_schul", memberSchul);
				formData.set("member_grade", memberGrade);
				formData.set("member_no", memberNo);
				formData.set("member_phone",memberPhone);
				
				$.ajax({
					url : "/update/member",
					type : "post",
					data : formData,
					enctype : "multipart/form-data",
					contentType : false,
					processData : false,
					cache : false,
					dataType :"json",
					success : function(data){
						if(data.res_code==500){
							Swal.fire({
								  title: "변경실패",
								  text: "서버 오류입니다.",
								  icon: "warning",
								  confirmButtonColor: '#205DAC'
								}).then(() => {
									location.href ="<%=request.getContextPath()%>/mypage/view";
								});
						}else{
							Swal.fire({
								  title: "변경성공",
								  text: "개인 정보가 수정 되었습니다.",
								  icon: "success",
								  confirmButtonColor: '#205DAC'
								}).then(() => {
									location.href ="<%=request.getContextPath()%>/main";
								});
							 
							 
						}					
					}
					
				});
			

			}
		
		})
		
	
	</script>

	<script>
		$("#deleteMember").on("submit",function(e){
			e.preventDefault();
			const form =this;
			Swal.fire({
				  title: "계정 삭제",
				  text: "정말로 계정을 삭제하시겠습니까?",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#205DAC",
				  cancelButtonColor: "#d33",
				  confirmButtonText: "삭제",
				  cancelButtonText: "취소"
				}).then((result) => {
				  if (result.isConfirmed) {
				    Swal.fire({
				      title: "삭제!",
				      text: "삭제되었습니다!",
				      icon: "success"
				    }).then(()=>{
				    form.submit(); 				    	
				    })
				  }
				});
		})
	
	</script>





















</body>
</html>