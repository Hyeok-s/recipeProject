<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&family=Lobster&family=Playwrite+DE+VA+Guides&display=swap" rel="stylesheet">
<title>마이페이지</title>
<link rel="stylesheet" href="/resources/css/memberMypage.css" />
<script src="https://kit.fontawesome.com/adad881590.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="mypageContainer">
		<div class="book">
			<div class="leftPage">
				<div class="pageContent">
					<div class="field">
						<c:if test="${member.gender == '남자'}">
							<img src="/resources/img/man.png"
								style="width: 100px; height: 100px;" />
						</c:if>
						<c:if test="${member.gender == '여자'}">
							<img src="/resources/img/girl.png"
								style="width: 100px; height: 100px;" />
						</c:if>
					</div>
					<div class="field">
						<span>이메일:</span> ${member.email}
					</div>
					<form action="/member/updateMember" method="post">
						<div class="field" id="pwField">
							<span>비밀번호:</span><span id="currentPassword"
								class="currentPassword">****</span> <input type="hidden"
								id="passwordInput" placeholder="****" name="pw" disabled />
						</div>
						<div id="pwError" style="color: red; font-size: 13px;"></div>
						<div class="field" id="passwordChkInputDiv" style="display: none;">
							<span>비밀번호 확인:</span> <input type="password"
								id="passwordChkInput" placeholder="****" name="pwChk" disabled />
						</div>
						<div id="pwMatchError" style="color: red; font-size: 13px;"></div>
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
							<span>닉네임:</span><span class="currentNickName"
								id="currentNickName">${member.nickName}</span> <input
								type="hidden" id="nickNameInput" value="${member.nickName}"
								name="nickName" disabled />
						</div>
						<div class="field">
							<span>가입일:</span> ${member.regDate}
						</div>
						<button id="saveBtn" type="submit" style="display: none;"
							onclick="return finalValidation()">저장하기</button>
					</form>
					<button id="editBtn" class="editBtn">수정하기</button>
				</div>
			</div>
			<div class="bookSpine"></div>
			<div class="rightPage">
				<div class="rightPageContainer">
					<!-- 메모 영역 -->
					<div class="section memoSection">
					    <h2>메모</h2>
					    <div class="memoContainer">
					        <c:forEach var="RCP_SEQ" items="${groupedMemos.keySet()}">
					            <div class="memoGroup">
					                <!-- RCP_SEQ 헤더 -->
					                <div class="memoHeader" onclick="toggleDetails('${RCP_SEQ}')">
					                    ${groupedMemos[RCP_SEQ][0].RCP_NM}
					                    <!-- 접기/펼치기 버튼 -->
					                    <button class="toggleButton">▼</button>
					                </div>
					                <!-- 각 RCP_SEQ에 속하는 메모 리스트 -->
					                <div class="memoDetails" id="details-${RCP_SEQ}" style="display: none;">
					                    <c:forEach var="memo" items="${groupedMemos[RCP_SEQ]}">
					                        <div class="memoItem">
					                            <a class="manual" href="/recipe/manual?RCP_SEQ=${RCP_SEQ}&step=${memo.STEP_NO}&isRecognitionActive=false&isVolumeOn=false">메뉴얼: ${memo.STEP_NO}번</a>
					                        </div>
					                    </c:forEach>
					                </div>
					            </div>
					        </c:forEach>
					    </div>
					</div>
					<!-- 내 게시글 영역 -->
					<div class="section postSection">
						<h2>내 게시글</h2>
						<table>
				            <tbody>
				                <c:forEach var="community" items="${communities}">
				                    <tr>
				                        <td>
				                            <a href="/community/detail?id=${community.id}" style="text-decoration: none; color: #5b4a3f;">
				                                ${community.title}
				                            </a>
				                        </td>
				                        <td id="updateDate">${community.updateDate}</td>
				                        <td><i class="fa-regular fa-eye"></i>${community.count}</td>
				                    </tr>
				                </c:forEach>
				            </tbody>
				        </table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 비밀번호 확인 모달 -->
	<div class="modal" id="passwordModal">
		<div class="modal-content">
			<span class="close-btn" id="closeModal">&times;</span>
			<h3>비밀번호 확인</h3>
			<input type="password" id="currentPasswordInput"
				placeholder="비밀번호를 입력하세요" />
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
       
       window.onload = function() {
           var updateDateElements = document.querySelectorAll('td[id="updateDate"]');
           updateDateElements.forEach(function(element) {
               var regDate = element.textContent.trim();
               var dateParts = regDate.split(' ')[0].split('-');
               var formattedDate = dateParts[1] + '월 ' + dateParts[2] + '일';
               element.textContent = formattedDate;
           });
       };
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

function toggleDetails(RCP_SEQ) {
    const details = document.getElementById(`details-\${RCP_SEQ}`);
    const button = details.previousElementSibling.querySelector('.toggleButton');

    if (details.style.display === "none") {
        // 펼치기
        details.style.display = "block";
        button.textContent = "▲";
    } else {
        // 접기
        details.style.display = "none";
        button.textContent = "▼";
    }
}
</script>
</body>
</html>