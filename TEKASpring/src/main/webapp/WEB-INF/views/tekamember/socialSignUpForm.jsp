<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- SweetAlert -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.mainHeader {
	color: #9a3dff;
	font-weight: bold;
	font-size: 18px;
}


h1{
  margin: 0px;
  font-weight: 800px;
}
p {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;/*글자간격 */
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
	margin-top: -15px;
}

a {
	
	font-size: 14px;
	text-decoration: none;
}

#loginBtn {
	border-radius: 20px;
	border: 1px solid #9a3dff;
	background-color: #9a3dff;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
}


#findForm {
	background-color: #FFFFFF;
	display: flex;				/* element배치 방법 */
	align-items: center;		/* flex container의 자식들 가운데 정렬 */
	justify-content: center;	/* flex container의 가운데에 정렬 */
	flex-direction: column;		/* 메인축을 세로 방향으로 정렬 */
	padding: 0 50px;
	height: 100%;
	text-align: center;
	width: 100%;
}

#findForm > input {
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.container {
	background-color: #fff;
	border-radius: 10px;
  	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
	margin-top: 50px;
}
.formContainer {
	position: absolute;
	top: 0;
	height: 100%;
	width: 100%;
}

</style>

<script type="text/javascript">
var checkNICKNAME = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;

$(document).ready(function(){
	// 닉네임 사용 가능여부 확인하기
	$("#m_nickname").keyup(function(event) {
		var m_nickname = $(this).val();
		
		if (!checkNICKNAME.test(m_nickname)) {
			$("#nicknameMsg").html('닉네임은 16자 이하의 영어,숫자,한글로 작성해주세요.').css("color", "red");
			$("#sendBtn").attr("disabled", true);
			return;
		} 
		
		$.ajax({
			url : 'checkNickname.do',
			data : {'m_nickname' : m_nickname},
			dataType : 'json',
			success : function(resData){
				if(resData.result){
				$("#nicknameMsg").html('사용 가능한 닉네임입니다.').css("color","green");
				$("#sendBtn").attr("disabled", false);
				} else {
				$("#nicknameMsg").html('이미 사용중인 닉네임입니다.').css("color","red");
				$("#sendBtn").attr("disabled", true);
				}
			},
			error: function(err){
				alert(err.responseText);
			}
		});
	});
});
function send(f){
	
	var m_nickname = $("#m_nickname").val().trim();
	
	f.action ='socialSignUp.do';
	f.method = "POST";
	f.submit();
	
}

</script>
</head>
<!-- 브라우저에서 뒤로가기로 로그인 페이지 넘어올 수 없도록 지정 -->
<body style="background-color: #0a092d;">
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h1>TEKA, 첫 방문을 환영합니다!</h1>
				</div>
				<c:if test="${!empty param.m_naverId }">
					<input type="hidden"     id="service"  name="service" value="${param.service }"> 
					<input type="hidden"     id="m_naverId"  name="m_naverId" value="${param.m_naverId }"> 
				</c:if>
				
				<c:if test="${!empty param.m_googleId }">
					<input type="hidden"     id="service"  name="service" value="${param.service }"> 
					<input type="hidden"     id="m_googleId"  name="m_googleId" value="${param.m_googleId }"> 
				</c:if>
				
				<input type="email" id="m_email" name="m_email" value="${param.m_email }" readonly="readonly"> 
				<input type="text" id="m_nickname" name="m_nickname" placeholder="서비스에서 사용할 닉네임을 입력하세요.">
				<div id="nicknameMsg"></div> 
				<input id="sendBtn" type="button" value="가입하기" onclick="send(this.form);" disabled="disabled">
			</form>
			
		</div>
	</div>
</body>
</html>