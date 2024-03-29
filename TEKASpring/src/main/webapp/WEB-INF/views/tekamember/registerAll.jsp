<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 전체회원 관리</title>
<!-- BootStrap 3.x 라이브러리 등록 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- SweetAlert2 library 등록 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">
#box{
	margin     : auto;
	margin-top : 100px;
	width      : 1300px;
}

#title{
	text-align : center;
	font-size  : 35px;
	font-weight: bold;
}

th, td{
	text-align: center;
}

#grade {
	color: black;
}

#join{
	text-align   : right;
	margin-top   : 20px;
	margin-bottom: 20px;
	margin-right : 20px;
}
#transQuitPage {
	text-align: right;
	margin-bottom:30px;
}
#transBtn {
	height:50px;
	width:300px;
	border:2px solid black;
	border-radius: 10px;
	font-size: 18px;
}
</style>
<script type="text/javascript">
function updateBtn(f) {
	Swal.fire({
		  title: '정말 수정하시겠습니까?',
		  text : "선택하신 회원의 등급이 변경됩니다.",
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6', 
		  cancelButtonColor : '#d33',
		  confirmButtonText : '수정',
		  cancelButtonText  : '취소'
		}).then((result) => {
		  if (result.isConfirmed) {
			  //location.href="memberModify.do?m_idx=" + m_idx + "&m_grade=" + m_grade;
			  f.method="POST";	
			  f.action="memberGradeUpdate.do";
			  f.submit();
		  }
	}); 
}// end : modify
</script>
</head>
<body>
<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>
	<div id="box">
	
	<div id="transQuitPage">
		<input type="button" value="탈퇴회원 관리" onclick="location.href='selectQuitMember.do';" id="transBtn">
	</div>
		<div>
			<hr>
			<h3>전체회원 목록</h3>
			<hr>
			<table class="table table-striped">
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>회원등급</th>
					<th>가입일자</th>
					<th>등급관리</th>
				</tr>
			<c:if test="${empty list}">
				<tr><th colspan="6"><font color="red">회원이 없습니다.</font></th></tr>
			</c:if>
				<!-- 데이터가 있는 경우 -->
				<c:if test="${not empty list}">
					<c:forEach var="vo" items="${list}">
						<%-- <input type="hidden" value="m_idx" name="${vo.m_idx}"> --%>
					<tr>
						<td>${vo.m_idx}</td>
						<td>${vo.m_id}</td>
						<td>${vo.m_nickname}</td>
						<td>${vo.m_email}</td>
						<c:if test="${vo.m_grade eq '관리자'}">
							<td style="color:blue; font-weight: bold;">${vo.m_grade}</td>						
						</c:if>
						<c:if test="${vo.m_grade eq '일반'}">
							<td>${vo.m_grade}</td>						
						</c:if>
						<td>${vo.m_regdate}</td>
						<td>
							<!-- 회원등급 추가 수정 예정 -->
							<input class="btn btn-default"  type="button" value="수정" onclick="updateBtn(this.form);" disabled="disabled">
						</td>
					</tr>
					</c:forEach>
				</c:if>
			</table>
			<!-- Paging -->
		</div>
	</div>
</body>
</html>