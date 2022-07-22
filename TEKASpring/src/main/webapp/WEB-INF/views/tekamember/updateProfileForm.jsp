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
body {
	background-color: #0a092d;
}

#content{
	padding-top: 100px;
	margin: auto;
	color: white;
	width: 500px;
}
#buttons{
	margin: auto;
	text-align: center;
	
}
#delbtn{
	color: grey;
	border: 0;
	outline: 0;
	background-color:transparent;
	display: block;
	margin-left: 430px;
}

</style>

<script type="text/javascript">
var checkPWD = /^[a-zA-Z0-9]{4,20}$/;
var checkNICKNAME = /^(?=.*[a-z0-9가-힣ㄱ-ㅎㅏ-ㅣ])[a-z0-9가-힣ㄱ-ㅎㅏ-ㅣ]{2,16}$/;

$(document).ready(function() {
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
						$("#nicknameMsg").html('사용 가능한 닉네임입니다.').css("color","white");
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
	// 비밀번호 사용 가능여부 확인하기
	$("#m_pwd").keyup(
		function(event) {
			var m_pwd = $(this).val().trim();

			if (!checkPWD.test(m_pwd)) {
				$("#pwdMsg").html('비밀번호는 알파벳, 숫자로 4~20자리 이하로 입력 가능합니다.')
						.css("color", "red");
				$("#registerBtn").attr("disabled", true);
				return;
			} 
			$("#pwdMsg").html('');
			$("#registerBtn").attr("disabled", false);
		});
	
	// 수정비밀번호
	$("#changed_pwd").keyup(
		function(event) {
			var changed_pwd = $(this).val().trim();
			if (!checkPWD.test(changed_pwd)) {
				$("#pwdcfmMsg").html('비밀번호는 알파벳, 숫자로 4~20자리 이하로 입력 가능합니다.')
						.css("color", "red");
				$("#registerBtn").attr("disabled", true);
				return;
			} 
			$("#pwdcfmMsg").html('');
			$("#registerBtn").attr("disabled", false);
		});
	
}); // key up events


	function send(f) {
		var m_nickname = $("#m_nickname").val().trim();
		var m_pwd = $("#m_pwd").val().trim();
		var changed_pwd = $("#c_pwd").val();
		
		if(m_nickname==''){
			alert('닉네임을 입력하세요.');
			$("#m_nickname").val('');
			$("#m_nickname").focus();
			return;
		}
		// 그럴일은 없지만 비번이 null이면 유저의 비번으로 채움
		if(m_pwd==''){
			$("#m_pwd").val("${user.m_pwd}");
		}
		if(changed_pwd==''){
			$("#changed_pwd").val("${user.m_pwd}");
		}
		
		// 업데이트 하는 것들: m_nickname, m_pwd
		f.action = "memberUpdate.do";
		f.method = "POST";
		f.submit();
		
		
	}
	
	function deleteAccount(){
		if(!confirm('정말 탈퇴하시겠습니까? 흑흑')){
			return;
		}
		
		location.href="deleteAccount.do?m_idx="+"${user.m_idx}";
		
	}

</script>

</head>
<body>
		<div><%@ include file="../header/mainmenu.jsp"%></div>
<div id="box"> </div>
<form>
		<div id="content">
			<div class="form-group">
				<label for="inputlg">아이디(변경 불가)</label> 
				<input class="form-control input-lg" id="m_id" value="${user.m_id}" disabled="disabled">
				<p id="idMsg"></p>
			</div>
			<div class="form-group">
				<label for="inputlg">닉네임</label> 
				<input class="form-control input-lg" id="m_nickname" name="m_nickname" type="text" maxlength="20" value="${user.m_nickname}">
				<p id="nicknameMsg"></p>
			</div>
			<div class="form-group">
				<label for="inputlg">이메일(변경 불가)</label> 
				<input class="form-control input-lg" id="m_email" value="${user.m_email}" disabled="disabled">
				<p id="emailMsg"></p>
			</div>
			<div class="form-group">
				<label for="inputlg">현재 비밀번호</label> 
				<input class="form-control input-lg" id="m_pwd" name="m_pwd" type="password">
				<p id="pwdMsg"></p>
			</div>
			<div class="form-group">
				<label for="inputlg">수정 비밀번호</label> 
				<input class="form-control input-lg" id="changed_pwd" name="changed_pwd" type="password">
				<p id="pwdcfmMsg"></p>
			</div>
			<input id="delbtn" type="button" value="회원탈퇴" onclick="deleteAccount();">
		</div>
		<div id="buttons">
			<input class="btn" type="button" value="취소" onclick="location.href='../me/mypage.do'">
			<input class="btn" id="registerBtn" type="button" value="수정" onclick="send(this.form);">
		</div>
</form>

	<div><%@ include file="../footer/footer.jsp"%></div>
</body>
</html>