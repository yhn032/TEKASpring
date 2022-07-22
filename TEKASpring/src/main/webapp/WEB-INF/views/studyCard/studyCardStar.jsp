<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>TEKA : 관심질문</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/studyCard/studyCardWord.css">
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
	
	
	$(".card").click(function(){
		$(this).toggleClass("flipped");
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
		<!-- 즐겨찾기한 카드가 없는 경우 -->
		<c:if test="${empty list }">
			<div class="card">
				<div class="card-inner">
					<div class="card-front">즐겨찾기한 질문이 없습니다. 카드를 클릭해보세요.</div>
					<div class="card-back">
						학습을 통해 관심 질문을 선택해보세요.
					</div>
				</div>
			</div>
		</c:if>
		<!-- 슬라이드 영역 -->
		<!-- 즐겨찾기한 카드가 있는 경우 -->
		<c:if test="${not empty list }">
			<c:forEach var="qna" items="${list }" begin="0" end="${fn:length(list)-1 }" varStatus="i">
				<li>
					<!-- 이전 페이지로 이동한다.  -->
					<div class="checked"><input class="checkBtn" id="star${qna.q_idx }" type="button" value="☆" name="${qna.q_idx }"></div>
					<span style="z-index: 11;"><label for="slide${i.index}" class="left"></label>◀</span>
					<div class="card">
						<div class="card-inner">
							<div class="card-front">${qna.q_question }</div>
							<div class="card-back">${qna.q_answer }</div>
						</div>
					</div>
					<span><label for="slide${i.count+1 }" class="right"></label>▶</span>
				</li>
			</c:forEach>
		</c:if>
		<!-- 슬라이드 영역 종료 -->	
		</ul>
	</div>
</div><!-- section end -->
<c:if test="${not empty list }">
	<span id="msg"></span>
	<div id="btnBox">
		<input type="button" value="▶ 원래대로" id="notShuffleCard" onclick="location.href='?c_idx=${param.c_idx}';">
		<input type="button" value="∞ 순서섞기" id="shuffleCard" onclick="location.href='?c_idx=${param.c_idx}&opt=random';">
	</div>
</c:if>
<c:if test="${empty list }">
	<div id="btnBox">
		<input type="button" value="낱말카드" onclick="location.href='studyCardWord.do?c_idx=${param.c_idx }&type=word'">
		<input type="button" value="시험보기" onclick="location.href='studyCardTest.do?c_idx=${param.c_idx }&type=test'">
	</div>
</c:if>
</body>
</html>