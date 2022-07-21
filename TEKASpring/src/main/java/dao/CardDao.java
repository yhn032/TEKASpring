package dao;

import java.util.List;
import java.util.Map;

import vo.MyCardSetVo;
import vo.ViewVo;

public interface CardDao {

	public List<ViewVo> 	selectList();
	public List<ViewVo>		selectAllList(Map map);
	public List<ViewVo> 	selectByCondition(Map map);
	public int 				insertMyCard(MyCardSetVo vo);
	public MyCardSetVo 		selectCheckMyCard(MyCardSetVo check);
	public List<ViewVo> 	selectMyCardList(Map map);
	public int 				like(String c_title);
	public int 				deleteMyCard(MyCardSetVo vo);
	public int 				selectTotalMain();
	public int				selectTotalMain(Map map);
	public int              selectTotalMine(Map map);	//나의 학습세트 조회
	public int              updateIsPublic(int c_idx);	//카드 비공개 전환
	public List<ViewVo>     selectModifyCard(int c_idx);//카드 수정용 데이터 불러오깅
	public int              selectQnaCnt(int c_idx);
}
