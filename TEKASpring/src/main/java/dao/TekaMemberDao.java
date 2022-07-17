package dao;

import vo.TekaMemberVo;

public interface TekaMemberDao {
	
	public TekaMemberVo selectOneById(String m_id);
	public TekaMemberVo selectOneByNickname(String m_nickname);
	public TekaMemberVo selectOneByEmail(String m_email);
	public int insertMember(TekaMemberVo vo);
	public TekaMemberVo selectOneByNaver(String m_naverId);
	public TekaMemberVo selectOneByGoogle(String m_googleId);
	public int insertSocialNaver(TekaMemberVo vo);
	public int insertSocialGoogle(TekaMemberVo vo);
	public TekaMemberVo selectOneByIdx(int m_idx);
	public int updatePwd(TekaMemberVo vo);
}
