<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>IO Admin</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/hangul-romanize@1.0.0/dist/hangul-romanize.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<link href="/resources/adcss/css/styles.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">

	<div id="layoutSidenav">

		<!-- Sidebar -->
		<aside class="side-bar">
			<ul class="nav nav-tabs" role="tablist">
				<i class="fi fi-rr-list"></i>
				<li><a class="nav-link active" data-bs-toggle="tab" href="/admin/index"><i class="fi fi-rr-home"> </i>홈</a>
				<li><a class="nav-link" data-bs-toggle="tab" href="/board/list"><i class="fi fi-rr-lock"> </i>게시판</a></li>
				<li><a class="nav-link" data-bs-toggle="tab" href="/admin/userList"><i class="fi fi-rr-rss"> </i>유저관리</a></li>
				<li><a class="nav-link" data-bs-toggle="tab" href="/admin/category"><i class="fi fi-rr-rss"> </i>카테고리관리</a></li>
			</ul>
		</aside>
		<!-- End of Sidebar -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4" style="width: 95%; float: right;">
					<h1 class="mt-4">CateGory</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active"></li>
					</ol>

					<!-- 카테고리정보 -->

					<div class="col-sm-12">
						<div class="content">
							<div class="main">
								<div class="manu">
									<h3>카테고리목록</h3>
									<div class="row">
										<div class="col-sm-6">
											<div class="card">
												<table class="table table-dark table-hover text-center">
													<tr>
														<th>row</th>
														<th>code</th>
														<th>카테고리명</th>
													</tr>
													<c:forEach items="${cate}" var="ul" varStatus="row">
														<tr>
															<td><c:out value="${row.index+1}" /></td>
															<td><c:out value="${ul.caid}" /></td>
															<td><c:out value="${ul.category}" /></td>
														</tr>
													</c:forEach>

												</table>
												<button id="addRowBtn">행 추가</button>

											</div>
										</div>

									</div>
									<div class="row">
										<div class="col-sm-6">
									<div id="newRowForm" style="display: none;">
										<div class="input-group mb-3">
											<span class="input-group-text" id="basic-addon1">code그림</span> <input
												type="text" class="form-control" placeholder="code" name="caid" id="newCode" readonly="readonly"
												aria-label="newcode" aria-describedby="basic-addon1">
										</div>
										<div class="input-group mb-3">
											<span class="input-group-text" id="basic-addon1">카테고리명</span> 
											<input
												type="text" class="form-control" placeholder="카테고리명을 입력하세요" name="caid" id="newCategory" required="required"
												aria-label="newcode" aria-describedby="basic-addon1">
										</div>
									
										<button id="saveRowBtn">저장</button>
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
					<div class="text-muted">Copyright © Information Ocean
						Company</div>
				</div>
			</div>
		</footer>

	</div>
	</div>
	<script>
		$(document).ready(function() {
			console.log('jQuery and hangul-romanize loaded');
			console.log('hangulRomanize test: ' + hangulRomanize('기술'));
		});
	</script>
	<script src="/resources/js/admin/scripts.js"></script>
</body>
</html>
