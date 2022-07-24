<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 회원관리</title>
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
	color: white;
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
</style>
<script type="text/javascript">
/* $(function(){
	$("#m_grade").val('${vo.m_grade}');
}); */

function update(f) {
	
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
<body style="background:#0a092d;">
<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>
	<div id="box">
	<input type="button" value="탈퇴회원 관리" onclick="location.href='selectQuitMember.do';">
		<div>
			<table class="table table">
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
			<form>
				<!-- 데이터가 있는 경우 -->
				<c:if test="${not empty list}">
					<c:forEach var="vo" items="${list}">
						<input type="hidden" value="m_idx" name="${vo.m_idx}">
					<tr>
						<td>${vo.m_idx}</td>
						<td>${vo.m_id}</td>
						<td>${vo.m_nickname}</td>
						<td>${vo.m_email}</td>
						<td>
							<select id="grade" name="m_grade">
								<option value="일반">일반</option>
								<option value="관리자">관리자</option>
							</select>
						</td>
						<td>${vo.m_regdate}</td>
						<td>
							<input class="btn btn-default"  type="button" value="수정" onclick="update(this.form);">
						</td>
					</tr>
					</c:forEach>
				</c:if>
				</form>	
			</table>
		</div>
	</div>
<div id="footer" style="background:none;">
	<%@ include file="../footer/footer.jsp" %>	
</div>
</body>
</html>