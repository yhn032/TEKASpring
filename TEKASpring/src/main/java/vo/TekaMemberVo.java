package vo;

public class TekaMemberVo {
	int    m_idx;
	String m_id;
	String m_pwd;
	String m_nickname;
	String m_email;
	String m_grade;
	String m_naverId;
	String m_googleId;
	String m_regdate;
	
	public String getM_regdate() {
		return m_regdate;
	}
	public void setM_regdate(String m_regdate) {
		this.m_regdate = m_regdate;
	}
	public String getM_googleId() {
		return m_googleId;
	}
	public void setM_googleId(String m_googleId) {
		this.m_googleId = m_googleId;
	}
	public String getM_naverId() {
		return m_naverId;
	}
	public void setM_naverId(String m_naverId) {
		this.m_naverId = m_naverId;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_pwd() {
		return m_pwd;
	}
	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}
	public String getM_grade() {
		return m_grade;
	}
	public void setM_grade(String m_grade) {
		this.m_grade = m_grade;
	}
}