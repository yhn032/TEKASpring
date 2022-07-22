<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 내 학습세트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/myCard.css">

<script type="text/javascript">

function study(c_title, c_idx){
	Swal.fire({
		  icon: 'success',
		  title: c_title + '을(를) 학습합니다.',
		  returnFocus: false
	}).then((result) => {
		
		if(result.isConfirmed){
			location.href="../studyCard/studyCardMain.do?c_idx="+c_idx;
		}
	});
}

function deleteCard(c_idx){
	$.ajax({
		url : 'myCardDelete.do',
		data: {"c_idx":c_idx},
		success: function(res){
			if(res.result){
				Swal.fire({
					  icon: 'success',
					  title: '학습세트에서 삭제하였습니다.',
					  returnFocus: false
				}).then((result) => {
					
					//현재 페이지 호출(=새로고침)
					location.href="";
				});
			}
		},
		error  : function(err){
			Swal.fire({
				  icon: 'warning',
				  title: '학습세트에서 삭제하지 못했습니다.',
				  returnFocus: false
			});
		}
	});
}

</script>
</head>
<body>

	<c:if test="${!empty subject }">
		<div id="title">
			<i class="fas fa-award" style="color: navy;"></i>&nbsp;<b>${subject }</b>
		</div>
	
	</c:if>
	<div id="filter">
		<hr style="background-color: #003026; height: 1px; border: 0;">
			<b style="color: white;">여기에서는 검색 필터를 지정할 수 있습니다.</b>
			<select name="category" style="height: 40px;">
				<option value="">검색조건</option>
				<option value="com001">인기순</option>
				<option value="ele002">추천순</option>
				<option value="sp003">최근순</option>
			</select>
			<input type="button" value="검색" style="height: 40px; width: 80px;">
		<hr style="background-color: #003026; height: 3px; border: 0;">
	</div>
	
	<div style="text-align: center; font-size: 25px; margin-top: 10px; margin-bottom: 10px; color: white;">${pageMenu }</div>
	
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
			</div>
			<c:if test="${card.c_isPublic eq '비공개' }">
				<div class="myStudy">
					<div id="c_content">카드를 만든 사람이 비공개로 전환하였습니다. 카드를 커스터마이징하여 새로운 카드를 만들어야 학습을 할 수 있습니다.</div>
					<input class="myBtn" id="delBtn"   type="button" value="카드삭제하기" onclick="deleteCard(${card.c_idx});"><br>
					<c:if test="${card.m_nickname eq user.m_nickname }">
						<input class="myBtn" id="modifyBtn" type="button" value="카드수정하기" onclick="location.href='../card/modifyCardForm.do?c_idx=${card.c_idx}';">
					</c:if>
					<c:if test="${card.m_nickname ne user.m_nickname }">
						<div class="myBtn" id="customBtn" style="position: relative;">
							<a href="../card/customCardForm.do?c_idx=${card.c_idx}" id="custom" data-text="커스터마이징">커스터마이징</a>
						</div>
					</c:if>
				</div>
			</c:if>
			<c:if test="${card.c_isPublic eq '공개' }">
				<div class="myStudy">
					<div id="c_content">${card.c_content }</div>
					<input class="myBtn" id="studyBtn" type="button"  value="카드학습하기" onclick="study('${card.c_title}', ${card.c_idx });" style="margin-top: 30px;"><br>
					<input class="myBtn" id="delBtn"   type="button"  value="카드삭제하기" onclick="deleteCard(${card.c_idx});"><br>
					<c:if test="${card.m_nickname eq user.m_nickname }">
						<input class="myBtn" id="modifyBtn" type="button" value="카드수정하기" onclick="location.href='../card/modifyCardForm.do?c_idx=${card.c_idx}';">
					</c:if>
					<c:if test="${card.m_nickname ne user.m_nickname }">
						<div class="myBtn" id="customBtn" style="position: relative;">
							<a href="../card/customCardForm.do?c_idx=${card.c_idx}" id="custom" data-text="커스터마이징">커스터마이징</a>
						</div>
					</c:if>
				</div>
			</c:if>
		</c:forEach>
	</div>
</body>
</html>