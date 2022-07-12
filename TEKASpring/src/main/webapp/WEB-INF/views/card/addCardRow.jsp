<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addCardRow.css">
<script type="text/javascript">
//div 추가	
function addRow(){
	
	/* 추가할 div html코드 json배열 저장 */
	var jsonHTML = {
					row: "<div class=\"row\">",	
					delBtn: "<div><a onclick=\"delRow();\" id=\"delBtn\" >🗑️</a>",
					qArea: "<div class=\"tArea\"><div class=\"qArea\"><div class=\"cnt\"></div><textarea COLS=40 ROWS=8 name=\"q_question\"></textarea><p>&emsp;&emsp;&emsp;&emsp;질문</p></div>",
					aArea: "<div class=\"aArea\"><textarea COLS=80 ROWS=8 name=\"q_answer\"></textarea><p>&emsp;&emsp;&emsp;&emsp;&emsp;답변</p></div></div>",
					closeDiv: "</div>"	
				  };
	
	var add = ''; //반복문 안에서 선언하면 누적 못함
	//json배열에 있는 요소 누적
	for(i in jsonHTML){
		add += jsonHTML[i];
	}
	//추가할 영역 지정
	$(".list").append(add);
}

//div 삭제	
function delRow(){ //.row의 this를 넘겨주니까 밑에서부터 삭제됨 -> this 빼고 index를 구해서 해당 index삭제하도록 변경
	
	var index = $(".list .row").index();
	
	//$(".list .row").eq(index).fadeOut(250);
	
	//list내의 row클래스의 index와 동일하면 삭제
	$(".list .row").eq(index).remove();
	
}//delRow() end

</script>
</head>
<body>

<div id="container">
	<div id="box">
		<!-- list영역 행추가 -->
		<div class="list" style="display:table;">
			<div class="row">
				<!-- div 삭제 : this의 정보를 넘겨야 해당 행만 삭제가능 -->
				<div>
					<a id="delBtn" onclick="delRow();">🗑️</a>
				</div>
				<div class="tArea">
					<!-- 텍스트영역 추가 -->
					<div class="qArea">
						<div class="cnt"></div>
						<textarea cols=40 rows=8 name="q_question" class="focus"></textarea>
						<p>&emsp;&emsp;&emsp;&emsp;질문</p>
					</div>
					<div class="aArea">
						<textarea cols=80 rows=8 name="q_answer" class="focus"></textarea>
						<p>&emsp;&emsp;&emsp;&emsp;&emsp;답변</p>
					</div>			
				</div>
			</div><!-- end : row  -->
		</div><!-- end : list -->
		<div id="insert_btn">
			<input type="button" value="카드추가" id="cardBtn" onclick="addRow();">
		</div>
		
		<div id="cardSet_btn">
			<input type="button" value="학습세트 만들기" id="makeCard" onclick="addCardSet(this.form);">
		</div>
		<!-- footer -->
		<div id="footer">
			© 2022 TEKA All Rights Reserved. <br>
			만든사람: 김다정, 김병국, 류다희<br>
			<a href="https://github.com/yhn032/TEKA">깃허브 바로가기</a><br>
			<a href="https://github.com/yhn032/TEKA/issues">제작 기록 확인하기</a>
		</div>
	</div><!-- end : box -->
</div><!-- end : container -->

</body>
</html>