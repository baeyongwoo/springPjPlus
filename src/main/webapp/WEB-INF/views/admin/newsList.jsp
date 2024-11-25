<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
					href="${pageContext.request.contextPath}/admin/index"><i
						class="fi fi-rr-home"> </i>홈</a>
				<li><a class="nav-link"
					href="${pageContext.request.contextPath}/board/list"><i
						class="fi fi-rr-lock"> </i>게시판</a></li>
				<li><a class="nav-link"
					href="${pageContext.request.contextPath}/admin/userList"><i
						class="fi fi-rr-rss"> </i>유저관리</a></li>
					<li><a class="nav-link" data-bs-toggle="tab"
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


					<!-- 게시글 -->
					<div class="col-sm-12">
						<div class="content">
							<div class="main">
								<div class="manu">

									<c:choose>
										<c:when test="${code == 'complete'}">
											<h3>완료된 기사</h3>
										</c:when>
										<c:when test="${code == 'permit'}">
											<h3>허가된 기사</h3>
										</c:when>
										<c:when test="${code == 'ready'}">
											<h3>미확인 기사</h3>
										</c:when>
										<c:when test="${code == 'reject'}">
											<h3>거부된 기사</h3>
										</c:when>
										<c:otherwise>
											<h3>알 수 없는 상태</h3>
										</c:otherwise>
									</c:choose>
									<div class="row">
										<div class="col-sm-12">
											<div class="card">
												<table class="table table-dark table-hover text-center">
													<tr>
														<th>row</th>
														<th>카테고리</th>
														<th>제목</th>
														<th>내용</th>
														<th>작성일자</th>
														<th>이메일</th>
														<th>작성자</th>
														<c:choose>
															<c:when
																test="${not empty tboardList and tboardList[0].code != 'complete'}">
																<th>처리</th>
															</c:when>
														</c:choose>
													</tr>
													<c:forEach items="${tboardList}" var="ul" varStatus="row">
														<tr class="${ul.code == 'complete' ? 'complete' : ''}">
														
														   <td><c:out value="${(currentPage - 1) * criteria.amount + row.index + 1}" /></td>
															<td><c:out value="${ul.category}" /></td>
															<td><c:out value="${ul.tmptitle}" /></td>
															<c:choose>
																<c:when test="${fn:length(ul.tmpcontent) > 50}">
																	<td><c:out
																			value="${fn:substring(ul.tmpcontent, 0, 50)}..." /></td>
																</c:when>
																<c:otherwise>
																	<td><c:out value="${ul.tmpcontent}" /></td>
																</c:otherwise>
															</c:choose>
															<td><c:out value="${ul.tmpregdate}" /></td>
															<td><c:out value="${ul.uemail}" /></td>
															<td><c:out value="${ul.uname}" /></td>
															<c:choose>
																<c:when test="${ul.code != 'complete'}">
																	<td class="check-btn" style="cursor: pointer;"
																		onclick="checkThisTempContent('${ul.tno}')"><input
																		type="hidden" id="title_${ul.tno}"
																		value="${fn:escapeXml(ul.tmptitle)}" /> <input
																		type="hidden" id="content_${ul.tno}"
																		value="${fn:escapeXml(ul.tmpcontent)}" /> <input
																		type="hidden" id="regdate_${ul.tno}"
																		value="${ul.tmpregdate}" /> <input type="hidden"
																		id="email_${ul.tno}" value="${ul.uemail}" /> <input
																		type="hidden" id="name_${ul.tno}"
																		value="${fn:escapeXml(ul.uname)}" /> <c:out
																			value="확인하기" /></td>
																</c:when>
															</c:choose>
														</tr>
													</c:forEach>
												</table>
											</div>
										</div>
										<nav>
											<ul class="pagination">
												<c:forEach var="i" begin="1" end="${totalPages}">
													<li class="page-item ${i == currentPage ? 'active' : ''}">
														<a class="page-link"
														href="?pageNum=${i}&amount=${criteria.amount}&code=${code}">${i}</a>
													</li>
												</c:forEach>
											</ul>
										</nav>

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
	<!-- 모달창 -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h4 class="modal-title">상세 정보</h4>
					<button type="button" class="close" data-dismiss="modal"
						onclick="cancelModal()">×</button>
				</div>
				<!-- 모달 바디 -->
				<div class="modal-body">
					<p>
						<strong>TNO:</strong> <span id="modalTno"></span>
					</p>
					<p>
						<strong>제목:</strong> <span id="modalTitle"></span>
					</p>
					<p>
						<strong>내용:</strong> <span id="modalContent"></span>
					</p>
					<p>
						<strong>작성일자:</strong> <span id="modalRegdate"></span>
					</p>
					<p>
						<strong>이메일:</strong> <span id="modalEmail"></span>
					</p>
					<p>
						<strong>작성자:</strong> <span id="modalName"></span>
					</p>
				</div>
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="approve()">허가</button>
					<button type="button" class="btn btn-danger"
						onclick="openRejectionModal()">거절</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 거절사유 모달 Modal -->
	<div class="modal" id="rejectionModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">거절 사유</h4>
					<button type="button" class="close" data-dismiss="modal"
						onclick="cancelRejectionModal()">×</button>
				</div>
				<div class="modal-body">
					<textarea id="rejectionReason" class="form-control" rows="5"
						placeholder="거절 사유를 입력하세요" required="required"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="sendRejectionEmail()">이메일 전송</button>
					<button type="button" class="btn btn-danger" onclick="reject()">거절</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/resources/js/admin/scripts.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			var rows = document.querySelectorAll('tr.complete');
			rows.forEach(function(row) {
				var ths = row.parentNode.querySelectorAll('th');
				var tds = row.querySelectorAll('td');

				var hideIndex = 6;

				ths[hideIndex].style.display = 'none';
				tds[hideIndex].style.display = 'none';
			});
		};
	</script>

</body>
</html>
