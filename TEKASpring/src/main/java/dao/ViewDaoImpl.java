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
	
	//qnaCard ���̺� DML
	public int cardInsert(ViewVo vo) {
		return sqlSession.insert("card.cardInsert", vo);
	}
	
	//좋아요 insert
	public int insertLiked(ViewVo vo) {
		return sqlSession.insert("card.insertLiked", vo);
	}
	
	//qnaCard ���̺� DML
	public int myCardSetInsert(ViewVo vo) {
		return sqlSession.insert("card.myCardSetInsert", vo);
	}	
	
	//팝업 리스트 전체조회
	public List<ViewVo> previewList(){
		return sqlSession.selectList("card.preview");
	}
	
	//c_idx에 해당하는 닉네임/카드제목/소개글 구하기
	public List<ViewVo> previewSelectThree(int c_idx) {
		return sqlSession.selectList("card.previewSelectThree", c_idx);
	}
}
