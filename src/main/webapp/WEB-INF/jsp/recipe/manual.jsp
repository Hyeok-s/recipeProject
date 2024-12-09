<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
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
	margin-top: 8px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.bookBody {
	margin-top: 20px;
	background: #f7f2e9;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
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
}

.ingredients {
	padding: 20px;
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

.info-item:last-child {
	margin-bottom: 0;
}

.info-item span:first-child {
	font-weight: bold;
	color: #6a553e;
}

.info-item span:last-child {
	font-weight: bold;
	color: #52734d;
}

.nutrition {
	display: flex;
	flex-direction: column;
	align-items: center;
	top: 170px;
}

.nutrition img {
	margin: 0 auto;
	max-width: 450px;
	width: 450px;
	height: auto;
	margin-bottom: 20px;
}

.ingredients-title {
	font-family: "Do Hyeon", serif;
	font-size: 30px;
	color: #5c4c3b;
	margin-top: 10px;
	line-height: 1.5;
	padding-left: 30px;
	padding-right: 30px;
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
     opacity: 0;
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
    right: -28%;
    background-color: transparent;
    border-radius: 50%;
    font-size: 120px;
    color: #6a553e;
    z-index: 3;
    display: flex;
    justify-content: center;
    align-items: center;
    border-style: none;
    animation: pulse 2s infinite; /* 애니메이션 추가 */
    transition: transform 0.2s ease; /* 클릭 시 부드러운 반응 */
}

.next-button::after {
    content: ">";
    background: linear-gradient(90deg, transparent, #6a553e, transparent);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: gradient-flicker 1.5s infinite; /* 텍스트 빈 부분 애니메이션 */
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.2);
    }
}

.fa-solid{
	padding: 26px;
}
.microphone {
    position: absolute;
    top: 10px;
    right: 65px;
    font-size: 24px;
    color: #6a553e;
    cursor: pointer;
    z-index: 10;
    align-items: center;
    display: inline-flex;
}

.dot {
 position: absolute;
 top: 50%;
 left: 26%;
 transform: translate(-50%, -50%);
  color: #6a553e;
  font-size: 0.4em;
  }
  
.volume {
  position: absolute;
  top: 10px;
  right: 20px;
  font-size: 24px;
  color: red;
  cursor: pointer;
  z-index: 10;
  align-items: center;
  display: inline-flex;   
}

.fa-volume-xmark{
	color: #6a553e;
}

.before-button {
    position: absolute;
    left: -14%;
    background-color: transparent;
    border-radius: 50%;
    font-size: 120px;
    color: #6a553e;
    z-index: 3;
    display: flex;
    justify-content: center;
    align-items: center;
    border-style: none;
    animation: pulse 2s infinite;
    transition: transform 0.2s ease;
}

.before-button::after {
    content: "<";
    background: linear-gradient(90deg, transparent, #6a553e, transparent);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: gradient-flicker 1.5s infinite; /* 텍스트 빈 부분 애니메이션 */
}


.reverse-flipping .right-page {
    animation: pageFlipReverse 1s ease-in-out forwards; /* 역방향 덮는 애니메이션 */
    z-index: 2; /* 왼쪽 페이지 위로 올라오게 설정 */
}
.reverse-flipping .left-image {
    animation: fadeOutImage 1s ease-in-out reverse; /* 다시 나타나는 효과 */
    z-index: 1; /* 오른쪽 페이지 아래로 이동 */
    opacity: 1;
}
@keyframes pageFlipReverse {
    0% {
        transform: rotateY(-180deg);
        opacity: 1;
    }
    50% {
        transform: rotateY(-90deg);
        opacity: 0.6; /* 약간 더 투명 */
    }
    100% {
        transform: rotateY(0deg);
        opacity: 1;
    }
}
.fade-out-before-button {
    animation: fadeOutBefore 1s ease-in-out forwards;
}
</style>

    
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="bookBody">
		<div class="book-cover">
			<div class="book-title">${RCP_NM}</div>

			<div class="left-image">
				<div class="ingredients">
					<div class="memo">sfdggfds</div>
				</div>
			</div>
				<button id="beforeButton" class="before-button">
					&lt;
			    </button>
			<div class="right-page">
			<i class="fa-solid fa-microphone-slash microphone">
  				<span class="dot">●</span>
			</i>
			<i class="fa-solid fa-volume-high volume"></i>
				<div class="nutrition">
					<img src="${manual.MANUAL_IMG}" alt="manual Image" />
					<div class="ingredients-title">${manual.MANUAL_TEXT}</div>
				</div>
					<button id="nextButton" class="next-button">
					&gt;
			    	</button>
			</div>
		</div>
	</div>
<script>
let isRecognitionActive = ${isRecognitionActive};
let isVolumeOn = ${isVolumeOn};
let goDetail = false;
document.addEventListener("DOMContentLoaded", function() {
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
});


if ('webkitSpeechRecognition' in window && 'speechSynthesis' in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.lang = 'ko-KR';
    recognition.interimResults = false;
    recognition.maxAlternatives = 1;
    const synth = window.speechSynthesis;

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
        	if(${maxStep} <= ${step}){
                const finalpage = new SpeechSynthesisUtterance(`마지막 페이지입니다.`);
                finalpage.lang = 'ko-KR';
                synth.speak(finalpage);
        	}
        	else{
        		synth.cancel();
        		document.getElementById('nextButton').click();
        	}
        }
        else if (transcript.includes('이전')) {
        	if(${step} === 0){
                const finalpage = new SpeechSynthesisUtterance(`첫페이지로 이동합니다.`);
                finalpage.lang = 'ko-KR';
                synth.cancel();
                synth.speak(finalpage);
                document.getElementById('beforeButton').click();
        	}
        	else{
	            console.log("명령 인식: '이전' -> 메뉴얼 읽기 시작");
	            synth.cancel();
	            document.getElementById('beforeButton').click();
        	}
        }
        else if (transcript.includes('다시')) {
            console.log("명령 인식: '다시' -> 메뉴얼 읽기 시작");
            synth.cancel();
            readManual();
        }
        else if (transcript.includes('그만')) {
            console.log("명령 인식: '그만' -> 음성 출력 중단");
            synth.cancel();
        }
        else if (transcript.includes('마이크 끄기')) {
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
        else if (transcript.includes('처음으로')) {
            console.log("명령 인식: '처음으로' -> 처음으로 가기");
            synth.cancel();
            goDetail = true;
            document.getElementById('beforeButton').click();
        }
        else {
            console.log("알 수 없는 명령: ", transcript);
        }
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
    	 if(${isVolumeOn}){
    		 readManual();
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
    
    
    function readManual() {
    	if (!isVolumeOn) {
            console.log("볼륨이 꺼져 있어 도움말을 읽지 않습니다.");
            return;
        }
        const manualContent = document.querySelector('.ingredients-title');
        if (!manualContent || !manualContent.textContent.trim()) {
            const utterance = new SpeechSynthesisUtterance('메뉴얼이 없습니다.');
            utterance.lang = 'ko-KR';
            synth.speak(utterance);
            return;
        }
        const utterance = new SpeechSynthesisUtterance(`${step}번째: \${manualContent.textContent}`);
        utterance.lang = 'ko-KR';
        synth.speak(utterance);
    }
    
} else {
    console.warn("이 브라우저는 Web Speech API를 지원하지 않습니다.");
}


document.getElementById('nextButton').addEventListener('click', function () {
	if(${maxStep} === ${step}){
		alert("마지막 페이지입니다.");
		return;
	}
    const bookCover = document.querySelector('.book-cover');

    // 페이지 전환 애니메이션 클래스 추가
    bookCover.classList.add('flipping');

    // 애니메이션이 끝난 후 페이지 이동
    setTimeout(() => {
    	window.location.href = "/recipe/manual?RCP_SEQ=" + ${manual.RCP_SEQ} + '&step=' + ${step + 1} + '&isRecognitionActive=' + isRecognitionActive + '&isVolumeOn=' + isVolumeOn;
    }, 1000); // 애니메이션 시간 (1초)
});

document.getElementById('beforeButton').addEventListener('click', function () {
    const bookCover = document.querySelector('.book-cover');
    const beforeButton = document.getElementById('beforeButton');
    
    bookCover.classList.remove('flipping', 'reverse-flipping');
    
    // 페이지 전환 애니메이션 클래스 추가
     bookCover.classList.add('reverse-flipping');
     beforeButton.classList.add('fade-out-before-button');
    // 애니메이션이 끝난 후 페이지 이동
    setTimeout(() => {
    	if(${step} === 1 || goDetail){
    		window.location.href = "/recipe/detail?RCP_SEQ=" + ${manual.RCP_SEQ} + '&isRecognitionActive=' + isRecognitionActive + '&isVolumeOn=' + isVolumeOn;
    	}
    	else{
    		window.location.href = "/recipe/manual?RCP_SEQ=" + ${manual.RCP_SEQ} + '&step=' + ${step - 1} + '&isRecognitionActive=' + isRecognitionActive + '&isVolumeOn=' + isVolumeOn;
    	}
    }, 1000); // 애니메이션 시간 (1초)
});


</script>
</body>
</html>