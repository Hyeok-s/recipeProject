<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
body {
	margin: 0;
}

.form-body {
	background: linear-gradient(to bottom, #fef5e7, #ffe6cc);
	color: #4d4d4d;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80vh;
	margin-top: 20px;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	text-align: center;
	width: 90%;
	max-width: 500px;
	background: #ffffff;
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	padding: 40px;
	position: relative;
}

h1 {
	font-size: 36px;
	color: #ff8c42;
	margin-bottom: 25px;
	font-weight: bold;
}

form {
	width: 100%;
}

input {
	width: 97%;
	padding: 15px 15px;
	margin: 15px 0;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 18px;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

button {
	width: 100%;
	padding: 15px;
	background-color: #ff8c42;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 20px;
	font-weight: bold;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

button:hover {
	background-color: #ff7043;
	transform: scale(1.05);
}

.extra-info {
	margin-top: 20px;
	font-size: 16px;
	color: #666;
}

.extra-info a {
	color: #ff8c42;
	text-decoration: none;
	font-weight: bold;
}

.extra-info a:hover {
	text-decoration: underline;
}

@media ( max-width : 768px) {
	.container {
		width: 95%;
		padding: 25px;
	}
	h1 {
		font-size: 30px;
	}
	button {
		font-size: 18px;
		padding: 12px;
	}
}
</style>
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
