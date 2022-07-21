<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card/addCardRow.css">
<script type="text/javascript">
var idx = '${size}';

function addRow(){
	var jsonHTML = {
					row: "<div class=\"row\" id=\"row_" + idx + "\">",	
					delBtn: "<div><input type=\"button\" class=\"delBtn\" id=\"" + idx++ + "\"", 
					del: "onclick=\"delRow(this.id);\" value=\"🗑️\">",
					qArea: "<div class=\"tArea\"><div class=\"qArea\"><div class=\"cnt\"></div><textarea COLS=40 ROWS=8 name=\"q_question\"></textarea><p>&emsp;&emsp;&emsp;&emsp;질문</p></div>",
					aArea: "<div class=\"aArea\"><textarea COLS=80 ROWS=8 name=\"q_answer\"></textarea><p>&emsp;&emsp;&emsp;&emsp;&emsp;답변</p></div></div>",
					closeDiv: "</div>"	
				  };
	var add = '';
	for(i in jsonHTML){
		add += jsonHTML[i];
	}
	
	$(".list").append(add);
}

function delRow(idx){
	$("#row_" + idx).remove();
}
</script>
</head>
<body>
	<div id="container">
		<div id="box">
			<!-- list영역 행추가 -->
			<div class="list" style="display:table;">
			
				<c:forEach var="card" items="${list}" varStatus="i">
					<div class="row" id="row_${i.index }">
						<!-- div 삭제 : this의 정보를 넘겨야 해당 행만 삭제가능 -->
						<div>
							<input type="button" class="delBtn" id="${i.index }" onclick="delRow(this.id);" value="🗑️">
						</div>
						<div class="tArea">
							<!-- 텍스트영역 추가 -->
							<div class="qArea">
								<div class="cnt"></div>
								<textarea cols=40 rows=8 name="q_question" class="focus">${card.q_question }</textarea>
								<p>&emsp;&emsp;&emsp;&emsp;질문</p>
							</div>
							<div class="aArea">
								<textarea cols=80 rows=8 name="q_answer" class="focus">${card.q_answer }</textarea>
								<p>&emsp;&emsp;&emsp;&emsp;&emsp;답변</p>
							</div>			
						</div>
					</div><!-- end : row  -->
				</c:forEach>
				
			</div><!-- end : list -->
			
			<div id="insert_btn">
				<input type="button" value="카드추가" id="cardBtn" onclick="addRow();">
			</div>
			
			<div id="cardSet_btn">
				<input type="button" value="학습세트 수정하기" id="makeCard" onclick="modifyCardSet(this.form);">
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