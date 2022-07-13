package dao;

import org.apache.ibatis.session.SqlSession;

import vo.TekaMemberVo;

public class TekaMemberDaoImpl implements TekaMemberDao{
	SqlSession sqlSession;

	public TekaMemberDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	public TekaMemberVo selectOneById(String m_id) {
		return sqlSession.selectOne("tekamember.memberListById", m_id);
	}

	public TekaMemberVo selectOneByNickname(String m_nickname) {
		return sqlSession.selectOne("tekamember.memberListByNickname", m_nickname);
	}
	
	//비동기 이메일 중복체크
	public TekaMemberVo selectOneByEmail(String m_email) {
		return sqlSession.selectOne("tekamember.memberListByEmail", m_email);
	}
	
	public int insertMember(TekaMemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("tekamember.insert", vo);
	}

	@Override
	public TekaMemberVo selectOneBySocial(String m_naverId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("tekamember.selectOneBySocial", m_naverId);
	}

	@Override
	public int insertSocial(TekaMemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("tekamember.insertSocial", vo);
	}
}
