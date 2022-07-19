package dao;

import java.util.List;

import vo.ViewVo;

public interface LikeDao {
	public List<Integer> checkLike(int m_idx);
	public ViewVo selectLike(ViewVo vo);
	public int insertLike(ViewVo vo);
	public int cancelLike(ViewVo vo);
}