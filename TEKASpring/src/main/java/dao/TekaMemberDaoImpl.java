package dao;

import java.util.List;
import java.util.Map;

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
	public TekaMemberVo selectOneByIdx(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("tekamember.selectOneByIdx", m_idx);
	}

	@Override
	public int updatePwd(TekaMemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("tekamember.updatePwd", vo);
	}

	@Override
	public int insertSocialNaver(TekaMemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("tekamember.insertSocialNaver", vo);
	}

	@Override
	public int insertSocialGoogle(TekaMemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("tekamember.insertSocialGoogle", vo);
	}

	@Override
	public TekaMemberVo selectOneByNaver(String m_naverId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("tekamember.selectOneByNaver", m_naverId);
	}

	@Override
	public TekaMemberVo selectOneByGoogle(String m_googleId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("tekamember.selectOneByGoogle", m_googleId);
	}

	@Override
	public List<TekaMemberVo> selectRegister() {
		return sqlSession.selectList("tekamember.selectRegister");
	}

	@Override
	public int memberUpdate(Map map) {
		return sqlSession.update("tekamember.memberUpdate", map);
	}

	@Override
	public int memberDelete(int m_idx) {
		return sqlSession.delete("tekamember.memberDelete", m_idx);
	}

	@Override
	public int memberDeleteFromClient(TekaMemberVo vo) {
		return sqlSession.update("tekamember.memberDeleteFromClient", vo);
	}
}
