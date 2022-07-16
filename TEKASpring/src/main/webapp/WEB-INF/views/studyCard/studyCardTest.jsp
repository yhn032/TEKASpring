<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/studyCardWord.css"> --%>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<!-- 스크립트 -->
<script type="text/javascript">
var timer = null;
var index = 1;
var card = 0;
$(document).ready(function(){
	
	//즐겨찾기 버튼 초기화
	$.ajax({
		
		type: "GET",
		url	: "checkWrong.do",
		data: {"c_idx":"${param.c_idx}", "m_idx":"${user.m_idx}"},
		dataType:'json',
		success: function(res_data){
			if(res_data.res){
				//alert('초기화 성공');
				for(var i=0; i<res_data.list.length; i++){
					$("#star"+res_data.list[i]).val("★");
				}
			}else{
				//alert('초기화 실패. 틀린문제(즐겨찾기)가 없습니다.');
			}
			
		},
		error:	function(err){
			alert(err.responseText);
		}
		
	});
	
	card = $("input[name=slide]").length;
	
	$("#status").html(index +" / " + card);
	
	//프로그레스 바 초기 셋팅
	var per = index/card*100;
	$("#myBar").css("width", per+"%");

	//슬라이드의 체크 상태가 변경되면 진행바를 변경시키기
	$("input:radio[name='slide']").change(function(){
		//1번 슬라이드 : 0, 2번 슬라이드 : 1 ,,, n번 슬라이드 : n-1
		var temp = $(this).val() - 1;
		//alert(temp);
		var cnt = temp * -100;
		$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
		$("#status").html((temp+1) +" / " + card);
		var per = (temp+1)/(card)*100;
		//alert(per);
		$("#myBar").css("width", per+"%");
	});
	 
	//자동 재생 버튼을 누르면 시작
	$("#playCard").click(function(){
		location.href='?c_idx=${param.c_idx}&timer=use';//자기 자신에게 파라미터를 전달해주기
	});
	
	//정지 버튼을 누르면 정지
	$("#stopCard").click(function(){
		stop();
	});
	
	//섞기 버튼을 누르면 섞기 
	if('${param.opt eq "random"}' == 'true'){
		$("#msg").text("질문의 순서가 랜덤입니다.");
	}
	
	//파라미터가 있을때만, 재생 시작
	if('${ param.timer == "use"}'=='true'){
		play();
	}
	
	//class가 checkBtn인 모든 버튼에 대해서 click이벤트가 발생한다면,,,
	//현재 클릭한 태그만 값을 바꾼다.(모든 태그의 값을 바꾸지 않음)
	$(".checkBtn").click(function(){
		//name값을 얻어오는 방법
		var q_idx = $(this).attr("name");
		var c_idx = "${param.c_idx}";
		var m_idx = "${user.m_idx}";
		
		//alert(q_idx);
		//alert(c_idx);
		//alert(m_idx);
		
		if($(this).val()=="☆"){
			$(this).val("★");
			
			
			//q_idx값에 해당하는 질문의 q_Correct를 true로
			$.ajax({
				type:"GET",
				url :"wrongQna.do",
				data:{"q_idx": q_idx, "c_idx": c_idx},
				dataType: 'json',
				success : function(res_data){
					if(res_data.res){
						alert('즐겨찾기 성공');
					}else{
						alert('즐겨찾기 실패');
					}
				},
				error   : function(err){
					alert(err.responseText);
				}
				
			});
		}else{
			$(this).val("☆");
			
			//q_idx값에 해당하는 질문의 q_Correct를 false로
			$.ajax({
				type:"GET",
				url :"correctQna.do",
				data:{"q_idx": q_idx},
				dataType: 'json',
				success : function(res_data){
					if(res_data.res){
						alert('즐겨찾기 해제 성공');
					}else{
						alert('즐겨찾기 해제 실패');
					}
				},
				error   : function(err){
					alert(err.responseText);
				}
				
			});
		}
	});
});

function play(){
	if(timer == null){
		timer = setInterval(playCard, 6000);
		$("#msg").text("자동 재생이 켜져있습니다.");
	}
}

function stop(){
	clearInterval(timer);
	timer = null;
	index=1;
	$("#msg").text("자동 재생이 종료되었습니다.");
}

//flip과 slide를 나누어서 진행
function playCard() {
	var flip  = setTimeout(flipCard, 0);
}

function flipCard() {
	if(index > card){
		stop();
		return;
	}
	$(".card").toggleClass('flipped');
	var re = setTimeout(function(){
		$(".card").toggleClass('flipped');
	},2500);
	var slide = setTimeout(slideCard, 3000);
}

function slideCard(){
	index++;
	if(index > card){
		alert("모든 카드를 학습했습니다!");
		stop();
		return;
	}
	//console.log(index);
	$("#status").html(index +" / " + card);
	var cnt = (index-1) * -100;
	$("#slide" + index).prop("checked", true);
	$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
	var per = (index-1)/(card-1)*100;
	$("#myBar").css("width", per+"%");
}
</script>
<!-- 김다정_20220713 : q_question 요소 랜덤으로 섞기 -->
<script type="text/javascript">
	
	var q   = 0;
	var len = "${fn:length(list)*3-1}";
	
	$(function(){
		
		classList = $(".chooseCorrect");
		
		//쿼리의 c_idx를 이용해서 q_question 전체 조회
		$.ajax({
			url     : 'selectQuestion.do',
			data    : {"c_idx":"${param.c_idx}"},
			dataType: 'json',
			success : function(res) {
				
				//오답 질문 출력
				for(var i=0; i<res.suffle.length; i++) {
					
					q = classList[i].id;
					
					if( (i%3)==0 ) {

						$("#" + q).val(res.q_question[i]);
						
						$("#" + q).click(function(){
							
							alert('정답입니다.');
							
						})
						
						continue;
					} 
					
					$("#" + q).val(res.suffle[i]);
					$("#" + q).click(function(){
						
						alert('오답입니다.');
					})
					
				} //end : for
			}
		}); //end : ajax
	}); //end : function
	
</script>
<style type="text/css">
*{
	margin  : 0px;
	padding : 0px;
}

/* card css */
.card {	
	width        : 100%;
	height       : 100%;
	border-radius: 15px;
	margin-top: 10px;
}

.card-inner {
	position   : relative;
	width      : 100%;
	height     : 100%;
	text-align : center;
	transition : transform 0.5s;
	transform-style : preserve-3d; 	
	border-radius: 20px;
	
}
.card.flipped .card-inner {
	transform: rotateX(180deg);
}
.card-front {
	position : absolute; 
	top      : 0%;
	bottom   : 0%;
	width    : 100%;
	height   : 100%;
	border-radius    : 10px;
	border			 : 2px solid black;
	box-shadow       : 1px 1px 4px black;
	box-sizing       : border-box;
	-webkit-backface-visibility: hidden; /* Safari */
	backface-visibility: hidden;
	font-weight     : bold;
	font-size       : 30px;
	display         : flex;
	align-items     : top;
	padding:110px;
	justify-content : center;
	line-height     : 30px;
	white-space: normal;
	background: #2e3856;
	color: white;
}
.card-back {
	transform: rotateX(180deg);
}
/* study menu */
.studyMenu{
	display: flex;
	justify-content: space-between;
}

.studyItem{
	border: 1px solid black;
	width: 23%;
	height: 50px;
	border-radius    : 5px;
	border			 : 2px solid black;
	box-shadow       : 1px 1px 4px black;
	box-sizing       : border-box;
	text-align: left;
	line-height: 50px;
	font-size: 25px;
	font-weight: 600;
}

/* slide css */

/* 라디오 버튼 숨김 */
.section [id*=slide]{
	display : none;
}

.section .slideBox{
	max-width  : 900px;
	height     : 700px;
	/* margin     : auto; */
	margin-left: 200px;
	overflow   : hidden;
}

.section .slideList{
	white-space : nowrap;
	font-size   : 0;
	position    : relative;
	width       : 900px;
	height      : 620px;
	margin-top: 10px;
}

.section .slideList > li{
	display        : inline-block;
	vertical-align : middle;
	width	       : 100%;
	height         : 620px;
	transition     : 0.3s; /* 슬라이드 속도 설정 */
}

.section .slideList label{
	position  : absolute;
	z-index   : 1;
	top       : 50%;
	padding   : 27px;
	width	  : 350px;
	cursor    : pointer; /* 마우스가 올라갔을 때, 커서 -> 포인터 변경 */
	border    : 4px solid #3ccfcf;
}


.section .slideList .left{
	left : 50px;
	top: 600px;
	border-bottom-left-radius: 40px;
	border-top-left-radius: 40px;
}
.section .slideList .right{
	right : 50px;
	top: 600px;
	border-bottom-right-radius: 40px;
	border-top-right-radius: 40px;
}

/* 초기위치 설정값 */
 .section [id="slide1"]:checked ~ .slideBox .slideList > li {
	transform:translateX(0%);
}

#progress{
	position: relative;
	width: 100%;
	height: 3px;
	background-color: black;
	border-radius: 5px;
	box-shadow: 1px 1px 3px 1px black;
}
#myBar{
	position: absolute;
	width: 0%;
	height: 100%;
	background-color: purple;
}

#btnBox{
	margin-left: 200px;	
	background-color: #0a092d; 
	width: 900px; 
	display: flex; 
	justify-content: space-around;
	box-shadow: 1px 1px 3px 1px #dadce0;
	height: 80px;
}

#btnBox > input{
	width: 30%; 
	height: 60px;
	border: 1px solid #282e3e; 
	background-color: #13141b; 
	color: #3ccfcf; 
	border: 2px solid #3ccfcf;
	margin-top: 10px;
}

.checked{
	height: 55px; 
	width: 55px;
	font-size: 40px; 
	text-align: right; 
	margin-right: 15px;
	border-radius: 35px;
	border: 2px dotted yellow;
	line-height: 50px;
	box-sizing: border-box;
}

.checkBtn{
	width: 50px;
	height: 50px;
	border: 2px dotted yellow;
	background-color: transparent; 
	border: 0;
	line-height: 50px;
	color: gold;
}

.checkBtn:hover{
	background-color: #979958;
	border-radius: 35px;
}

#msg{
	color: white;
	margin-left: 550px;
	font-size: 18px; 
	font-weight: 600;
}

.correctArea {
	position:fixed;
	top:420px;
	right:105px;
}
.chooseCorrect {
	display: block;
	width: 700px;
	height: 50px;
	background-color: #2E3856;
	font-size:20px;
	text-align: left;
	color:white;
	border: none;
	border-radius: 10px;
	cursor:pointer; 
}

.chooseCorrect:hover{
	background-color: #586380;
}

</style>
</head>
<body style="background-color: #0a092d;">

<div id="header">
	<%@include file="../header/studyCardHeader.jsp" %>
</div>
<div id="progress">
	<div id="myBar"></div>
</div>
<div class="section">
	<!-- 카드 개수 : input -->
	<input type="radio" name="slide" value="1" id="slide1" checked>
	<c:forEach begin="2" end="${fn:length(list) }" varStatus="i">
		<!-- i.count begin과 관계없이 1부터 시작 -->
		<input type="radio" name="slide" value="${i.count+1 }" id="slide${i.count + 1 }">
	</c:forEach>
	
	<div class="slideBox">
		<ul class="slideList">
		<!-- 슬라이드 영역 -->
		<c:forEach var="qna" items="${list }" begin="0" end="${fn:length(list)-1 }" varStatus="i">
			<li>
				<!-- 이전 페이지로 이동한다.  -->
				<div class="checked"><input class="checkBtn" id="star${qna.q_idx }" type="button" value="☆" name="${qna.q_idx }"></div>
				<span style="z-index: 11;"><label for="slide${i.index}" class="left"></label>◀</span>
				<div class="card" style="font-size: 10px;">
					<div class="card-inner">
						<div class="card-front" style="font-size:20px; ">${qna.q_answer }</div>
					</div>
					
					<!-- 김다정_20220713 : 삼지선다 영역 -->
					<div class="correctArea">
						<input type="button" class="chooseCorrect" id="q_${3*i.index+1}" >
						<input type="button" class="chooseCorrect" id="q_${3*i.index+2}" >
						<input type="button" class="chooseCorrect" id="q_${3*i.index+3}" >
					</div>
				</div>
				<span><label for="slide${i.count+1 }" class="right"></label>▶</span>
			</li>
			</c:forEach>
		<!-- 슬라이드 영역 종료 -->	
		</ul>
	</div>
	
</div><!-- section end -->
</body>
</html>