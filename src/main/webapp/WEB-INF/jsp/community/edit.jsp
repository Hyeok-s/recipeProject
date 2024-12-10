<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="pageTitle" value="글 수정" />
<style>
/* 동일한 스타일 적용 */
.container {
    display: flex;
    max-width: 1700px;
    margin: 30px auto;
    overflow: hidden;
    gap: 40px;
}

.sidebar {
    width: 15%;
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

.form-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}

.input-title {
    width: 100%;
    padding: 8px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.submit-button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/jsp/common/header.jsp"%>
    <%@ include file="/WEB-INF/jsp/common/toastUiEditorLib.jsp"%>
    <div class="container">
        <div class="sidebar">
            <ul>
                <li><a href="/community/communityForm">전체 게시판</a></li>
                <c:forEach var="mainCategory" items="${categories.keySet()}">
                    <li>
                        <div class="mainCategory">
                            <c:choose>
                                <c:when test="${categories[mainCategory].size() == 1 && categories[mainCategory][0].subCategory == null}">
                                    <a href="/community/communityForm?categoryId=${categories[mainCategory][0].id}">▶ ${mainCategory}</a>
                                </c:when>
                                <c:otherwise>
                                    <a>▶ ${mainCategory}</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <ul>
                            <c:forEach var="subCategory" items="${categories[mainCategory]}">
                                <c:if test="${subCategory.subCategory != null}">
                                    <li><a href="/community/communityForm?categoryId=${subCategory.id}">${subCategory.subCategory}</a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="content">
            <form action="/community/edit?id=${community.id}" method="post" onsubmit="submitForm(this); return false;">
                <div class="form-title">게시글 수정</div>

                <input class="input-title" type="text" name="title" placeholder="제목을 입력하세요" value="${community.title}" />

				<div class="form-group">
				    <label for="mainCategorySelect">메인 카테고리</label>
				    <select id="mainCategorySelect" class="input-title" name="mainCategory">
				        <option value="" selected>메인 카테고리를 선택하세요</option>
				        <c:forEach var="mainCategory" items="${categories.keySet()}">
				            <option value="${mainCategory}" ${mainCategory == category.mainCategory ? 'selected' : ''} required>${mainCategory}</option>
				        </c:forEach>
				    </select>
				</div>
				
				<div class="form-group">
				    <label for="subCategorySelect">서브 카테고리</label>
				    <select id="subCategorySelect" class="input-title" name="subCategory" required>
				        <option value="" selected>서브 카테고리를 선택하세요</option>
				        <c:forEach var="subCategory" items="${categories[category.mainCategory]}">
				            <option value="${subCategory.id}" ${subCategory.id == category.id ? 'selected' : ''} required>${subCategory.subCategory}</option>
				        </c:forEach>
				    </select>
				</div>

                <input type="hidden" name="body" />
                <div id="toast-ui-editor">
                	<c:forEach var="content" items="${contentList}">
				        <c:choose>
				            <c:when test="${content['type'] == 'text'}">
				                <p>${content['value']}</p>
				            </c:when>
				            <c:when test="${content['type'] == 'image'}">
				                <img src="${content['value']}" alt="Community Image">
				            </c:when>
				        </c:choose>
				    </c:forEach>
                </div>

                <button type="submit" class="submit-button">수정</button>
            </form>
        </div>
    </div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const mainCategorySelect = document.getElementById("mainCategorySelect");
        const subCategorySelect = document.getElementById("subCategorySelect");
        const categories = ${categoriesJson};

        mainCategorySelect.addEventListener("change", function () {
            const selectedMainCategory = mainCategorySelect.value;
            subCategorySelect.innerHTML = '<option value="" selected>서브 카테고리를 선택하세요</option>';
            subCategorySelect.disabled = true;

            if (selectedMainCategory && categories[selectedMainCategory]) {
                const subCategoryList = categories[selectedMainCategory];

                if (subCategoryList.length > 0) {
                    subCategoryList.forEach(subCategory => {
                        if (subCategory.subCategory) {
                            const option = document.createElement("option");
                            option.value = subCategory.id;
                            option.textContent = subCategory.subCategory;
                            subCategorySelect.appendChild(option);
                        }
                    });
                    subCategorySelect.disabled = false;
                }
            }
        });
    });
</script>
</body>
</html>
