<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 기술 면접 플래시 카드</title>

<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
body{
	background: #2e015f;
}

/* main.css */
#content {
	min-height: 700px;
	padding-top: 80px;
	width: 55%;
	margin-left: 0px;
	float: left;
}

#sub_content {
	padding-top: 80px;
	width: 35%;
	margin-left: 0px;
	float: left;
	margin-top: 120px;
	margin-left: 50px;
	color: white;
}

/* content */
.mainBtn {
	width: 160px;
	height: 30px;
	margin: auto;
}

.tutorial{
	margin-left: 200px;
}

/* card */
#card-container{
	background: #CFD8FF;
	background: linear-gradient(to right, #b25858, #9a3dff);
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	width: 70%;
	height: 330px; 
	border-radius: 100px;
	margin: auto;
	margin-top: 50px;
	border: 1px solid #9E5B40;
}

.card {
	line-height: 270px;
	width: 400px;
	height: 270px;
	margin: 0 auto;
	margin-top: 5%;
}

.card-inner {
	position: relative;
	width: 100%;
	height: 100%;
	text-align: center;
	transition: transform 0.8s;
	transform-style: preserve-3d; 
}

.card.flipped .card-inner {
	transform: rotateX(180deg);
}

.card-front, .card-back {
	position: absolute;
	top:0%;
	bottom:0%;
	width: 100%;
	height: 100%;
	background-color: white;
	border-radius: 50px;
	box-shadow: 1px 1px 4px black;
	box-sizing: border-box;
	-webkit-backface-visibility: hidden; /* Safari */
	backface-visibility: hidden;
}

.card-back {
	transform: rotateX(180deg);
}


</style>
<script type="text/javascript">
$(document).ready(function(){
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});
	
});

</script>
</head>
<body>
<div id="main-container">
	<div id="header">
		<%@include file="../header/mainmenu.jsp" %>
	</div>
	
	<div id="content">
		<div id="card-container">
			<div class="card">
				<div class="card-inner">
					<div class="card-front">TEKA</div>
					<div class="card-back">Tech Kard : 기술 면접 준비</div>
				</div>
			</div>
		</div><br>
		<div class="tutorial">
			<input class="mainBtn btn btn-info" type="button" value="나도 만들어보기"    onclick="location.href='test.do'">
			<input class="mainBtn btn btn-info" type="button" value="다른 학습세트보기"  onclick="location.href='mainList.do'">
		</div>
	</div>
	
	<div id="sub_content">
		<div id="explain">
			<p style="font-size: 25px; font-weight: 700;">
				TEKA<br>
				Technical Interview Study<br>
				지금 바로 다른 사람의 학습법을 공유받으세요.<br>
			</p>
		</div><br>
		<c:if test="${empty user }">
			<input class="mainBtn btn btn-success" type="button" value="로그인"   onclick="location.href='../tekamember/loginForm.do'">
			<input class="mainBtn btn btn-success" type="button" value="회원가입" onclick="location.href='../tekamember/signUpForm.do'">
		</c:if>
	</div>
</div>
<div id="footer">
	<%@ include file="../footer/footer.jsp" %>	
</div>
</body>
</html>