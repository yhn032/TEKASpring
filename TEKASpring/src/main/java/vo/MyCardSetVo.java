package vo;

public class MyCardSetVo {
	
	int mc_idx; //내 카드번호 PK
//외래키	
	int s_idx; //주제번호
	int m_idx; //학습자멤버번호
	int c_idx; //카드(게시글)번호
	
	public int getMc_idx() {
		return mc_idx;
	}
	public void setMc_idx(int mc_idx) {
		this.mc_idx = mc_idx;
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
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
}