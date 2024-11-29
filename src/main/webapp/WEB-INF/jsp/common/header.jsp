<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&display=swap"
	rel="stylesheet">

<style>
/* 전체 헤더 컨테이너 */
header {
	max-width: 1650px; /* main.jsp의 body와 동일한 너비 */
	margin: 0 auto; /* 가운데 정렬 */
	padding: 10px 0;
	display: flex;
	flex-direction: column; /* 두 개의 행을 구성 */
}

.header-top {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 0 20px;
}

.header-auth {
	display: flex;
	gap: 15px; /* 로그인과 회원가입 간격 */
}

.header-auth a {
	text-decoration: none;
	color: #007bff;
	font-size: 14px;
	font-weight: bold;
	transition: color 0.3s ease;
}

.header-auth a:hover {
	color: #0056b3;
}

/* 하단 로고와 메뉴 영역 */
.header-bottom {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-right: 240px;
	margin-left: 240px;
}

/* 로고 영역 */
.header-logo {
	display: flex;
	align-items: center;
}

.header-logo img {
	width: 170px; /* 로고 크기 */
	height: auto;
	margin-right: 15px; /* 로고와 텍스트 사이 여백 */
}

.header-logo h1 {
	font-size: 24px;
	font-weight: bold;
	margin: 0;
	color: #333;
}

/* 메뉴 리스트 */
.header-menu {
	display: flex;
	gap: 20px;
}

.header-menu a {
	text-decoration: none;
	color: #333;
	padding: 5px 10px;
	border-radius: 5px;
	transition: background-color 0.3s ease;
	font-family: "Diphylleia", serif;
	font-weight: 400;
	font-style: normal;
	font-size: 28px;
	
}

.header-menu a:hover {
	background-color: #e9ecef;
}
</style>

<header>
	<!-- 상단 영역: 로그인/회원가입 -->
	<div class="header-top">
		<div class="header-auth">
			<a href="/login">로그인</a> <a href="/signup">회원가입</a>
		</div>
	</div>

	<!-- 하단 영역: 로고와 메뉴 -->
	<div class="header-bottom">
		<!-- 로고 -->
		<div class="header-logo">
			<img src="/resources/img/logo.png" alt="Logo">
		</div>

		<!-- 메뉴 -->
		<div class="header-menu">
			<a href="/recommend">오늘의 추천 메뉴</a> <a href="/wishlist">찜 항목</a> <a
				href="/share">메뉴 자랑</a> <a href="/contact">문의하기</a>
		</div>
	</div>
</header>
