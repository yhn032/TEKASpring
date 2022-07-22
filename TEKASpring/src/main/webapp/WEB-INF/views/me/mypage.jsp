<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEKA : 마이페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- fullcalendar CDN -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<style type="text/css">
body{
background-color: #0a092d;
}
#page{
	margin-left: 40px;
}
#calendar{
	margin-top: 20px;
	width: 600px;
	padding: 10px;
	border-radius : 10px;
	background: linear-gradient(45deg, Violet, Orange);
	float: left;
	margin-bottom: 100px;
}
#attendbtndiv{
	margin-bottom: 10px;
	margin-top: 10px;
	padding-top: 90px;
	margin: auto;
}
#profile{
	color: white;
	font-size: 30px;
	float: left;
	margin: auto;
	margin-left: 20%;

}

.profilebtn{
	font-size: 20px;
	margin: 10px;	
	margin-left: 10px;
	border: none;
	width: 200px;
	height: 40px;
	border-radius: 10px;
	background: linear-gradient(
	      45deg,
	      #002bff,
	      #7a00ff,
	      #ff00c8,
	      #ff0000
	  );
    color: white;
}



</style>

<script>
	var attendList = [];
	var date = new Date();
	var y = date.getFullYear();
	var m = String(date.getMonth()+1).padStart(2, "0");
	var d = String(date.getDate()).padStart(2, "0");
	let today = y+"-"+m+"-"+d;
	
	
	$(function(){ // 로딩되면 처리 
		if("${empty user}"=="true"){
			alert('로그인 해주세요');
			location.href="../tekamember/loginForm.do";
		}
	
		$.ajax({
			type : "GET",
			url : "attendList.do",
			data : {"m_idx" : "${user.m_idx}"},
			dataType : 'json',
			success : function(resData){
				console.log(resData);
				attendList = resData;
				showCalendar();
				// 오늘 날짜가 마지막 출석 입력일이랑 같으면 버튼 비활성화
				if(attendList[attendList.length-1].start==today){
					$("#attendbtn").attr("disabled",true);
					$("#attendbtn").val('출석 완료!');
				}
			},
			error : function(err){
			}
		});// ajax
		
	});
	
	function showCalendar(){
			//console.log(attendList);
		    var calendarEl = document.getElementById('calendar');
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		   	  locale: 'ko',
		      initialView: 'dayGridMonth',
		      events: attendList
		      
		    });
		    
		    calendar.render();
	}
	
	function insertAttend(){
		if("${empty user}"=="true"){
			alert('로그인 해주세요');
			location.href="../tekamember/loginForm.do";
		}
		
		$.ajax({
			type: 'GET',
			url: 'attend.do',
			data: {'m_idx' : "${user.m_idx}"},
			success: function(resData){
				if(resData == 1){
					alert('출석체크 완료!!');
					location.href="mypage.do";
				} else{
					alert('실패했습니다...');
					return;
				}
			},
			error: function(err){
				alert('서버에러');
			}
		});
		
		
		
	}
	
		    
</script>

<style type="text/css">

</style>

</head>
<body>
	<div id="header">
		<%@ include file="../header/mainmenu.jsp"%>
	</div>
	<div id="page">
		<div id="attendbtndiv">
			<input id="attendbtn" class="btn btn-danger" type="button"
				value="출석체크하기!" onclick="insertAttend();">
		</div>
		<div id="calendar"></div>
		<div id="profile">
			반갑습니다!<br>
			${ user.m_nickname }님의 페이지입니다.<br><br>
			<input class ="profilebtn" type="button" value="내 학습세트 보기" onclick="location.href='../card/myCardList.do'"><br>
			<input class ="profilebtn" type="button" value="내 프로필 수정" onclick="location.href='../tekamember/updateProfileForm.do'"><br>
			<input class ="profilebtn" type="button" value="문의하기" onclick="location.href='askform.do';"><br>
			<c:if test="${user.m_grade eq '관리자'}">
				<input class="profilebtn" type="button" value="회원관리" onclick="location.href='../tekamember/register.do'"><br>
			</c:if>
		</div>
		<div><%@ include file="../footer/footer.jsp"%></div>
	</div>
</body>
</html>