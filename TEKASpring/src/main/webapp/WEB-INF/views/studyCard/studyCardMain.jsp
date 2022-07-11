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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/studyCard.css">
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<!-- 스크립트 -->
<script type="text/javascript">
var index = 1;
var card = 0;
$(document).ready(function(){
	
	
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});
	
	card = $("input[name=slide]").length;
	
	$("#status").html(index +" / " + card);

	//슬라이드의 체크 상태가 변경되면 진행바를 변경시키기
	$("input:radio[name='slide']").change(function(){
		//1번 슬라이드 : 0, 2번 슬라이드 : 1 ,,, n번 슬라이드 : n-1
		var temp = $(this).val() - 1;

		var cnt = temp * -100;
		$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
		$("#status").html((temp+1) +" / " + card);
	});
	 
});
</script>
<script type="text/javascript">
	
	function previewPopup(c_idx){
		
		$.ajax({

			url:'../card/popup.do?c_idx=' + c_idx, //c_idx를 쿼리로 전송
			dataType:'json',
			success : function(resData){
			
				//m_nickname 출력
				$("#m_nickname").html('madeBy' + ' ' + resData.m_nickname);
				$("#c_title").html(resData.c_title);
				$("#c_content").html(resData.c_content);
				
				for(i in resData.question){
					
					var jsonDiv = {
									 table : "<table class=\"question\">",
									 q : "<tr><th><textarea cols=\"40\" readonly=\"readonly\" class=\"q_question" + i + "\"",	
									 qCss: "style=\"border:none; border-bottom: thick double #C2B0DA; resize:none; font-size:17px;\"></textarea></th>",
									 a : "<th><textarea cols=\"80\" readonly=\"readonly\" class=\"q_answer" + i + "\"",
									 aCss:"style=\"border:none; border-bottom: thick double #C2B0DA; resize:none; font-size:17px; vertical-align: bottom;\"></textarea></th></tr>",
									 qText:	"<tr><th class=\"qnaText\">질문</th>",
									 aText: "<th class=\"qnaText\">답변</th></tr></table>"
								  };
					
					var div = '';
					
					for(j in jsonDiv){
						
						div += jsonDiv[j];
					}
					
					$(".res").append(div);
				
					$(".q_question" + i).append(resData.question[i]);
					$(".q_question" + i).height(1).height($(".q_question" + i).prop('scrollHeight'));
					
					$(".q_answer" + i).append(resData.answer[i]);
					$(".q_answer" + i).height(1).height($(".q_answer" + i).prop('scrollHeight'));
				}	
			}//success end
		});
		
		//append했던 데이터 지우기
		$("#q_question").remove();
		$("#q_answer").remove();
		$(".question").remove();

		centerBox();
		$("#popupBox").show();
	}
</script>

</head>
<body style="background-color: #0a092d;">
<%@include file="../content/previewPopup.jsp" %>

<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>

<div class="section">
	<!-- 카드 개수 : input -->
	<input type="radio" name="slide" value="1" id="slide1" checked>
	<c:forEach begin="2" end="${fn:length(list) }" varStatus="i">
		<!-- i.count begin과 관계없이 1부터 시작 -->
		<input type="radio" name="slide" value="${i.count+1 }" id="slide${i.count + 1 }">
	</c:forEach>
	
	<div class="slideBox">
		<div id="title" style="font-size: 25px; font-weight: 600; color: white;">
			${list[0].c_title }<br>
			<span style="font-size: 18px; font-weight: 400; color: white;">안녕하세요, ${user.m_nickname }님! 오늘은 어떤 학습을 하시겠어요?</span>
		</div>
		<!-- 학습 목록 -->
		<div class="studyMenu">
			<div class="studyItem">&nbsp<i class="fas fa-clone"></i>&nbsp <a href="studyCardWord.do?c_idx=${param.c_idx }&type=word">낱말카드</a></div>
			<div class="studyItem">&nbsp<i class="fas fa-brain"></i>&nbsp <a href="studyCardLearn.do?c_idx=${param.c_idx }&type=learn">학습하기</a></div>
			<div class="studyItem">&nbsp<i class="fas fa-hourglass-start"></i>&nbsp <a href="studyCardTest.do?c_idx=${param.c_idx }&type=test">시험보기</a></div>
			<div class="studyItem">&nbsp<i class="fas fa-star"></i>&nbsp <a href="studyCardStar.do?c_idx=${param.c_idx }&type=star">관심질문</a></div>
		</div>
		<ul class="slideList">
		<!-- 슬라이드 영역 -->
		<c:forEach var="qna" items="${list }" begin="0" end="${fn:length(list)-1 }" varStatus="i">
			<li>
				<!-- 이전 페이지로 이동한다.  -->
				<label for="slide${i.index}" class="left"><span>◀</span></label>
				<div class="card">
					<div class="card-inner">
						<div class="card-front">${qna.q_question }</div>
						<div class="card-back">${qna.q_answer }</div>
					</div>
				</div>
				<label for="slide${i.count+1 }" class="right"><span>▶</span></label>
			</li>
		</c:forEach>
		<!-- 슬라이드 영역 종료 -->	
		</ul>
		<div id="status" style="text-align: center; color: white; font-size: 15px;"></div>
	</div>
</div><!-- section end -->
<div style="text-align: center;"><input class="btn btn-success" type="button" value="카드 한 눈에 보기" style="text-align:center; width: 150px; height: 40px;" onclick="previewPopup(${param.c_idx});"></div>
</body>
</html>