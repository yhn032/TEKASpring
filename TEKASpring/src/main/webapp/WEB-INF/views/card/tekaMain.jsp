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
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/tekaMain.css">
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
			<input class="mainBtn btn btn-info" type="button" value="나도 만들어보기"    onclick="location.href='tutorial.do'">
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
<div id="footer" style="background: #2e015f;">
	<%@ include file="../footer/footer.jsp" %>	
</div>
</body>
</html>