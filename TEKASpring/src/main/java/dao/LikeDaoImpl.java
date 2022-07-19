package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ViewVo;

public class LikeDaoImpl implements LikeDao{
	SqlSession sqlSession;
	public LikeDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	public List<Integer> checkLike(int m_idx) {
		return sqlSession.selectList("like.checkLike", m_idx);
	}
	public ViewVo selectLike(ViewVo vo) {
		return sqlSession.selectOne("like.selectLike", vo);
	}
	public int insertLike(ViewVo vo) {
		return sqlSession.update("like.insertLike", vo);
	}
	public int cancelLike(ViewVo vo) {
		return sqlSession.update("like.cancelLike", vo);
	}
}