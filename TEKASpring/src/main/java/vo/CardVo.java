package vo;

public class CardVo {
	
	int    c_idx;
	String c_title;
	String c_content;
	String c_isPublic;
	String c_regdate;
//¿Ü·¡Å°
	int    s_idx;
	int    m_idx;
//Getter/Setter	
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public String getC_isPublic() {
		return c_isPublic;
	}
	public void setC_isPublic(String c_isPublic) {
		this.c_isPublic = c_isPublic;
	}
	public String getC_regdate() {
		return c_regdate;
	}
	public void setC_regdate(String c_regdate) {
		this.c_regdate = c_regdate;
	}
	public int getS_idx() {
		return s_idx;
	}
	public void setS_idx(int s_idx) {
		this.s_idx = s_idx;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
}