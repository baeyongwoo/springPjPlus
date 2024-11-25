<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<title>IO</title>
<script>
  $(function () {
    $(".shado").click(function () {
        var url = $(this).attr("href");
        $("body div").animate({
            "opacity": "0",
            "top": "10px"
        },500, function () {
            document.location.href = "/board/list";
        });
        return false;
    });
});
</script>
<style>
body {
	margin: 0;
	overflow: hidden;
	background-color: #3a3a3a;
	color: #ffffff;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	font-family: "Nanum Pen Script", cursive;
}

.shado {
	padding: 50px;
	border-radius: 50%;
	box-shadow: 0px -5px 20px rgba(47, 0, 255, 0.6), 0px 5px 20px rgba(47, 0, 255, 0.6);
	background-color: rgba(255, 255, 255, 0.2);
	backdrop-filter: blur(10px);
	z-index: 2;
	text-align: center;
	transition: transform 0.3s ease-in-out;
}

.shado:hover {
	transform: scale(1.1);
}

.shado h1 {
	color: #ffffff;
	font-size: 3rem;
	transition: color 0.3s;
}

.shado:hover h1 {
	color: #ffcc00;
}

img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	position: fixed;
	top: 0;
	left: 0;
	opacity: 0.7;
	z-index: 1;
}

.tracking-in-expand {
	-webkit-animation: tracking-in-expand 2s ease-out ;
	        animation: tracking-in-expand 2s ease-out ;
}
@-webkit-keyframes tracking-in-expand {
  0% {
    letter-spacing: -0.5em;
    opacity: 0;
  }
  40% {
    opacity: 0.6;
  }
  100% {
    opacity: 1;
  }
}
@keyframes tracking-in-expand {
  0% {
    letter-spacing: -0.5em;
    opacity: 0;
  }
  40% {
    opacity: 0.6;
  }
  100% {
    opacity: 1;
  }
}

</style>
</head>
<body>
	<img src="/resources/logo/lolo.jpg" alt="Ocean Image">
	<div class="shado tracking-in-expand">
		<a type="button">
			<h1>Information Ocean</h1>
		</a>
	</div>
</body>
</html>
