<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#choose{
	margin:auto;
	width : 1350px;
	height:400px;
	font-family: 윤고딕700;
	color:gray;
}

#subjectSelect{
	
	margin-top:100px;
	margin-left:65px;
	float : left;
	width : 20%;
	height: 250px;
	font-size: 17px;
}

#cardTitle{
	margin-top:100px;
	float : left;
	width : 33%;
}

#cardInfo{
	margin-top:100px;
	float : left;
	width : 42%;
}

p{
	font-size: 20px;	
	font-weight:700;
}

textarea{
	width:80%;
	resize: none;
}

</style>
</head>
<body>

<!-- 주제, 카드제목, 카드소개글 -->
	<div id="choose">
		<!-- 주제선택 -->
		<hr>
		<div id="subjectSelect" class="radio">
			<p>학습세트 주제선택</p>
			<!-- 주제선택 라디오버튼(단일선택) : 체크된 항목 전송-->
			<label for="1"><input type="radio" name="s_idx" value="1" id="1" checked>운영체제</label><br>
			<label for="2"><input type="radio" name="s_idx" value="2" id="2">네트워크</label><br>
			<label for="3"><input type="radio" name="s_idx" value="3" id="3">알고리즘</label><br>
			<label for="4"><input type="radio" name="s_idx" value="4" id="4">자료구조</label><br>
			<label for="5"><input type="radio" name="s_idx" value="5" id="5">자바</label><br>
			<label for="6"><input type="radio" name="s_idx" value="6" id="6">스프링</label><br>
		</div>
		<!-- 카드제목  -->
		<div id="cardTitle">
		  <label for="title"><p>내 학습세트 제목</p></label>
	      <textarea rows="5" col="30" id="title" name="c_title"></textarea>
		</div>
		<!-- 카드소개글  -->
		<div id="cardInfo">
		  <label for="info"><p>내 학습세트 소개</p></label>
	      <textarea rows="10" id="info" name="c_content"></textarea>
		</div>
	</div>
<hr>

</body>
</html>