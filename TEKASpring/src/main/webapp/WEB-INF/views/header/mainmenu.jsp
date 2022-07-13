<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#searchbar{
margin-left: 15%;
}
#makebtn{
margin-left: 1%;
}

#bar{
width: 100%;
padding-top: 15px;
height: 80px;
}
</style>
<!-- 스크립트 -->
<script type="text/javascript">
	
	//로그인 하지 않고 카드만들기 하려는 경우 -> 로그인 후에 카드 만들기를 바로 하러 가도록 세션 트래킹
	function insertCard(){
		
		if(!confirm('로그인 후 이용가능합니다.\n로그인 하시겠습니까?')) {
			return;
		}
		
		var url_insert = "http://localhost:9090/teka/card/insertCardForm.do"
		
		location.href="../tekamember/loginForm.do?url=" + encodeURIComponent(url_insert);
	}
	
	//로그인 하지 않고 나의 학습세트로 이동 하려는 경우 -> 로그인 후에 나의 학습세트로 이동하도록 세션 트래킹
	function myCardSet(){
		
		if(!confirm('로그인 후 이용가능합니다.\n로그인 하시겠습니까?')) {
			return;
		}
		
		//마이페이지 만들면 추가하기

		var url_myCardSet = "../card/myCardList.do";

		
		location.href="../tekamember/loginForm.do?url=" + encodeURIComponent(url_myCardSet);
	}


	$(document).ready(function(){
		$(".dropDownToggle").click(function(){
			$(".dropDownMenu").toggleClass("drop");
		});
	});

	
	//카드 검색
	function search(){
		
		var selectSearch = $("#selectSearch").val();
		var text         = $("#text").val().trim();
		
		if(selectSearch != "all" && text==''){
			alert('검색어를 입력해주세요.');
			$("#text").val('');
			$("#text").focus();
			return;
		}
		
		location.href="../card/cardSearch.do?selectSearch=" + selectSearch + "&text=" + encodeURIComponent(text);
	}
	
	
	$(function(){
	
		//주소창에 파라미터 search가 비어있지 않을 때만 해당 코드를 실행해라
		if( "${not empty param.selectSearch}" == "true" ){
			$("#selectSearch").val('${param.selectSearch}');
		}
		
		//전체검색 실행시, 검색어 지우기
		if( "${ param.selectSearch eq 'all' }" == "true" ){
			
			$("#text").val('');
		}
	});
	
</script>
<style type="text/css">
.dropDownMenu{
		display: none;
		width: 150px;
		height: 180px; 
		background-color: white;	
		padding: 0;
		border: 1px solid gray;
		border-radius: 2px;
		box-shadow: 1px 1px 5px 1px gray;
}

.dropDownMenu li{
	list-style: none;
	line-height: 30px;
	padding-left: 25px;
}

.dropDownMenu a{
	text-decoration: none;
	color: black;
}

.drop{
	display: block;
}
</style>
</head>
<body>
	<nav id="bar" class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
		
			<div class="navbar-header">
				<a class="navbar-brand" href="../card/main.do" style="font-size: x-large; font-weight: bolder;">TEKA</a>
			</div>
			
			<ul class="nav navbar-nav">
				<li><a href="../card/main.do">홈페이지</a></li>
				<li><a href="../card/mainList.do">모든 학습세트</a></li>
				<li>
					<c:if test="${empty user}">
						<a href="#" onclick="myCardSet();">내 학습세트</a>
					</c:if>
					<c:if test="${!empty user}">
						<a href="../card/myCardList.do">내 학습세트</a>
					</c:if>
				</li>
				<li class="dropDown"><a class="dropDownToggle" href="#" style="width: 150px;height: 65px;">주제 <span class="caret"></span></a>
					<ul class="dropDownMenu">
						<li><a href="../card/mainList.do?subject=os">운영체제</a></li>
						<li><a href="../card/mainList.do?subject=network">네트워크</a></li>
						<li><a href="../card/mainList.do?subject=algorithm">알고리즘</a></li>
						<li><a href="../card/mainList.do?subject=datastructure">자료구조</a></li>
						<li><a href="../card/mainList.do?subject=java">Java</a></li>
						<li><a href="../card/mainList.do?subject=spring">Spring</a></li>

					</ul>
			</ul>
			
			<!-- 회원가입 전 -->
			<c:if test="${empty user}">
				<button id="makebtn" class="btn btn-success navbar-btn navbar-left" onclick="insertCard();">만들기</button>
			</c:if>
			<!-- 회원가입 후 -->
			<c:if test="${!empty user}">
				<button id="makebtn" class="btn btn-success navbar-btn navbar-left" onclick="location.href='../card/insertCardForm.do'">만들기</button>
			</c:if>
			
			<div id="searchbar" class="navbar-form navbar-left">
				<div class="form-group">
					<select id="selectSearch" class="form-control">
						<option value="all">전체검색</option>
						<option value="c_title">카드제목</option>
						<option value="c_content">카드소개글</option>
						<option value="m_nickname">닉네임</option>
					</select>
					<input class="form-control" placeholder="카드 찾기" value="${param.text}" id="text" onkeyup="if(window.event.keyCode==13){search();}">
				</div>
				<input type="button" class="btn btn-default" value="검색" onclick="search();">
			</div>
			
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${empty user }">
					<li><a href="../tekamember/signUpForm.do"><span class="glyphicon glyphicon-user"></span>회원가입</a></li>
					<li><a href="../tekamember/loginForm.do"><span class="glyphicon glyphicon-log-in"></span>로그인</a></li>
				</c:if>
				<c:if test="${!empty user }">
					<li><a href="../me/mypage.do"><span class="glyphicon glyphicon-user"></span>${user.m_nickname }님</a></li>
					<li><a href="../tekamember/logout.do"><span class="glyphicon glyphicon-log-in"></span>로그아웃</a></li>
				</c:if>
			</ul>
			
		</div>
	</nav>
</body>
</html>