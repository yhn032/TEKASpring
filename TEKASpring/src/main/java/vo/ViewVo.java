package vo;

public class ViewVo {
	//likey + subject
	int c_idx;
	int l_like;
	String c_title;
	String c_content;
	String c_isPublic;
	String s_name;
	String m_nickname;
	String c_regdate;
	
	//qna
	int q_idx;
	String q_question;
	String q_answer;
	String q_correct;
	int s_idx;
	int m_idx;
	
	//Ư�� ī���� qna����
	int c_qCnt;
	
	public int getC_qCnt() {
		return c_qCnt;
	}
	public void setC_qCnt(int c_qCnt) {
		this.c_qCnt = c_qCnt;
	}
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public int getL_like() {
		return l_like;
	}
	public void setL_like(int l_like) {
		this.l_like = l_like;
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
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getC_regdate() {
		return c_regdate;
	}
	public void setC_regdate(String c_regdate) {
		this.c_regdate = c_regdate;
	}
	public int getQ_idx() {
		return q_idx;
	}
	public void setQ_idx(int q_idx) {
		this.q_idx = q_idx;
	}
	public String getQ_question() {
		return q_question;
	}
	public void setQ_question(String q_question) {
		this.q_question = q_question;
	}
	public String getQ_answer() {
		return q_answer;
	}
	public void setQ_answer(String q_answer) {
		this.q_answer = q_answer;
	}
	public String getQ_correct() {
		return q_correct;
	}
	public void setQ_correct(String q_correct) {
		this.q_correct = q_correct;
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
