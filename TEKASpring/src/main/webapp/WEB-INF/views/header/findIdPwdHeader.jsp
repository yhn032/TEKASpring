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
<style type="text/css">
#headContainer{
	width: 100%;
	height: 80px;
	background-color: #222222;
	display: flex;
	justify-content: flex-end;
}

html, body, hr{
	margin: 0;
	padding: 0;
}

a{
	text-decoration-line: none;
	color:white;
}

#cancelBtn{
	width: 50px;
	height: 50px;
	border: 2px solid black;
	margin-top: 15px;
	margin-right: 50px;
	border-radius: 5px;
	background-color: #b0adad;
	color: black;
	font-size: 20px;
	align-content: right;
}

.findBtn{
	line-height: 80px;
	width: 100px;
	text-align:center;
	border: 2px solid #222222;
	background-color: #222222;
	border-radius: 10px;
	box-shadow: 1px 3px 1px black;
}
</style>

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