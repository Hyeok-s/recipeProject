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
.pagination {
    display: flex;
    justify-content: center;
    margin: 20px 0;
    gap: 10px;
}

.pagination a,
.pagination span {
    padding: 10px 15px;
    border: 1px solid #ddd;
    text-decoration: none;
    color: #333;
    border-radius: 5px;
}

.pagination a:hover {
    background-color: #f0f0f0;
}

.pagination .current {
    background-color: #ff8c42;
    color: white;
    font-weight: bold;
    cursor: default;
}

.pagination .disabled {
    color: #aaa;
    cursor: not-allowed;
}

.search-container {
        display: flex;
        justify-content: center;
        padding-top: 20px;
        padding-bottom: 20px;
        background-color: #fef5f8;
        border: 2px solid #ffc0cb;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        font-family: 'Arial', sans-serif;
        max-width: 1650px;
        margin: 20px auto;
    }

    form {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    label {
        font-size: 14px;
        color: #d26d8e;
        font-weight: bold;
    }

    select, input[type="text"] {
        padding: 8px 12px;
        font-size: 14px;
        border: 1px solid #ffc0cb;
        border-radius: 8px;
        background-color: #fff;
        color: #333;
    }

    select:hover, input[type="text"]:hover {
        border-color: #f080a9;
    }

    .btn-search {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #f080a9;
        color: #fff;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn-search:hover {
        background-color: #d26d8e;
    }
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
	
	<div class="search-container">
	    <form id="searchForm" method="get" action="/home/main">
	        <label for="method">방식</label>
	        <select id="method" name="method">
	            <option value="">전체</option>
	            <option value="굽기" <c:if test="${method == '굽기'}">selected</c:if>>굽기</option>
	            <option value="끓이기" <c:if test="${method == '끓이기'}">selected</c:if>>끓이기</option>
	            <option value="볶기" <c:if test="${method == '볶기'}">selected</c:if>>볶기</option>
	            <option value="찌기" <c:if test="${method == '찌기'}">selected</c:if>>찌기</option>
	            <option value="튀기기" <c:if test="${method == '튀기기'}">selected</c:if>>튀기기</option>
	            <option value="기타" <c:if test="${method == '기타'}">selected</c:if>>기타</option>
	        </select>
	
	        <label for="category">종류</label>
	        <select id="category" name="category">
	            <option value="">전체</option>
	            <option value="국&찌개" <c:if test="${category == '국&찌개'}">selected</c:if>>국&찌개</option>
	            <option value="밥" <c:if test="${category == '밥'}">selected</c:if>>밥</option>
	            <option value="일품" <c:if test="${category == '일품'}">selected</c:if>>일품</option>
	            <option value="반찬" <c:if test="${category == '반찬'}">selected</c:if>>반찬</option>
	            <option value="후식" <c:if test="${category == '후식'}">selected</c:if>>후식</option>
	            <option value="기타" <c:if test="${category == '기타'}">selected</c:if>>기타</option>
	        </select>
	
	        <label for="searchQuery">검색</label>
	        <input type="text" id="searchQuery" name="searchQuery" value="${searchQuery}" placeholder="검색어를 입력하세요" />
	
	        <button type="submit" class="btn-search">검색</button>
	    </form>
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
	
	<div class="pagination">
				<c:choose>
					<c:when test="${page > 1}">
						<a
							href="/home/main?method=${method}&category=${category}&searchQuery=${searchQuery}&page=1">&lt;&lt;</a>
						<a
							href="/home/main?method=${method}&category=${category}&searchQuery=${searchQuery}&page=${page - 1}">&lt;</a>
					</c:when>
					<c:otherwise>
						<span>&lt;&lt;</span>
						<span>&lt;</span>
					</c:otherwise>
				</c:choose>

				<c:set var="startPage" value="${page - 2}" />
				<c:set var="endPage" value="${page + 2}" />

				<c:if test="${startPage < 1}">
					<c:set var="startPage" value="1" />
				</c:if>

				<c:if test="${endPage < 5}">
					<c:set var="endPage" value="5" />
				</c:if>

				<c:if test="${endPage > pageCnt}">
					<c:set var="endPage" value="${pageCnt}" />
				</c:if>

				<!-- 페이지 번호 출력 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == page}">
							<span class="current">${i}</span>
						</c:when>
						<c:otherwise>
							<a
								href="/home/main?method=${method}&category=${category}&searchQuery=${searchQuery}&page=${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 페이지로 이동 -->
				<c:choose>
					<c:when test="${page < pageCnt}">
						<a
							href="/home/main?method=${method}&category=${category}&searchQuery=${searchQuery}&page=${page + 1}">&gt;</a>
						<a
							href="/home/main?method=${method}&category=${category}&searchQuery=${searchQuery}&page=${pageCnt}">&gt;&gt;</a>
					</c:when>
					<c:otherwise>
						<span>&gt;</span>
						<span>&gt;&gt;</span>
					</c:otherwise>
				</c:choose>

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
