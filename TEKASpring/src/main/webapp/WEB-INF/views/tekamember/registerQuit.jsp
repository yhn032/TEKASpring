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

#m_grade {
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
function del(m_idx){
	Swal.fire({
	  title: '정말 삭제하시겠습니까?',
	  text : "선택하신 회원이 영구삭제됩니다.",
	  icon: 'question',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6', 
	  cancelButtonColor : '#d33',
	  confirmButtonText : '삭제',
	  cancelButtonText  : '취소'
	}).then((result) => {
	  if (result.isConfirmed) {
		  location.href="memberDelete.do?m_idx=" + m_idx + "&register_idx=${user.m_idx}";
	  }
	}); 
}// end : del
</script>
</head>
<body style="background:#0a092d;">
<div id="header">
	<%@include file="../header/mainmenu.jsp" %>
</div>
	<div id="box">
	<input type="button" value="전체회원 관리" onclick="location.href='register.do';">
		<div>
			<table class="table table">
				<tr>
					<th>회원번호</th>
					<th>닉네임</th>
					<th>회원등급</th>
					<th>탈퇴일자</th>
					<th>회원관리</th>
				</tr>
			<c:if test="${empty list}">
				<tr><th colspan="6"><font color="red">탈퇴한 회원이 없습니다.</font></th></tr>
			</c:if>
				<!-- 데이터가 있는 경우 -->
				<c:if test="${not empty list}">
					<c:forEach var="vo" items="${list}">
					<tr>
						<td>${vo.m_idx}</td>
						<td>${vo.m_nickname}</td>
						<td>${vo.m_grade}</td>
						<td>${vo.m_regdate}</td>
						<td>
							<input class="btn btn-default"  type="button" value="삭제" onclick="del(${vo.m_idx});">
						</td>
					</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
	</div>
	
<div id="footer" style="background:none;">
	<%@ include file="../footer/footer.jsp" %>	
</div>
</body>
</html>