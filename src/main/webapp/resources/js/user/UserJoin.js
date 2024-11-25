console.log("JavaScript 호출");

const code = generateAuthCode();

function emptyCheckEmail(){
	let uemail = $("#uemail").val();
	
	 $.ajax({
        type: 'GET',
        url: '/user/findUser',
        data: { uemail:uemail },
        success: function(response) {
            console.log(response);
            if (response ==='useable') {
                $('#checkBtn').show();
                $('#emailAuth').show();
                $('#messageEmail').text('사용가능한 이메일입니다.');
            } else {
                $('#messageEmail').text('이미 사용된 이메일입니다.').css('color', 'red');
                $('#emailAuth').hide();
            }
        },
        error: function(xhr, status, error) {
            console.error("이메일 발송 오류:", error);
        }
    });
}



// 이메일 인증 코드 요청 함수
function sendEmailAuth() {
    let email = $("#uemail").val();
    
    $.ajax({
        type: 'GET',
        url: '/send-email',
        data: { to: email, subject:'email인증', text:code },
        success: function(response) {
            console.log(response);
            if (response) {
                $('#emailLabel').show();
                $('#emailCheck').show();
                $('#checkBtn').show();
                $('#messageEmail').text('인증 코드가 발송되었습니다.');
            } else {
                $('#messageEmail').text('이메일 발송 실패. 다시 시도해주세요.');
            }
        },
        error: function(xhr, status, error) {
            console.error("이메일 발송 오류:", error);
        }
    });
}

function generateAuthCode() {
    const length = 6;
    const characters = '0123456789';
    let authCode = '';
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        authCode += characters[randomIndex];
    }
    return authCode;
}





// 인증 코드 확인 함수
function emailAuthCheck() {
    let authCode = $("#emailCheck").val();
    let sendCode = code;
    
    if(authCode === sendCode){
     $('#messageEmail').text('인증되었습니다.');
                $('#emailCheck').hide();
                $('#emailLabel').hide();
                $('#emailAuth').hide();
                $('#checkBtn').hide();
                $('#uemail').prop('readonly', true);
    }else{
     $('#messageEmail').text('인증 실패하였습니다.');
    }
   
}

// 폼 유효성 검사 함수
function validateForm(form) {
    console.log('validateForm 호출');

    if (form.uname.value === "") {
        alert("이름을 입력하세요");
        form.uname.focus();
        return false;
    }
    if (form.upwd.value === "") {
        alert("비밀번호를 입력하세요");
        form.upwd.focus();
        return false;
    }
    if (form.upwdch.value === "") {
        alert("비밀번호 확인을 입력하세요");
        form.upwdch.focus();
        return false;
    }
    if (form.upwdch.value !== form.upwd.value) {
        alert("비밀번호와 일치하지 않습니다.");
        form.upwdch.focus();
        return false;
    }
    if ($('#messageEmail').text() === '이미 사용 중인 이메일입니다.') {
        alert('이미 사용중인 이메일입니다. 다시 작성해주세요');
        form.uemail.focus();
        return false;
    }

    return true;
}

// 이메일 인증 관련 요소 숨기기
function removeECheck() {
    $('#messageEmail').empty();
    $('#emailCheck').hide();
    $('#emailLabel').hide();
    $('#emailAuth').hide();
    $('#checkBtn').hide();
}

function toggleDept() {
    var deptDiv = document.getElementById("deptDiv");
    var roleUser = document.querySelector('input[name="role"][value="ROLE_USER"]');
    
    if (roleUser.checked) {
        deptDiv.style.display = "none";
    } else {
        deptDiv.style.display = "block";
    }
}

function checkDeptSelection() {
    var didSelect = document.getElementById("didSelect");
    var hiddenDid = document.getElementById("hiddenDid");

    if (didSelect.value === "") {
        hiddenDid.value = "non";
    } else {
        hiddenDid.value = didSelect.value;
    }
}
