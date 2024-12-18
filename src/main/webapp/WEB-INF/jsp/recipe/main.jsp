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

.search-bar {
    display: flex;
    align-items: center;
    gap: 15px;
    flex: 1;
    margin-left: 320px;
}

label {
    font-size: 20px;
    color: #d26d8e;
    font-weight: bold;
}

input[type="text"] {
        padding: 12px 18px;
        font-size: 16px;
        border: 2px solid #ffc0cb;
        border-radius: 8px;
        background-color: #fff;
        color: #333;
        width: 100%;
        max-width: 500px;
        box-sizing: border-box;
    }

input[type="text"]:focus {
        border-color: #f080a9;
        outline: none;
    }
    

.sort-options {
    display: flex;
    gap: 20px;
    align-items: center;
    font-size: 16px;
    margin-right: 320px;
}

.sort-options label {
    display: flex;
    align-items: center;
    gap: 8px;
}

.sort-options input[type="radio"] {
    display: none; /* 기본 라디오 버튼 숨김 */
}

.sort-options label {
    position: relative;
    font-size: 16px;
    padding-left: 30px; /* 체크 마크 공간 확보 */
    cursor: pointer;
    color: #d26d8e;
    font-weight: bold;
}

.sort-options label::before {
    content: ''; /* 기본 상태 */
    position: absolute;
    left: 0;
    top: 0;
    width: 20px;
    height: 20px;
    border: 2px solid #ffc0cb;/* 테두리 색상 */
    border-radius: 3px; /* 체크박스 형태 */
    background-color: white;
    transition: all 0.3s ease;
}

/* 체크된 상태 */
.sort-options input[type="radio"]:checked + label::before {
    background-color: #f080a9; /* 체크된 상태 배경색 */
    border-color: #f080a9;
    content: '✔'; /* 체크 마크 */
    color: white; /* 체크 마크 색상 */
    font-size: 14px;
    text-align: center;
    line-height: 20px; /* 체크 마크 정렬 */
}

.sort-options input[type="radio"]:checked + label {
    color: #f080a9; /* 체크된 라벨 텍스트 색상 */
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
	    <div class="search-bar">
			    <label for="searchQuery">검색</label>
			    <input type="text" id="searchQuery" placeholder="검색어를 입력하세요" />
		</div>
	        <div class="sort-options">
				<input type="radio" name="sortOption" id="latest" value="latest" checked />
			    <label for="latest"> 최신순</label>
			    <input type="radio" name="sortOption" id="popular" value="popular" />
			    <label for="popular"> 인기순</label>
			    <input type="radio" name="sortOption" id="oldest" value="oldest" />
			    <label for="oldest"> 오래된순</label>
			</div>
	</div>
	

		
	<!-- 이미지 그리드 -->
	<div class="image-grid-container">
		<div class="image-grid">
		</div>
	</div>
	

	
	<div class="pagination">
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const textElement = document.getElementById('animatedText');
			const text = textElement.textContent;
			const searchInput = document.getElementById("searchQuery");
	        const sortOptions = document.querySelectorAll('input[name="sortOption"]');
	        const paginationContainer = document.querySelector(".pagination");
	        const recipeContainer = document.querySelector(".image-grid");
			textElement.textContent = '';
			
			for (let i = 0; i < text.length; i++) {
				setTimeout(() => {
					textElement.textContent += text[i];
					textElement.style.opacity = 1;
				}, i * 100); // 100ms 간격으로 글자 추가
			}
			
			function fetchRecipes(page = 1) {
	            const query = searchInput.value;
	            const sort = document.querySelector('input[name="sortOption"]:checked').value;

	            fetch(`/recipe/search?page=\${page}&query=\${query}&sort=\${sort}`)
	                .then(response => response.json())
	                .then(data => {
	                    renderRecipes(data.recipeInfos);
	                    renderPagination(data.page, data.pageCnt);
	                })
	                .catch(error => console.error("Error fetching recipes:", error));
	        }

	        function renderRecipes(recipes) {
	            recipeContainer.innerHTML = ""; // 기존 데이터 삭제
	            recipes.forEach(recipe => {
	                const recipeItem = `
	                    <div class="image-item">
	                        <img src="\${recipe.att_FILE_NO_MAIN}" alt="Recipe Image" 
	                            onclick="window.location.href='/recipe/detail?RCP_SEQ=\${recipe.rcp_SEQ}'" />
	                        <div class="image-text">
	                            <span class="recipe-name">\${recipe.rcp_NM}</span>
	                            <div class="recipe-method-category">
	                                <span class="recipe-method">\${recipe.rcp_WAY2}</span>
	                                <span class="recipe-category">\${recipe.rcp_PAT2}</span>
	                            </div>
	                        </div>
	                    </div>`;
	                recipeContainer.innerHTML += recipeItem;
	            });
	            
	        }

	        function renderPagination(currentPage, totalPages) {
	            const paginationContainer = document.querySelector(".pagination");
	            paginationContainer.innerHTML = ""; // 기존 페이지 삭제
	            if (currentPage > 1) {
	                paginationContainer.innerHTML += `
	                    <a href="#" data-page="1">&lt;&lt;</a>
	                    <a href="#" data-page="\${currentPage - 1}">&lt;</a>
	                `;
	            } else {
	                paginationContainer.innerHTML += `
	                    <span>&lt;&lt;</span>
	                    <span>&lt;</span>
	                `;
	            }

	            const startPage = Math.max(1, currentPage - 2);
	            const endPage = Math.min(totalPages, currentPage + 2);
	            for (let i = startPage; i <= endPage; i++) {
	                if (i === currentPage) {
	                    paginationContainer.innerHTML += `<span class="current">\${i}</span>`;
	                } else {
	                    paginationContainer.innerHTML += `<a href="#" data-page="\${i}">\${i}</a>`;
	                }
	            }

	            if (currentPage < totalPages) {
	                paginationContainer.innerHTML += `
	                    <a href="#" data-page="\${currentPage + 1}">&gt;</a>
	                    <a href="#" data-page="\${totalPages}">&gt;&gt;</a>
	                `;
	            } else {
	                paginationContainer.innerHTML += `
	                    <span>&gt;</span>
	                    <span>&gt;&gt;</span>
	                `;
	            }

	            // 페이지 클릭 이벤트 추가
	            paginationContainer.querySelectorAll("a").forEach(pageLink => {
	                pageLink.addEventListener("click", function (event) {
	                    event.preventDefault();
	                    const page = parseInt(this.getAttribute("data-page"));
	                    fetchRecipes(page);
	                });
	            });
	        }
	        // 검색 이벤트
	        searchInput.addEventListener("input", () => fetchRecipes());
	        sortOptions.forEach(option => {
	            option.addEventListener("change", () => fetchRecipes());
	        });
	        // 초기 로드
	        fetchRecipes();
		});

	</script>
</body>
</html>