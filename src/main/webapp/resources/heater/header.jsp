<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.navbar-nav right{
style="z-index:30"
}
</style>
</head>

<body>
	<header>
		<nav class="navbar navbar-expand-sm">
			<div class="container">
				<a  style="z-index:30" class="navbar-brand" href="/board/list"> <img
					src="/resources/logo/IOLogo.png" alt="Logo" id="logo">
				</a>
				<div class="navbar-nav">
					<p id="Logoo">IO</p>
				</div>
				<div class="navbar-nav right">
					<ul class="navbar-nav">
						<c:choose>
							<c:when test="${loggedIn}">
								<c:if
									test="${not fn:contains(sessionScope.authorities, 'ROLE_USER')}">
									<li class="nav-item"><a class="nav-link"
										href="/board/post">기사 작성 </a></li>
								</c:if>
								<c:if
									test="${fn:contains(sessionScope.authorities, 'ROLE_ADMIN')}">
									<li class="nav-item"><a class="nav-link"
										href="/admin/index">관리자 페이지</a></li>
								</c:if>
								<li class="nav-item"><a class="nav-link"
									href="/user/logout">로그아웃 </a></li>
								<li class="nav-item"><a class="nav-link"
									href="/user/mypage">마이페이지</a></li>
							</c:when>
							<c:otherwise>
								<li  class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
								<li style="z-index:30" class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
			<aside class="side-bar">
				<ul class="nav nav-tabs" role="tablist">
					
					<li><a class="nav-link" href="/board/list"><i
							class="fi fi-rr-home"> </i>홈</a></li>
					<li><a class="nav-link" href="/board/list/all"><i
							class="fi fi-rr-home"> </i>전체보기</a></li>
					<c:forEach var="cate" items="${cateList}">
						<li><a class="nav-link" href="/board/list/${cate.caid}"><i
								class="fi fi-rr-lock"> </i>${cate.category}</a></li>
					</c:forEach>
				</ul>
			</aside>
		</nav>
	</header>
</body>
</html>
