<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
var checkPWD = /^[a-zA-Z0-9]{4,20}$/;
$(document).ready(function() {
	// 기존 비밀번호가 맞는지 확인하기 
	$("#old_pwd").keyup(function(event) {
		var old_pwd = $(this).val();
		var origin  = $("#origin").val();
		
		
		if(old_pwd != origin){
			$("#oldPwdMsg").html('변경 전 비밀번호를 정확하게 입력해주세요.').css("color", "red");
			$("#changePwd").attr("disabled", true);
			return;
		}else{
			$("#oldPwdMsg").html('정확합니다.').css("color", "green");
			$("#changePwd").attr("disabled", false);
			return;
		}
	});

	
	// 비밀번호 사용 가능(중복여부x 유효성검사o)여부 확인하기
	$("#new_pwd").keyup(function(event) {
		var m_pwd = $(this).val();

		if (!checkPWD.test(m_pwd)) {
			$("#newPwdMsg").html('비밀번호는 알파벳, 숫자로 4~20자리 이하로 입력 가능합니다.').css("color", "red");
			$("#changePwd").attr("disabled", true);
			return;
		}else {
			$("#newPwdMsg").html('사용 가능한 비밀번호입니다.').css("color","green");
			$("#changePwd").attr("disabled", false);
		}
	});
	
	// 비밀번호 재확인
	$("#new_pwdCheck").keyup(function(event) {
		var new_pwdCheck = $(this).val().trim();
		var new_pwd = $("#new_pwd").val().trim();

		if (new_pwdCheck != new_pwd) {
			$("#newPwdCheckMsg").html('비밀번호가 일치하지 않습니다.').css("color", "red");
			$("#changePwd").attr("disabled", true);
			return;
		} else{
			$("#newPwdCheckMsg").html('사용 가능한 비밀번호입니다.').css("color","green");
			$("#changePwd").attr("disabled", false);
		}
	});
	

});

function change(m_idx){
	var old_pwd = $("#old_pwd").val().trim();
	var new_pwd = $("#new_pwd").val().trim();
	var new_pwdCheck = $("#new_pwdCheck").val().trim();
	
	
	if(old_pwd == ''){
		alert("변경전 비밀번호를 입력하세요.");
		$("#old_pwd").val('');
		$("#old_pwd").focus();
		return;
	}
	if(new_pwd == ''){
		alert("변경할 비밀번호를 입력하세요.");
		$("#new_pwd").val('');
		$("#new_pwd").focus();
		return;
	}
	if(new_pwdCheck == ''){
		alert("비밀번호 확인을 위해 입력해주세요.");
		$("#new_pwdCheck").val('');
		$("#new_pwdCheck").focus();
		return;
	}
	
	location.href="updatePwd.do?m_idx="+m_idx+"&m_pwd="+new_pwd;
}

</script>
</head>
<!-- 브라우저에서 뒤로가기로 로그인 페이지 넘어올 수 없도록 지정 -->
<body style="background-color: #0a092d;">
	<%@include file="../header/findIdPwdHeader.jsp" %>
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<input type="hidden" id="origin" value="${vo.m_pwd }">
				<div class="mainHeader">
					<h1>[TEKA] 비밀번호 변경</h1>
				</div>
				<span>현재 비밀번호</span><input type="text"     id="old_pwd"  placeholder="old_pwd" /> 
				<p id="oldPwdMsg"></p>
				<span>변경 비밀번호</span><input type="text"     id="new_pwd"  name="m_pwd"    placeholder="new_pwd" /> 
				<p id="newPwdMsg"></p>
				<span>비밀번호 확인</span><input type="text"     id="new_pwdCheck" placeholder="new_pwdCheck" /> 
				<p id="newPwdCheckMsg"></p>
				
				<input id="changePwd" type="button" value="변경하기" onclick="change(${param.m_idx});" disabled="disabled">
			</form>
			
		</div>
	</div>
</body>
</html>