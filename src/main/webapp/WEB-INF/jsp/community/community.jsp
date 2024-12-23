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
<link rel="stylesheet" href="/resources/css/community.css" />
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