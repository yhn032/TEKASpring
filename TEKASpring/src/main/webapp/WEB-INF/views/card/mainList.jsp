<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 모든 학습세트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style type="text/css">
#mainmenu{
	height: 80px;
}
#content{
	margin: auto;
	min-height: 700px;
}
#footer{
	padding: 10px;
	color: white;
	height: 200px;
	clear:both;
}
</style>
</head>
<body style="background:#2e3856;">
<div id="box">
	<div id="mainmenu">
		<%@ include file="../header/mainmenu.jsp" %>
	</div>
	<div id="content" style="background:#2e3856;">
		<%@ include file="../content/mainCardListContent.jsp" %>
	</div>
	<div id="footer" style="background:#2e3856;">
		<%@ include file="../footer/footer.jsp" %>
	</div>
</div>
</body>
</html>
