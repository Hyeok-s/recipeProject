<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/memberLogin.css" />

</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="form-body">
		<div class="container">
			<h1>로그인</h1>
			<form action="/member/login" method="post">
				<input type="text" name="email" id="email" placeholder="이메일"
					required>
				<div id="emailError" style="color: red;"></div>
				<input type="password" name="pw" id="pw" placeholder="비밀번호" required>
				<div id="pwError" style="color: red;"></div>
				<button type="submit">로그인</button>
			</form>
			<div class="extra-info">
				계정이 없으신가요? <a href="/member/signup">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>
