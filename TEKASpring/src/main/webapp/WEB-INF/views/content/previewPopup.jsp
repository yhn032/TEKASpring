<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 카드 미리보기</title>
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