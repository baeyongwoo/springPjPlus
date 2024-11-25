<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>403 Forbidden</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
	color: #343a40;
	text-align: center;
	padding: 50px;
}

.container {
	max-width: 600px;
	margin: 0 auto;
}

h1 {
	font-size: 72px;
	margin-bottom: 20px;
}

p {
	font-size: 24px;
	margin-bottom: 40px;
}

a {
	color: #007bff;
	text-decoration: none;
	font-size: 18px;
}

a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="container">
		<h1>403</h1>
		<p>접근이 금지되었습니다.</p>
		<p>이 페이지에 접근할 권한이 없습니다.</p>
		 <button onclick="history.back();">뒤로가기</button>
	</div>
</body>
</html>
