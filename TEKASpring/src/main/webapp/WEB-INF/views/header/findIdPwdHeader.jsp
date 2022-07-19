<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header/findIdPwdHeader.css">
</head>
<body>
<div id="headContainer">
	<div class="findBtn" style="margin-right: 10px;">
		<a href="findID.do">아이디찾기</a>
	</div>
	<div class="findBtn" style="margin-right: 40%;">
		<a href="findPWD.do">비밀번호찾기</a>
	</div>
	<div id="cancel">
		<input id="cancelBtn" type="button" value="x" onclick="location.href='../tekamember/loginForm.do'">
	</div>
</div>
</body>
</html>