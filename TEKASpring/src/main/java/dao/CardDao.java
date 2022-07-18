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
	public List<ViewVo> 	selectMyCardList(int m_idx);
	public int 				like(String c_title);
	public int 				deleteMyCard(MyCardSetVo vo);
	public int 				selectTotalMain();
	public int				selectTotalMain(Map map);
}
