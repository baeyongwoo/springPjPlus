<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <title>회원정보 수정/삭제</title>
    <script>
	    document.getElementById("operForm").onsubmit = function() {
	        var pwd = document.getElementById("pwd").value;
	        var pwdch = document.getElementById("pswdch").value;
	
	        if (pwd !== pwdch) {
	            alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
	            return false;
	        }
	        return true;
	    };
	</script>
</head>
<body>
    <div class="container" style="text-align: center; margin-top: 90px;">
        <a class="navbar-brand" href="/board/list">
            <img src="/resources/logo/IOLogo.png" alt="Logo" style="width: 100px; border-radius: 20%; margin-bottom: 100px;">
        </a>
        
        <div class="container d-flex justify-content-center">
            <div>
                <h3>회원정보수정</h3>
                <form method="post" action="/user/update" id="operForm" class="was-validated">
				    <div class="mb-3 mt-3">
				        <label for="uname" class="form-label">이름:</label>
				        <input type="text" class="form-control" id="uname" name="uname" value="${userData.uname}" readonly>
				    </div>
				    <div class="mb-3">
				        <label for="email" class="form-label">이메일:</label>
				        <input type="email" class="form-control" id="email" name="uemail" value="${userData.uemail}" readonly>
				    </div>
				    <div class="mb-3">
				        <label for="pwd" class="form-label">비밀번호:</label>
				        <input type="password" class="form-control" id="pwd"  name="upwd" placeholder="비밀번호를 입력하세요" required>
				    </div>
				    <div class="mb-3">
				        <label for="pswdch" class="form-label">비밀번호 확인:</label>
				        <input type="password" class="form-control" id="upwdch" placeholder="비밀번호 확인을 입력하세요" name="pwdch"  required>
				    
				    </div>
				    <div class="mb-3">
				        <label for="email" class="form-label">소속:</label> <select
							name="did">
							<c:forEach var="dept" items="${dept}">
								<option value="${dept.did}">${dept.dname}</option>
							</c:forEach>
						</select>
				    </div>
				    <div class="d-flex justify-content-between">
				        <input type="submit" value="수정" class="btn btn-primary" onsubmit="return confirm('정말 수정하시겠습니까?');">
				        <input type="button" value="취소" class="btn btn-secondary" onclick="location.href='/board/list'">
				    </div>
				</form>
				<form style="width:100%; margin-top:10px;  background-color:red;" method="post" action="/user/delete" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="uemail" value="${userData.uemail}" style="width:100%;">
                    <input type="submit" value="삭제" class="btn btn-danger" style="width:100%; background-color:red;">
                </form>
            </div>
        </div>
    </div>
    <%@ include file="/resources/heater/footer.jsp" %>
    <script type="text/javascript">
	function checkpwd() {
	    let upwd = document.getElementById('upwd').value;
	    let upwdch = document.getElementById('upwdch').value;
	    if (upwd !== upwdch) {
	        alert("비밀번호가 일치하지 않습니다.");
	        return false;
	    }else{
	    	alert("비밀번호가 확인되었니다.");
	    }
	}

	</script>
</body>
</html>
