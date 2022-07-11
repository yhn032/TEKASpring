package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ViewVo;

public class LikeyDaoImpl implements LikeyDao{
	SqlSession sqlSession;

	public LikeyDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	//현재 유저의 좋아요 수 조회
	public List<ViewVo> likeCheck(int m_idx) {
		return sqlSession.selectList("card.likeCheck", m_idx);
	}
	
	//c_idx, m_idx에 해당하는 객체 1건 구하기
	public ViewVo selectLike(ViewVo vo) {
		return sqlSession.selectOne("card.selectLike", vo);
	}
	
	//l_like + 1 (insert)
	public int liked(ViewVo vo) {
		return sqlSession.update("card.liked", vo);
	}
	
	public int deleteLike(ViewVo vo) {
		return sqlSession.update("card.deleteLike", vo);
	}
	
}
