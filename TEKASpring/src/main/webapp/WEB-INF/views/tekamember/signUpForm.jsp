<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
#registerForm {
	width: 600px;
	margin: auto;
	margin-top: 100px;
}


</style>
<script type="text/javascript">
 window.history.forward();
 function noBack(){window.history.forward();}
</script>

<script type="text/javascript">
	var checkID = /^[a-zA-Z0-9]{4,16}$/;
	var checkPWD = /^[a-zA-Z0-9]{4,20}$/;
	var checkNICKNAME = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;
	var checkEMAIL =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	$(document).ready(function() {
		// 아이디 사용 가능여부 확인하기
		$("#m_id").keyup(
			function(event) {
				var m_id = $(this).val();
				
				if (!checkID.test(m_id)) {
					$("#idMsg").html('아이디는 알파벳, 숫자로 4~16자리 이하로 입력 가능합니다.')
							.css("color", "red");
					$("#registerBtn").attr("disabled", true);
					return;
				} 

				$.ajax({
					url : 'checkID.do',
					data : {'m_id' : m_id},
					dataType : 'json',
					success : function(resData){
						if(resData.result){
						$("#idMsg").html('사용 가능한 아이디입니다.').css("color","green");
						$("#registerBtn").attr("disabled", false);
						} else {
						$("#idMsg").html('이미 사용중인 아이디입니다.').css("color","red");
						$("#registerBtn").attr("disabled", true);
						}
					},
					error: function(err){
						alert(err.responseText);
					}
				});
				});
		
		// 닉네임 사용 가능여부 확인하기
		$("#m_nickname").keyup(
				function(event) {
					var m_nickname = $(this).val();
					
					if (!checkNICKNAME.test(m_nickname)) {
						$("#nicknameMsg").html('닉네임은 16자 이하의 영어,숫자,한글로 작성해주세요.')
								.css("color", "red");
						$("#registerBtn").attr("disabled", true);
						return;
					} 
					
					$.ajax({
						url : 'checkNickname.do',
						data : {'m_nickname' : m_nickname},
						dataType : 'json',
						success : function(resData){
							if(resData.result){
							$("#nicknameMsg").html('사용 가능한 닉네임입니다.').css("color","green");
							$("#registerBtn").attr("disabled", false);
							} else {
							$("#nicknameMsg").html('이미 사용중인 닉네임입니다.').css("color","red");
							$("#registerBtn").attr("disabled", true);
							}
						},
						error: function(err){
							alert(err.responseText);
						}
					});
					});
		// 이메일 사용 가능여부 확인하기
		$("#m_email").keyup(
				function(event) {
					var m_email = $(this).val().trim();
					
					if (!checkEMAIL.test(m_email)) {
						$("#emailMsg").html('이메일 형식이 올바르지 않습니다.')
								.css("color", "red");
						$("#registerBtn").attr("disabled", true);
						return;
					} 
					
					$.ajax({
						url : 'checkEmail.do',
						data : {'m_email' : m_email},
						dataType : 'json',
						success : function(resData){
							if(resData.result){
							$("#emailMsg").html('사용 가능한 이메일입니다.').css("color","green");
							$("#registerBtn").attr("disabled", false);
							} else {
							$("#emailMsg").html('이미 사용중인 이메일입니다.').css("color","red");
							$("#registerBtn").attr("disabled", true);
							}
						},
						error: function(err){
							alert(err.responseText);
						}
					});
					});
		
		// 비밀번호 사용 가능여부 확인하기
		$("#m_pwd").keyup(
			function(event) {
				var m_pwd = $(this).val();

				if (!checkPWD.test(m_pwd)) {
					$("#pwdMsg").html('비밀번호는 알파벳, 숫자로 4~20자리 이하로 입력 가능합니다.')
							.css("color", "red");
					$("#registerBtn").attr("disabled", true);
					return;
				} 
				$("#pwdMsg").html('사용 가능한 비밀번호입니다.').css("color","green");
				$("#registerBtn").attr("disabled", false);
			});
		
		// 비밀번호 재확인
		$("#c_pwd").keyup(
			function(event) {
				var c_pwd = $(this).val().trim();
				var m_pwd = $("#m_pwd").val().trim();

				if (c_pwd != m_pwd) {
					$("#pwdcfmMsg").html('비밀번호가 일치하지 않습니다.')
							.css("color", "red");
					$("#registerBtn").attr("disabled", true);
					return;
				} 
				$("#pwdcfmMsg").html('사용 가능한 비밀번호입니다.').css("color","green");
				$("#registerBtn").attr("disabled", false);
			});
		
	
	});
	

	function send(f) {
		// 파라미터 받기
		var m_id = $("#m_id").val().trim();
		var m_nickname = $("#m_nickname").val().trim();
		var m_email  = $("#m_email").val().trim();
		var m_pwd = $("#m_pwd").val().trim();
		var c_pwd = $("#c_pwd").val().trim();
		// 아이디, 닉네임, 이메일, 비번, 비번체크가 비어있으면 확인
		
		if(m_id==''){
			alert('아이디를 입력하세요.');
			$("#m_id").val('');
			$("#m_id").focus();
			return;
		}
		if(m_nickname==''){
			alert('닉네임을 입력하세요.');
			$("#m_nickname").val('');
			$("#m_nickname").focus();
			return;
		}
		if(m_email==''){
			alert('이메일을 입력하세요.');
			$("#m_email").val('');
			$("#m_email").focus();
			return;
		}
		if(m_pwd==''){
			alert('비밀번호를 입력하세요.');
			$("#m_pwd").val('');
			$("#m_pwd").focus();
			return;
		}
		if(c_pwd==''){
			alert('비밀번호를 확인해주세요');
			$("#c_pwd").val('');
			$("#c_pwd").focus();
			return;
		}
		
		
		// 아니면 submit 
		f.action = "signUp.do";
		f.method = "POST";
		f.submit();

	}
</script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<div><%@include file="../header/mainmenu.jsp"%></div>
	<form>
		<div class="panel panel-default" id="registerForm">
			<div class="panel-heading">
				<h3>회원가입</h3>
			</div>
			<div class="panel-body">
				<div id="content">
					<div class="form-group">
						<label for="inputlg">아이디</label> <input
							class="form-control input-lg" id="m_id" name="m_id" type="text"
							maxlength="20">
						<p id="idMsg"></p>
					</div>
					<div class="form-group">
						<label for="inputlg">닉네임</label> <input
							class="form-control input-lg" id="m_nickname" name="m_nickname"
							type="text" maxlength="20">
							<p id="nicknameMsg"></p>
					</div>
					<div class="form-group">
						<label for="inputlg">이메일</label> <input
							class="form-control input-lg" id="m_email" name="m_email"
							type="email" maxlength="20">
							<p id="emailMsg"></p>
					</div>
					<div class="form-group">
						<label for="inputlg">비밀번호</label> <input
							class="form-control input-lg" id="m_pwd" name="m_pwd"
							type="password">
							<p id="pwdMsg"></p>
					</div>
					<div class="form-group">
						<label for="inputlg">비밀번호 재확인</label> <input
							class="form-control input-lg" id="c_pwd" type="password">
							<p id="pwdcfmMsg"></p>
					</div>
					<div>
						<h1>미래의 캡챠 자리</h1>
					</div>
					<div>
						<input class="btn" id="registerBtn" type="button" value="가입하기"
							onclick="send(this.form);">
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>