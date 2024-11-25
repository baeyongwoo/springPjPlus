<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IO News</title>
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

let tno =${boardMap.tno}

    $(document).ready(function(){
        $(".box").mouseenter(function(){
            var target = $(this).find(".box-content");
            target.animate({top: "0"}, 300);
            target.find(".default-content").hide();
            target.find(".hidden-content").show();
        }).mouseleave(function(){
            var target = $(this).find(".box-content");
            target.animate({top: "240px"}, 300);
            target.find(".default-content").show();
            target.find(".hidden-content").hide();
        });
        
        $(document).ready(function(){
            let tno = ${boardMap.tno}
            
            $.getJSON("/board/getAttachList", {tno: tno}, function(arr){  
                var str = "";

                $(arr).each(function(i, attach){       
                    if(attach.fileType){
                        var fileCallPath =  encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
                        str += "<li><img src='/display?fileName=" + fileCallPath + "' alt='첨부파일 이미지'></li>";
                    } else {
                        str += "<li style='cursor:pointer;' data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
                        str += "<div><span>" + attach.fileName + "</span><br/>";
                        str += "<img src='/resources/logo/Noimg.png' alt='기본 이미지'></div></li>";
                    }
                });
                
                $(".uploadResult").html(str);
                console.log("Generated HTML: " + str); // HTML 구조 확인
            });
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var loggedIn = /* 서버에서 세션 상태를 확인하는 로직 */
        
        if (loggedIn) {
            document.getElementById("login-link").style.display = "none";
            document.getElementById("join-link").style.display = "none";
            document.getElementById("logout-link").style.display = "block";
            document.getElementById("mypage-link").style.display = "block";
        } else {
            document.getElementById("login-link").style.display = "block";
            document.getElementById("join-link").style.display = "block";
            document.getElementById("logout-link").style.display = "none";
            document.getElementById("mypage-link").style.display = "none";
        }
    });
</script>
</head>
<body>
	<%@ include file="/resources/heater/header.jsp"%>
	<!-- 비디오 섹션 -->
	<figure class="vid">
		<video loop autoplay muted>
			<source src="/resources/logo/simhea.mp4" type="video/mp4">
		</video>
	</figure>


	<!-- 네비게이션 바 -->
	<div class="container-fluid">
		<!-- 탭 콘텐츠 -->
		<div class="tab-content">
			<div id="menu1" class="container tab-pane active">
				<br>
				<div class="row">
					<a type="submit button">
						<h3>
							최신순<i class="fi fi-rr-angle-right"></i>
						</h3>
					</a>
					<div class="container_fluid">

						<!-- 나머지 데이터 표시 -->
						<c:forEach var="board" items="${latestList}">

							<a type="button" class="box uploadResult"> <c:url
									value="/display" var="url">

									<c:param name="fileName"
										value="${board.buploadpath}/${board.buuid}_${board.bfilename}" />
								</c:url> <img src="${url}" alt="이미지" width="100%">
								<div class="box-content">

									<%-- <img src='/display?fileName=${board.buploadpath}/${board.buuid}_${board.bfilename}' alt='첨부파일 이미지'> --%>
									<div class="default-content">
										<c:choose>
											<c:when test="${fn:length(board.title) > 25}">
																${fn:substring(board.title, 0, 25)}...
															</c:when>
											<c:otherwise>
																${board.title}
															</c:otherwise>
										</c:choose>

										<div class="container-fluid" style="text-align: left;">${board.uname}</div>
									</div>
									<div class="hidden-content">
										<c:choose>
											<c:when test="${fn:length(board.bcontent) > 180}">
																${fn:substring(board.bcontent, 0, 180)}...
															</c:when>
											<c:otherwise>
																${board.bcontent}
															</c:otherwise>
										</c:choose>
									</div>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
			</div>
			<c:forEach var="cate" items="${cateList}">
				<c:forEach var="entry" items="${boardMap}">
					<c:choose>
						<c:when test="${entry.key == cate.category}">
							<div id="menu1" class="container tab-pane active">
								<br>
								<div class="row">
									<a type="submit button">
										<h3 style="${empty entry.value ? 'display:none;' : ''}">
											${cate.category} <i class="fi fi-rr-angle-right"></i>
										</h3>
									</a>
									<div class="container_fluid">

										<!-- 나머지 데이터 표시 -->

										<c:forEach var="board" items="${entry.value}">

											<a type="button" class="box"> <c:url value="/display"
													var="url">

													<c:param name="fileName"
														value="${board.buploadpath}/${board.buuid}_${board.bfilename}" />
												</c:url> <img src="${url}" alt="이미지" width="100%">


												<div class="box-content">

													<div class="default-content">
														<c:choose>
															<c:when test="${fn:length(board.title) > 25}">
																${fn:substring(board.title, 0, 25)}...
															</c:when>
															<c:otherwise>
																${board.title}
															</c:otherwise>
														</c:choose>
														<div class="container-fluid" style="text-align: left;">${board.uname}</div>
													</div>

													<div class="hidden-content">
														<c:choose>
															<c:when test="${fn:length(board.bcontent) > 200}">
																${fn:substring(board.bcontent, 0, 200)}...
															</c:when>
															<c:otherwise>
																${board.bcontent}
															</c:otherwise>
														</c:choose>
													</div>
												</div>
											</a>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:forEach>
			</c:forEach>
		</div>
		<!-- 탭 끝 -->
	</div>
	<!-- 콘텐츠 끝 -->

	<!-- 푸터 -->
	<%@ include file="/resources/heater/footer.jsp"%>
	<script>
        $(document).ready(function() {
            var logoutMessage = "${logoutMessage}";
            if (logoutMessage) {
                alert(logoutMessage);
            }
        });
    </script>
</body>
</html>
