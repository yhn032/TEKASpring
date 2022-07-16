<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드세트팝업창</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/previewPopup.css">
<script type="text/javascript">

	function hidePopup(){
		
		$("#popupBox").hide();
	}	
	
	//윈도우 중앙배치
	function centerBox(){
		
		var wWidth  = $(window).width();
		var wHeight = $(window).height();
		
		var pWidth  = $("#popupBox").width();
		var pHeight = $("#popupBox").height();
		
		var left = (wWidth/2) - (pWidth/2);
		var top  = (wHeight/2) - (pHeight/2);
		
		$("#popupBox").css({"left" : left, "top" : top});
	}
</script>
<style type="text/css">
#popupBox {
	margin-bottom: 100px;
	width:1350px;
	height:750px;
	overflow-y: auto;
	overflow-x: hidden;
	border: 3px solid black;
	border-radius: 15px;
	display: none;
	position: absolute;
	z-index: 100;
	position:fixed;
	top:150px;
	left:30px;
	box-shadow : rgba(0,0,0,0.7) 0 0 0 9999px, rgba(0,0,0,0.7) 2px 2px 2px 3px;
	background:#2e3856;
}

#popupBox::-webkit-scrollbar {
  	width: 10px;
}

#popupBox::-webkit-scrollbar-thumb {
    background-color: #2f3542;
  	border-radius: 15px;
}

#popupBox::-webkit-scrollbar-track {
  	background-color: gray;
 	border-radius: 15px;
 	box-shadow: inset 0px 0px 5px white;
}

#container{
	margin-left:8px;
	font-family: 윤고딕700;
	color : white;
	background:#2e3856;
}

#preTitle{
	margin-top:30px;
	font-size: 30px;
	height : 80px;
}

.madeBy {
	font-size: 25px;
	text-align: left;
	font-weight:500;
	margin-bottom : 60px;
	margin-top : 60px;
	margin-left : 25px;
	width : 80%;
}

th{
	width : 10%;
	height : 30px;
}

td{
	width : 60%;
	font-size: 20px;
}

#m_nickname{
	margin-left:26px;
	font-size:18px;
}

#btnArea{
	margin-bottom : 30px;
}

#hideBtn{
	cursor : pointer;
	text-decoration: none;
	font-size: 30px;
	color : #586380;
	position : fixed;
	/* fixed는 뷰포인트로 위치지정 */
	right : 140px;
	top : 85px;
}
.qnaText{
	font-size: 18px;
	text-align: left;
	color:#586380;
}	

.question{
	width:100%;
	margin-left : 10px;
	margin-top : 30px;
	margin-bottom : 30px;
}
/* 클릭시 포커스 없애기 */
textarea:focus{
	outline: none;
}
</style>
</head>
<body>

<div id="popupBox">

<div id="container">

<!-- 팝업닫기버튼  -->
	<div id="btnArea">
		<a onclick="hidePopup();" id="hideBtn">X</a>
	</div>
	
<!-- 카드제목/소개글/만든사람 -->
		<table class="madeBy">
			<tr>
				<th style="color: #586380;">제목</th>
				<td><div id="c_title"></div></td>
			</tr>
			<tr>
				<th style="color: #586380;">소개</th>
				<td><div id="c_content"></div></td>
			</tr>
			<span class="badge" id="m_nickname"></span>	
		</table>
	<!-- 동적 요소 추가 -->
		<div class="res"></div></div>
</div>
</body>
</html>