<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 모든 학습세트</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.card-container {
	text-decoration: none;
	margin: auto;
	width: 640px;
	height: 300px;
	background: linear-gradient(to right, #b25858, #9a3dff);
	border-radius: 10px;
	display: flex;
}

.card {
	background-color: transparent;
	width: 420px;
	height: 280px;
	perspective: 1000px; /* Remove this if you don't want the 3D effect */
	margin-top: 10px;
	margin-left: 10px;
}

/* This container is needed to position the front and back side */
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

/* Position the front and back side */
.card-front, .card-back {
	position: absolute;
	width: 100%;
	height: 100%;
	border-radius: 10px;
	box-shadow: 1px 1px 4px black;
	-webkit-backface-visibility: hidden; /* Safari */
	backface-visibility: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: white;
}

.card-back {
	transform: rotateX(180deg);
}

#question, #answer {
	font-weight: bolder;
	font-size: 30px;
}

.side {
	padding: 10px;
	margin-left: 15px;
	margin-top: 20px;
	width: 180px;
	height: 280px;
}

.introduction {
	padding-top: 30px;
}

#grid_container {
	margin: auto;
	width: 1460px;
	padding-top: 15px;
	display: grid;
	grid-template-columns: 725px 725px;
	grid-template-rows: 300px 300px;
	row-gap: 50px;
	column-gap: 20px;
	border-radius: 20px;
}

#filter {
	margin: auto;
	width: 1460px;
	height: 100px;
}

#title {
	margin: auto;
	width: 1460px;
	height: 100px;
	line-height: 100px;
	font-size: 45px;
}

.plusCard {
	text-align: center;
	width: 100%;
	height: 60px;
	margin-top: 40px;
}

.w-btn {
    position: relative;
    border: none;
    display: inline-block;
    border-radius: 15px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
}

.w-btn-gra3 {
    background: linear-gradient(
        45deg,
        #002bff,
        #7a00ff,
        #ff00c8,
        #ff0000
    );
    color: white;
}

.w-btn-gra-anim {
    background-size: 400% 400%;
    animation: gradient1 5s ease infinite;
}

/* button animation */
@keyframes gradient1 {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});	
	
	setTimeout(showMsg, 100);
	
});

function showMsg(){
	if("${param.reason eq 'exist'}" == "true"){
		Swal.fire({
			title: '이미 저장되어 있는 학습카드입니다.\n나의 학습카드로 이동하시겠습니까?',
			icon: 'question',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="myCardList.do";
			} else if (result.isDenied) {
				return;
			}
		});
	}
	
	if("${param.reason eq 'success'}" == "true"){
		Swal.fire({
			title: '선택한 카드를 나의 학습세트에 저장했습니다.\n나의 학습카드로 이동하시겠습니까?',
			icon: 'question',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="myCardList.do";
			} else if (result.isDenied) {
				return;
			}
		});
	}
}

function addOrDeleteMyCards(c, s){
	var user = "${user.m_id}";
	//로그인 정보 확인
	if(user ==''){
		Swal.fire({
			title: '로그인 후 이용가능합니다.\n로그인 하시겠습니까?',
			icon:'question',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="../tekamember/loginForm.do";
			} else if (result.isDenied) {
				return;
			}
		});
	}
	
	//$("#addelete").text("");
	if(user != ''){
		location.href='myCardInsert.do?c_idx=' + c + '&s_idx=' + s;
		
	}
}

function filter(){
	var order = $("#order").val();
	
	location.href='mainList.do?page=${empty param.page ? 1 : param.page}&subject=${empty param.subject ? 'all' : param.subject}&selectSearch=${empty param.selectSearch ? 'all' : param.selectSearch}&text=${param.text}&order='+order;
}
		
</script>
<script type="text/javascript">
function previewPopup(c_idx){
	$.ajax({
		url:'previewPopup.do?c_idx=' + c_idx, //c_idx를 쿼리로 전송
		dataType:'json',
		success : function(resData){

			$("#m_nickname").html('madeBy' + ' ' + resData.m_nickname);
			$("#c_title").html(resData.c_title);
			$("#c_content").html(resData.c_content);
			//동적으로 요소추가 (list만큼 반복하기 때문에 모든 요소 출력가능) : 질문-답변은 쌍으로 저장(반복횟수 동일)
			for(i in resData.question){
				
				var jsonDiv = {
								 table : "<table class=\"question\">",
								 q : "<tr><th><textarea cols=\"45\" readonly=\"readonly\" class=\"q_question" + i + "\"",	
								 qCss: "style=\"border:none; background:#2e3856; border-bottom: 1px solid #586380; resize:none; font-size:17px; overflow: hidden;\"></textarea></th>",
								 a : "<th><textarea cols=\"80\" readonly=\"readonly\" class=\"q_answer" + i + "\"",
								 aCss:"style=\"border:none; background:#2e3856; border-bottom: 1px solid #586380; resize:none; font-size:17px; vertical-align: bottom; overflow: hidden;\"></textarea></th></tr>",
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
	//append되어있는 데이터 삭제
	$("#q_question").remove();
	$("#q_answer").remove();
	$(".question").remove();

	centerBox();
	$("#popupBox").show();
}
</script>
<!-- 좋아요 기능 -->
<script type="text/javascript">
$(function(){
	//로그인하지 않은 경우
	if("${empty user}"  == "true") return;
	//로그인한 경우
	if("${!empty user}" == "true") {
		$.ajax({
			url:'../card/like.do',
			data:{"m_idx":"${user.m_idx}"},
			dataType:'json',
			success : function(res){
 				for(i in res.list){
					$("#like"+ res.list[i]).val("❤️");
				}
			}
		});//end : ajax
	}
});//end : 윈도우 초기화

function like(c_idx, s_idx){
	//로그인하지 않았을 경우
	if("${empty user}"=="true"){
		Swal.fire({
			title: '로그인 후 이용가능합니다.\n로그인 하시겠습니까?',
			icon:'question',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="../tekamember/loginForm.do";
			} else if (result.isDenied) {
				return;
			}
		});
	}
	
	
	$.ajax({
		url:'../card/insertLike.do',
		data:{"m_idx": "${user.m_idx}", "c_idx":c_idx},
		dataType:'json',
		success : function(res){
			//좋아요
			if(res.result){ 
				location.href="../card/mainList.do?page=" + "${param.page}"; //현재 페이지 정보를 담고 이동
			//좋아요 취소
			}else { 
				location.href="../card/cancelLike.do?c_idx="+c_idx+"&m_idx=${user.m_idx}&page=${param.page}";
			}
		}
	});//end : ajax
}//end : like()
</script>
</head>
<body id="box">
	<c:if test="${!empty subject }">
		<div id="title" style="color: white;">
			<i class="fas fa-award" style="color: yellow;"></i>&nbsp;<b>${subject }</b>
		</div>
	</c:if>
	<div id="filter">
		<hr style="background-color: #003026; height: 1px; border: 0;">
		<b style="color: white;">여기에서는 검색 필터를 지정할 수 있습니다.</b> 
		<select id="order" style="height: 40px; border-radius: 15px;">
			<option value="">검색조건</option>
			<option value="newest">최신순</option>
			<option value="mostLiked">추천순</option>
			<option value="oldest">오래된순</option>
		</select> <input type="button" class="w-btn" value="검색" style="height: 40px; width: 80px;" onclick="filter();">
		<hr style="background-color: #003026; height:3px; border:0;">
	</div>
	<div id="grid_container">
		<c:if test="${empty list}">
			<div style="color: red; text-align: center; line-height: 333px;">카드가 없습니다.</div>
		</c:if>
		<c:forEach var="card" items="${ list }">
			<!-- 미리보기팝업 -->
			<%@include file="previewPopup.jsp"%>

			<div class="card-container">
				<div class="card">
					<div class="card-inner">
						<div class="card-front">
							<div id="question">
								<b>${card.c_title}</b>
							</div>
						</div>
						<div class="card-back">
							<div id="answer">
								<b>${card.c_content}</b>
							</div>
						</div>
					</div>
				</div>

				<div class="side">

					<button type="button" class="btn btn-xs btn-primary"
						onclick="like(${card.c_idx},${card.s_idx });">
						추천 <span class="badge">${card.l_like}</span>
					</button>
					<input type="button" value="🤍" id="like${card.c_idx}"
						disabled="disabled" style="background: transparent;"><br>
					
					<!-- 주제별로 다른 레이블 색상 -->
					<c:if test="${card.s_name eq '운영체제' }">
						<div class="myCardSubject label label-info"
							style="background-color: red;">${card.s_name }</div>
					</c:if>
					<c:if test="${card.s_name eq '네트워크' }">
						<div class="myCardSubject label label-info"
							style="background-color: orange;">${card.s_name }</div>
					</c:if>
					<c:if test="${card.s_name eq '알고리즘' }">
						<div class="myCardSubject label label-info"
							style="background-color: navy;">${card.s_name }</div>
					</c:if>
					<c:if test="${card.s_name eq '자료구조' }">
						<div class="myCardSubject label label-info"
							style="background-color: green;">${card.s_name }</div>
					</c:if>
					<c:if test="${card.s_name eq '자바' }">
						<div class="myCardSubject label label-info"
							style="background-color: blue;">${card.s_name }</div>
					</c:if>
					<c:if test="${card.s_name eq '스프링' }">
						<div class="myCardSubject label label-info"
							style="background-color: purple;">${card.s_name }</div>
					</c:if>
					
					<span class="badge">${card.m_nickname }</span><br> 
					<input type="button" class="plusCard w-btn w-btn-gra3 w-btn-gra-anim" value="미리보기" onclick="previewPopup(${card.c_idx});"> 
					<input type="button" id="addelete" class="plusCard w-btn w-btn-gra3 w-btn-gra-anim" value="내 학습세트에 추가" onclick="addOrDeleteMyCards(${card.c_idx},${card.s_idx });">
				</div>
			</div>
		</c:forEach>
	</div>	
	<div style="text-align: center; font-size: 25px; margin-top: 100px; color: white;">
		${pageMenu }
	</div>
</body>
</html>