<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Object Detection</title>
    <link rel="stylesheet" href="/resources/css/main.css" />
<style>

</style>
</head>
<body>
    <h1>Object Detection Result</h1>

    <form onsubmit="event.preventDefault(); uploadImage();">
        <label for="file">Upload an image:</label>
        <input type="file" name="file" id="file" required>
        <button type="submit">Upload</button>
    </form>
    <h3>Detection Result:</h3>
    <img id="resultImage" style="display:none; max-width: 500px;" alt="Detection Result">
    <div id="message" style="display: none; color: red; margin-bottom: 20px;"></div>

	<div class="image-grid-container">
		<div class="image-grid">
		</div>
	</div>

    <script>
    function uploadImage() {
        const recipeContainer = document.querySelector(".image-grid");
        const fileInput = document.getElementById("file");
        const formData = new FormData();
        formData.append("file", fileInput.files[0]);

        fetch("/image/upload", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            console.log("Response from server:", data);

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
        });
    }
    </script>
</body>
</html>
