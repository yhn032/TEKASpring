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

	
	public List<ViewVo> selectByCondition(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectByCondition", map);
	}
	
	public int insertMyCard(MyCardSetVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("card.insertMyCard", vo);
	}
	
	public MyCardSetVo selectCheckMyCard(MyCardSetVo check) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectCheckMyCard", check);
	}

	public List<ViewVo> selectMyCardList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectMyCardList", map);
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
		return sqlSession.selectOne("card.selectTotalRow");
	}

	@Override
	public List<ViewVo> selectAllList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectAllList", map);
	}
	
	//조건이 있는 카드의 개수 조회하기 
	@Override
	public int selectTotalMain(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectTotalRowByCondition", map);
	}

	@Override
	public int selectTotalMine(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectTotalMine", map);
	}

	@Override
	public int updateIsPublic(int c_idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("card.updateIsPublic", c_idx);
	}

	@Override
	public List<ViewVo> selectModifyCard(int c_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.selectModifyCard", c_idx);
	}

	@Override
	public int selectQnaCnt(int c_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("card.selectQnaCnt", c_idx);
	}
	
}
