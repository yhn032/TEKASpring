<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html data-theme="dark">
<head>
<meta charset="UTF-8">
<title>TEKA : 카드 수정하기</title>
<!-- 부트스트랩 라이브러리등록 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css파일 연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header/mainmenuHeader.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/addCardRow.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/insertCard.css">
<!-- 자바스크립트 -->
<script type="text/javascript">

	function modifyCardSet(f){
		
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
		f.action = "modifyCard.do";		
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
	<input type="hidden" name="c_idx" value="${param.c_idx}">
	<!-- 주제/카드제목/소개 입력 -->
	<!-- 주제, 카드제목, 카드소개글 -->
	<div id="choose">
		<br><br><!-- 주제선택 -->
		<div id="subjectSelect" class="radio">
			<p>학습세트 주제선택</p>
			<!-- 주제선택 라디오버튼(단일선택) : 체크된 항목 전송-->
			<c:if test="${s_idx eq 1 }">
				<label for="1"><input type="radio" name="s_idx" value="1" id="1" checked>운영체제</label><br>
			</c:if>
			<c:if test="${s_idx ne 1 }">
				<label for="1"><input type="radio" name="s_idx" value="1" id="1">운영체제</label><br>
			</c:if>
			
			<c:if test="${s_idx eq 2 }">
				<label for="2"><input type="radio" name="s_idx" value="2" id="2" checked>네트워크</label><br>
			</c:if>
			<c:if test="${s_idx ne 2 }">
				<label for="2"><input type="radio" name="s_idx" value="2" id="2">네트워크</label><br>
			</c:if>
			
			<c:if test="${s_idx eq 3 }">
				<label for="3"><input type="radio" name="s_idx" value="3" id="3" checked>알고리즘</label><br>
			</c:if>
			<c:if test="${s_idx ne 3 }">
				<label for="3"><input type="radio" name="s_idx" value="3" id="3">알고리즘</label><br>
			</c:if>
			
			<c:if test="${s_idx eq 4 }">
				<label for="4"><input type="radio" name="s_idx" value="4" id="4" checked>자료구조</label><br>
			</c:if>
			<c:if test="${s_idx ne 4 }">
				<label for="4"><input type="radio" name="s_idx" value="4" id="4">자료구조</label><br>
			</c:if>
			
			<c:if test="${s_idx eq 5 }">
				<label for="5"><input type="radio" name="s_idx" value="5" id="5" checked>자바</label><br>
			</c:if>
			<c:if test="${s_idx ne 5 }">
				<label for="5"><input type="radio" name="s_idx" value="5" id="5">자바</label><br>
			</c:if>
			
			<c:if test="${s_idx eq 6 }">
				<label for="6"><input type="radio" name="s_idx" value="6" id="6" checked>스프링</label><br>
			</c:if>
			<c:if test="${s_idx ne 6 }">
				<label for="6"><input type="radio" name="s_idx" value="6" id="6">스프링</label><br>
			</c:if>
		</div>
		<table id="cardTitle">
			<tr class="trHeight">
				<th class="inputText"><p><label for="title">학습세트 제목</label></p></th>
				<td><textarea rows="2" cols="30" id="title" name="c_title" readonly="readonly">${c_title }</textarea></td>
			</tr>
			<tr class="trHeight">	
				<th class="inputText"><p><label for="info">학습세트 소개</label></p></th>
				<td><textarea rows="3" cols="50" id="info" name="c_content" readonly="readonly">${c_content }</textarea></td>
			</tr>	
		</table>
	</div><!-- end : choose -->
		
<hr class="dashed">
	
	<div id="insertCard">
		<%@include file="modifyCardRow.jsp"%>
	</div>
</form>	
</body>
</html>