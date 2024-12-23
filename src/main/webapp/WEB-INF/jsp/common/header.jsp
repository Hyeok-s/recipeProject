<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&display=swap"
	rel="stylesheet">

<link rel="stylesheet" href="/resources/css/header.css" />

<header>
	<div class="header-top">
	    <div class="header-auth">
			<c:if test="${empty memberId or memberId == -1 or memberId == 0}">
			    <a href="/member/loginForm">로그인</a>
			    <a href="/member/signUpForm">회원가입</a>
			</c:if>
			<c:if test="${not empty memberId and memberId != -1}">
			    <a href="/member/logout">로그아웃</a>
			    <a href="/member/mypageForm">마이페이지</a>
			</c:if>
	    </div>
	</div>
	<div class="header-bottom">
		<div class="header-logo">
			<img src="/resources/img/logo.png" onclick="window.location.href='/'" alt="Logo">
		</div>

		<div class="header-menu">
			<a href="#">오늘의 추천 메뉴</a> <a href="/wishList/mainForm">찜 항목</a> <a
				href="/community/communityForm">메뉴 자랑</a> <a href="/search/mainForm">분석하기</a>
		</div>
	</div>
</header>