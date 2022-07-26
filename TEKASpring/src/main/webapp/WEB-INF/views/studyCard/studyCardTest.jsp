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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/studyCard/studyCardTest.css">
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<!-- SweetAlert -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
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
					$("input[name="+ res_data.list[i] +"]").val("★");	//id로 태그 접근
					//$("#star"+res_data.list[i]).val("★");				//name으로 태그 접근
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
		
		if($(this).val()=="☆"){
			$(this).val("★");
			
			//해당 질문을 관심질문 테이블에 추가하기
			$.ajax({
				type:"GET",
				url :"wrongQna.do",
				data:{"q_idx": q_idx, "c_idx": c_idx},
				dataType: 'json',
				success : function(res_data){
					if(res_data.res){
						Swal.fire({
							  icon: 'success',
							  title: '관심질문에 등록되었습니다!'
						});
						//alert('즐겨찾기 성공');
					}else{
						//alert('즐겨찾기 실패');
						Swal.fire({
							  icon: 'warning',
							  title: '관심질문에 등록하지 못했습니다ㅜ'
						});
					}
				}
			});
		}else{
			$(this).val("☆");
			
			//해당 질문을 관심질문 테이블에서 삭제하기
			$.ajax({
				type:"GET",
				url :"correctQna.do",
				data:{"q_idx": q_idx},
				dataType: 'json',
				success : function(res_data){
					if(res_data.res){
						Swal.fire({
							  icon: 'success',
							  title: '관심질문에서 삭제되었습니다!'
						});
					}else{
						Swal.fire({
							  icon: 'warning',
							  title: '관심질문에서 삭제하지 못했습니다 ㅜ'
						});
					}
				}
			});
		}
	});
	
});

function slideCard(){
	index++;
	if(index > card){
		Swal.fire({
			title: '시험이 종료되었습니다.\n틀린문제만 따로 학습하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="studyCardStar.do?c_idx="+${param.c_idx};
			} else if (result.isDenied) {
				location.href="studyCardMain.do?c_idx=" + ${param.c_idx};
			}
		});
	}

	$("#status").html(index +" / " + card);
	var cnt = (index-1) * -100;
	$("#slide" + index).prop("checked", true);
	$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
	var per = (index-1)/(card-1)*100;
	$("#myBar").css("width", per+"%");
	
	//정답 배경이미지 제거
	$(".card-front").css("background-image", "url('')");
}

/* 틀린문제 추가하기 */
function updateWrongQna(num){
	if($("#star"+num).val() == "☆"){
		$("#star"+num).val("★");
		
		var q_idx = $("#star"+num).attr("name");
		var c_idx = "${param.c_idx}";
		
		$.ajax({
			type:"GET",
			url :"wrongQna.do",
			data:{"q_idx": q_idx, "c_idx": c_idx},
			dataType: 'json',
			success : function(res_data){
				
			}
		});
	}
}
</script>
<!-- 삼지선다 보기 -->
<script type="text/javascript">

//document가 초기화되자마자 모든 li에 3지 선다 초기화 시키기. arr에는 각 섞인 인덱스가 저장되고, 0 3, 6, 9 ..가 정답이다. 
$(function(){
	var arr = new Array();
	$.ajax({
		url     : 'threeChoice.do',
		data    : {"c_idx":"${param.c_idx}"},
		dataType: 'json',
		success : function(res) {
			var globalListSize = "${fn:length(list)}";
			//alert(random_1+" "+random_2);
			if(globalListSize < 3){
				Swal.fire({
					  icon: 'warning',
					  title: '적어도 3개의 질문이 있어야 시험보기 기능이 가용합니다!'
				});
				return;
			}
			for(var i=0; i<"${fn:length(list)}"; i++) {

				var q1 = 3*i+0;
				var q2 = 3*i+1;
				var q3 = 3*i+2;
				var temp = [q1,q2,q3];
				shuffle(temp);
				
				for(var k=0; k<3; k++){
					arr[i*3+k] = temp[k];	
				}
				
				var random_1 = Math.floor(Math.random()*globalListSize);
				var random_2 = Math.floor(Math.random()*globalListSize);
				
				while(random_1 == i){
					random_1 = Math.floor(Math.random()*globalListSize);
				}
				while((random_2 == i) || (random_2 == random_1)){
					random_2 = Math.floor(Math.random()*globalListSize);
				}
				$("#q_" + arr[i*3+0]).val(res.one[i]);//정답
				$("#q_" + arr[i*3+1]).val(res.one[random_1]);//순서를 섞은 오답
				$("#q_" + arr[i*3+2]).val(res.one[random_2]);//순서를 섞은 오답
				
				/* //정답
				$("#q_" + arr[0]).click(function(){
					$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/answerIcon.png')",
										   "background-size":"450px", "background-repeat":"no-repeat", "background-position":"center top" });
					setTimeout(function() { slideCard() }, 600); //다음 카드로 넘기기
				});
				//오답
				$("#q_" + arr[1]).click(function(){
					$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/falseIcon.png')",
										   "background-size":"400px", "background-repeat":"no-repeat", "background-position":"center top" });
					var a = $(this).attr("id").substring(2);
					var num = Math.floor(a/3);
					updateWrongQna(num);
					setTimeout(function() { slideCard() }, 600); //다음 카드로 넘기기
				})
				$("#q_" + arr[2]).click(function(){
					$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/falseIcon.png')",
						  				   "background-size":"400px", "background-repeat":"no-repeat", "background-position":"center top" });
					var a = $(this).attr("id").substring(2);
					var num = Math.floor(a/3);
					updateWrongQna(num);
					setTimeout(function() { slideCard() }, 600); //다음 카드로 넘기기
				}) */
			} //end : for
			/* for(var i=0; i<arr.length; i++){
				console.log(i + " : " +arr[i]);
			} */
		}
	}); //end : ajax
	
	
/* 	$(".threechoice").click(function(){
		alert($(this).attr("id"));
		return;
	}); */
	$(".threechoice").click(function(){
		var idx = $(this).attr("id").substring(2);
		
		var i = Math.floor(idx/3);
		//alert(idx);
		//alert(arr[idx]);
		//선택된 값(idx)이 -> arr[i*0]이랑 같아야 한다 이말이지.
		if(arr[i*3] == idx){
			//alert("정답");
			$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/answerIcon.png')",
				   "background-size":"450px", "background-repeat":"no-repeat", "background-position":"center top" });
			setTimeout(function() { slideCard() }, 600); //다음 카드로 넘기기
			
		}else {
			//alert("오답");
			$(".card-front").css( {"background-image": "url('${pageContext.request.contextPath}/resources/img/falseIcon.png')",
				   "background-size":"400px", "background-repeat":"no-repeat", "background-position":"center top" });
			var num = Math.floor(idx/3);
			updateWrongQna(num);
			setTimeout(function() { slideCard() }, 600); //다음 카드로 넘기기
		}
	});
}); //end : 윈도우 초기화


function shuffle(arr) {
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
				<div class="checked"><input class="checkBtn" id="star${i.index }" type="button" value="☆" name="${qna.q_idx }"></div>
				<div class="card" style="font-size: 10px;">
					<div class="card-inner">
						<div class="card-front" style="font-size:20px; ">${qna.q_answer }</div>
					</div>
					<!-- 삼지선다 보기 -->
					<div class="choice">
						<input type="button" class="threechoice" id="q_${3*i.index+0}">
						<input type="button" class="threechoice" id="q_${3*i.index+1}">
						<input type="button" class="threechoice" id="q_${3*i.index+2}">
					</div>
				</div>
			</li>
		</c:forEach>
		<!-- 슬라이드 영역 종료 -->	
		</ul>
	</div>
</div><!-- section end -->
</body>
</html>