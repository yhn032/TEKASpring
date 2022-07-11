<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드세트팝업창</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	
#popupBox{
	margin-bottom : 100px;
	width :1350px;
	height:750px;
	overflow : auto;
	border : 3px solid black;
	display : none;
	position   : absolute;
	background-color : white;
	z-index : 100;
	position:fixed;
	top:150px;
	left:30px;
	box-shadow : rgba(0,0,0,0.7) 0 0 0 9999px, rgba(0,0,0,0.7) 2px 2px 2px 3px;
	border-radius: 10px;
}

#container{
	margin-left:8px;
	font-family: 윤고딕700;
}

#preTitle{
	margin-top:30px;
	font-size: 30px;
	height : 80px;
}

/* .q{
	margin-top : 10px;
	margin-left : 12px;
	font-size:18px;
	float : left;
	width : 35%;
	min-height:50px;
}
.a{
	margin-top : 10px;
	font-size:18px;
	float : left;
	width : 55%;
	min-height:50px;
} */

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
	color : gray;
	position : fixed;
	/* fixed는 뷰포인트로 위치지정 */
	right : 140px;
	top : 85px;
}
.qnaText{
	font-size: 18px;
	text-align: left;
	color:#C2B0DA;
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
				<th>제목</th>
				<td><div id="c_title"></div></td>
			</tr>
			<tr>
				<th>소개</th>
				<td><div id="c_content"></div></td>
			</tr>
			<span class="badge" id="m_nickname"></span>	
		</table>
<hr>			

	<!-- 동적 요소 추가 -->
		<div class="res"></div></div>
</div>
</body>
</html>