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
	width: 550px;
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
</head>
<body style="background-color: #0a092d;">
	<%@include file="../header/findIdPwdHeader.jsp" %>
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h1>[TEKA] 회원님의 비밀번호는 </h1>
					<h1>${vo.m_pwd}입니다.</h1>
				</div>
				<input type="button" value="비밀번호 바꾸기" onclick="location.href='newPWD.do?m_idx=${vo.m_idx}'">
				<input type="button" value="로그인 하러가기" onclick="location.href='loginForm.do'">
			</form>
			
		</div>
	</div>
</body>
</html>