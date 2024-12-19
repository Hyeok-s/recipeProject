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
<link rel="stylesheet" href="/resources/css/main.css" />
<style>
.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px;
	margin: 0 auto;
	background-color: #f0f8ff;
	margin-top: 20px;
}

.upload-instruction {
	font-size: 14px;
	color: #555;
	margin-bottom: 20px;
}

.upload-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.file-drop-area {
	flex: 1;
	padding: 15px;
	border: 2px dashed #ccc;
	border-radius: 10px;
	text-align: center;
	background-color: #f0f0f0;
	color: #777;
	cursor: pointer;
	transition: background-color 0.3s, border-color 0.3s;
}

.file-drop-area:hover {
	border-color: #007BFF;
	color: #333;
}

.file-drop-area input[type="file"] {
	display: none;
}

.upload-button {
	padding: 15px 20px;
	background-color: #007BFF;
	color: white;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	font-size: 17px;
	transition: background-color 0.3s;
	margin-left: 15px;
	font-weight: bold;
}

.upload-button:hover {
	background-color: #0056b3;
}

.display-section {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 100%;
	max-width: 1000px;
	margin-top: 20px;
}

.image-box {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 80%;
	height: 300px;
	border: 1px dashed #ccc;
	position: relative;
	margin-left: 30px;
    margin-right: 30px;
}

.image-box img {
	width: 500px;
	max-width: 100%;
	max-height: 100%;
	display: none;
}

.arrow {
	font-size: 45px;
	color: #666;
	font-weight: bold;
}

#detectedLabels {
	margin-top: 20px;
}

.detected-labels-title {
	font-size: 20px;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.detected-labels {
	display: flex;
	flex-wrap: wrap;
}

.label-item {
	background-color: #f0f0f0;
	padding: 8px;
	margin-right: 10px;
	border-radius: 5px;
	font-size: 16px;
	color: #333;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.spinner {
	border: 4px solid #f3f3f3;
	border-top: 4px solid #007BFF;
	border-radius: 50%;
	width: 30px;
	height: 30px;
	animation: spin 1s linear infinite;
	margin: 50px auto;
}

@keyframes spin {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
}
.loading-message {
	text-align: center;
	font-size: 28px;
	color: #666;
	margin-top: 90px;
}

.image-grid-container {
	display: block;
}
</style>
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
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
	<div class="image-grid-container">
		<!-- 안내 문구 -->
		<div class="loading-message" id="loadingMessage">이 부분에 분석 결과가
			표시됩니다.</div>
		<!-- 스피너 -->
		<div class="spinner" id="spinner"></div>
		<div class="image-grid"></div>
	</div>

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