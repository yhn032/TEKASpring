<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style type="text/css">
#headContainer{
	width: 100%;
	height: 80px;
	background-color: #222222;
	display: flex;
	justify-content: space-between;
	color: white;
}

#nav{
	width:14%;
	height: 100%;
	margin-left: 20px;
	cursor: pointer;
	display: flex;
	line-height: 80px;
	font-size: 30px;
}

html, body, hr{
	margin: 0;
	padding: 0;
}

.dropDownItem{
	display: none;
	position: absolute;
	z-index: 1;
	width: 300px;
	height: 165px;
	background-color: #b0adad;
	top:80px;
}

.dropDownItem a {
	display: block;
	font-size: 20px;
	height: 40px;
	text-decoration: none;
	line-height: 40px;
	color: white;
}

.drop{
	display: block;
}

#dropDownContainer{
	margin: auto;
	width: 100%;
}

#dropDown{
	display: inline-block;
}

#dropDown:hover{
	border-radius: 5px;
	background-color: #b0adad;
}

.dropDownItem a:hover {
	background-color: #d0aaaa;
}

.icon{
	display:inline-block;
	margin-left: 5px;
	width: 25px;
	height: 25px;
}

#cancelBtn{
	width: 50px;
	height: 50px;
	border: 2px solid black;
	margin-top: 15px;
	margin-right: 50px;
	border-radius: 5px;
	background-color: #b0adad;
	color: black;
	font-size: 20px;
}

#prg{
	font-size: 20px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#dropDown").click(function(){
		$(".dropDownItem").toggleClass("drop");
	});	
});
</script>

</head>
<body>
<div id="headContainer">
	<div id="nav">
		<div id="dropDownContainer">
			
			<!-- 낱말카드를 학습하는 경우 -->
			<c:if test="${type eq 'word'}">
				<span><i class="fas fa-clone"></i></span>
				<div id="dropDown">
					<span class="dropDownBtn">낱말카드</span>
					<div class="dropDownItem">
						<a href="studyCardLearn.do?c_idx=${param.c_idx }&type=learn"><span class="icon"><i class="fas fa-brain"></i></span>학습하기</a>
						<a href="studyCardTest.do?c_idx=${param.c_idx }&type=test"><span class="icon"><i class="fas fa-hourglass-start"></i></span>시험보기</a>
						<a href="studyCardStar.do?c_idx=${param.c_idx }&type=star"><span class="icon"><i class="fas fa-star"></i></span>관심질문</a>
						<hr>
						<a href="studyCardMain.do?c_idx=${param.c_idx}"><span class="icon"><i class="fas fa-home"></i></span>홈</a>
					</div>
					<span><i class="fas fa-chevron-circle-down"></i></span>
				</div>	
			</c:if>
			
			<!-- 학습세트를 문제 풀이 하는 경우 -->
			<c:if test="${type eq 'learn' }">
				<span><i class="fas fa-brain"></i></span>
				<div id="dropDown">
					<span class="dropDownBtn">학습하기</span>
					<div class="dropDownItem">
						<a href="studyCardWord.do?c_idx=${param.c_idx }&type=word"><span class="icon"><i class="fas fa-clone"></i></span>낱말카드</a>
						<a href="studyCardTest.do?c_idx=${param.c_idx }&type=test"><span class="icon"><i class="fas fa-hourglass-start"></i></span>시험보기</a>
						<a href="studyCardStar.do?c_idx=${param.c_idx }&type=star"><span class="icon"><i class="fas fa-star"></i></span>관심질문</a>
						<hr>
						<a href="studyCardMain.do?c_idx=${param.c_idx}"><span class="icon"><i class="fas fa-home"></i></span>홈</a>
					</div>
					<span><i class="fas fa-chevron-circle-down"></i></span>
				</div>	
			</c:if>
			
			<!-- 학습세트를 시험 보는 경우 -->
			<c:if test="${type eq 'test'}">
				<span><i class="fas fa-hourglass-start"></i></span>
				<div id="dropDown">
					<span class="dropDownBtn">시험보기</span>
					<div class="dropDownItem">
						<a href="studyCardWord.do?c_idx=${param.c_idx }&type=word"><span class="icon"><i class="fas fa-clone"></i></span>낱말카드</a>
						<a href="studyCardLearn.do?c_idx=${param.c_idx }&type=learn"><span class="icon"><i class="fas fa-brain"></i></span>학습하기</a>
						<a href="studyCardStar.do?c_idx=${param.c_idx }&type=star"><span class="icon"><i class="fas fa-star"></i></span>관심질문</a>
						<hr>
						<a href="studyCardMain.do?c_idx=${param.c_idx}"><span class="icon"><i class="fas fa-home"></i></span>홈</a>
					</div>
					<span><i class="fas fa-chevron-circle-down"></i></span>
				</div>	
			</c:if>
			
			<!-- 즐겨찾기한 카드만 보는 경우 -->
			<c:if test="${type eq 'star'}">
				<span><i class="fas fa-star"></i></span>
				<div id="dropDown">
					<span class="dropDownBtn">관심질문</span>
					<div class="dropDownItem">
						<a href="studyCardWord.do?c_idx=${param.c_idx }&type=word"><span class="icon"><i class="fas fa-clone"></i></span>낱말카드</a>
						<a href="studyCardLearn.do?c_idx=${param.c_idx }&type=learn"><span class="icon"><i class="fas fa-brain"></i></span>학습하기</a>
						<a href="studyCardTest.do?c_idx=${param.c_idx }&type=test"><span class="icon"><i class="fas fa-hourglass-start"></i></span>시험보기</a>
						<hr>
						<a href="studyCardMain.do?c_idx=${param.c_idx}"><span class="icon"><i class="fas fa-home"></i></span>홈</a>
					</div>
					<span><i class="fas fa-chevron-circle-down"></i></span>
				</div>	
			</c:if>
			
		</div>
	</div>
	
	<div id="prg" style="line-height: 40px;">
		<div id="status" style="text-align: center;"></div>
		<div id="title" style="text-align: center;">${list[0].c_title }</div>
	</div>
	<div id="cancel">
		<input id="cancelBtn" type="button" value="x" onclick="location.href='studyCardMain.do?c_idx=${param.c_idx}'">
	</div>
</div>
</body>
</html>