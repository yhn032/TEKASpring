package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ViewVo;
import vo.WrongQnaVo;

public class StudyCardDaoImpl implements StudyCardDao {
	SqlSession sqlSession;

	public StudyCardDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	public List<ViewVo> selectCard(int c_idx) {
		return sqlSession.selectList("studyCard.selectCard", c_idx);
	}

	public List<Integer> selectWrongNumber(WrongQnaVo vo) {
		return sqlSession.selectList("studyCard.selectWrongNumber", vo);
	}

	public int insertWrongQnaCard(WrongQnaVo vo) {
		return sqlSession.insert("studyCard.insertWrongQnaCard", vo);
	}

	public int deleteWrongQnaCard(WrongQnaVo vo) {
		return sqlSession.delete("studyCard.deleteWrongQnaCard", vo);
	}
}
