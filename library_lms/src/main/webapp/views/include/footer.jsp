<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
	footer{
	
		background-color: #333333;
		height: 150px;
		color: white;
		margin-top: 50px;
	}


	.footerImg{
		width: 124px;
		height: 96px;
		margin-right: 40px;
		margin-top: 10px;
	}
	
	.footerBox{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.information{
	margin-right: 80px;
	
	}
	
	span.material-symbols-outlined.icon-footer {
		display: inline-block;
		vertical-align: top;
		margin-right: 5px;
		font-size: 24px !important;
	}
	
	span.footer-detail {
		display: inline-block;
		margin-bottom: 10px;
	}
</style>
<footer>
	
		<div class="footerBox">
			<div class="footerImg">
				<img alt="대체 텍스트" src="/images/logo_invert.png" style="width: 100%; height: 100%; object-fit: cover;">
			</div>
			<div class="informationBox" style="margin-top:30px;">
			<div style="display: flex;">
				<div class="information">
					<span class="material-symbols-outlined icon-footer">location_on</span>
					<span class="footer-detail">서울특별시 금천구 가산디지털2로 95 KM타워 3층 305호</span>
					<br>
					<span class="material-symbols-outlined icon-footer">schedule</span>
					<span class="footer-detail">OFFICE  HOUR : 9:00 - 18:00</span>
				</div>
				<div class="information2">
				<span class="material-symbols-outlined icon-footer">phone_in_talk</span>
					<span class="footer-detail">MAIN OFFICE : 02-818-7950</span>
					<br>
					<span class="material-symbols-outlined icon-footer">schedule</span>
					<span class="footer-detail">STUDENT  HOUR : 7:50 - 24:00</span>
				</div>
			</div>	
				<p style="text-align:center; margin-bottom:5px;">© 2023-2025 Example Corp. All rights reserved.</p>
			</div>
		</div>
	</footer>