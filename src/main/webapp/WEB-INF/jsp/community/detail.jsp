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
<link rel="stylesheet" href="/resources/css/communityDetail.css" />
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
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
					            <a href="/community/editForm?id=${cmu.id}" class="edit-community">수정</a>
					            <a href="#" class="delete-community" onclick="confirmDelete('${cmu.id}')">삭제</a>
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
					<div class="like-dislike-section">
					    <button class="like-btn" id="like-btn">
					        <c:choose>
					            <c:when test="${isLiked}">
					                <i class="fa-solid fa-thumbs-up"></i>
					            </c:when>
					            <c:otherwise>
					                <i class="fa-regular fa-thumbs-up"></i>
					            </c:otherwise>
					        </c:choose>
					        (<span id="like-count">${countLikesDislikes.likeCount}</span>)
					    </button>
					
					    <button class="dislike-btn" id="dislike-btn">
					        <c:choose>
					            <c:when test="${isDisliked}">
					                <i class="fa-solid fa-thumbs-down"></i>
					            </c:when>
					            <c:otherwise>
					                <i class="fa-regular fa-thumbs-down"></i>
					            </c:otherwise>
					        </c:choose>
					        (<span id="dislike-count">${countLikesDislikes.dislikeCount}</span>)
					    </button>
					</div>
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
	    
	    const likeButton = document.getElementById("like-btn");
        const dislikeButton = document.getElementById("dislike-btn");
        const likeCount = document.getElementById("like-count");
        const dislikeCount = document.getElementById("dislike-count");
	    
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
		 // 좋아요 버튼 클릭 이벤트
	        likeButton.addEventListener("click", function () {
	            fetch('/community/toggleLikeDislike', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify({
	                    communityId: ${cmu.id},
	                    likeStatus: true,
	                }),
	            })
	                .then((response) => response.json())
	                .then((data) => {
	                    if (data.success) {
	                    	dislikeCount.textContent = data.dislikeCount;
	                    	likeCount.textContent = data.likeCount;
	                    	
	                    	const likeIcon = likeButton.querySelector("i");
	                        if (data.isLiked) {
	                        	likeIcon.classList.remove("fa-regular");
	                        	likeIcon.classList.add("fa-solid");
	                        } else {
	                        	likeIcon.classList.remove("fa-solid");
	                        	likeIcon.classList.add("fa-regular");
	                        }
	                        
	                    	const dislikeIcon = dislikeButton.querySelector("i");
	                        if (data.isDisliked) {
	                        	dislikeIcon.classList.remove("fa-regular");
	                        	dislikeIcon.classList.add("fa-solid");
	                        } else {
	                        	dislikeIcon.classList.remove("fa-solid");
	                        	dislikeIcon.classList.add("fa-regular");
	                        }
	                        
	                    } else {
	                        alert('좋아요 처리 중 오류가 발생했습니다.');
	                    }
	                })
	                .catch((error) => {
	                    console.error('좋아요 오류:', error);
	                    alert('좋아요 처리 중 오류가 발생했습니다.');
	                });
	        });
	
	        // 싫어요 버튼 클릭 이벤트
	        dislikeButton.addEventListener("click", function () {
	            fetch('/community/toggleLikeDislike', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify({
	                    communityId: ${cmu.id},
	                    likeStatus: false,
	                }),
	            })
	                .then((response) => response.json())
	                .then((data) => {
	                    if (data.success) {
	                    	dislikeCount.textContent = data.dislikeCount;
	                    	likeCount.textContent = data.likeCount;
	                    	
	                    	const likeIcon = likeButton.querySelector("i");
	                        if (data.isLiked) {
	                        	likeIcon.classList.remove("fa-regular");
	                        	likeIcon.classList.add("fa-solid");
	                        } else {
	                        	likeIcon.classList.remove("fa-solid");
	                        	likeIcon.classList.add("fa-regular");
	                        }
	                    	
	                    	const dislikeicon = dislikeButton.querySelector("i");
	                        if (data.isDisliked) {
	                        	dislikeicon.classList.remove("fa-regular");
	                        	dislikeicon.classList.add("fa-solid");
	                        } else {
	                        	dislikeicon.classList.remove("fa-solid");
	                        	dislikeicon.classList.add("fa-regular");
	                        }
	                        
	                    } else {
	                        alert('싫어요 처리 중 오류가 발생했습니다.');
	                    }
	                })
	                .catch((error) => {
	                    console.error('싫어요 오류:', error);
	                    alert('싫어요 처리 중 오류가 발생했습니다.');
	                });
	        });
	    });
	
	
    function confirmDelete(id) {
        if (confirm('게시물을 삭제하시겠습니까?')) {
            // 확인을 눌렀을 경우 삭제 URL로 이동
            window.location.href = '/community/delete?id=' + id;
        }
    }
</script>
</body>
</html>
