<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1:wght@100;200;300;400;500;600;700;800;900&family=Gowun+Batang&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>레시피 커뮤니티</title>
<style>
/* 전체 컨테이너 */
.container {
	display: flex;
	max-width: 1700px; /* 좌우로 더 넓게 */
	margin: 30px auto; /* 상단 여백 추가 */
	overflow: hidden;
	gap: 40px; /* 사이드바와 콘텐츠 간격 */
	margin-top: 0px;
}

/* 카테고리 메뉴 */
.sidebar {
	width: 15%; /* 너비 약간 증가 */
	padding: 20px;
	padding-top: 90px;
}

.mainCategory {
	border-top: 3.3px solid #eea3aa;
	border-bottom: 2px solid #e5e5e5;
	padding-top: 10px;
	padding-bottom: 10px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 15px;
}

/* 메인 카테고리 스타일 */
.sidebar ul li>a {
	text-decoration: none;
	font-size: 24px;
	font-family: "Gothic A1", serif;
	font-weight: 600;
	font-style: normal;
	color: #000;
}

.sidebar ul li div>a {
	text-decoration: none;
	font-size: 20px;
	color: #000;
	font-family: "Gothic A1", serif;
	font-weight: 600;
	font-style: normal;
}

.sidebar ul li>a:hover {
	color: #ff7043;
}

.sidebar ul ul {
	padding-left: 20px;
	margin-top: 10px;
}

.sidebar ul ul li>a {
	text-decoration: none;
	font-size: 16px;
	color: #000;
	font-weight: normal;
}

.sidebar ul ul li>a:hover {
	color: #ff5722;
}

.content {
	width: 75%; /* 너비 약간 증가 */
	padding: 20px;
	background-color: #ffffff; /* 콘텐츠 배경 흰색 */
	box-shadow: -4px 0 15px rgba(0, 0, 0, 0.1); /* 왼쪽에만 그림자 */
	margin-top: 0px;
}

.content h1 {
	text-align: center;
	font-size: 42px;
	color: #ff8c42;
	margin-bottom: 30px;
	font-weight: bold;
}

.board-table {
	width: 95%;
	border-collapse: collapse;
	margin-top: 10px;
}

.board-table tr {
	border-bottom: 1px solid #ddd;
}

.board-table th, .board-table td {
	text-align: center;
	font-size: 20px;
	padding-top: 8px;
	padding-bottom: 8px;
	font-family: "Gothic A1", serif;
	font-style: normal;
	font-weight: 500;
}

.board-table th {
	background-color: #ffc5ca;
	color: #363636;
	font-family: "Gothic A1", serif;
	font-style: normal;
	font-weight: 600;
	padding-top: 14px;
	padding-bottom: 14px;
}

.board-table td:first-child {
	width: 60%;
}

.board-table td:first-child(2) {
	width: 20%;
}

.board-table td:nth-child(3) {
	width: 20%;
}

.board-table td:first-child {
	text-align: left; /* 글씨를 왼쪽 정렬 */
	padding-left: 40px; /* 약간의 여백 추가 */
}

.board-table a {
	text-decoration: none;
	color: #000;
	transition: color 0.3s ease;
}

.board-table td:first-child:hover {
	color: #FFA07A;
}

.date {
	display: inline-block;
	font-size: 16px;
}

.search-container {
	display: flex;
	align-items: center;
	margin-top: 20px;
    gap: 20px; 
}

.search-container select,
.search-container input,
.search-container button {
    font-size: 16px;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.search-container select {
    width: 200px;
}

.search-container input {
    width: 300px;
}

.search-container button {
    background-color: #ff8c42;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
    font-weight: bold;
    width: 100px;
}

.search-container button:hover {
    background-color: #ff7043;
}

.search-container .new-post-btn {
    display: inline-block;
    padding: 10px 25px;
    background-color: #ff8c42;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s ease, transform 0.2s ease;
    width: 63px;
    text-align: center;
    margin-left: 195px;
}

.search-container .new-post-btn:hover {
    background-color: #ff7043;
    transform: translateY(-3px); /* Hover 효과로 위로 살짝 떠오르게 */
}

@media ( max-width : 768px) {
	.container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		box-shadow: none;
		padding: 15px;
	}
	.content {
		width: 100%;
		padding: 15px;
	}
}

.main-image {
	width: 80%;
	height: 32%;
	margin: 0 auto;
	display: block;
}

.fa-solid {
	font-size: 6px;
	vertical-align: middle;
	margin-right: 10px;
	color: #4d4d4d;
}

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
.categoryName {
    text-decoration: none;
    font-size: 24px;
    font-family: "Gothic A1", serif;
    font-weight: 600;
    font-style: normal;
    color: #000;
}
.categoryNameDiv{
	margin-top: 20px;
}
</style>
<script src="https://kit.fontawesome.com/adad881590.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="container">
		<!-- 카테고리 메뉴 -->
		<div class="sidebar">
			<ul>
				<li><a href="/community/communityForm">전체 게시판</a></li>
				<c:forEach var="mainCategory" items="${categories.keySet()}">
					<li>
						<div class="mainCategory">
							<c:choose>
								<c:when
									test="${categories[mainCategory].size() == 1 && categories[mainCategory][0].subCategory == null}">
									<a
										href="/community/communityForm?categoryId=${categories[mainCategory][0].id}">▶
										${mainCategory}</a>
								</c:when>
								<c:otherwise>
									<a>▶ ${mainCategory}</a>
								</c:otherwise>
							</c:choose>
						</div>
						<ul>
							<c:forEach var="subCategory" items="${categories[mainCategory]}">
								<c:if test="${subCategory.subCategory != null}">
									<li><a
										href="/community/communityForm?categoryId=${subCategory.id}">${subCategory.subCategory}</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>

		<!-- 게시판 콘텐츠 -->
		<div class="content">
			<img class="main-image" src="/resources/img/communityMain.png"
				alt="Main Content Image">
			<div class="categoryNameDiv">
			<c:choose>
			    <c:when test="${empty categoryName}">
			        <a class="categoryName">전체 게시판</a>
			    </c:when>
			    <c:otherwise>
			        <a class="categoryName">${categoryName}</a>
			    </c:otherwise>
			</c:choose>
			</div>
			<div class="search-container">
			    <!-- 메인 카테고리 -->
			    <select id="mainCategory" name="mainCategory" onchange="loadSubCategories(this.value)">
			        <option value="0">전체 카테고리</option>
			        <c:forEach var="mainCategory" items="${categories.keySet()}">
			            <option value="${mainCategory}">${mainCategory}</option>
			        </c:forEach>
			    </select>
			
			    <!-- 서브 카테고리 -->
			    <select id="subCategory" name="subCategory" disabled>
			        <option value="0">서브 카테고리 선택</option>
			    </select>
			
			    <!-- 검색어 입력 -->
			    <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="search-input">
			
			    <!-- 검색 버튼 -->
			    <button type="button" onclick="search()">검색</button>
			    
			    <a href="/community/writeForm" class="new-post-btn">글쓰기</a>
			</div>

			
			<table class="board-table">
				<thead>
					<tr>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cmuList" items="${cmuLists}">
						<tr class="board-item" data-title="${cmuList.title}">
							<td onclick="location.href='/community/detail?id=${cmuList.id}'"><i
								class="fa-solid fa-square"></i>${cmuList.title}</td>
							<td>${cmuList.nickName}</td>
							<td class="relative-time" data-regdate="${cmuList.regDate}"></td>
							<td>${cmuList.count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="pagination">
				<c:choose>
					<c:when test="${page > 1}">
						<a href="/community/communityForm?categoryId=${param.categoryId}&page=1&mainCategory=${param.mainCategory}&keyword=${param.keyword}">&lt;&lt;</a>
						<a href="/community/communityForm?categoryId=${param.categoryId}&page=${page - 1}&mainCategory=${param.mainCategory}&keyword=${param.keyword}">&lt;</a>
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
							<a href="/community/communityForm?categoryId=${param.categoryId}&page=${i}&mainCategory=${param.mainCategory}&keyword=${param.keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 페이지로 이동 -->
				<c:choose>
					<c:when test="${page < pageCnt}">
						<a
							href="/community/communityForm?categoryId=${param.categoryId}&page=${page + 1}&mainCategory=${param.mainCategory}&keyword=${param.keyword}">&gt;</a>
						<a
							href="/community/communityForm?categoryId=${param.categoryId}&page=${pageCnt}&mainCategory=${param.mainCategory}&keyword=${param.keyword}">&gt;&gt;</a>
					</c:when>
					<c:otherwise>
						<span>&gt;</span>
						<span>&gt;&gt;</span>
					</c:otherwise>
				</c:choose>

			</div>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
    // 페이지 로드 시 상대 시간 계산
    document.addEventListener("DOMContentLoaded", function () {
        const timeElements = document.querySelectorAll(".relative-time");
        const mainCategory = document.querySelector("mainCategory");
        const subCategorySelect = document.getElementById('subCategory');
        // 현재 시간을 기준으로 상대 시간 계산 함수
        const formatRelativeTime = (dateString) => {
            const now = new Date();
            const givenTime = new Date(dateString);
            const diffMs = now - givenTime;
            const diffSeconds = Math.floor(diffMs / 1000);
            const diffMinutes = Math.floor(diffSeconds / 60);
            const diffHours = Math.floor(diffMinutes / 60);
            const diffDays = Math.floor(diffHours / 24);

            if (diffMinutes < 1) {
                return diffSeconds + '초 전';
            } else if (diffHours < 1) {
                return diffMinutes + '분 전';
            } else if (diffDays < 1) {
                return diffHours + '시간 전';
            } else {
                return diffDays + '일 전';
            }
        };

        timeElements.forEach((element) => {
            const regDate = element.getAttribute("data-regdate");
            element.textContent = formatRelativeTime(regDate);
        });
       
    });
    
    
    function loadSubCategories(mainCategory) {
        const subCategory = document.getElementById("subCategory");
        subCategory.disabled = true;
        subCategory.innerHTML = '<option value="0">서브 카테고리 선택</option>';

        if (mainCategory != 0) {
            const url = new URL(`/community/subCategories`, window.location.origin);
            url.searchParams.append("mainCategory", mainCategory);

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    subCategory.disabled = false;
                    data.forEach(sub => {
                        subCategory.innerHTML += `<option value="\${sub.id}">\${sub.subCategory}</option>`;
                    });
                });
        }
    }
    
    function search() {
        const mainCategory = document.getElementById("mainCategory").value;
        const subCategory = document.getElementById("subCategory").value;
        const keyword = document.getElementById("keyword").value;

        const params = new URLSearchParams({
        	mainCategory: mainCategory,
            categoryId: subCategory,
            keyword: keyword
        });

        window.location.href = `/community/communityForm?\${params}`;
    }
    
</script>
</body>
</html>