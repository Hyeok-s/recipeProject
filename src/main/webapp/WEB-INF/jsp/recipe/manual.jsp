<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Diphylleia&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<head>
<link rel="stylesheet" href="/resources/css/manual.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recipe Book</title>
    
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
<style>
.question {
    position: absolute;
    top: 10px;
    right: 174px;
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
			<div class="book-title">${RCP_NM}</div>
			
			<div class="left-image">
					<div class="memoUp">
						<span class="memoTitle">Memo</span>
						<div>
							<button onclick="saveMemo()">Save</button>
							<button onclick="deleteMemo()">Delete</button>
						</div>
					</div>
					<div class="memo"><textarea placeholder="Write your notes here..." readonly onclick="checkLogin()">${memo.text}</textarea></div>
			</div>
				<button id="beforeButton" class="before-button">
					&lt;
			    </button>
			<div class="right-page">
			<i class="fa-solid fa-hourglass-half timer"></i>
			<i class="fa-solid fa-microphone-slash microphone">
  				<span class="dot">●</span>
			</i>
			<i class="fa-solid fa-volume-high volume"></i>
			<i class="fa-solid fa-question question"></i>
			
			<span class="step">${step}</span>
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
<div id="timerPopup" class="timer-popup" style="display: none;">
  <h3>타이머 설정</h3>
  <label for="minutes">분:</label>
  <input type="number" id="minutes" min="0" value="0">
  <label for="seconds">초:</label>
  <input type="number" id="seconds" min="0" value="0">
  <button id="startTimerButton">타이머 시작</button>
  <button id="closeTimerPopup">닫기</button>
</div>

<div id="customAlert" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border: 1px solid #ccc; padding: 20px; z-index: 1000;">
    <p>타이머가 종료되었습니다!</p>
    <button id="confirmButton">확인</button>
</div>
<div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
	<!-- 팝업 창 -->
<div id="popup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border: 1px solid #ccc; padding: 20px; z-index: 1000;">
    <img id="popupImage" src="/resources/img/help2.png" alt="Popup Image">
    <button id="closePopup" style="margin-top: 10px;">닫기</button>
</div>
<div id="popupOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
<script>
let isRecognitionActive = ${isRecognitionActive};
let isVolumeOn = ${isVolumeOn};
let goDetail = false;
document.addEventListener("DOMContentLoaded", function() {
	const timerPopup = document.getElementById('timerPopup');
	const startTimerButton = document.getElementById('startTimerButton');
	const closeTimerPopup = document.getElementById('closeTimerPopup');
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
        else if (transcript.includes('타이머') && transcript.includes('분') && transcript.includes('초')) {
            const timePattern = /(\d+)\s*분\s*(\d*)\s*초?/;
            const match = transcript.match(timePattern);

            if (match) {
                const minutes = parseInt(match[1], 10);
                const seconds = match[2] ? parseInt(match[2], 10) : 0; // 초가 없으면 0으로 처리
                console.log(`명령 인식: 타이머 설정 - \${minutes}분 \${seconds}초`);
                remainingTime = (minutes * 60) + seconds;

                // 타이머 시작
                startTimer();
                const confirmationMessage = new SpeechSynthesisUtterance(`\${minutes}분 \${seconds}초로 타이머를 시작합니다.`);
                confirmationMessage.lang = 'ko-KR';
                synth.speak(confirmationMessage);
            } else {
                const errorMessage = new SpeechSynthesisUtterance('타이머를 설정할 수 없습니다. 다시 시도해주세요.');
                errorMessage.lang = 'ko-KR';
                synth.speak(errorMessage);
            }
        } 
        else if (transcript.includes('타이머') && transcript.includes('분')) {
            const timePattern = /(\d+)\s*분/;
            const match = transcript.match(timePattern);

            if (match) {
                const minutes = parseInt(match[1], 10);
                console.log(`명령 인식: 타이머 설정 - ${minutes}분`);
                remainingTime = minutes * 60;

                // 타이머 시작
                startTimer();
                const confirmationMessage = new SpeechSynthesisUtterance(`\${minutes}분으로 타이머를 시작합니다.`);
                confirmationMessage.lang = 'ko-KR';
                synth.speak(confirmationMessage);
            } else {
                const errorMessage = new SpeechSynthesisUtterance('타이머를 설정할 수 없습니다. 다시 시도해주세요.');
                errorMessage.lang = 'ko-KR';
                synth.speak(errorMessage);
            }
        } 
        else if (transcript.includes('타이머') && transcript.includes('초')) {
            const timePattern = /(\d+)\s*초/;
            const match = transcript.match(timePattern);

            if (match) {
                const seconds = parseInt(match[1], 10);
                console.log(`명령 인식: 타이머 설정 - ${seconds}초`);
                remainingTime = seconds;

                // 타이머 시작
                startTimer();
                const confirmationMessage = new SpeechSynthesisUtterance(`\${seconds}초로 타이머를 시작합니다.`);
                confirmationMessage.lang = 'ko-KR';
                synth.speak(confirmationMessage);
            } else {
                const errorMessage = new SpeechSynthesisUtterance('타이머를 설정할 수 없습니다. 다시 시도해주세요.');
                errorMessage.lang = 'ko-KR';
                synth.speak(errorMessage);
            }
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
        else if (transcript.includes('도움말')) {
            console.log("명령 인식: '도움말' -> 도움말 읽기 시작");
            synth.cancel();
            readHelp();
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
    //도움말 읽기
    function readHelp() {
    	if (!isVolumeOn) {
            console.log("볼륨이 꺼져 있어 도움말을 읽지 않습니다.");
            return;
        }
        popup.style.display = 'block'; // 팝업 보이기
        popupOverlay.style.display = 'block';
        const utterance = new SpeechSynthesisUtterance(`가능한 명령어는 '다음', '이전', '다시', '도움말', '그만', 'n분m초 타이머', '마이크 끄기', '소리 꺼', '소리 켜', '처음으로', '닫기' 가 있습니다.`);
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

function checkLogin() {
	const textarea = document.querySelector('.memo textarea');
    fetch('/member/checkLogin')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
            	textarea.setAttribute('readonly', true);
                alert('로그인이 필요합니다.');
                return false;
            }
            textarea.removeAttribute('readonly');
            return true;
        })
        .catch(error => {
            console.error('로그인 상태 확인 중 오류:', error);
            alert('오류가 발생했습니다. 다시 시도해주세요.');
            return false;
        });
}


async function saveMemo() {
    const memoText = document.querySelector('.memo textarea').value;
    const step = ${step};
    const RCP_SEQ = ${manual.RCP_SEQ};
    
    if (!memoText.trim()) {
        alert('메모를 작성해주세요.');
        return;
    }

    // 비동기로 서버로 데이터 전송
    fetch('/recipe/saveMemo', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            memo: memoText,
            step: step,
            RCP_SEQ: RCP_SEQ,
        }),
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('메모가 저장되었습니다.');
            } else {
                alert('메모 저장에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('메모 저장 중 오류:', error);
            alert('오류가 발생했습니다. 다시 시도해주세요.');
        });
}


function deleteMemo() {
    const step = ${step};
    const RCP_SEQ = ${manual.RCP_SEQ};

    // 먼저 checkLogin 호출
    fetch('/member/checkLogin')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
                alert('로그인이 필요합니다.');
                return; // 로그인되지 않았으면 메모 삭제 로직 중단
            }

            // 로그인된 상태에서 메모 삭제 진행
            fetch('/recipe/deleteMemo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    step: step,
                    RCP_SEQ: RCP_SEQ,
                }),
            })
                .then(response => response.json()) // 서버의 응답을 JSON으로 파싱
                .then(data => {
                    if (data.success) {
                        alert('메모가 삭제되었습니다.');
                        document.querySelector('.memo textarea').value = '';
                    } else {
                        alert('작성된 메모가 없습니다.');
                    }
                })
                .catch(error => {
                    console.error('메모 삭제 중 오류:', error);
                    alert('오류가 발생했습니다. 다시 시도해주세요.');
                });
        })
        .catch(error => {
            console.error('로그인 상태 확인 중 오류:', error);
            alert('로그인 검증 중 오류가 발생했습니다. 다시 시도해주세요.');
        });
}

document.querySelector('.timer').addEventListener('click', () => {
    timerPopup.classList.remove('hidden');
});

//타이머 시작 버튼 동작
startTimerButton.addEventListener('click', () => {
	const minutesInput = document.getElementById('minutes');
	const secondsInput = document.getElementById('seconds');
    // 입력된 분과 초 값 가져오기
    const minutes = parseInt(minutesInput.value, 10);
    const seconds = parseInt(secondsInput.value, 10);

    // 입력값 유효성 검사
    if (isNaN(minutes) || isNaN(seconds) || (minutes === 0 && seconds === 0)) {
        alert('유효한 시간을 입력하세요.');
        return;
    }

    // 남은 시간 설정 (초 단위 변환)
    remainingTime = (minutes * 60) + seconds;

    // 타이머 팝업 숨기기
    timerPopup.style.display = 'none';

    // 타이머 시작
    startTimer();
});

// 팝업 닫기 버튼
closeTimerPopup.addEventListener('click', () => {
    timerPopup.classList.add('hidden');
});

// 타이머 관리 변수
let timerId = null;
let remainingTime = 0;


// 타이머 시작 함수
document.querySelector('.timer').addEventListener('click', () => {
    timerPopup.style.display = 'block';
});

// 타이머 팝업 닫기
closeTimerPopup.addEventListener('click', () => {
    timerPopup.style.display = 'none';
});

// 타이머 시작 함수

function startTimer() {
	
    if (timerId) clearInterval(timerId);

    timerId = setInterval(() => {
        if (remainingTime <= 0) {
            clearInterval(timerId);
            playAlarmSound();
        } else {
            const mins = Math.floor(remainingTime / 60);
            const secs = remainingTime % 60;
            remainingTime--;
        }
    }, 1000);
}

function playAlarmSound() {
    const audio = new Audio('/resources/timer/timer.mp3'); // 알림 소리 파일 경로
    audio.play();
    showCustomAlert();
}

function showCustomAlert() {
    const customAlert = document.getElementById('customAlert');
    const overlay = document.getElementById('overlay');

    customAlert.style.display = 'block';
    overlay.style.display = 'block';

    setTimeout(() => {
        customAlert.style.display = 'none';
        overlay.style.display = 'none';
    }, 4000); // 4초 후 닫힘
}
</script>
</body>
</html>