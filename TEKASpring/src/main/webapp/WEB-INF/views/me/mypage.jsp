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
#page{
	margin-left: 20px;
}
#calendar{
	margin-top: 20px;
	width: 600px;
	padding: 10px;
	border-radius : 10px;
	background: linear-gradient(45deg, Violet, Orange);
}
#attendbtn{
	margin-bottom: 10px;
	margin-top: 10px;
	padding-top: 90px;
	margin: auto;
}

</style>

<script>
	var attendList = [];
	
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
				attendList = resData;
				showCalendar();
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
		      events: attendList,
		      customButtons: {
			        custom2: {
			          text: '출석체크하기',
			          id: 'check',
			          click: function() {
		                    // ajax 통신으로 출석 정보 저장하기 
		                    // POST "/users/attend" -> { status: "success", date:"2018-07-01"}
		                    // 통신 성공시 버튼 바꾸고, property disabled 만들기 
			          }
			        }
			    }
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
			data: {'user' : "${user.m_idx}"},
			success: function(resData){
				if(resData == 1){
					alert('출석체크 완료!!');
					location.href="#";
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
	<div id="attendbtn">
	<input class="btn btn-danger" type="button" value="출석체크하기!" onclick="insertAttend();">
	</div>
	<div id='calendar'>
	</div>
	<div>
		<%@ include file="../footer/footer.jsp" %>
	</div>
	</div>
</body>
</html>