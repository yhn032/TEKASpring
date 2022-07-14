package dao;

import java.util.List;

import vo.AttendVo;

public interface AttendDao {
	
	public int insertAttend(AttendVo vo);
	public int deleteAttend(int m_idx);
	public List<AttendVo> selectAttendList(int m_idx);

}
