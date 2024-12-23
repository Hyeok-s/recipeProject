<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<head>
<link rel="stylesheet" href="/resources/css/searchMain.css" />
<link rel="stylesheet" href="/resources/css/main.css" />
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.22/dist/full.min.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

	<div class="container">
		<!-- 업로드 섹션 -->
		<div class="upload-instruction">※사진 선택 후 분석하기 클릭시 분석이 시작됩니다.</div>

		<!-- 업로드 섹션 -->
		<div class="upload-section">
			<form onsubmit="event.preventDefault(); uploadImage();"
				style="display: flex; align-items: center; gap: 10px;">
				<!-- 파일 선택 -->
				<label class="file-drop-area" for="file"> 파일을 여기에 놓으세요 <input
					type="file" name="file" id="file" required accept="image/*"
					onchange="previewImage(event)">
				</label>
				<!-- 업로드 버튼 -->
				<button type="submit" class="upload-button">분석하기</button>
			</form>
		</div>

		<!-- 이미지 표시 섹션 -->
		<div class="display-section">
			<!-- 왼쪽 이미지 박스 -->
			<div class="image-box" id="previewBox">
				<img id="previewImage" alt="Preview">
			</div>

			<!-- 화살표 -->
			<div class="arrow">→</div>

			<!-- 오른쪽 이미지 박스 -->
			<div class="image-box" id="resultBox">
				<img id="resultImage" alt="Detection Result">
			</div>
		</div>

		<div id="message" style="display: none; color: red; margin-top: 20px;"></div>
		<div class="detected-labels" id="detectedLabels"></div>

	</div>
	<div class="image-grid-container" style="display: block !important;">
		<!-- 안내 문구 -->
		<div class="loading-message" id="loadingMessage">이 부분에 분석 결과가
			표시됩니다.</div>
		<!-- 스피너 -->
		<div class="spinner" id="spinner"></div>
		<div class="image-grid"></div>
	</div>
		<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
	<script>
    // 이미지 선택 시 미리보기 표시
    function previewImage(event) {
        const fileInput = event.target;
        const previewImage = document.getElementById("previewImage");

        if (fileInput.files && fileInput.files[0]) {
            const reader = new FileReader();

            // 파일이 로드되었을 때 실행
            reader.onload = function (e) {
                previewImage.src = e.target.result; // Base64로 변환된 이미지 데이터 설정
                previewImage.style.display = "block"; // 이미지 표시
            };

            reader.readAsDataURL(fileInput.files[0]); // 파일 읽기 (Base64로 변환)
        } else {
            previewImage.style.display = "none"; // 파일이 없을 경우 이미지 숨김
        }
    }
    
    function uploadImage() {
    	const recipeContainerDiv = document.querySelector(".image-grid-container");
        const recipeContainer = document.querySelector(".image-grid");
        const fileInput = document.getElementById("file");
        const formData = new FormData();
        const spinner = document.getElementById("spinner");
        const loadingMessage = document.getElementById("loadingMessage");
        
        formData.append("file", fileInput.files[0]);

        if (!fileInput.files.length) {
            alert("먼저 파일을 선택해주세요!");
            return;
        }
        spinner.style.display = "block";
        loadingMessage.style.display = "block";
        recipeContainer.innerHTML = "";
        
        fetch("/image/upload", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
        	spinner.style.display = "none";
            loadingMessage.style.display = "none";
            recipeContainerDiv.style.display="flex";
            // 분석된 이미지 결과 표시
            if (data.resultImageUrl) {
                const resultImage = document.getElementById("resultImage");
                resultImage.src = data.resultImageUrl;
                resultImage.style.display = "block";
            }

            const messageContainer = document.getElementById("message");
            recipeContainer.innerHTML = "";

            switch (data.result) {
                case 0: // 재료를 인식하지 못한 경우
                    messageContainer.innerText = data.message || "사진 내 인식된 재료가 없습니다.";
                    messageContainer.style.display = "block";
                    break;

                case 1: // 검색된 레시피가 없는 경우
                    messageContainer.innerText = data.message || "검색된 레시피가 없습니다.";
                    messageContainer.style.display = "block";
                    break;

                case 2: // 검색된 레시피가 있는 경우
                    messageContainer.style.display = "none"; // 메시지 숨김
                    if (data.recipes && data.recipes.length > 0) {
                        data.recipes.forEach(recipe => {
                            const recipeItem = `
                            	<div class="image-item">
	                                <img src="\${recipe.att_FILE_NO_MAIN}" alt="Recipe Image" 
	                                	data-rcp-seq=\"${recipe.rcp_SEQ}"
	                                    onclick="window.location.href='/recipe/detail?RCP_SEQ=\${recipe.rcp_SEQ}'" />
	                                <div class="image-text">
	                                    <span class="recipe-name">\${recipe.rcp_NM}</span>
	                                    <div class="recipe-method-category">
	                                        <span class="recipe-method">\${recipe.rcp_WAY2}</span>
	                                        <span class="recipe-category">\${recipe.rcp_PAT2}</span>
	                                    </div>
	                                </div>
                                </div>
                            `;
                            recipeContainer.innerHTML += recipeItem;
                        });
                    }
                    const detectedLabelsContainer = document.getElementById("detectedLabels");
                    let labelsHtml = '<div class="detected-labels-title">인식된 재료 <i class="fa-solid fa-copy"></i></div><div class="detected-labels">';
                    
                    data.detectedLabels.forEach((label, index) => {
                        labelsHtml += `<span class="label-item">\${label}</span>`;
                        if (index < data.detectedLabels.length - 1) {
                            labelsHtml += ' ';
                        }
                    });

                    labelsHtml += '</div>';
                    detectedLabelsContainer.innerHTML = labelsHtml;
                    detectedLabelsContainer.style.display = 'block';
                    break;

                default:
                    messageContainer.innerText = "알 수 없는 오류가 발생했습니다.";
                    messageContainer.style.display = "block";
                    break;
            }
        })
        .catch(error => {
            console.error("Error uploading image:", error);
            const messageContainer = document.getElementById("message");
            messageContainer.innerText = "이미지를 업로드하는 도중 오류가 발생했습니다.";
            messageContainer.style.display = "block";
            
            spinner.style.display = "none";
            loadingMessage.style.display = "none";
        });
    }
    </script>
</body>
</html>