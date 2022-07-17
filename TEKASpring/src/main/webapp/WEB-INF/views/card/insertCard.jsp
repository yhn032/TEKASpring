<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-theme="dark">
<head>
<meta charset="UTF-8">
<title>TEKA : 카드만들기</title>
<!-- 부트스트랩 라이브러리등록 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- css파일 연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainmenuHeader.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainInsertCard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addCardRow.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/insertCard.css">
<!-- 자바스크립트 -->
<script type="text/javascript">

	function addCardSet(f){
		
		var c_title    = f.c_title.value.trim(); 
		var c_content  = f.c_content.value.trim();
		var q_question = f.q_question.value.trim();	
		var q_answer   = f.q_answer.value.trim();
		var s_idx      = f.s_idx.value; //checked속성 -> 선택 안 되는 경우는 없음
		
		if(c_title==''){
			alert('학습세트 제목을 입력해주세요.');
			f.c_title.value='';
			f.c_title.focus();
			return;
		}
		if(c_content==''){
			alert('학습세트 소개를 입력해주세요.');
			f.c_content.value='';
			f.c_content.focus();
			return;
		}
		
		/* if(q_question==''){
			alert('질문을 입력해주세요.');
			f.q_question.value='';
			f.q_question.focus();
			return;
		}
		if(q_answer==''){
			alert('답변을 입력해주세요.');
			f.q_answer.value='';
			f.q_answer.focus();
			return;
		} */
		
		f.method = "POST";
		f.action = "insertCard.do";		
		f.submit();
	}
</script>

</head>
<body style="background-color: #0a092d;">
<!-- header -->
<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>
<form>	
	<input type="hidden" name="m_idx" value="${user.m_idx}">
	<!-- 주제/카드제목/소개 입력 -->
	<!-- 주제, 카드제목, 카드소개글 -->
	<div id="choose">
		<br><br><!-- 주제선택 -->
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
		<table id="cardTitle">
			<tr class="trHeight">
				<th class="inputText"><label for="title"><p>학습세트 제목</p></label></th>
				<td><textarea rows="2" col="30" id="title" name="c_title"></textarea></td>
			</tr>
			<tr class="trHeight">	
				<th class="inputText"><label for="info"><p>학습세트 소개</p></label></th>
				<td><textarea rows="3" col="50" id="info" name="c_content" ></textarea></td>
			</tr>	
		</table>
	</div><!-- end : choose -->
		
<hr class="dashed">
	
	<div id="insertCard">
		<%@include file="addCardRow.jsp"%>
	</div>
</form>	
</body>
</html>