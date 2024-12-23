<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/memberSignUp.css" />

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