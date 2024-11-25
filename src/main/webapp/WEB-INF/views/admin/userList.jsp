<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<link href="/resources/adcss/css/styles.css" rel="stylesheet" />



<title>IO Admin</title>


</head>

<body class="sb-nav-fixed">

	<div id="layoutSidenav">

	<!-- Sidebar -->
		<aside class="side-bar">
			<ul class="nav nav-tabs" role="tablist">
				<i class="fi fi-rr-list"></i>
				<li><a class="nav-link active" 
					href="${pageContext.request.contextPath}/admin/index"><i class="fi fi-rr-home"> </i>홈</a>
				<li><a class="nav-link"  href="${pageContext.request.contextPath}/board/list"><i
						class="fi fi-rr-lock"> </i>게시판</a></li>
				<li><a class="nav-link" 
					href="${pageContext.request.contextPath}/admin/userList"><i class="fi fi-rr-rss"> </i>유저관리</a></li>
				<li><a class="nav-link" 
					href="${pageContext.request.contextPath}/admin/category"><i class="fi fi-rr-rss"> </i>카테고리관리</a></li>
			</ul>
		</aside>
		<!-- End of Sidebar -->
	<div id="layoutSidenav_content">
						<main>
				<div class="container-fluid px-4" style="width: 95%; float: right;">
					<a href="${pageContext.request.contextPath}/admin/index">
						<h1 class="mt-4">Home</h1>
					</a>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active"></li>
					</ol>


					<!-- 유저정보 -->
					<div class="col-sm-12">
						<div class="content">
							<div class="main">
								<div class="manu">
									<h3>유저목록</h3>

									<div class="row">
										<div class="col-sm-12">
											<div class="card">
												<table class="table table-dark table-hover text-center">
													<tr>
														<th>row</th>
														<th>Email</th>
														<th>이름</th>
														<th>소속</th>
														<th>채택된 게시글수</th>
														<th>등록한 게시글수</th>
														<th>관리</th>
													</tr>
													<c:forEach items="${userList}" var="ul" varStatus="row">
														<tr>
															<td><c:out value="${row.index+1}" /></td>
															<td id="uemail"><c:out value="${ul.uemail}" /></td>
															<td><c:out value="${ul.uname}" /></td>
															<td><c:out value="${ul.dname}" /></td>
															<td><c:out value="${ul.post_count}" /></td>
															<td><c:out value="${ul.insert_count}" /></td>
															<td><button type="button" class="btn btn-danger"
																				data-bs-toggle="modal" data-bs-target="#deleteModal"
																				data-email="${ul.uemail}">회원삭제</button></td>



														</tr>
													</c:forEach>

												</table>

											</div>
										</div>

									</div>
								</div>

							</div>
						</div>

					</div>

				</div>
		
					</div>
		</main>
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; Information Ocean
						Company</div>
				</div>
			</div>
		</footer>
	
				</div>
	<!--삭제모달 -->
	<div class="modal fade" id="deleteModal" tabindex="-1"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">회원 삭제 확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					정말로 삭제하시겠습니까?
					<div class="mb-3">
						<label for="deleteReason" class="form-label">사유 작성</label>
						<textarea class="form-control" id="deleteReason" rows="3"></textarea>
					</div>
					<p>
						<strong>이메일:</strong> <span id="modalEmail"></span>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" onclick="sendEmail()">이메일
						발송</button>
					<button type="button" class="btn btn-danger" onclick="deleteUser()">탈퇴</button>
				</div>
			</div>
		</div>
	</div>








	<script src="/resources/js/admin/user.js"></script>


</body>
</html>
