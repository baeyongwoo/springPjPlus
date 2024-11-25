<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>error</title>
</head>
<body>
	<h1>Access Denied</h1>
	<h2>
		<c:out value="${msg}"></c:out>
	</h2>
</body>
</html>