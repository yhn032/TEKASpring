package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.MyCardSetVo;
import vo.ViewVo;

public class CardDaoImpl implements CardDao {
	SqlSession sqlSession;

	public CardDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	public List<ViewVo> selectList() {
		return sqlSession.selectList("card.selectAll");
	}

	
	public List<ViewVo> selectBySubject(String subject) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectBySubject", subject);
	}
	
	public int insertMyCard(MyCardSetVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("card.insertMyCard", vo);
	}
	
	public MyCardSetVo selectCheckMyCard(MyCardSetVo check) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectCheckMyCard", check);
	}

	public List<ViewVo> selectMyCardList(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectMyCardList", m_idx);
	} 
	
	public List<ViewVo> cardCondition(Map map){
		return sqlSession.selectList("card.cardCondition", map);
	}
	
	public int like(String c_title){
		return sqlSession.selectOne("card.like", c_title);
	}
	
	public int deleteMyCard(MyCardSetVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("card.deleteMyCard", vo);
	}

	//전체 카드 개수 조회하기
	@Override
	public int selectTotalMain() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectTotalMain");
	}

	@Override
	public List<ViewVo> selectAllList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectAllList", map);
	}
	
}
