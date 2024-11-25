document.addEventListener('DOMContentLoaded', function() {
  let deleteModal = document.getElementById('deleteModal');
  deleteModal.addEventListener('show.bs.modal', function(event) {
    let button = event.relatedTarget; 
    let email = button.getAttribute('data-email');
    let modalEmail = deleteModal.querySelector('.modal-body #modalEmail');
    modalEmail.textContent = email; // Update the modal's content
  });
});

function sendEmail() {
  let reason = document.getElementById('deleteReason').value;
  let email = document.getElementById('modalEmail').textContent;
  let subject = "회원 삭제 사유";
  let text = "회원 삭제 사유: " + reason;

  $.ajax({
    url: '/send-email',
    type: 'GET',
    data: {
      to: email,
      subject: subject,
      text: text
    },
    success: function(response) {
      alert('메일송신을 완료하였습니다.');
    },
    error: function(xhr, status, error) {
      alert('해당 메일이 보호상태이거나, 존재하지않는 이메일입니다.');
    }
  });
}


function deleteUser() {
  let reason = document.getElementById('deleteReason').value;
  let email = document.getElementById('modalEmail').textContent;

  $.ajax({
    url: '/admin/deleteUser',
    type: 'GET',
    data: {
      email: email,
      reason: reason
    },
    success: function(response) {
      alert('성공적으로 탈퇴되었습니다.');
      location.reload();
    },
    error: function(xhr, status, error) {
      alert('존재하지 않는 사용자입니다.');
    }
  });
}

