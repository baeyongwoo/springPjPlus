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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<title>로그인</title>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
</head>
<body>
	<div class="container" style="text-align: center; margin-top: 90px;">
		<a class="navbar-brand" href="/board/list">
            <img src="/resources/logo/IOLogo.png" alt="Logo" style="width: 100px; border-radius: 20%; margin-bottom: 100px;">
        </a>

		<div class="container d-flex justify-content-center">
			<div>
				<h3>로그인</h3>
				<form method="post" id="operForm" class="was-validated"
					action="/user/login">
					<div class="mb-3 mt-3">
						<label for="uname" class="form-label">아이디:</label> <input
							type="email" class="form-control" id="userId"
							placeholder="email-id" name="username"required>
					</div>
					<div class="mb-3">
						<label for="pwd" class="form-label">비밀번호:</label> <input
							type="password" class="form-control" id="pwd"
							placeholder="비밀번호를 입력하세요" name="password"required> <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</div>
					<c:if test="${param.error == 'true'}">
						<div style="color: red;">아이디와 비밀번호를 확인해주세요.</div>
					</c:if>
					<button type="submit" data-oper="login" class="btn btn-primary"style="margin-top:5px;margin-bottom:10px;width:80%;"  >로그인</button>
					<a href="/user/join" class="btn btn-primary" role="button" style="margin-top:5px;margin-bottom:5px; width:40%;">회원가입</a>

					<a href="/board/list" class="btn btn-primary"  role="button" style="margin-top:5px;margin-bottom:5px;width:40%;">메인페이지</a>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/resources/heater/footer.jsp"%>
</body>
</html>
