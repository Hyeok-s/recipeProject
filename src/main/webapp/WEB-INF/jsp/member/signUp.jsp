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
</head>
<body>
    <%@ include file="/WEB-INF/jsp/common/header.jsp"%>
    <div class="form-body">
        <div class="container">
            <h1>회원가입</h1>
            <form action="/member/signUp" method="post">
                <div class="email-container">
                    <input type="text" name="email" id="email" placeholder="이메일" required>
                    <button type="button" onclick="checkEmail()">메일 인증</button>
                </div>
                <div id="emailError" style="color:red;"></div><br/>
                <input type="password" name="pw" id="pw" placeholder="비밀번호" oninput="validatePw()" required>
                <div id="pwError" style="color:red;"></div>
                <input type="password" name="pwChk" id="pwChk" placeholder="비밀번호 확인" oninput="checkPwdMatch()" required>
                <div id="pwMatchError" style="color:red;"></div><br/>
                <input type="text" name="name" placeholder="이름" required>
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
                <button type="submit" onclick="return finalValidation()">회원가입</button>
            </form>
            <div class="extra-info">
                이미 계정이 있으신가요? <a href="/member/loginForm">로그인하기</a>
            </div>
        </div>
    </div>
<script>

</script>
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

let isEmailChecked = false;
checkedEmail = "";

function checkEmail() {
    const email = document.getElementById("email").value;
    
    fetch(`/member/checkEmail?email=\${email}`,{
    	method: 'POST'
    })
        .then(response => response.json())
        .then(data => {
            if (data) {
            	document.getElementById("emailError").textContent = data;
                isEmailChecked = true;
            } 
        })
        .catch(error => {
            emailError.textContent = "서버 오류가 발생했습니다.";
            isEmailChecked = false;
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
function finalValidation() {
    const email = document.getElementById("email").value;
    const pwError = document.getElementById("pwError").textContent;
    const pwMatchError = document.getElementById("pwMatchError").textContent;
    const emailError = document.getElementById("emailError");
    
    if (!isEmailChecked) {
        alert("이메일 인증을 해주세요.");
        return false;
    }
    
   	if(checkedEmail !== email){
           alert("이메일이 변경되었습니다. 중복 확인을 다시 해주세요.");
           emailError.textContent = "중복확인을 다시 실시해주세요.";
           return false;
    }

    if (pwError || pwMatchError) {
        alert("비밀번호를 다시 확인해주세요.");
        return false;
    }

    return true;
}

</script>
</body>
</html>
