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
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header/studyCardHeader.css">
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