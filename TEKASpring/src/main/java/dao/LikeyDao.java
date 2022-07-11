package dao;

import java.util.List;

import vo.ViewVo;

public interface LikeyDao {
	//현재 유저의 좋아요 수 조회
	public List<ViewVo> likeCheck(int m_idx);
	
	//c_idx, m_idx에 해당하는 객체 1건 구하기
	public ViewVo selectLike(ViewVo vo);
	
	//l_like + 1 (insert)
	public int liked(ViewVo vo);
	
	public int deleteLike(ViewVo vo);
}
