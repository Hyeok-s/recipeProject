<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<head>
<link rel="stylesheet" href="/resources/css/main.css" />

<style>
</style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
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
				<div class="image-item">
					<img src="${recipeInfo.ATT_FILE_NO_MAIN}" alt="Recipe Image"
						onclick="window.location.href='/recipe/detail?RCP_SEQ=${recipeInfo.RCP_SEQ}'" />
					<div class="image-text">
						<span class="recipe-name">${recipeInfo.RCP_NM}</span>
						<div class="recipe-method-category">
							<span class="recipe-method">${recipeInfo.RCP_WAY2}</span> <span
								class="recipe-category">${recipeInfo.RCP_PAT2}</span>
						</div>
					</div>
				</div>
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
