<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
	body, header{
		margin: 0 0 50px 0;
		padding: 0;
		height: 100px;
	}
	
	header{
	
	background-color: #B6D0E2;
	
	
	}
	.headerImg{
		width: 109px;
		height: 81px;
		margin: 0 auto;
		cursor: pointer;
	}
</style>
<header>
	<div class="headerBox">
		<div class="headerImg">
			<img src="/images/logo.png" style="width: 100%; height: 100%; object-fit: cover; margin-top: 8.5px;"
			onclick="location.href='/'">
		</div>

	</div>
</header>

<script>
window.onpageshow = function(event){   // onpageshow는 page 호출되면 캐시든 아니든 무조건 호출된다.
    if (event.persisted || (window.performance && window.performance.navigation.type == 2)){
        // 사파리 or 안드로이드에서 뒤로가기로 넘어온 경우 캐시를 이용해 화면을 보여주는데, 
        // 이때 사파리의 경우 event.persisted 가 ture다. 
        // 그외 브라우저(크롬 등)에서는 || 뒤에 있는 조건으로 뒤로가기인지 체크가 가능하다!
        window.location.reload();
    }
};
</script>
