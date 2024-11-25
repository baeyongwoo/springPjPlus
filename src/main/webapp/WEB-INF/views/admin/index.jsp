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
<title>IO Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<link href="/resources/adcss/css/styles.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">

	<div id="layoutSidenav">

		<!-- Sidebar -->
		<aside class="side-bar">
			<ul class="nav nav-tabs" role="tablist">
				
				<li><a class="nav-link active" data-bs-toggle="tab"
					href="/admin/index"><i class="fi fi-rr-home"> </i>홈</a>
				<li><a class="nav-link" data-bs-toggle="tab"
					href="/admin/userList"><i class="fi fi-rr-rss"> </i>유저관리</a></li>
					<li><a class="nav-link" data-bs-toggle="tab"
					href="/admin/category"><i class="fi fi-rr-rss"> </i>카테고리관리</a></li>
					<li><hr style="border: 1px solid #1e3a56; margin: 0;"/></li>
				<li><a class="nav-link" data-bs-toggle="tab" href="/board/list"><i
						class="fi fi-rr-lock"> </i>게시판</a></li>
						<li/>
			</ul>
		</aside>
		<!-- End of Sidebar -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4" style="width: 95%; float: right;">
					<h1 class="mt-4">Dashboards</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active"></li>
					</ol>
					<div class="row">
						<div class="col-xl-3 col-md-6">
							<div class="card bg-primary text-white mb-4">
								<div class="card-body">
									등록된 기사들 (
									<c:out value="${tboardCount.complete}" />
									)
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link"
										href="/admin/newsList?code=complete">자료보러가기</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-warning text-white mb-4">
								<div class="card-body">
									허가된 기사들(
									<c:out value="${tboardCount.permit}" />
									)
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link"
										href="/admin/newsList?code=permit">자료보러가기</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-success text-white mb-4">
								<div class="card-body">
									확인하지않는 기사들 (
									<c:out value="${tboardCount.ready}" />
									)
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link"
										href="/admin/newsList?code=ready">자료보러가기</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-danger text-white mb-4">
								<div class="card-body">
									거부된 기사들 (
									<c:out value="${tboardCount.reject}" />
									)
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link"
										href="/admin/newsList?code=reject">자료보러가기</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> Area Chart Example
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> Bar Chart Example
								</div>
								<div class="card-body">
									<canvas id="myBarChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>
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
													</tr>
													<c:forEach items="${userList}" var="ul" varStatus="row">
														<tr>
															<td><c:out value="${row.index+1}" /></td>
															<td><c:out value="${ul.uemail}" /></td>
															<td><c:out value="${ul.uname}" /></td>
															<td><c:out value="${ul.dname}" /></td>
															<td><c:out value="${ul.post_count}" /></td>
															<td><c:out value="${ul.insert_count}" /></td>
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
	</div>
	<script src="js/scripts.js"></script>
</body>
</html>
