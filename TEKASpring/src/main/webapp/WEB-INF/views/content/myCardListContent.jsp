<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 내 학습세트</title>
<script type="text/javascript">

function study(c_idx){
	alert(c_idx + "번 카드를 학습합니다.");
	location.href="../studyCard/studyCardMain.do?c_idx="+c_idx;
}

function deleteCard(c_idx){
	$.ajax({
		url : 'myCardDelete.do',
		data: {"c_idx":c_idx},
		success: function(res){
			if(res.result){
				alert("삭제 성공");
				//현재 페이지 호출(=새로고침)
				location.href="";
			}
		},
		error  : function(err){
			alert("삭제 실패");
			alert(err.responseText);
		}
	});
}
</script>
<style type="text/css">
.myCardContainer {
	margin: auto;
	width: 500px;
	height: 300px;
	border: 2px solid navy;
	border-radius: 10px;
 	box-shadow: 1px 1px 4px purple;
}

.myCardTitle{
	font-size: 30px;
	font-weight: 700;
	margin: 20px 0px 0px 20px;
}

.myCardSubject{
	font-size: 20px;
	display: inline-block;;
	width: 20%;
	/* 상 우 하 좌 */
	margin: 20px 0px 0px 20px;
}

.myCardWord{
	display: inline-block;;
	text-align:center;
	width: 15%;
}

#grid_container{
	margin: auto;
	width: 1460px;
	padding-top: 15px;
	display: grid;
	grid-template-columns: 725px 725px;
	grid-template-rows: 300px 300px;
	row-gap: 50px;
	column-gap: 20px;
	border: 1px solid gray;
	border-radius: 20px;
	box-shadow: inset 3px 3px 5px 2px black;
}

#filter{
	margin: auto;
	width: 1460px;
	height: 100px;
}

.myBtn{
	margin: 50px 0px 0px 20px;
	width: 150px; 
	height: 80px;
	background-color: white;
	border: 0;
	box-shadow: 1px 1px 3px grey;
	font-size: 15px;
	font-weight: 300;
}

</style>

</head>
<body>

	<c:if test="${!empty subject }">
		<div id="title">
			<i class="fas fa-award" style="color: navy;"></i>&nbsp<b>${subject }</b>
		</div>
	
	</c:if>
	<div id="filter">
		<hr>
			<b>여기에서는 검색 필터를 지정할 수 있습니다.</b>
			<select name="category" style="height: 40px;">
				<option value="">검색조건</option>
				<option value="com001">인기순</option>
				<option value="ele002">추천순</option>
				<option value="sp003">최근순</option>
			</select>
			<input type="button" value="검색" style="height: 40px; width: 80px;">
		<hr>
	</div>
	<div id="grid_container">
		<c:if test="${empty list }">
			<div style="color: red; text-align: center; line-height: 333px;">아직 추가한 학습 카드가 없습니다.</div>
		</c:if>
		
		<c:forEach var="card" items="${ list }">
			<div class="myCardContainer">
				<div class="myCardTitle">${card.c_title }</div>
				<!-- 주제별로 색상을 다르게 설정 -->
				<c:if test="${card.s_name eq '운영체제' }">
					<div class="myCardSubject label label-info" style="background-color: red;">${card.s_name }</div>
				</c:if>
				<c:if test="${card.s_name eq '네트워크' }">
					<div class="myCardSubject label label-info" style="background-color: orange;">${card.s_name }</div>
				</c:if>
				<c:if test="${card.s_name eq '알고리즘' }">
					<div class="myCardSubject label label-info" style="background-color: navy;">${card.s_name }</div>
				</c:if>
				<c:if test="${card.s_name eq '자료구조' }">
					<div class="myCardSubject label label-info" style="background-color: green;">${card.s_name }</div>
				</c:if>
				<c:if test="${card.s_name eq '자바' }">
					<div class="myCardSubject label label-info" style="background-color: blue;">${card.s_name }</div>
				</c:if>
				<c:if test="${card.s_name eq '스프링' }">
					<div class="myCardSubject label label-info" style="background-color: purple;">${card.s_name }</div>
				</c:if>
				<div class="myCardWord">${card.c_qCnt }단어</div>
				<div class="myCardMake badge">${card.m_nickname }</div><br>
				<input class="myBtn" type="button" value="카드학습하기" onclick="study(${card.c_idx});"> 
				<input class="myBtn" type="button" value="카드삭제하기" onclick="deleteCard(${card.c_idx});"> 
			</div>
		</c:forEach>
	</div>
</body>
</html>