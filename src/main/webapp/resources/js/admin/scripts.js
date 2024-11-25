function checkThisTempContent(tno) {
    // hidden input에서 값 가져오기
    var title = document.getElementById("title_" + tno).value;
    var content = document.getElementById("content_" + tno).value;
    var regdate = document.getElementById("regdate_" + tno).value;
    var email = document.getElementById("email_" + tno).value;
    var name = document.getElementById("name_" + tno).value;

    // 모달창에 데이터 설정
    document.getElementById("modalTno").innerText = tno;
    document.getElementById("modalTitle").innerText = title;
    document.getElementById("modalContent").innerText = content;
    document.getElementById("modalRegdate").innerText = regdate;
    document.getElementById("modalEmail").innerText = email;
    document.getElementById("modalName").innerText = name;
    // 모달창 표시
    console.log('click실행');
    $('#myModal').modal('show');
}

function approve() {
    let code = 'permit';
    dataUpdate(code);
    alert("허가되었습니다.");
    $('#myModal').modal('hide');
}


function openRejectionModal() {

    $('#rejectionModal').modal('show');
}

function cancelRejectionModal() {
    $('#rejectionModal').modal('hide');
}

function sendRejectionEmail() {
    let reason = document.getElementById('rejectionReason').value;
    let email = document.getElementById('modalEmail').innerText;
    let name = document.getElementById('modalName').innerText;

    // 이메일 전송 로직 추가
    console.log('Sending rejection email to:', email);
    console.log('Rejection reason:', reason);
    
    
    
     $.ajax({
    url: '/send-email',
    type: 'GET',
    data: {
      to: email,
      subject: '거절사유',
      text: reason
    },
    success: function(response) {
     
    },
    error: function(xhr, status, error) {
      alert('해당 메일이 보호상태이거나, 존재하지않는 이메일입니다.');
    }
  });
    
     let code = 'reject';
      dataUpdate(code);

    // 모달 닫기
    $('#rejectionModal').modal('hide');
    alert("거절 사유가 전송되었습니다.");
}

function reject() {
    openRejectionModal();
}

function dataUpdate(code){
    let tno = document.getElementById("modalTno").innerText;
    console.log('tno' + tno);
    $.ajax({
        type: "POST",
        url: "/admin/updateData",
        data: { tno: tno, code: code },
        success: function(response) {
            location.reload();            	
            $('#myModal').modal('hide');
        },
        error: function(error) {
            console.error(error);
        }
    });
}

function reject() {
	console.log('왜 호출이 안되지?');
    let code = 'reject';
    dataUpdate(code);
    alert("거절되었습니다.");
    $('#myModal').modal('hide');
}

function cancelModal() {
    location.reload();
}

  function generateCode(category) {
        console.log('cate value ' + category);
        var engCategory = Hangul.disassemble(category).join('').replace(/[^a-zA-Z]/g, ''); // 한글을 로마자로 변환
        var prefix = engCategory.substring(0, 2).toLowerCase();
        
        return prefix + '01'; // 예시로 '01'을 붙임
    }


//category
$(document).ready(function() {
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    $('#addRowBtn').click(function() {
        $('#newRowForm').show();
    });

    $('#newCategory').on('input', function() {
        var category = $(this).val();
        var code = generateCode(category);
        console.log('category value ' + code);
        $('#newCode').val(code);
    });

    $('#saveRowBtn').click(function() {
        let newCode = $('#newCode').val();
        let newCategory = $('#newCategory').val();
        
        console.log('data ' + newCode + ', ' + newCategory);
      $.ajax({
            type: 'POST',
            url: '/admin/saveCategory',
            data: { caid: newCode, category: newCategory },
            success: function(response) {
                alert('저장되었습니다!');
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                alert('저장에 실패했습니다: ' + error);
            }
        });
    });

  function generateCode(category) {
    console.log('cate value ' + category);
    
    // 오늘 날짜를 'YYYYMMDD' 형식으로 가져오기
    var today = new Date();
    var year = today.getFullYear();
    var month = ('0' + (today.getMonth() + 1)).slice(-2);
    var day = ('0' + today.getDate()).slice(-2);
    var dateString = year + month + day;
    
    // 카테고리명과 오늘 날짜 결합
    var code = category + dateString;
    
    return code;
}

});
