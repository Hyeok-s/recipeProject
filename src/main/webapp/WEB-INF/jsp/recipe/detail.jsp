<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recipe Book</title>
<style>
body {
    margin: 0;
    font-family: 'Gowun Batang', serif;
}

.bookBody {
    margin-top: 20px;
    background: #f7f2e9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    perspective: 1500px;
}

.book-cover {
    position: relative;
    width: 80%;
    max-width: 1420px;
    height: 700px;
    background: linear-gradient(145deg, #e0d8c4, #fff);
    border-radius: 15px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    text-align: center;
    padding: 30px;
    transform-style: preserve-3d; /* 3D 회전 효과 적용을 위한 설정 */
    transition: transform 1s ease-in-out; /* 부드러운 회전 애니메이션 */
}

.book-cover::before {
    content: '';
    position: absolute;
    top: 0;
    left: 50%;
    width: 2px;
    height: 100%;
    background: #ccc;
    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1), 2px 0 5px rgba(0, 0, 0, 0.1);
    z-index: 1;
}

.book-title {
    position: absolute;
    font-size: 48px;
    margin: 0;
    color: #6a553e;
    font-family: "Gowun Batang", serif;
    font-weight: 700;
    font-style: normal;
    top: -120px;
}

.book-image {
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 2;
}

.book-image img {
    max-width: 320px;
    width: 320px;
    height: auto;
    border-radius: 50%;
    object-fit: cover;
    position: absolute;
}

.left-image {
    position: absolute;
    left: 0;
    width: 50%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.left-image img {
    max-width: 300px;
    border-radius: 10px;
    transform-origin: left; /* 왼쪽에서 회전하도록 설정 */
}

.ingredients {
    width: 70%;
    padding: 20px;
    text-align: left;
    margin-right: 80px;
}

.ingredients-title {
    font-weight: bold;
    font-size: 35px;
    margin-bottom: 30px;
    font-family: 'Nanum Gothic Coding', monospace;
}

.ingredients li {
    margin-bottom: 5px;
    font-size: 20px;
    line-height: 1.6;
    color: #6a553e;
    padding-left: 15px;
    position: relative;
    list-style: none;
    font-weight: bold;
}

.ingredients li::before {
    content: "✔";
    position: absolute;
    left: 0;
    font-size: 14px;
    color: #6a994e;
}

.right-page {
    position: absolute;
    right: 0;
    top: 0;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: left;
    width: 50%;
    transform-origin: left; /* 왼쪽을 기준으로 회전 */
    backface-visibility: hidden; /* 뒷면이 보이지 않도록 설정 */
}

.nutrition {
    width: 70%;
    padding: 20px;
    text-align: left;
    margin-left: 200px;
    position: absolute;
    top: 40px;
}

.nutrition-info {
    width: 80%;
    padding: 20px;
    background: #faf8f2;
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    font-family: 'Nanum Gothic Coding', monospace;
    color: #444;
}

.nutrition-info h2 {
    font-weight: bold;
    margin-bottom: 20px;
    color: #6a553e;
    border-bottom: 2px solid #e0d8c4;
    padding-bottom: 10px;
}

.info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 15px;
    margin-bottom: 12px;
    font-size: 18px;
    color: #5a5a5a;
    border-radius: 8px;
    background: #ffffff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.tip-container {
    position: absolute;
    bottom: 30px;
    width: 80%;
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    font-family: 'Nanum Gothic Coding', monospace;
    color: #6a553e;
}

.tip-title {
    position: absolute;
    top: -19px;
    left: -19px;
    color: #ff0000;
    font-size: 28px;
    font-weight: bold;
    padding: 5px 10px;
}

.tip-content {
    font-size: 18px;
    font-weight: bold;
    line-height: 1.5;
    margin-top: 10px;
}

/* 애니메이션 키프레임 */
@keyframes pageFlip {
    0% {
        transform: rotateY(0deg);
        opacity: 1;
    }
    50% {
        transform: rotateY(-90deg);
        opacity: 0.5;
    }
    100% {
        transform: rotateY(-180deg);
        opacity: 1;
    }
}
@keyframes fadeOut {
    0% {
        opacity: 1;
    }
    100% {
        opacity: 0;
    }
}

.flipping .left-image {
    animation: fadeOut 1s ease-in-out forwards;
    z-index: 1; /* 오른쪽 페이지 뒤로 들어가도록 조정 */
}

.right-page {
    transform-origin: left; /* 왼쪽을 기준으로 회전 */
    transform: rotateY(0deg);
    transition: transform 1s ease-in-out;
    backface-visibility: hidden;
}

.flipping .right-page {
    animation: pageFlip 1s ease-in-out forwards;
    z-index: 2; /* 오른쪽 페이지가 왼쪽 페이지를 덮도록 설정 */
}

@keyframes fadeOutImage {
    0% {
        opacity: 1;
    }
    50% {
        opacity: 0.5; /* 반투명 상태 */
    }
    100% {
        opacity: 0; /* 완전히 사라짐 */
    }
}

.fade-out-image {
    animation: fadeOutImage 1s ease-in-out forwards; /* 이미지 사라지는 애니메이션 */
}
.next-button {
    position: absolute;
    right: -60px;
    background-color: #dcdcdc;
    border-radius: 50%;
    font-size: 60px;
    color: #6a553e;
    z-index: 3;
    display: flex;
    justify-content: center;
    align-items: center;
    border-style: none;
}
.next-button .arrow {
    display: inline-block;
}

.next-button:hover .arrow {
    color: #ff5733; /* 마우스 오버 시 색상 변경 */
}
.fa-solid{
	padding: 26px;
}
</style>
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="bookBody">
		<div class="book-cover">
			<div class="book-title">${details.RCP_NM}</div>
			<div class="book-image">
				<img src="${details.ATT_FILE_NO_MAIN}" alt="Recipe Image">
			</div>

			<div class="left-image">
				<div class="ingredients">
					<div class="ingredients-title">재료 목록</div>
					<c:forEach var="ingredient" items="${ingredients}">
						<ul>
							<li>${ingredient.RCP_PARTS_DTLS}</li>
						</ul>
					</c:forEach>
				</div>
			</div>

			<div class="right-page">
				<div class="nutrition">
					<div class="ingredients-title">영양 정보</div>
					<div class="nutrition-info">
					<c:set var="nutritionItems" value="${fn:split('INFO_WGT,INFO_ENG,INFO_CAR,INFO_PRO,INFO_FAT,INFO_NA', ',')}" />
						<c:forEach var="item" items="${nutritionItems}">
							<c:choose>
								<c:when test="${not empty details[item]}">
									<div class="info-item">
										<span> <c:choose>
												<c:when test="${item == 'INFO_WGT'}">1인분 기준 무게:</c:when>
												<c:when test="${item == 'INFO_ENG'}">칼로리:</c:when>
												<c:when test="${item == 'INFO_CAR'}">탄수화물:</c:when>
												<c:when test="${item == 'INFO_PRO'}">단백질:</c:when>
												<c:when test="${item == 'INFO_FAT'}">지방:</c:when>
												<c:when test="${item == 'INFO_NA'}">나트륨:</c:when>
											</c:choose>
										</span> <span> ${details[item]} <c:choose>
												<c:when test="${item == 'INFO_WGT'}">g</c:when>
												<c:when test="${item == 'INFO_ENG'}">kcal</c:when>
												<c:when
													test="${item == 'INFO_CAR' || item == 'INFO_PRO' || item == 'INFO_FAT'}">g</c:when>
												<c:when test="${item == 'INFO_NA'}">mg</c:when>
											</c:choose>
										</span>
									</div>
								</c:when>
								<c:otherwise>
									<div class="info-item">
										<span> <c:choose>
												<c:when test="${item == 'INFO_WGT'}">1인분 기준 무게:</c:when>
												<c:when test="${item == 'INFO_ENG'}">칼로리:</c:when>
												<c:when test="${item == 'INFO_CAR'}">탄수화물:</c:when>
												<c:when test="${item == 'INFO_PRO'}">단백질:</c:when>
												<c:when test="${item == 'INFO_FAT'}">지방:</c:when>
												<c:when test="${item == 'INFO_NA'}">나트륨:</c:when>
											</c:choose>
										</span> <span>정보가 없습니다.</span>
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
				<div class="tip-container">
					<div class="tip-title">Tip!</div>
					<div class="tip-content">${details.RCP_NA_TIP}</div>
				</div>
					<!-- 화살표 버튼 -->
			    <button id="nextButton" class="next-button">
					<i class="fa-solid fa-arrow-right"></i>
			    </button>
			</div>
		</div>
	</div>
<script>
//기존 음성 인식 코드와 함께 추가
if ('webkitSpeechRecognition' in window && 'speechSynthesis' in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.lang = 'ko-KR';
    recognition.interimResults = false;
    recognition.maxAlternatives = 1;

    const synth = window.speechSynthesis;

    // 재료 목록 가져오기
    const ingredients = document.querySelectorAll('.ingredients li');

    // 음성 인식 시작
    recognition.addEventListener('start', () => {
        console.log("음성 인식 시작!");
    });

    let isRecognitionStopped = false;
    
    // 음성 인식 결과 처리
    recognition.addEventListener('result', (event) => {
        const transcript = event.results[0][0].transcript.trim();
        console.log(`음성 인식 결과: ${transcript}`);
        console.log(`정확도: ${event.results[0][0].confidence}`);

        if (transcript.includes('다음')) {
            console.log("명령 인식: '다음' -> 버튼 클릭");
            document.getElementById('nextButton').click();
        } else if (transcriptincludes('재료')) {
            console.log("명령 인식: '재료' -> 재료 읽기 시작");
            readIngredients(ingredients);
        } else if (transcriptincludes('꿀팁')) {
            console.log("명령 인식: '팁' -> 팁 읽기 시작");
            readTip();
        } else if (transcriptincludes('도움말')) {
            console.log("명령 인식: '도움말' -> 도움말 읽기 시작");
            readHelp();
        } else if (transcriptincludes('그만')) {
            console.log("명령 인식: '그만' -> 음성 출력 중단");
            synth.cancel();
        } else if (transcriptincludes('마이크 끄기')) {
            console.log("명령 인식: '마이크 끄기' -> 음성 인식 중지");
            recognition.stop();
            isRecognitionStopped = true;
        } else {
            console.log("알 수 없는 명령: ", transcript);
        }
        
        setTimeout(() => { isProcessingCommand = false; }, 1000);
    });

    // 인식 종료 처리
    recognition.addEventListener('end', () => {
    	if (!isRecognitionStopped) {
            console.log("음성 인식 종료, 다시 시작 중...");
            recognition.start(); // 재시작
        } else {
            console.log("음성 인식이 멈췄습니다.");
        }
    });

    // 오류 처리
    recognition.addEventListener('error', (event) => {
        console.error("음성 인식 오류 발생!");
        console.error("오류 코드: ", event.error);

        if (event.error === 'no-speech') {
            console.warn("음성이 감지되지 않았습니다. 다시 시도하세요.");
        } else if (event.error === 'network') {
            console.warn("네트워크 연결 문제. 연결 상태를 확인하세요.");
        } else if (event.error === 'not-allowed') {
            console.warn("마이크 권한이 허용되지 않았습니다. 브라우저 설정을 확인하세요.");
        }
    });

    // 페이지 로드 시 자동 시작
    window.onload = () => {
        recognition.start();
        console.log("음성 인식 자동 시작!");
    };

    // 재료 목록 읽기 함수
    function readIngredients(ingredients) {
        if (ingredients.length === 0) {
            const utterance = new SpeechSynthesisUtterance('재료 목록이 비어 있습니다.');
            utterance.lang = 'ko-KR';
            synth.speak(utterance);
            return;
        }

        ingredients.forEach((ingredient, index) => {
            const utterance = new SpeechSynthesisUtterance();
            utterance.lang = 'ko-KR';
            utterance.text = `\${index + 1}번 재료, \${ingredient.textContent}`;
            console.log(`재료 음성: \${utterance.text}`);
            speechSynthesis.speak(utterance);
        });
        const endMessage = new SpeechSynthesisUtterance('이상 재료 끝');
        endMessage.lang = 'ko-KR';
        speechSynthesis.speak(endMessage);
    }
    
    function readTip() {
        const tipContent = document.querySelector('.tip-content');
        if (!tipContent || !tipContent.textContent.trim()) {
            const utterance = new SpeechSynthesisUtterance('팁이 없습니다.');
            utterance.lang = 'ko-KR';
            synth.speak(utterance);
            return;
        }

        const utterance = new SpeechSynthesisUtterance(`팁 내용: \${tipContent.textContent}`);
        utterance.lang = 'ko-KR';
        synth.speak(utterance);
    }
    
    function readHelp() {
        const utterance = new SpeechSynthesisUtterance(`가능한 명령어는 다음과 같습니다. '다음', '재료', '꿀팁', '그만', '도움말', '마이크끄기'.`);
        utterance.lang = 'ko-KR';
        synth.speak(utterance);
    }
} else {
    console.warn("이 브라우저는 Web Speech API를 지원하지 않습니다.");
}

// 기존 버튼 클릭 이벤트 처리
document.getElementById('nextButton').addEventListener('click', function () {
    const bookCover = document.querySelector('.book-cover');
    const imageElement = document.querySelector('.book-image img');

    // 이미지가 사라지는 애니메이션을 적용
    imageElement.classList.add('fade-out-image');

    // 페이지 전환 애니메이션 클래스 추가
    bookCover.classList.add('flipping');

    // 애니메이션이 끝난 후 페이지 이동
    setTimeout(() => {
        window.location.href = '/recipe/manual?RCP_SEQ=' + ${details.RCP_SEQ};
    }, 1000); // 애니메이션 시간 (1초)
});
</script>
</body>
</html>