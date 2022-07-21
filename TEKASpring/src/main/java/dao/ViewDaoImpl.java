package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ViewVo;

public class ViewDaoImpl implements ViewDao{
	SqlSession sqlSession;

	public ViewDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	//c_title로 c_idx 구하기
	public ViewVo selectCIdx(String c_title) {
		return sqlSession.selectOne("card.selectCidx", c_title);
	}
	//c_idx에 해당하는 qnaCard테이블 List 구하기
	public List<ViewVo> qnaCardList(int c_idx){
		return sqlSession.selectList("card.preview", c_idx);
	}
	//c_idx로 m_nickname 구하기
	public String selectNickname(int c_idx) {
		return sqlSession.selectOne("studyCard.selectNickname", c_idx);
	}
	//qnaCard DML
	public int qnaInsert(ViewVo vo) {
		return sqlSession.insert("card.qnaInsert", vo);
	}
	//qnaCard 
	public int cardInsert(ViewVo vo) {
		return sqlSession.insert("card.cardInsert", vo);
	}
	//좋아요 insert
	public int insertLiked(ViewVo vo) {
		return sqlSession.insert("card.insertLiked", vo);
	}
	//qnaCard
	public int myCardSetInsert(ViewVo vo) {
		return sqlSession.insert("card.myCardSetInsert", vo);
	}	
	//c_idx에 해당하는 팝업 리스트 조회
	public List<ViewVo> previewList(int c_idx){
		return sqlSession.selectList("card.preview", c_idx);
	}

	@Override
	public int cardUpdate(ViewVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("card.cardUpdate", vo);
	}

	@Override
	public List<Integer> qnaIdxNum(int c_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("card.qnaIdxNum", c_idx);
	}

	@Override
	public int qnaUpdate(ViewVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("card.qnaUpdate", vo);
	}
}