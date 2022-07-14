package dao;

import vo.TekaMemberVo;

public interface TekaMemberDao {
	
	public TekaMemberVo selectOneById(String m_id);
	public TekaMemberVo selectOneByNickname(String m_nickname);
	public TekaMemberVo selectOneByEmail(String m_email);
	public int insertMember(TekaMemberVo vo);
	public TekaMemberVo selectOneBySocial(String m_naverId);
	public int insertSocial(TekaMemberVo vo);
	public TekaMemberVo selectOneByIdx(int m_idx);
	public int updatePwd(TekaMemberVo vo);
}
