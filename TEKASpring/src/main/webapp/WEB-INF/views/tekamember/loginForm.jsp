<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 로그인</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- RSA JS Library -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jsbn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/rsa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/prng4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/rng.js"></script>

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

body {
	background: #0a092d;
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
.social{
    color: #9a3dff;
}



#loginForm {
	background-color: #FFFFFF;
	display: flex;				/* element배치 방법 */
	align-items: center;		/* flex container의 자식들 가운데 정렬 */
	justify-content: center;	/* flex container의 가운데에 정렬 */
	flex-direction: column;		/* 메인축을 세로 방향으로 정렬 */
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

#loginForm > input {
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
}

.logInContainer {
	left: 0;
	width: 50%;
	z-index: 2;
}
.overlayContainer {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
}


.overlay {
	background: #c2b0da;
	background: linear-gradient(to right, #b25858, #9a3dff);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
}

.overlayPanel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
}


.overlayRight {
	right: 0;
}

.socialContainer {
	margin: 50px 0;
}

.socialContainer a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
	text-decoration: none;
}

#backFromLogin{
	color: white;
	width: 150px;
	height: 70px;
	border: 0;
	background: transparent;
	box-shadow: 1px 3px 1px black;
	font-size: 20px;
	font-weight: 600;
}

#backFromLogin:hover{
	background: black;
}
</style>

<script type="text/javascript">
	//로그인 성공시 브라우저 뒤로 가기 버튼으로 다시 로그인 페이지로 이동할 수 없도록 막기
	window.history.forward();
	function noBack(){
		window.history.forward();
	}
	
	$(document).ready(function(){
		setTimeout(showMessage, 100);
		
		$("#loginForm").keypress(function(e){
			if(e.keyCode == 13){
				checkValidate();
			}
		});
	});
	
	function showMessage(){
		if("${param.reason eq 'failId'}" == "true"){
			Swal.fire({
				  icon: 'question',
				  title: '아이디를 확인하세요...',
				  text: '존재하지 않는 아이디입니다.',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#m_id").focus();
				}else{
					return;
					
				}
				
			});
		}
		
		if("${param.reason eq 'failPwd'}" == "true"){
			Swal.fire({
				  icon: 'question',
				  title: '비밀번호를 확인하세요...',
				  text: '존재하지 않는 비밀번호입니다.',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#m_pwd").focus();
				}else{
					
					return;
				}
				
			});
		}
		
		if("${param.reason eq 'sessionTimeout'}" == "true"){
			Swal.fire({
				  icon: 'question',
				  title: '로그인 해주세요...',
				  text: '세션이 만료되었습니다.',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#m_id").focus();
				}else{
					return;
					
				}
				
			});
		}
		
		if("${param.reason eq 'social'}" == "true"){
			Swal.fire({
				title: '이미 가입한 계정이 있습니다.\n아이디를 찾으시겠습니까?',
				icon:'warning',
				showDenyButton: true,
				confirmButtonText: '네',
				denyButtonText: '아니요',
			}).then((result) => {
				/* Read more about isConfirmed, isDenied below */
				if (result.isConfirmed) {
					location.href="findID.do";
				} else if (result.isDenied) {
					return;
				}
			});
			
		}
		
		
	}

	function checkValidate(){
		
		//사용자 입력값 체크
		var m_id  = $("#m_id").val().trim();
		var m_pwd = $("#m_pwd").val().trim();
		
		if(m_id == ''){
			Swal.fire({
				  icon: 'info',
				  title:'아이디를 입력하세요!',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#m_id").val('');
					$("#m_id").focus();
					return;
				}
			});
		}
		
		//비밀번호는 정규식 추가해야 할 것 같음
		if(m_pwd == ''){
			Swal.fire({
				  icon: 'info',
				  title:'비밀번호를 입력하세요!',
				  returnFocus: false
			}).then((result) => {
				
				if(result.isConfirmed){
					$("#m_pwd").val('');
					$("#m_pwd").focus();
					return;
				}
			});
		}
		
		
		try{
			var RSAPublicKeyModulus  = $("#RSAModulus").val();
			var RSAPublicKeyExponent = $("#RSAExponent").val();
			submitEncryptedForm(m_id, m_pwd, RSAPublicKeyModulus, RSAPublicKeyExponent);
		}catch(err){
			console.log(err);
		}
		
		return false;
	}
	
	function submitEncryptedForm(m_id, m_pwd, RSAPublicKeyModulus, RSAPublicKeyExponent){
		//서버로 전송하기 비로 전에 값을 암호화한다. 바이트배열을 16진 문자열로 바꾼다.
		var rsa = new RSAKey();
		rsa.setPublic(RSAPublicKeyModulus, RSAPublicKeyExponent);
		
		//사용자 계정정보를 암호화 처리 
		var securedM_id  = rsa.encrypt(m_id);
		var securedM_pwd = rsa.encrypt(m_pwd);
		
		//숨겨진 폼에 값을 설정하고 서브밋한다. 
		$("#encryptedID").val(securedM_id);
		$("#encryptedPWD").val(securedM_pwd);
		
		securedForm.submit();
	}
</script>
</head>
<!-- 브라우저에서 뒤로가기로 로그인 페이지 넘어올 수 없도록 지정 -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<div class="container" id="container">
		<div class="formContainer logInContainer">
			<form id="loginForm" name="loginForm">
				<input type="hidden" id="RSAModulus"  value="${RSAModulus }" /> <!-- 서버에서 전달해준 공개키 저장(세션트래킹) -->
				<input type="hidden" id="RSAExponent" value="${RSAExponent }" /> <!-- 서버에서 전달해준 공개키 저장(세션트래킹) -->
				<div class="mainHeader">
					<h1>Sign-in</h1>
				</div>
				<div class="socialContainer">
					<a href="${naverUrl }" class="social"><i class="fab fa-neos" style="color: green;"></i></a>
					<a href="${googleUrl}" class="social"><i class="fab fa-google"></i></a>
				</div>
				<span>or use your account</span> 
				<input type="text"     id="m_id"  name="m_id"    placeholder="id" /> 
				<input type="password" id="m_pwd" name="m_pwd"   placeholder="Password" /> 
				<a href="findID.do">Forgot your id or password?</a>
				<input id="loginBtn" type="button" value="Sign In" onclick="checkValidate(); return false;" />
			</form>
			
			<!-- 실제로 서버에 전송할 데이터를 담을 폼 -->
			<form id="securedForm" name="securedForm" method="POST" action="login.do" style="display: none;">
				<input type="hidden" id="url" name="url" value="${url }">
				<input type="hidden" id="encryptedID"  name="encryptedID"  value="" /> <!-- 서버에서 전달해준 공개키 저장(세션트래킹) -->
				<input type="hidden" id="encryptedPWD" name="encryptedPWD" value="" /> <!-- 서버에서 전달해준 공개키 저장(세션트래킹) -->
			</form>
		</div>
		<div class="overlayContainer">
			<div class="overlay">
				<div class="overlayPanel overlayRight">
					<h1>Welcome Back!</h1>
					<p>Study Hard. And then pass the Technical Interview. Let's Go NeKaLiCuBaeDangTo!</p>
					<input id="backFromLogin" type="button" value="뒤로가기" onclick="location.href='../card/main.do';">
				</div>
			</div>
		</div>
	</div>
</body>
</html>