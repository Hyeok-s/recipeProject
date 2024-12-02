<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recipe Book</title>
<style>
body {
	margin-top: 8px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.bookBody {
	margin-top: 20px;
	background: #f7f2e9;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.book-cover {
	position: relative;
	width: 80%;
	max-width: 1420px;
	height: 700px;
	background: linear-gradient(145deg, #e0d8c4, #fff);
	border-radius: 15px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	text-align: center;
	padding: 30px;
}

.book-cover::before {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	width: 2px;
	height: 100%;
	background: #ccc;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1), 2px 0 5px rgba(0, 0, 0, 0.1);
}

.book-title {
	font-size: 48px;
	margin: 0;
	color: #6a553e;
	font-weight: bold;
}

.book-subtitle {
	font-size: 24px;
	margin: 10px 0 30px;
	color: #8b7d6b;
}

.navigation {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 50px;
}

.nav-button {
	font-family: 'Georgia', serif;
	background: #6a994e;
	color: white;
	padding: 15px 30px;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	transition: all 0.3s ease;
}

.nav-button:hover {
	background: #52734d;
	transform: translateY(-2px);
}

.book-image {
	width: 150px;
	height: 150px;
	background: #ddd;
	border-radius: 50%;
	margin: 20px 0;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 24px;
	color: #555;
}

.left-image {
	position: absolute;
	left: 0;
	width: 50%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.left-image img {
	max-width: 300px;
	border-radius: 10px;
}

.ingredients {
	width: 50%;
	padding: 20px;
	font-size: 18px;
	text-align: left;
	margin-top: 20px;
}

.ingredients-title {
	font-weight: bold;
	font-size: 24px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="bookBody">
		<div class="book-cover">
			<div class="left-image">
				<img src="${details.ATT_FILE_NO_MAIN}" alt="Recipe Image">
				<div class="ingredients">
					<div class="ingredients-title">필요한 재료</div>
					<c:forEach var="ingredient" items="${ingredients}">
						<li>${ingredient.RCP_PARTS_DTLS}</li>
					</c:forEach>
				</div>

			</div>


			<!-- 책 커버 디자인 -->
			<div class="book-title">${details.RCP_NM}</div>
			<div class="book-subtitle">${details.RCP_PAT2}
				${details.RCP_WAY2}</div>
			<div class="book-image">📖</div>


			<!-- 내비게이션 -->
			<div class="navigation">
				<button class="nav-button"
					onclick="location.href='previousPage.jsp'">이전</button>
				<button class="nav-button" onclick="location.href='detailsPage.jsp'">시작</button>
			</div>
		</div>
	</div>
</body>
</html>
