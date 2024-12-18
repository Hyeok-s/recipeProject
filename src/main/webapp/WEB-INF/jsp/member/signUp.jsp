<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body {
    margin: 0;
}

.form-body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(to bottom, #fef5e7, #ffe6cc);
    color: #4d4d4d;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
    margin-top: 20px;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    text-align: center;
    width: 80%;
    max-width: 600px;
    background: #ffffff;
    border-radius: 15px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    padding: 30px;
    position: absolute;
}

h1 {
    font-size: 32px;
    color: #ff8c42;
    margin-bottom: 20px;
    font-weight: bold;
}

form {
    width: 100%;
}

input {
    width: 97%;
    padding: 12px 15px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    padding-right: 0px;
}

select {
    width: 100%;
    padding: 12px 15px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    background: #fff;
}

button {
    width: 100%;
    padding: 15px;
    background-color: #ff8c42;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #ff7043;
}

.extra-info {
    margin-top: 20px;
    font-size: 14px;
    color: #666;
}

.extra-info a {
    color: #ff8c42;
    text-decoration: none;
}

.extra-info a:hover {
    text-decoration: underline;
}

.phone-input {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 10px 0;
}

.phone-input span {
    display: inline-block;
    text-align: center;
    width: 20px;
    line-height: 1;
}

@media (max-width: 768px) {
    .container {
        width: 90%;
        padding: 20px;
    }

    h1 {
        font-size: 28px;
    }

    button {
        font-size: 16px;
        padding: 12px;
    }
}

.email-container {
    display: flex;
    gap: 10px;
    align-items: center;
}
.email-container input {
    flex: 1;
}
.email-container button {
    flex-shrink: 0;
    width: auto;
    padding: 12px 15px;
}
</style>
<style>
/* 스피너 스타일 */
.spinner {
    border: 8px solid #f3f3f3;
    border-top: 8px solid #3498db; /* 파란색 */
    border-radius: 50%;
    width: 50px;
    height: 50px;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* 중앙에 배치 */
#loadingSpinner {
	position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.7); /* 반투명한 배경 */
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}
.sort-options {
	width: 45%;
    display: flex;
    gap: 20px;
    align-items: center;
    font-size: 16px;
    margin-left: 30px;
}

.sort-options label {
    display: flex;
    align-items: center;
    gap: 8px;
}

.sort-options input[type="radio"] {
    display: none; /* 기본 라디오 버튼 숨김 */
}

.sort-options label {
    position: relative;
    font-size: 16px;
    padding-left: 30px; /* 체크 마크 공간 확보 */
    cursor: pointer;
    color: #d26d8e;
    font-weight: bold;
}

.sort-options label::before {
    content: ''; /* 기본 상태 */
    position: absolute;
    left: 0;
    top: 0;
    width: 20px;
    height: 20px;
    border: 2px solid #ffc0cb; /* 테두리 색상 */
    border-radius: 3px; /* 체크박스 형태 */
    background-color: white;
    transition: all 0.3s ease;
}

/* 체크된 상태 */
.sort-options input[type="radio"]:checked + label::before {
    background-color: #f080a9; /* 체크된 상태 배경색 */
    border-color: #f080a9;
    content: '✔'; /* 체크 마크 */
    color: white; /* 체크 마크 색상 */
    font-size: 14px;
    text-align: center;
    line-height: 20px; /* 체크 마크 정렬 */
}

.sort-options input[type="radio"]:checked + label {
    color: #f080a9; /* 체크된 라벨 텍스트 색상 */
}
.nameGender{
	display: flex;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/jsp/common/header.jsp"%>
    <div class="form-body">
        <div class="container">
            <h1>회원가입</h1>
            <form action="/member/signUp" method="post">
                <div class="email-container">
                    <input type="text" id="email" placeholder="이메일" required>
                    <button type="button" onclick="checkEmail()">메일 인증</button>
                    <input type="hidden" name="email" id="formEmail" >
                </div>
                <div id="emailError" style="color:red;"></div><br/>
                <input type="password" name="pw" id="pw" placeholder="비밀번호" oninput="validatePw()" required>
                <div id="pwError" style="color:red;"></div>
                <input type="password" name="pwChk" id="pwChk" placeholder="비밀번호 확인" oninput="checkPwdMatch()" required>
                <div id="pwMatchError" style="color:red;"></div><br/>
                <div class="nameGender">
                    <input type="text" name="name" placeholder="이름" required>
           	        <div class="sort-options">
						<input type="radio" name="gentder" id="man" value="남자" checked />
					    <label for="man"> 남자</label>
					    <input type="radio" name="gentder" id="girl" value="여자" />
					    <label for="girl"> 여자</label>
					</div>
                </div>

				<div class="phone-input">
				    <input type="text" id="phone1" name="phone1" placeholder="010" maxlength="3" required>
				    <span>-</span>
				    <input type="text" id="phone2" name="phone2" placeholder="1234" maxlength="4" required>
				    <span>-</span>
				    <input type="text" id="phone3" name="phone3" placeholder="5678" maxlength="4" required>
				</div>
                <div style="display: flex; gap: 10px;">
                    <select name="birthYear" required>
                        <option value="">출생년도</option>
                        <% for (int year = 2024; year >= 1910; year--) { %>
                            <option value="<%= year %>"><%= year %></option>
                        <% } %>
                    </select>
                    <select name="birthMonth" required>
                        <option value="">월</option>
                    </select>
                    <select name="birthDay" required>
                        <option value="">일</option>
                    </select>
                </div>
                <input type="text" name="nickName" placeholder="닉네임" required>
                <button type="submit" onclick="return finalValidation(event)">회원가입</button>
            </form>
            <div class="extra-info">
                이미 계정이 있으신가요? <a href="/member/loginForm">로그인하기</a>
            </div>
        </div>
    </div>
<div id="loadingSpinner" style="display: none;">
    <div class="spinner"></div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const birthYearSelect = document.querySelector('select[name="birthYear"]');
    const birthMonthSelect = document.querySelector('select[name="birthMonth"]');
    const birthDaySelect = document.querySelector('select[name="birthDay"]');
    
    birthYearSelect.addEventListener('change', () => {
        populateMonths();
        populateDays();
    });

    birthMonthSelect.addEventListener('change', populateDays);

    if (birthYearSelect.value) {
        populateMonths();
        if (birthMonthSelect.value) {
            populateDays();
        }
    }
    setupPhoneInput();
});
</script>
<script>
// 월 선택 옵션을 채우는 함수
function populateMonths() {
    const birthYearSelect = document.querySelector('select[name="birthYear"]');
    const birthMonthSelect = document.querySelector('select[name="birthMonth"]');
    const currentYear = new Date().getFullYear();
    const currentMonth = new Date().getMonth() + 1;
    const selectedYear = parseInt(birthYearSelect.value);

    birthMonthSelect.innerHTML = '<option value="">월</option>';

    if (!selectedYear) return;

    const maxMonth = (selectedYear === currentYear) ? currentMonth : 12;

    for (let month = 1; month <= maxMonth; month++) {
        const option = document.createElement('option');
        option.value = month;
        option.textContent = month + '월';
        birthMonthSelect.appendChild(option);
    }
}

// 일 선택 옵션을 채우는 함수
function populateDays() {
    const birthYearSelect = document.querySelector('select[name="birthYear"]');
    const birthMonthSelect = document.querySelector('select[name="birthMonth"]');
    const birthDaySelect = document.querySelector('select[name="birthDay"]');

    birthDaySelect.innerHTML = '<option value="">일</option>';

    const selectedYear = parseInt(birthYearSelect.value);
    const selectedMonth = parseInt(birthMonthSelect.value);

    if (!selectedYear || !selectedMonth) return;

    const daysInMonth = new Date(selectedYear, selectedMonth, 0).getDate();

    for (let day = 1; day <= daysInMonth; day++) {
        const option = document.createElement('option');
        option.value = day;
        option.textContent = day + '일';
        birthDaySelect.appendChild(option);
    }
}

// 전화번호 입력 필드를 제어하는 함수
function setupPhoneInput() {
    const phone1 = document.getElementById('phone1');
    const phone2 = document.getElementById('phone2');
    const phone3 = document.getElementById('phone3');

    phone1.addEventListener('input', function () {
        if (this.value.length === this.maxLength) {
            phone2.focus();
        }
    });

    phone2.addEventListener('input', function () {
        if (this.value.length === this.maxLength) {
            phone3.focus();
        }
    });
}


//메일보내기
function checkEmail() {
    const email = document.getElementById("email").value;
    const emailError = document.getElementById("emailError");
    const loadingSpinner = document.getElementById("loadingSpinner");
    
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        emailError.textContent = "유효한 형식이 아닙니다";
        return;
    }
    
	emailError.textContent = ""
	loadingSpinner.style.display = "flex";
 	// 서버로 이메일 중복 확인 요청
    fetch(`/member/checkEmail?email=\${email}`,{
    	method: 'POST'
    })
        .then(response => response.json())
        .then(data => {
        	if (data && data.message) {
        		alert(data.message);
        		document.getElementById("email").disabled = true;
        		document.getElementById("formEmail").value = email;
            }
	        else {
	            emailError.textContent = "서버에서 예기치 않은 응답이 왔습니다.";
	        }
        })
        .catch(error => {
            emailError.textContent = "서버 오류가 발생했습니다.";
        })
        .finally(() => {
            loadingSpinner.style.display = "none"; // 로딩 스피너 숨김
        });
}

// 비밀번호 유효성 검사
function validatePw() {
    const pw = document.getElementById("pw").value;
    const pwError = document.getElementById("pwError");

    // 비밀번호 규칙: 9~15자, 영어, 숫자, 특수문자 포함
    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
    if (!passwordPattern.test(pw)) {
    	pwError.textContent = "영어, 숫자, 특수문자를 포함해 8~16자리로 만들어주세요.";
    } else {
    	pwError.textContent = "";
    }
    checkPwdMatch();
}

//비밀번호 일치 여부 검사
function checkPwdMatch() {
    const pw = document.getElementById("pw").value;
    const pwChk = document.getElementById("pwChk").value;
    const pwMatchError = document.getElementById("pwMatchError");

    if (pw !== pwChk) {
    	pwMatchError.textContent = "비밀번호가 일치하지 않습니다.";
    } else {
    	pwMatchError.textContent = "";
    }
    validatePw();
}

//최종 유효성 검사 (이메일과 비밀번호)
async function finalValidation(event) {
	event.preventDefault();
	
    const email = document.getElementById("email").value;
    const pwError = document.getElementById("pwError").textContent;
    const pwMatchError = document.getElementById("pwMatchError").textContent;

    try {
        const response = await fetch(`/member/checkEmailPoint?email=\${email}`, {
            method: 'POST'
        });
        const data = await response.json();
        
        if (!data) {
            alert("이메일 인증을 완료해주세요.");
            return false;
        }
        else{
        	console.log(data);
        }
    } catch (error) {
        alert("서버 오류가 발생했습니다.");
        return false;
    }

    if (pwError || pwMatchError) {
        alert("비밀번호를 다시 확인해주세요.");
        return false;
    }

    event.target.form.submit();
    return true;
}

</script>
</body>
</html>