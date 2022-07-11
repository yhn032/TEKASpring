package dao;

import java.util.List;

import vo.ViewVo;
import vo.WrongQnaVo;

public interface StudyCardDao {
	public List<ViewVo> selectCard(int c_idx);
	public List<Integer> selectWrongNumber(WrongQnaVo vo);
	public int insertWrongQnaCard(WrongQnaVo vo);
	public int deleteWrongQnaCard(WrongQnaVo vo);
}
