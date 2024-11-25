<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Page</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn-uicons.flaticon.com/2.5.1/uicons-regular-rounded/css/uicons-regular-rounded.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Sevillana&display=swap"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/css/logo" rel="stylesheet">
</head>
<body>

	<nav class="navbar navbar-expand-sm">
		<div class="container">
			<a class="navbar-brand" href="/board/list"> <img
				src="/resources/logo/IOLogo.png" alt="Logo" id="logo">
			</a>
			<div class="navbar-nav">
				<p id="Logoo">IO</p>
			</div>
			<div class="navbar-nav right">
				<ul class="navbar-nav">
					<c:choose>
						<c:when test="${loggedIn}">
							<li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
							<li class="nav-item"><a class="nav-link" href="/user/mypage">마이페이지</a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
							<li class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<aside class="side-bar">
			<ul class="nav nav-tabs" role="tablist">
				<i class="fi fi-rr-list"></i>
				<li><a class="nav-link" href="/board/list"><i
						class="fi fi-rr-home"> </i>홈</a></li>
				<li><a class="nav-link" href="/board/list/all"><i
						class="fi fi-rr-home"> </i>전체보기</a></li>
				<li><a class="nav-link" href="/user/modify">회원정보 수정/삭제</a></li>
			</ul>
		</aside>
	</nav>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://www.springframework.org/security/tags"
		prefix="sec"%>

	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER','ROLE_USER')">
	<h1>내 게시글</h1>
		<table class="table table-dark table-hover text-center">
			<thead>
				<tr>
					<th>No</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>내용</th>
					<th>카테고리</th>
					<th>소속사</th>
					<th>수정</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="post" items="${myPosts}">
					<tr>
						<td>${post.tno}</td>
						<td><c:choose>
								<c:when test="${fn:length(post.tmptitle) > 30}">
                                ${fn:substring(post.tmptitle, 0, 30)}...
                            </c:when>
								<c:otherwise>
                                ${post.tmptitle}
                            </c:otherwise>
							</c:choose></td>
						<td>${post.tmpregdate}</td>
						<td><c:choose>
								<c:when test="${fn:length(post.tmpcontent) > 50}">
                                ${fn:substring(post.tmpcontent, 0, 50)}...
                            </c:when>
								<c:otherwise>
                                ${post.tmpcontent}
                            </c:otherwise>
							</c:choose></td>
						<td>${post.category}</td>
						<td>${post.dname}</td>
						<!-- 수정 페이지로 이동하는 폼 -->
						<td>
						
						<a class="btn btn-primary" href="/board/edit/${post.tno}">수정하기</a>
							
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</sec:authorize>

	<%@ include file="/resources/heater/footer.jsp"%>
</body>
</html>
