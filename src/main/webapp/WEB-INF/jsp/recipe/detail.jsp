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
<link rel="stylesheet" href="/resources/css/recipeDetail.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recipe Book</title>

<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
<style>
.question {
    position: absolute;
    top: 10px;
    right: 124px;
    font-size: 25px;
    color: #6a553e;
    cursor: pointer;
    z-index: 10;
    align-items: center;
    display: inline-flex;
    }
</style>
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
			<i class="fa-solid fa-microphone-slash microphone">
  				<span class="dot">●</span>
			</i>
			<i class="fa-solid fa-volume-high volume"></i>
			<i class="fa-solid fa-question question"></i>
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
					>
			    </button>
			</div>
		</div>
	</div>
	
	<!-- 팝업 창 -->
	<div id="popup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border: 1px solid #ccc; padding: 20px; z-index: 1000;">
	    <img id="popupImage" src="/resources/img/help1.png" alt="Popup Image">
	    <button id="closePopup" style="margin-top: 10px;">닫기</button>
	</div>
	<div id="popupOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
<script>
let isRecognitionActive = ${isRecognitionActive};
let isVolumeOn = ${isVolumeOn};

document.addEventListener("DOMContentLoaded", function() {
	const popup = document.getElementById('popup');
    const popupOverlay = document.getElementById('popupOverlay');
    const popupImage = document.getElementById('popupImage');
    const closePopup = document.getElementById('closePopup');
    const questionIcon = document.querySelector('.fa-question');
    
    // 마이크 아이콘 처리
    const microphoneIcon = document.querySelector(".fa-microphone-slash");
    if (${isRecognitionActive}) {
        microphoneIcon.classList.remove("fa-microphone-slash");
        microphoneIcon.classList.add("fa-microphone");
        const dot = microphoneIcon.querySelector('.dot');
        dot.style.color = 'red'
    } else {
        microphoneIcon.classList.remove("fa-microphone");
        microphoneIcon.classList.add("fa-microphone-slash");
    }


    // 볼륨 아이콘 처리
    const volumeIcon = document.querySelector(".fa-volume-high");

    if (${isVolumeOn}) {
        volumeIcon.classList.remove("fa-volume-xmark");
        volumeIcon.classList.add("fa-volume-high");
    } else {
        volumeIcon.classList.remove("fa-volume-high");
        volumeIcon.classList.add("fa-volume-xmark");
    }
    
 // 팝업 열기
    questionIcon.addEventListener('click', function () {
        popup.style.display = 'block'; // 팝업 보이기
        popupOverlay.style.display = 'block'; // 배경 오버레이 보이기
    });

    // 팝업 닫기
    closePopup.addEventListener('click', function () {
        popup.style.display = 'none'; // 팝업 숨기기
        popupOverlay.style.display = 'none'; // 배경 오버레이 숨기기
    });

    // 오버레이 클릭 시 팝업 닫기
    popupOverlay.addEventListener('click', function () {
        popup.style.display = 'none';
        popupOverlay.style.display = 'none';
    });
});
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

    
    // 음성 인식 결과 처리
    recognition.addEventListener('result', (event) => {
        const transcript = event.results[0][0].transcript.trim();
        console.log(`음성 인식 결과: ${transcript}`);
        console.log(`정확도: ${event.results[0][0].confidence}`);

        if (transcript.includes('다음')) {
            console.log("명령 인식: '다음' -> 버튼 클릭");
            synth.cancel();
            document.getElementById('nextButton').click();
        } else if (transcript.includes('재료')) {
            console.log("명령 인식: '재료' -> 재료 읽기 시작");
            synth.cancel();
            readIngredients(ingredients);
        } else if (transcript.includes('꿀팁')) {
            console.log("명령 인식: '팁' -> 팁 읽기 시작");
            synth.cancel();
            readTip();
        } else if (transcript.includes('도움말')) {
            console.log("명령 인식: '도움말' -> 도움말 읽기 시작");
            synth.cancel();
            readHelp();
        } else if (transcript.includes('그만')) {
            console.log("명령 인식: '그만' -> 음성 출력 중단");
            synth.cancel();
        } else if (transcript.includes('마이크 끄기')) {
            console.log("명령 인식: '마이크 끄기' -> 음성 인식 중지");
            recognition.stop();
            document.querySelector('.microphone').click();
        } 
        else if (transcript.includes('소리 꺼')) {
            console.log("명령 인식: '소리 끄기' -> 소리 중지");
            synth.cancel();
            document.querySelector('.volume').click();
        }
        else if (transcript.includes('소리 켜')) {
            console.log("명령 인식: '소리 켜기' -> 소리 켜기");
            synth.cancel();
            document.querySelector('.volume').click();
        }
        else if (transcript.includes('닫기')) {
            console.log("명령 인식: '닫기'");
            if (popup.style.display === 'block') {
                // 팝업이 열려 있으면 닫기
                popup.style.display = 'none';
                popupOverlay.style.display = 'none';
                const utterance = new SpeechSynthesisUtterance('도움말을 닫았습니다.');
                utterance.lang = 'ko-KR';
                synth.speak(utterance);
            } else {
                // 팝업이 열려 있지 않음
                const utterance = new SpeechSynthesisUtterance('도움말이 켜져 있지 않습니다.');
                utterance.lang = 'ko-KR';
                synth.speak(utterance);
            }
        }
        else {
            console.log("알 수 없는 명령: ", transcript);
        }
        
        setTimeout(() => { isProcessingCommand = false; }, 1000);
    });

    //윈도우 시작시 마이크, 소리 시작여부
    window.onload = () => {
    	synth.cancel();
    	 if (${isRecognitionActive}) {
    	        recognition.start();
    	        console.log("음성 인식 자동 시작");
    	    } else {
    	        console.log("음성 인식 시작되지 않음");
    	    }
    };
    
    // 인식 종료 처리
    recognition.addEventListener('end', () => {
    	if (isRecognitionActive) {
            console.log("음성 인식 종료, 다시 시작 중...");
            recognition.start(); // 재시작
        } else {
            console.log("음성 인식이 멈췄습니다.");
        }
    });

    //음성인식 버튼 처리
    document.querySelector('.fa-microphone-slash').addEventListener('click', function () {
        const icon = this;

        // 아이콘 변경
        if (icon.classList.contains('fa-microphone-slash')) {
            icon.classList.remove('fa-microphone-slash');
            icon.classList.add('fa-microphone');
            isRecognitionActive = true;
            recognition.start();
            console.log("음성 인식 시작");
            
        } else {
            icon.classList.remove('fa-microphone');
            icon.classList.add('fa-microphone-slash');
            console.log("음성 인식 중지");
            isRecognitionActive = false;
            recognition.stop();
        }

        // dot 색상 변경
        const dot = icon.querySelector('.dot');
        if (dot) {
            dot.style.color = icon.classList.contains('fa-microphone') ? 'red' : '#6a553e';
        }
    });
    
    
    //볼륨인식 버튼 처리
    document.querySelector('.fa-volume-high').addEventListener('click', function () {
        const icon = this;

        // 아이콘 변경
        if (icon.classList.contains('fa-volume-high')) {
            icon.classList.remove('fa-volume-high');
            icon.classList.add('fa-volume-xmark');
            isVolumeOn = false;
            synth.cancel();
            console.log("볼륨 끔");
        } else {
            icon.classList.remove('fa-volume-xmark');
            icon.classList.add('fa-volume-high');
            isVolumeOn = true;
            console.log("볼륨 켬");
        }

        // dot 색상 변경
        const dot = icon.querySelector('.dot');
        if (dot) {
            dot.style.color = icon.classList.contains('fa-microphone') ? 'red' : '#6a553e';
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

    // 재료 목록 읽기 함수
    function readIngredients(ingredients) {
    	
    	if (!isVolumeOn) {
            console.log("볼륨이 꺼져 있어 재료를 읽지 않습니다.");
            return;
        }
    	
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
    //팁 읽기
    function readTip() {
        if (!isVolumeOn) {
            console.log("볼륨이 꺼져 있어 팁을 읽지 않습니다.");
            return;
        }
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
    //도움말 읽기
    function readHelp() {
    	if (!isVolumeOn) {
            console.log("볼륨이 꺼져 있어 도움말을 읽지 않습니다.");
            return;
        }
        popup.style.display = 'block'; // 팝업 보이기
        popupOverlay.style.display = 'block';
        const utterance = new SpeechSynthesisUtterance(`가능한 명령어는 '다음', '재료', '꿀팁', '도움말', '그만', '마이크끄기'. '소리 꺼', '소리 켜', '닫기' 가 있습니다.`);
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
        window.location.href = '/recipe/manual?RCP_SEQ=' + ${details.RCP_SEQ} + '&isRecognitionActive=' + isRecognitionActive + '&isVolumeOn=' + isVolumeOn;
    }, 1000); // 애니메이션 시간 (1초)
});


</script>
</body>
</html>