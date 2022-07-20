<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/header/mainmenuHeader.css">

<!-- SweetAlert -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 스크립트 -->
<script type="text/javascript">
	
	//로그인 하지 않고 카드만들기 하려는 경우 -> 로그인 후에 카드 만들기를 바로 하러 가도록 세션 트래킹
	function insertCard(){
		var url_insert = "http://localhost:9090/teka/card/insertCardForm.do";
		
		Swal.fire({
			title: '로그인 후 이용가능합니다.\n로그인 하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="../tekamember/loginForm.do?url=" + encodeURIComponent(url_insert);
			} else if (result.isDenied) {
				return;
			}
		});
	}
	
	//로그인 하지 않고 나의 학습세트로 이동 하려는 경우 -> 로그인 후에 나의 학습세트로 이동하도록 세션 트래킹
	function myCardSet(){
		var url_myCardSet = "../card/myCardList.do";
		
		Swal.fire({
			title: '로그인 후 이용가능합니다.\n로그인 하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '네',
			denyButtonText: '아니요',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				location.href="../tekamember/loginForm.do?url=" + encodeURIComponent(url_myCardSet);
			} else if (result.isDenied) {
				return;
			}
		});

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
		
		//전체보기가 아닌데, 검색어가 비어있는 경우
		if(selectSearch != "all" && text==''){
			Swal.fire({
				  icon: 'info',
				  title:'검색어를 입력하세요!',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#text").val('');
					$("#text").focus();
					return;
				}
			});
		}else{
			//검색요청(자기자신을 호출하는 경우에는 쿼리만 작성해도 된다.)
			location.href="mainList.do?page=${empty param.page ? 1 : param.page}&subject=${empty param.subject ? 'all' : param.subject}&selectSearch=" + selectSearch + "&text=" + encodeURIComponent(text);
			
		}
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
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=os">운영체제</a></li>
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=network">네트워크</a></li>
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=algorithm">알고리즘</a></li>
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=datastructure">자료구조</a></li>
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=java">Java</a></li>
						<li><a href="../card/mainList.do?page=${empty param.page ? 1 : param.page}&subject=spring">Spring</a></li>

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