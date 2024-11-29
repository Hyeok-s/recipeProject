<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gothic+A1&display=swap"
	rel="stylesheet">



<head>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
}

.main-image-container {
	position: relative;
	max-width: 1650px;
	height: 450px;
	margin: 0px auto;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-top:20px;
}

.main-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.main-image-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	background: rgba(0, 0, 0, 0.4);
	color: #fff;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
	pointer-events: none;
}

.image-grid-container {
	display: flex;
	justify-content: center;
	margin: 0 auto;
	padding: 0 40px;
	margin-bottom: 40px;
	margin-top: 24px;
}

.image-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 50px;
	justify-content: center;
	max-width: 1560px;
}

.image-grid img {
	width: 350px;
	height: 260px;
	object-fit: cover;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.main-image-overlay a {
	position: absolute;
	top: 128px;
	left: 130px;
	color: #fff;
	font-size: 50px;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
	font-family: "Do Hyeon", sans-serif;
	font-weight: 400;
	font-style: normal;
	font-weight: 400;
}

.footer-text {
	position: absolute;
	top: 180px; /* 위치 조정 */
	left: 130px; /* 위치 조정 */
	color: #fff;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
	font-family: "Black Han Sans", sans-serif;
	line-height: 1.6;
	margin-top: 40px;
}

.footer-text p {
	font-size: 20px;
	font-family: "Gothic A1", sans-serif;
	font-weight: 400;
	font-style: normal;
	margin: 5px 0;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
	<!-- 맨 위에 큰 이미지 추가 -->
	<div class="main-image-container">
		<img class="main-image" src="/resources/img/mainContent.png"
			alt="Main Content Image" />
		<div class="main-image-overlay" id="overlayText">
			<a id="animatedText">레시피 세계에 오신걸 환영합니다.</a>
			<div class="footer-text">
				<p>※ 매일 새로운 요리로 기분 전환하세요!</p>
				<p>※ 지금 당신만의 레시피를 발견해 공유해보세요!</p>
				<p>※ 요리를 더 재미있게, 더 창의적으로 새로운 레시피가 여러분을 기다립니다!</p>
			</div>
		</div>
	</div>

	<!-- 이미지 그리드 -->
	<div class="image-grid-container">
		<div class="image-grid">
			<c:forEach var="recipeInfo" items="${recipeInfos}">
				<img src="${recipeInfo.ATT_FILE_NO_MAIN}" alt="Recipe Image" />
				<a>${recipeInfo.RCP_NM}</a>
				<a>${recipeInfo.RCP_WAY2}</a>
				<a>${recipeInfo.RCP_PAT2}</a>
			</c:forEach>
		</div>
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const textElement = document.getElementById('animatedText');
			const text = textElement.textContent;
			textElement.textContent = '';
			
			for (let i = 0; i < text.length; i++) {
				setTimeout(() => {
					textElement.textContent += text[i];
					textElement.style.opacity = 1;
				}, i * 100); // 100ms 간격으로 글자 추가
			}
		});
	</script>
</body>
</html>
