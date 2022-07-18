package utils;
/*
        nowPage: 현재 페이지
        rowTotal:전체 데이터 개수
        blockList:한 페이지 당 게시물 수 
        blockPage: 한 화면에 나타낼 페이지 목록 수
 */
public class Paging {
	public static String getPaging(String pageURL, String searchFilter, int nowPage, int rowTotal,int blockList, int blockPage){
		
		//전체 페이지수, 시작 페이지번호, 마지막 페이지 번호
		int totalPage,startPage,endPage;
		
		//다음 페이지 혹은 이전 페이지 이동할 수 있는 버튼의 활성화 여부를 저장할 변수
		boolean  isPrevPage,isNextPage;
		StringBuffer sb; // 동적으로 html코드를 저장할 변수
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수 구하기 
		totalPage = (int)(rowTotal/blockList);
		if(rowTotal%blockList!=0)totalPage++;
		

		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를 넘을 경우 
		//강제로 현재 페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		

		//시작 페이지와 마지막 페이지를 구한다.
		startPage = (int)(((nowPage-1)/blockPage)*blockPage+1);
		endPage = startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체 페이지 수보다 크면 마지막 페이지 값을 변경 
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막 페이지수가 전체페이지보다 작을 경우 다음 화면으로 이동하는 버튼 활성화
		//boolean변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 크다면 이전 화면으로 이동하는 버튼 활성화
		if(startPage > 1)isPrevPage = true;
		
		
		sb = new StringBuffer();
//-----그룹 이전 페이지 이동 처리 --------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append("<a href ='"+pageURL+"?page=");
			sb.append(startPage - 1);
			sb.append(searchFilter);
			sb.append("'>◀</a>");
		}
		else
			sb.append("◀");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
		sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("&nbsp;<b><font color='red'>");
				sb.append(i);
				sb.append("</font></b>");
			}
			else{//현재 페이지가 아니라면
				sb.append("&nbsp;<a href='"+pageURL+"?page=");
				sb.append(i);
				sb.append(searchFilter);
				sb.append("'>");
				
				
				sb.append("<span class='num_box'>");
				sb.append(i);
				sb.append("</span>");
				
				sb.append("</a>");
			}
		}// end for
		
		sb.append("&nbsp;|");
		
//-----그룹 다음 페이지 이동 처리 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<a href='"+pageURL+"?page=");
			sb.append(endPage+1);
			sb.append(searchFilter);
			sb.append("'>▶</a>");
		}
		else
			sb.append("▶");
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}
	public static String getPaging(String pageURL,int nowPage, int rowTotal,int blockList, int blockPage){
		
		//전체 페이지수, 시작 페이지번호, 마지막 페이지 번호
		int totalPage,startPage,endPage;
		
		//다음 페이지 혹은 이전 페이지 이동할 수 있는 버튼의 활성화 여부를 저장할 변수
		boolean  isPrevPage,isNextPage;
		StringBuffer sb; // 동적으로 html코드를 저장할 변수
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수 구하기 
		totalPage = (int)(rowTotal/blockList);
		if(rowTotal%blockList!=0)totalPage++;
		
		
		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를 넘을 경우 
		//강제로 현재 페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		
		
		//시작 페이지와 마지막 페이지를 구한다.
		startPage = (int)(((nowPage-1)/blockPage)*blockPage+1);
		endPage = startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체 페이지 수보다 크면 마지막 페이지 값을 변경 
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막 페이지수가 전체페이지보다 작을 경우 다음 화면으로 이동하는 버튼 활성화
		//boolean변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 크다면 이전 화면으로 이동하는 버튼 활성화
		if(startPage > 1)isPrevPage = true;
		
		
		sb = new StringBuffer();
//-----그룹 이전 페이지 이동 처리 --------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append("<a href ='"+pageURL+"?page=");
			sb.append(startPage - 1);
			sb.append("'>◀</a>");
		}
		else
			sb.append("◀");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
		sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("&nbsp;<b><font color='red'>");
				sb.append(i);
				sb.append("</font></b>");
			}
			else{//현재 페이지가 아니라면
				sb.append("&nbsp;<a href='"+pageURL+"?page=");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a>");
			}
		}// end for
		
		sb.append("&nbsp;|");
		
//-----그룹 다음 페이지 이동 처리 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<a href='"+pageURL+"?page=");
			sb.append(endPage+1);
			sb.append("'>▶</a>");
		}
		else
			sb.append("▶");
//---------------------------------------------------------------------------------------------------------------------	    
		
		return sb.toString();
	}
}