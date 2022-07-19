<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 튜토리얼</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/tutorial.css">
<script type="text/javascript">
$(document).ready(function(){
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});
});
function makeCard(){
	var qText = $("#qText").val().trim();
	var aText = $("#aText").val().trim();
	
	//글자 수가 110이상인 경우 폰트사이즈 변경
	if(qText.length>=110){
		$("#q").html(qText).css("font-size", "26.5px");
	}else {
		$("#q").html(qText).css("font-size", "30px");
	}
	if(aText.length>=110){
		$("#a").html(aText).css("font-size", "26.5px");
	}else {
		$("#a").html(aText).css("font-size", "30px");
	}
}
function send(){
	if(!confirm('아쉽네요... 다음번엔 TEKA와 함께해주세요')) return;
	location.href="main.do";
}
</script>
</head>
<body>
<!-- header -->
<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>
<!-- 카드 보여주기 cardView -->
	<div id="cardView">
		<div class="text">
			<p style="color:white; font-weight:500;">TEKA 학습세트를 직접 만들어보세요.<br><br>카드를 클릭해보세요! 👉</p><br><br>
		</div>
		<div class="card">
			<div class="card-inner">
				<div class="card-front">Click here!</div>
				<div class="card-back">Welcome TEKA!</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div><!-- card_view end -->
	<div id="one">
			<p class="count">&nbsp;하나.</p><br>
			<p class="ment">원하는 주제별로 카테고리를 설정해요.</p><br>
     		<select class="form-control" id="multiBox">
		        <option>주제를 선택하세요.</option>
		        <option>운영체제</option>
		        <option>네트워크</option>
		        <option>알고리즘</option>
		        <option>자료구조</option>
		        <option>자바</option>
		        <option>스프링</option>
	     	 </select><br><br><br>
 	</div><!-- one end -->
	<div id="two">
		<p class="count">&nbsp;둘.</p><br>
		<p class="ment">내용을 입력하세요. 카드를 클릭하면 뜻을 볼 수 있어요.&#128161;</p><br>
			<div id="card-container">
				<div class="card" id="cardBox">
					<div class="card-inner">
						<div class="card-front"><div id="q"></div></div>
						<div class="card-back"><div id="a"></div></div>
					</div>
				</div>
			</div>
		<div id="textInsert">
				<div class="qnaArea">
					<textarea spellcheck="false" maxlength="145" id="qText"></textarea>
					<p class="qnaText">질문</p>
				</div>
				<div class="qnaArea">
					<textarea spellcheck="false" maxlength="145" id="aText"></textarea>
					<p class="qnaText">답변</p>
				</div>
			<div id="insertbtnArea">
				<input type="button" id="insertBtn" value="카드만들기" onclick="makeCard();">
			</div>
		</div><!-- end : textInsert -->
	</div><!-- end : two -->
	<div id="three">
		<p class="count">&nbsp;셋.</p><br>
		<p class="ment">다른 사람의 학습세트를 공부할 수 있어요. ✏️</p><br>
	    <div id="grid_container">
		    <div class="card-container">
				<div class="card" id="cardSet">
					<div class="card-inner">
						<div class="card-front">
							<div id="question">
								<b>TEKA</b>
							</div>
						</div>
						<div class="card-back">
							<div id="answer">
								<b>Technical Interview Study</b>
							</div>
						</div>
					</div>
				</div>
				<div class="side">
					<button type="button" class="btn btn-xs btn-primary"><b style="font-size:18px;">추천</b>&nbsp;&nbsp;<span class="badge">13</span></button>
					<input type="button" value="❤️" disabled="disabled" style="background: transparent; font-size:20px;"><br>
					<div class="label label-info" style="background-color: red; font-size:17px;">자바
					</div>
					<span class="badge">TEKA</span><br> 
					<input type="button" class="plusCard w-btn w-btn-gra3 w-btn-gra-anim" value="미리보기"> 
					<input type="button" id="addelete" class="plusCard w-btn w-btn-gra3 w-btn-gra-anim" value="내 학습세트에 추가">
				</div>
			</div>
		</div>
	</div><!-- end : three -->
	<div class="text" style="margin-top:350px; margin-bottom:170px;">
		<p style="font-weight:500; color:white;">자, 이제 TEKA에서 학습할 준비가 끝났어요.<br><br>멋진 학습세트를 만들어보세요!</p><br><br>
		<div id="lastBtn">
			<input type="button" value="홈화면으로 돌아가기" class="btn btn-default btn-lg" onclick="send();">
			<input type="button" value="회원가입" class="btn btn-default btn-lg" onclick="location.href='../tekamember/signUpForm.do'">
		</div>			
	</div>			
<div id="footer" style="background:none;">
	<%@ include file="../footer/footer.jsp" %>	
</div>
</body>
</html>