<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>TEKA : 시험보기</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/studyCardTest.css">
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
				for(var i=0; i<res_data.list.length; i++){
					$("#star"+res_data.list[i]).val("★");
				}
			}else{
			}
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
	
	//class가 checkBtn인 모든 버튼에 대해서 click이벤트가 발생한다면,,,
	//현재 클릭한 태그만 값을 바꾼다.(모든 태그의 값을 바꾸지 않음)
	$(".checkBtn").click(function(){
		//name값을 얻어오는 방법
		var q_idx = $(this).attr("name");
		var c_idx = "${param.c_idx}";
		var m_idx = "${user.m_idx}";
		
		if($(this).val()=="☆"){
			$(this).val("★");
			
			//q_idx값에 해당하는 질문의 q_Correct를 true로
			$.ajax({
				type:"GET",
				url :"wrongQna.do",
				data:{"q_idx": q_idx, "c_idx": c_idx},
				dataType: 'json',
				success : function(res_data){
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
				}
			});
		}
	});
});

function slideCard(){
	index++;
	if(index > card){
		if(!confirm('시험이 종료되었습니다.\n메인학습페이지로 이동하시겠습니까?')) return;
		//메인 페이지로 이동
		location.href="studyCardMain.do?c_idx=" + ${param.c_idx};
	}

	$("#status").html(index +" / " + card);
	var cnt = (index-1) * -100;
	$("#slide" + index).prop("checked", true);
	$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
	var per = (index-1)/(card-1)*100;
	$("#myBar").css("width", per+"%");
	
	//정답 백그라운드 이미지 제거
	$(".card-front").css("background-image", "url('')");
}
</script>
<!-- 김다정_20220713 : q_question 요소 랜덤으로 섞기 -->
<script type="text/javascript">
	
	var len = "${fn:length(list)*3}";
	
	$(function(){
		
		$.ajax({
			url     : 'selectQuestion.do',
			data    : {"c_idx":"${param.c_idx}"},
			dataType: 'json',
			success : function(res) {
				
				for(var i=0; i<len/3; i++) {
					
					var q1 = 3*i+1;
					var q2 = 3*i+2;
					var q3 = 3*i+3;
					
					var arr = [q1,q2,q3];
					
					//보기 배열 섞기
					fisherYatesShuffle(arr);
					
					//오답 배열 섞기 (중복보기 최소화) 
					fisherYatesShuffle(res.two);
					fisherYatesShuffle(res.three);
					
					$("#q_" + arr[0]).val(res.one[i]);
					$("#q_" + arr[1]).val(res.two[i]);
					$("#q_" + arr[2]).val(res.three[i]);
					
					$("#q_" + arr[0]).click(function(){
						//정답 배경이미지 추가
						$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/answerIcon.png')",
											   "background-size":"450px", "background-repeat":"no-repeat",
											   "background-position":"center top"
												});
						//다음 카드로 넘기기
						setTimeout(function() {slideCard()}, 600);
					});
					
					$("#q_" + arr[1]).click(function(){
						//오답 배경이미지 추가
						$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/falseIcon.png')",
											   "background-size":"400px", "background-repeat":"no-repeat",
											   "background-position":"center top"
												});
						//배경이미지 제거
						setTimeout(function() {
							$(".card-front").css("background-image", "url('')")
						}, 650);
					})
					
					$("#q_" + arr[2]).click(function(){
						//오답 배경이미지 추가
						$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/falseIcon.png')",
							   "background-size":"400px", "background-repeat":"no-repeat",
							   "background-position":"center top"
								});
						//배경이미지 제거
						setTimeout(function() {
							$(".card-front").css("background-image", "url('')")
						}, 650);
					})
				} //end : for
			}
		}); //end : ajax
	}); //end : function
	
	function fisherYatesShuffle(arr){
	    for(var i=arr.length-1; i>0; i--){
	        var j = Math.floor( Math.random() * (i + 1) ); // 랜덤 인덱스 생성
	        [arr[i], arr[j]] = [arr[j], arr[i]]; // swap
	    }
	} // end : fisherYatesShuffle
	
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
					
					<!-- 김다정_20220713 : 삼지선다 영역 3*i.index+1 -->
					<div class="correctArea">
						<input type="button" class="chooseCorrect" id="q_${3*i.index+1}" name="${qna.q_idx}">
						<input type="button" class="chooseCorrect" id="q_${3*i.index+2}" name="${qna.q_idx}">
						<input type="button" class="chooseCorrect" id="q_${3*i.index+3}" name="${qna.q_idx}">
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