<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IO</title>
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
<script>
	$(document).ready(function() {
		$(".box").mouseenter(function() {
			var target = $(this).find(".box-content");
			target.animate({
				top : "0"
			}, 300);
			target.find(".default-content").hide();
			target.find(".hidden-content").show();
		}).mouseleave(function() {
			var target = $(this).find(".box-content");
			target.animate({
				top : "240px"
			}, 300);
			target.find(".default-content").show();
			target.find(".hidden-content").hide();
		});
	});
</script>
<style type="text/css">
.row {
	margin-left: 170px;
}
</style>
</head>
<body>
	<%@ include file="/resources/heater/header.jsp"%>
	<!-- Video Section -->
	<figure class="vid">
		<video loop autoplay muted>
			<source src="/resources/logo/simhea.mp4" type="video/mp4">
		</video>
	</figure>

	<!-- Navigation Bar -->
	<div class="container-fluid" >
		

		<div class="row" style="width: 80%;">
			<div class="col-sm-12">
				<div class="card">
					<table class="table table-dark table-hover text-center" >
						<tr>
							<th width="5%">row</th>
							<th width="30%">제목</th>
							<th width="*">내용</th>
							<th width="7%">작성일자</th>
							<th width="7%">이메일</th>
							<th width="6%">작성자</th>
						</tr>
						<c:forEach items="${boardList}" var="ul" varStatus="row">
							<tr onclick="location.href='/board/read?bno=${ul.bno}'"
								style="cursor: pointer;">
								<td><c:out value="${row.index+1}" /></td>
								<td><c:out value="${ul.title}" /></td>
								<c:choose>
									<c:when test="${fn:length(ul.bcontent) > 50}">
										<td><c:out value="${fn:substring(ul.bcontent, 0, 50)}..." /></td>
									</c:when>
									<c:otherwise>
										<td><c:out value="${ul.bcontent}" /></td>
									</c:otherwise>
								</c:choose>
								<td><c:out value="${ul.regdate}" /></td>
								<td><c:out value="${ul.uemail}" /></td>
								<td><c:out value="${ul.uname}" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<nav>
				<ul class="pagination" >
					<c:forEach var="i" begin="1" end="${totalPages}" >
						<li class="page-item ${i == currentPage ? 'active' : ''}" ><a 
							class="page-link"
							href="?pageNum=${i}&amount=${criteria.amount}&caid=${caid}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>

		<!-- tabEnd -->
	</div>
	<!-- content end -->

	<!-- Footer -->
	<%@ include file="/resources/heater/footer.jsp"%>
</body>
</html>
