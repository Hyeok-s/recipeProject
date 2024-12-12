<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&display=swap"
	rel="stylesheet">

<style>
header {
	max-width: 1650px;
	margin: 0 auto;
	padding: 10px 0;
	display: flex;
	flex-direction: column;
}

.header-top {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 0 20px;
}

.header-auth {
	display: flex;
	gap: 15px;
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


.header-bottom {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-right: 240px;
	margin-left: 240px;
}


.header-logo {
	display: flex;
	align-items: center;
}

.header-logo img {
	width: 170px;
	height: auto;
	margin-right: 15px;
}

.header-logo h1 {
	font-size: 24px;
	font-weight: bold;
	margin: 0;
	color: #333;
}


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
	<div class="header-top">
	    <div class="header-auth">
	            <c:if test="${empty memberId}">
	                <a href="/member/loginForm">로그인</a>
	                <a href="/member/signUpForm">회원가입</a>
	            </c:if>
	            <c:if test="${not empty memberId}">
	                <a href="/member/logout">로그아웃</a>
	                <a href="/member/myPage">마이페이지</a>
	            </c:if>
	    </div>
	</div>
	<div class="header-bottom">
		<div class="header-logo">
			<img src="/resources/img/logo.png" onclick="window.location.href='/'" alt="Logo">
		</div>

		<div class="header-menu">
			<a href="/recommend">오늘의 추천 메뉴</a> <a href="/wishlist">찜 항목</a> <a
				href="/community/communityForm">메뉴 자랑</a> <a href="/contact">문의하기</a>
		</div>
	</div>
</header>
