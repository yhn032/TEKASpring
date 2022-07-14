package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.AttendVo;

public class AttendDaoImpl implements AttendDao {
	
	SqlSession sqlSession;

	public AttendDaoImpl(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	@Override
	public int insertAttend(AttendVo vo) {
		return sqlSession.insert("attend.insert", vo);
	}

	@Override
	public int deleteAttend(int m_idx) {
		return sqlSession.delete("attend.delete", m_idx);
	}

	@Override
	public List<AttendVo> selectAttendList(int m_idx) {
		return sqlSession.selectList("attend.select", m_idx);
	}

}
