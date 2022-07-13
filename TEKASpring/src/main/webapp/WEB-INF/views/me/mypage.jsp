<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- fullcalendar CDN -->  
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />  
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>  
<!-- fullcalendar 언어 CDN -->  
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<script type="text/javascript"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
    	  locale: 'ko',
	      initialView: 'dayGridMonth',
	      events: [
	    	    {
	    	      "title"  : "출석체크 만들기^^",
	    	      "start"  : "2022-07-13"
	    	    }],
	    });
	    
	    calendar.render();
	  });
	
	
		    
</script>

<style type="text/css">
#calendar {
  max-width: 900px;
  margin: 20px auto;
  margin-top: 100px;
}
</style>

</head>
<body>
<div>
<%@ include file="../header/mainmenu.jsp" %>
</div>
<div id='calendar'></div>
</body>
</html>