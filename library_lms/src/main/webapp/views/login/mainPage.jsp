<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하연 독서실</title>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main/main.css">
<style>
	
	.sidebars {
		width: 300px;
		height: 850px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
	}
	
	.container {
		flex: 1;
	}
	
	header {
		margin: 0 !important;
	}
	
	footer {
		margin-top: 0px !important;
	}
	
	.background-image {
		display: flex;
		align-items: flex-end;
		justify-content: center;
	}
	
	.notice-section, .qna-section {
		width: 35%;
		height: 235px;
		background-color: rgba(0, 0, 0, 0.5);
		padding: 20px;
		color: white;
		margin: 50px;
	}
	
	.section-header {
		display: flex;
		justify-content: space-between;
		border-bottom: 1px solid #fff;
		margin: 5px 40px 10px 40px;
		
	}
	.section-header strong {
		font-size: 25px;
		margin-bottom: 15px;
		margin-left: 15px;
	}
	.section-plus {
		font-size: 24px;
		margin-right: 15px;
		cursor: pointer;
	}
	.section-plus:hover {
		text-decoration: underline;
	}
	
	.section-row {
		display: flex;
		font-size: 18px;
		justify-content: space-between;
		margin: 8px 45px;
	}
	.link {
		cursor: pointer;
	}
	.link:hover {
		text-decoration: underline;
	}

.background-image span {
	color: #ffffff;
	font-size: 18px;
	opacity: 1;
}

.link:hover {
	text-decoration: underline;
}

.weather-box {
	position: absolute;
	top: 14px;
	right: 40px;
}

.weather-wrapper {
	width: 141px;
	height: 54px;
	display: flex;
	align-items: center;
	border: 2px solid white;
	border-radius: 20px;
	padding: 8px 8px;
	background-color: rgba(0, 0, 0, 0.05);
	color: white;
}

.weather-left {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-right: 10px;
}

.weather-icon {
	position: absolute;
	top: 3px;
	right: 121px;
	width: 80px;
	height: 80px;
}

.city-name {
	position: absolute;
	top: 62px;
	right: 144px;
	color: #fff;
	font-size: 12px;
}
.weather-info {
	position: absolute;
	top: 27px;
	right: 60px;
	color: #fff;
	font-size: 14px;
	display: flex;
  flex-direction: column;
  gap: 5px; /* 원하는 간격(px, rem 등) */
}
</style>

</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<div class="background-image" style="background-image: url('<%= request.getContextPath() %>/images/wallpaper.gif'); background-repeat: no-repeat; height: 850px; background-size: cover;">
			    <!-- 공지사항 -->
			    <div class="notice-section">
			        <div class="section-header">
			            <strong>공지사항</strong>
			            <span class="section-plus" onclick="location.href='<c:url value="/notice/list"/>'">+</span>
			        </div>
			        <c:forEach var="notice" items="${noticeList}" varStatus="status" begin="0" end="4">
			            <div class="section-row">
			                <span onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'" class="link">${notice.title}</span>
			                <span>${notice.createAt}</span>
			            </div>
			        </c:forEach>
			    </div>
			
			    <!-- 질의응답 영역 -->
			    <div class="qna-section">
			        <div class="section-header">
			            <strong>질의응답</strong>
			            <span class="section-plus" onclick="location.href='<c:url value="/qna/view"/>'">+</span>
			        </div>
			        <c:forEach var="qna" items="${qnaList}" varStatus="status" begin="0" end="4">
			            <div class="section-row">
			                <span onclick="location.href='<c:url value="/qna/detail?no=${qna.qnaId }"/>'" class="link">${qna.title}</span>
			                <span>${qna.regDate}</span>
			            </div>
			        </c:forEach>
			    </div>
			    
			</div>
		</div>
		
		
		<div class="weather-box">
		  <div class="weather-wrapper">
		    <div class="weather-left">
		    </div>
		  </div>
		</div>
		
		<img class="weather-icon" id="icon" src="/images/weather_default.png" alt="날씨 아이콘">
		<div class="city-name" id="cityName"></div>
		
		<div class="weather-info">
		  <div>기온 <span id="temperature"></span> ℃</div>
		  <div>습도 <span id="humidity"></span> %</div>
		</div>
		
	<script>
		$(document).ready(function() {
			// 영어 도시명을 한글로 매핑
			
		    $.ajax({
		        url: "/weatherservlet",
		        method: "GET",
		        dataType: "json",
		        success: function(data) {
		        	
		            $("#cityName").text(data.cityName);
		            $("#weather").text(data.weather);
		            $("#icon").attr("src", "https://openweathermap.org/img/wn/" + data.icon + "@2x.png");
		            $("#temperature").text(parseInt(data.temperature));
		            $("#feelsLike").text(data.feelsLike);
		            $("#humidity").text(data.humidity);
		            $("#windSpeed").text(data.windSpeed);
		        },
		        error: function() {
		            $(".weather-box").text("날씨 정보를 불러올 수 없습니다.");
		        }
		    });
		});
	</script>
		
		
        
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>