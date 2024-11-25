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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Sevillana&display=swap"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>IO News</title>
<style type="text/css">
ul, li {
	list-style: none;
}

img {
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 60%;
	background:#ffffff;
}
</style>
<script>
	/* 오류가 날 수 있는 코드 (JS 파일로 이동 후 추가) */
	var csrfHeaderName = "<c:out value='${_csrf.headerName}'/>";
	var csrfTokenValue = "<c:out value='${_csrf.token}'/>";
</script>
</head>
<body>
	<%@ include file="/resources/heater/header.jsp"%>
	<div class="container mt-3" style="text-align: right;">

		<h3 style="text-align: center;">기사내용</h3>
		<div class="row">
			<div class="container-fluid">
				<div class="container mt-3" style="text-align: left;">
					<ol class="list-group">


						<li class="list-group-item"><c:out value="${board.bno}" />번기사</li>
						<li class="list-group-item">

							<h2 style="font-weight: bold;">
								<c:out value="${board.title}" />
							</h2>
						</li>
						<li class="list-group-item"><strong>${board.dname}</strong> <b><c:out
									value="${board.uname}" /></b> <span>(${board.uemail})</span></li>



						<li class="list-group-item"
							style="color: #6c757d; font-style: italic;"><fmt:formatDate
								value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></li>
						<li class="list-group-item" style="min-height: 200px;">

							<div class="row">
								<div class="col-lg-12">
									<div class="panel panel-default">

										<div class="panel-heading"></div>
										<!-- /.panel-heading -->
										<div class="panel-body">

											<div class='uploadResult'></div>
										</div>
										<!--  end panel-body -->
									</div>
									<!--  end panel-body -->
								</div>
								<!-- end panel -->
							</div> <!-- /.row -->
							<h4>
							<textarea style="width:100%" rows="20" readonly><c:out value="${board.bcontent}" />
							</textarea>
							</h4>
						</li>



					</ol>
				</div>
			</div>
			<div style="text-align: right; display: flex; margin-bottom: 20px;">
				<%-- <form
					action="${pageContext.request.contextPath}/board/edit/${board.bno}"
					method="get" style="display: inline;">
					<button type="submit" class="btn btn-primary">수정</button>
				</form> --%>
				<form action="/board/delete" method="post"
					style="width: 100%; margin-right: 20px;"
					onsubmit="return confirm('정말 삭제하시겠습니까?');">
					<input type="hidden" name="bno" value="${board.bno}" />
					<button type="submit">삭제</button>
				</form>
				<button type="button" onclick="location.href='/board/list'">목록</button>
			</div>
		</div>

		<!-- 댓글목록 ---------------------------------------------------------------->
		<div class="row">
			<div class="col-lg-12" style="text-align: left;">
				<div class="panel panel-defualt">
					<div class="panel-heading">
						<h2 style="width: 100%">
							<div>
								<i class="fa fa-comments fa-fw"></i>댓글
							</div>
						</h2>
						<div style="">
							<%-- 로그인한 경우만 댓글등록 버튼 출력 --%>
							<sec:authorize access="isAuthenticated()">
								<div style="text-align: right;">
									<button id="addReplyBtn" class="btn">등록</button>
								</div>
							</sec:authorize>
						</div>

					</div>
					<div class="panel-body">
						<!-- 댓글목록 출력 UL태그 ---------------------------->
						<ul class="chat">

						</ul>
					</div>
					<div class="panel-footer"></div>
				</div>
			</div>
		</div>
		<!-- 댓글목록.end -->

		<!-- 모달 ------------------------------------------------------------------->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">댓글 창</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>댓글</label><a href="#" class="pull-right" id="emoji">emoji</a>
							<input class="form-control" name='reply' id="message">
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name='replyer'
								readonly>

						</div>
						<div class="form-group">
							<label>등록일</label> <input class="form-control" name='replyDate'
								value="SYSDATE" readonly>
						</div>
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
						<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
						<button id='modalRegisterBtn' type="button"
							class="btn btn-primary">등록</button>
						<button id='modalCloseBtn' type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>   
		/* csrf토큰 *****************************************************************/
		var csrfHeaderName ="${_csrf.headerName}"; 
		var csrfTokenValue="${_csrf.token}";
		
		
		/* 댓글작성자 *****************************************************************************/
      <sec:authorize access="isAuthenticated()">          
         <sec:authentication property="principal" var="pinfo" />
         const replyerid= "${pinfo.username}";
      </sec:authorize>
      /*tno  */
 		var tno =${board.tno};
   </script>

	<script
		src="/resources/js/board/reply.js?bno=<c:out value='${board.bno}'/>"></script>



	<script src="/resources/js/board/vanillaEmojiPicker.js"></script>
	<script>

        new EmojiPicker({
            trigger: [
                {
                    selector: '#emoji',
                    insertInto: '#message'
                },
            ],
            closeButton: true,
        });

    </script>



	<%@ include file="/resources/heater/footer.jsp"%>
</body>
</html>