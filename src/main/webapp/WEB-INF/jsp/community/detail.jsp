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
	max-width: 1700px;
	margin: 30px auto;
	overflow: hidden;
	gap: 40px;
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
</style>
<style>
.content {
	width: 65%;
	margin: 0 auto;
	background: #fff;
	padding: 20px;
	margin-top: 100px;
	height: auto;
}

.post-title {
	font-size: 2rem;
	margin-bottom: 10px;
}

.post-meta {
	font-size: 0.9rem;
	color: #555;
	margin-bottom: 20px;
}

.post-meta span {
	margin-right: 15px;
}

.post-body {
	font-size: 1rem;
	margin-bottom: 20px;
}

.comment-section {
	margin-top: 40px;
}

.comment-list {
	list-style: none;
	padding: 0;
}

.comment-item {
	border-bottom: 1px solid #ccc;
	padding: 15px 0;
	 display: flex;
	flex-direction: column;  /* 세로로 정렬 */
    align-items: flex-start;  /* 기본 왼쪽 정렬 */
}

.comment-actions {
	display: flex;
	justify-content: flex-end;
	width: 100%;
}

.comment-meta {
	font-size: 0.9rem;
	color: #666;
	width: 100%;
}

.comment-form {
	display: flex;
	align-items: stretch;
	margin-top: 20px;
}

.comment-input {
	resize: none;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
	margin-bottom: 0;
	flex-grow: 1;
}

.btn {
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	color: white;
	cursor: pointer;
	text-decoration: none;
	text-align: center;
}

.submit-btn {
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	color: white;
	cursor: pointer;
	text-decoration: none;
	text-align: center;
	background-color: #007bff;
}

.back-btn {
	background-color: #007bff; /* 파란색 */
}

.edit-btn {
	background-color: #28a745; /* 초록색 */
}

.delete-btn {
	background-color: #dc3545; /* 빨간색 */
}

@media ( max-width : 600px) {
	.content {
		padding: 10px;
	}
	.post-title {
		font-size: 1.5rem;
	}
	.comment-input {
		height: 80px;
	}
	.comment-actions a {
		font-size: 0.8rem;
		padding: 4px 8px;
	}
	.comment-edit-input {
		font-size: 0.9rem;
	}
}
.comment-edit-input {
	resize: none;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
	margin-bottom: 0;
	flex-grow: 1;
	width: 84%;
}

/* 댓글 버튼 스타일 */
.comment-actions a {
	padding: 5px 5px;
	text-decoration: none;
	border-radius: 5px;
	font-size: 0.9rem;
	color: #5a5252;
	transition: background-color 0.3s, transform 0.2s;
	font-family: "Gothic A1", sans-serif;
	font-weight: bold;
}


.comment-actions .save-comment {
	background-color: #28a745; /* 초록색 */
	margin-top: 10px;
}

.comment-top{
	display: flex;
	width: 100%;
}
.save-comment{
	padding: 10px 15px;
    border: none;
    border-radius: 4px;
    color: white;
    cursor: pointer;
    text-decoration: none;
    text-align: center;
    background-color: #007bff;
}
.post-actions{
	float: right;
}
.post-actions a{
	padding: 5px 5px;
    text-decoration: none;
    border-radius: 5px;
    font-size: 0.9rem;
    color: #5a5252;
    transition: background-color 0.3s, transform 0.2s;
    font-family: "Gothic A1", sans-serif;
    font-weight: bold;
}
</style>
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
		<div class="content">
			<!-- 게시글 상세보기 -->
			<div class="post-container">
				<div class="post-detail">
					<h1 class="post-title">${cmu.title}</h1>
					<div class="post-meta">
						<span class="author">작성자: <strong>${cmu.nickName}</strong></span>
						<span class="date"> 작성일: <span class="relative-time"
							data-regdate="${cmu.regDate}">${cmu.regDate}</span>
						</span> <span class="views">조회수: ${cmu.count}</span>
						<c:if test="${cmu.memberId == memberId}">
					        <div class="post-actions">
					            <a href="/community/editCommunity?id=${cmu.id}" class="edit-community">수정</a>
					            <a href="/community/delete?id=${cmu.id}" class="delete-community">삭제</a>
					        </div>
					    </c:if>
					</div>
					<div class="divider"></div>
					<div class="post-body">
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
				</div>

				<!-- 댓글 섹션 -->
				<div class="comment-section">
					<h2>댓글</h2>
					<ul class="comment-list" id="comment-list">
						<!-- 서버에서 전달받은 댓글 데이터 렌더링 -->
						<c:forEach var="comment" items="${comments}">
							<li class="comment-item" id="comment-${comment.id}">
								<div class = "comment-top">
									<div class="comment-meta">
										<span class="comment-author">작성자: ${comment.nickName}</span> <span
											class="comment-date" data-regdate="${comment.updateDate}">작성일:
											${comment.updateDate}</span>
									</div>
									 <c:if test="${memberId == comment.memberId}">
										<div class="comment-actions">
											<a href="#" class="edit-comment" data-id="${comment.id}">수정</a>
											| <a href="#" class="delete-comment" data-id="${comment.id}">삭제</a>
										</div>
									</c:if>
								</div>
								<div class="comment-body">${comment.body}</div>
							</li>
						</c:forEach>
					</ul>
					<div class="comment-form">
						<textarea placeholder="댓글을 입력하세요..." id="comment-input"
							class="comment-input"></textarea>
						<button class="btn submit-btn" id="submit-comment">댓글 작성</button>
					</div>
				</div>

				<!-- 버튼 -->
				<div class="post-actions">
					<a href="/community/communityForm" class="btn back-btn">목록으로</a> <a
						href="/community/edit?id=${cmu.id}" class="btn edit-btn">수정</a> <a
						href="/community/delete?id=${cmu.id}" class="btn delete-btn">삭제</a>
				</div>
			</div>
		</div>
	</div>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const commentInput = document.getElementById("comment-input");
	    const submitButton = document.getElementById("submit-comment");
	    const commentList = document.getElementById("comment-list");
		const memberId = ${memberId};
	    let isLoggedIn = false;
	    
	    //로그인 확인
	    const checkLogin = async () => {
	        try {
	            const response = await fetch("/community/checkLogin");
	            if (!response.ok) throw new Error("로그인 상태 확인 실패");
	            const data = await response.json();
	            isLoggedIn = data.loggedIn;
	            return isLoggedIn;
	        } catch (error) {
	            console.error("로그인 확인 오류:", error);
	            alert("로그인 상태 확인 중 오류가 발생했습니다.");
	            return false;
	        }
	    };
	    
	 // 댓글창 클릭 시 로그인 확인
	    commentInput.addEventListener("focus", async () => {
	        const loggedIn = await checkLogin();
	        if (!loggedIn) {
	            alert("로그인이 필요한 기능입니다. 로그인 후 이용해주세요.");
	            commentInput.blur();
	        }
	    });

	    // 댓글 추가 함수
	    const addCommentToDOM = (comment) => {
	        const newComment = document.createElement("li");
	        newComment.classList.add("comment-item");
	        newComment.id = `comment-\${comment.id}`;
	        
	        const topDiv = document.createElement("div");
	        topDiv.classList.add("comment-top");

	        const metaDiv = document.createElement("div");
	        metaDiv.classList.add("comment-meta");
	        metaDiv.textContent = `작성자: \${comment.nickName}  작성일: \${comment.updateDate}`;

	        const bodyDiv = document.createElement("div");
	        bodyDiv.classList.add("comment-body");
	        bodyDiv.textContent = comment.body;

	        topDiv.appendChild(metaDiv);

	        if (memberId === comment.memberId) {
	            const actionsDiv = document.createElement("div");
	            actionsDiv.classList.add("comment-actions");
	            actionsDiv.innerHTML = `
	                <a href="#" class="edit-comment" data-id="\${comment.id}">수정</a> |
	                <a href="#" class="delete-comment" data-id="\${comment.id}">삭제</a>
	            `;
	            topDiv.appendChild(actionsDiv);
	        }


	        newComment.appendChild(topDiv);
	        
	        newComment.appendChild(bodyDiv);
	        commentList.prepend(newComment);
	    };

	    // 댓글 작성
	    submitButton.addEventListener("click", function () {
	        const commentContent = commentInput.value.trim();
	        if (!commentContent) {
	            alert("댓글 내용을 입력하세요.");
	            return;
	        }

	        const payload = {
	            communityId: ${cmu.id},
	            body: commentContent,
	        };

	        fetch(`/community/addComment`, {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json",
	            },
	            body: JSON.stringify(payload),
	        })
	            .then((response) => {
	                if (!response.ok) {
	                    throw new Error("댓글 작성 실패");
	                }
	                return response.json();
	            })
	            .then((data) => {
	                addCommentToDOM(data);
	                commentInput.value = "";
	            })
	            .catch((error) => {
	                console.error("댓글 작성 오류:", error);
	                alert("댓글 작성 중 오류가 발생했습니다.");
	            });
	    });

	    // 이벤트 위임: 수정 및 삭제 버튼 클릭 처리
	    commentList.addEventListener("click", function (event) {
	        event.preventDefault();

	        const target = event.target;
	        
	        const commentId = target.dataset.id;
	        
	        if (target.classList.contains("edit-comment")) {
	            const commentId = target.dataset.id;
	            if (!commentId) return;
	            const commentItem = document.getElementById(`comment-\${commentId}`);
	            const commentBody = commentItem.querySelector(".comment-body");
	            const originalContent = commentBody.textContent.trim();


	            const editInput = document.createElement("textarea");
	            editInput.classList.add("comment-edit-input");
	            editInput.value = originalContent;

	            // 저장 버튼 추가
				const saveButton = document.createElement("button");
		        saveButton.classList.add("save-comment");
		        saveButton.textContent = "저장";
		        
		        const actionsDiv = document.createElement("div");
		        actionsDiv.style.display = "flex";
		        actionsDiv.style.width = "100%";

		        actionsDiv.appendChild(editInput);
		        actionsDiv.appendChild(saveButton);
		        
		        commentBody.replaceWith(actionsDiv);

	            saveButton.addEventListener("click", function () {
	                const updatedContent = editInput.value.trim();
	                if (!updatedContent) {
	                    alert("댓글 내용을 입력하세요.");
	                    return;
	                }

	                fetch(`/community/editComment`, {
	                    method: "POST",
	                    headers: { "Content-Type": "application/json" },
	                    body: JSON.stringify({ id: commentId, body: updatedContent }),
	                })
	                    .then((response) => {
	                        if (!response.ok) {
	                            throw new Error("댓글 수정 실패");
	                        }
	                        return response.json();
	                    })
	                    .then((data) => {
	                        const updatedBody = document.createElement("div");
	                        updatedBody.classList.add("comment-body");
	                        updatedBody.textContent = data.body;
	                        editInput.replaceWith(updatedBody);
	                        actionsDiv.removeChild(saveButton);
	                    })
	                    .catch((error) => {
	                        console.error("댓글 수정 오류:", error);
	                        alert("댓글 수정 중 오류가 발생했습니다.");
	                    });
	            });
	        }

	        // 댓글 삭제
	        if (target.classList.contains("delete-comment")) {
	            const commentId = target.dataset.id;
	            if (!commentId) return;
	            if (confirm("댓글을 삭제하시겠습니까?")) {
	                fetch(`/community/deleteComment`, {
	                    method: "POST",
	                    headers: { "Content-Type": "application/json" },
	                    body: JSON.stringify({ id: commentId }),
	                })
	                    .then((response) => {
	                        if (!response.ok) {
	                            throw new Error("댓글 삭제 실패");
	                        }
	                        return response.json();
	                    })
	                    .then((data) => {
			                if (data.success) {
			                    const commentItem = document.getElementById(`comment-\${commentId}`);
			                    commentItem.remove();
			                    alert(data.message); 
			                } else {
			                    alert(data.message);
			                }
			            })
	                    .catch((error) => {
	                        console.error("댓글 삭제 오류:", error);
	                        alert("댓글 삭제 중 오류가 발생했습니다.");
	                    });
	            }
	        }
	    });
	});
</script>
</body>
</html>
