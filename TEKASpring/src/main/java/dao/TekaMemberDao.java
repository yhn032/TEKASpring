package dao;

import java.util.List;
import java.util.Map;

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
	public List<TekaMemberVo> selectRegister();
	public List<TekaMemberVo> selectQuitMember();
	public int memberGradeUpdate(TekaMemberVo vo);
	public int memberDelete(int m_idx);
	public int attendDelete(int m_idx);
	public int memberUpdate(Map map);
	public int memberDeleteFromClient(TekaMemberVo vo);
}
