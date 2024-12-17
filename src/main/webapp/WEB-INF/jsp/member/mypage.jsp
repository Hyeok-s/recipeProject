<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
body {
	margin: 0;
	font-family: 'Arial', sans-serif;
}
.mypageContainer {
	position: relative;
	width: 100%;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: linear-gradient(to bottom, #f9f6f2, #fff);
	overflow: hidden;
}
.book {
	position: relative;
	width: 80%;
	height: 70vh;
	background: #fff;
	display: flex;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
	margin-top: -60px;
}
.book::before, .book::after {
	content: '';
	position: absolute;
	top: 0;
	width: 20px;
	height: 100%;
	background: #e6e1d8;
	box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.2);
}
.book::before {
	left: -20px;
	border-radius: 5px 0 0 5px;
}
.book::after {
	right: -20px;
	border-radius: 0 5px 5px 0;
}
.leftPage, .rightPage {
	width: 50%;
	height: 100%;
	padding: 40px;
	box-sizing: border-box;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.leftPage {
	background: linear-gradient(to right, #f9f6f2, #fff 50%);
	box-shadow: inset -5px 0 10px rgba(0, 0, 0, 0.1);
}
.rightPage {
	background: linear-gradient(to left, #f9f6f2, #fff 50%);
	box-shadow: inset 5px 0 10px rgba(0, 0, 0, 0.1);
}
.pageContent {
	text-align: center;
	font-size: 1.5rem;
	color: #5b4a3f;
}
.bookSpine {
	position: absolute;
	top: 0;
	left: 50%;
	width: 10px;
	height: 100%;
	background: #d9d3c3;
	transform: translateX(-50%);
	box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.3);
	z-index: 1;
}
.field {
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    font-weight: bold;
}
.field span {
    font-weight: bold;
    margin-right: 10px;
    min-width: 160px; /* 고정 너비 설정 */
    text-align: left; /* 왼쪽 정렬 */
}
.field img {
    display: block;
    margin: 0 auto 20px auto; /* 이미지 가운데 정렬 */
    max-width: 120px; /* 이미지 최대 너비 설정 */
}
.currentPassword {
	letter-spacing: 5px;
}
button {
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #5b4a3f;
	color: #fff;
	border: none;
	cursor: pointer;
	font-size: 1rem;
	border-radius: 5px;
}
.modal {
	display: none;
	position: fixed;
	z-index: 10;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	justify-content: center;
	align-items: center;
}
.modal-content {
	position: relative; /* 닫기 버튼의 상대적 위치 기준 설정 */
    background-color: #fff;
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}
.close-btn {
    position: absolute;
    top: -10px; /* 입력창 바로 위 */
    right: -10px; /* 입력창 오른쪽 */
    font-size: 20px;
    cursor: pointer;
    color: #aaa;
    background: #fff; /* 닫기 버튼 배경 흰색 */
    border-radius: 50%; /* 둥근 버튼 */
    border: 1px solid #ccc;
    width: 25px;
    height: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.close-btn:hover {
	border-color: #555050;
    color: #555050;
}
input:disabled {
style: none;
border: none; /* 테두리 제거 */
    background-color: #f9f6f2; /* disabled 상태에서 배경색 */
    color: #5b4a3f; /* disabled 상태에서 텍스트 색상 */
    border: 1px solid #ccc; /* disabled 상태에서 경계선 색상 */
}
#passwordChkInputDiv {
    margin-bottom: 0px;
}
input#passwordInput, input#passwordChkInput, input#nickNameInput {
    width: 100%;
    height: 28px;
    font-size: 20px;
    font-weight: bold;
    color: #5b4a3f;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="mypageContainer">
		<div class="book">
			<div class="leftPage">
				<div class="pageContent">
					<div class="field">
					  <c:if test="${member.gender == '남자'}">
					    <img src="/resources/img/man.png" style="width: 100px; height: 100px;"/>
					  </c:if>
					  <c:if test="${member.gender == '여자'}">
					    <img src="/resources/img/girl.png" style="width: 100px; height: 100px;"/>
					  </c:if>
					</div>
					<div class="field">
						<span>이메일:</span> ${member.email}
					</div>
					<form action="/member/updateMember" method="post">
					<div class="field" id="pwField">
						<span>비밀번호:</span><span id = "currentPassword" class="currentPassword">****</span>
						<input type="hidden" id="passwordInput" placeholder="****" name="pw" disabled/>
					</div>
	                <div id="pwError" style="color:red; font-size:13px;"></div>
					<div class="field" id="passwordChkInputDiv" style="display: none;">
						<span>비밀번호 확인:</span>
						<input type="password" id="passwordChkInput" placeholder="****" name="pwChk" disabled/>
					</div>
	                <div id="pwMatchError" style="color:red; font-size:13px;"></div>
					<div class="field">
						<span>이름:</span> ${member.name}
					</div>
					<div class="field">
						<span>전화번호:</span> ${member.phoneNumber}
					</div>
					<div class="field">
						<span>생년월일:</span> ${member.bir}
					</div>
					<div class="field">
						<span>닉네임:</span><span class="currentNickName" id="currentNickName">${member.nickName}</span>
						<input type="hidden" id="nickNameInput" value="${member.nickName}" name="nickName" disabled/>
					</div>
					<div class="field">
						<span>가입일:</span> ${member.regDate}
					</div>
					<button id="saveBtn" type="submit" style="display: none;" onclick="return finalValidation()">저장하기</button>
					</form>
					<button id="editBtn">수정하기</button>
				</div>
			</div>
			<div class="bookSpine"></div>
			<div class="rightPage">
				<div class="pageContent">
					<h2>메모</h2>
					<p>이곳에 메모 내용을 작성하세요.</p>
					<h2>내 게시글</h2>
					<p>게시글 목록이 여기에 표시됩니다.</p>
				</div>
			</div>
		</div>
	</div>
	 <!-- 비밀번호 확인 모달 -->
    <div class="modal" id="passwordModal">
        <div class="modal-content">
        	<span class="close-btn" id="closeModal">&times;</span>
            <h3>비밀번호 확인</h3>
            <input type="password" id="currentPasswordInput" placeholder="비밀번호를 입력하세요" />
            <button id="confirmPasswordBtn">확인</button>
        </div>
    </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
	   const validPw = true;
	   const validPwChk = true;
	   
       const editBtn = document.getElementById('editBtn');
       const saveBtn = document.getElementById('saveBtn');
       const modal = document.getElementById('passwordModal');
       
       const currentPasswordInput = document.getElementById('currentPasswordInput');
       const confirmPasswordBtn = document.getElementById('confirmPasswordBtn');
       
       const currentPassword = document.getElementById('currentPassword');
       const passwordInput = document.getElementById('passwordInput');
       const currentNickName = document.getElementById('currentNickName');
       const nickNameInput = document.getElementById('nickNameInput');
       
       const passwordChkInputDiv = document.getElementById('passwordChkInputDiv');
       const passwordChkInput = document.getElementById('passwordChkInput');
       
       // 수정 버튼 클릭 시 모달 표시
       editBtn.addEventListener('click', () => {
           modal.style.display = 'flex';
       });
       // 비밀번호 확인 버튼 클릭 시 비밀번호 검증
       confirmPasswordBtn.addEventListener('click', () => {
           const enteredPassword = currentPasswordInput.value;
           if (!enteredPassword) {
               alert('비밀번호를 입력하세요.');
               return;
           }
           // AJAX 요청 (서버로 비밀번호 확인)
           fetch('/member/checkPassword', {
               method: 'POST',
               headers: { 'Content-Type': 'application/json' },
               body: JSON.stringify({ password: enteredPassword })
           })
           .then(response => response.json())
           .then(data => {
               if (data.success) {
                   modal.style.display = 'none';
                   
                   currentPassword.style.display = 'none';
                   passwordInput.type = 'password'
                   passwordInput.disabled = false;
                   passwordInput.oninput = function() {
                       validatePw();
                   };
                   
                   currentNickName.style.display = 'none';
                   nickNameInput.type = 'text'
                   nickNameInput.disabled = false;
                                       
                   passwordChkInputDiv.style.display = 'flex';
                   passwordChkInputDiv.style.marginBottom = '25px';
                   passwordChkInput.disabled = false;
                   passwordChkInput.oninput = function(){
                   	  checkPwdMatch();
                   }
                   
                   editBtn.style.display = 'none';     
                   saveBtn.style.display = 'inline-block';
                   
               } else {
                   alert('비밀번호가 일치하지 않습니다.');
               }
           })
           .catch(error => {
               console.error('Error:', error);
               alert('서버 오류가 발생했습니다.');
           });
       });
       
       document.addEventListener('click', (e) => {
           if (e.target && e.target.id === 'saveBtn') {
               hiddenPassword.value = passwordInput.value;
               hiddenNickname.value = nicknameInput.value;
               updateForm.submit(); // 동기 처리
           }
       });
       // 모달 닫기 버튼
       document.getElementById('closeModal').addEventListener('click', () => {
           modal.style.display = 'none';
       });
   });
	
// 비밀번호 유효성 검사
function validatePw() {
    const pw = document.getElementById("passwordInput").value;
    const pwError = document.getElementById("pwError");
    const pwField = document.getElementById('pwField');
    
    // 비밀번호 규칙: 9~15자, 영어, 숫자, 특수문자 포함
    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
    if (!passwordPattern.test(pw)) {
    	pwField.style.marginBottom = '0px';
    	pwError.style.marginBottom = '20px';
    	pwError.textContent = "영어, 숫자, 특수문자를 포함해 8~16자리로 만들어주세요.";
    } else {
    	pwError.textContent = "";
    }
    checkPwdMatch();
}
//비밀번호 일치 여부 검사
function checkPwdMatch() {
    const pw = document.getElementById("passwordInput").value;
    const pwChk = document.getElementById("passwordChkInput").value;
    const pwMatchError = document.getElementById("pwMatchError");
    const passwordChkInputDiv = document.getElementById('passwordChkInputDiv');
    
    if (pw !== pwChk) {
    	passwordChkInputDiv.style.marginBottom = '0px';
    	pwMatchError.style.marginBottom = '20px';
    	pwMatchError.textContent = "비밀번호가 일치하지 않습니다.";
    } else {
    	pwMatchError.textContent = "";
    }
    validatePw();
}
//최종 유효성 검사 (이메일과 비밀번호)
function finalValidation() {
    const pwError = document.getElementById("pwError").textContent;
    const pwMatchError = document.getElementById("pwMatchError").textContent;
    const nickNameInput = document.getElementById('nickNameInput');
    if (nickNameInput.value.trim() === "") {
        alert("닉네임을 입력해주세요");
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