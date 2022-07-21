package dao;

import java.util.List;

import vo.ViewVo;

public interface ViewDao {
	
	public ViewVo selectCIdx(String c_title);
	public List<ViewVo> qnaCardList(int c_idx);
	public String selectNickname(int c_idx);
	public int qnaInsert(ViewVo vo);
	public int cardInsert(ViewVo vo);
	public int insertLiked(ViewVo vo);
	public int myCardSetInsert(ViewVo vo);
	public List<ViewVo> previewList(int c_idx);
	public int cardUpdate(ViewVo vo);
	public List<Integer> qnaIdxNum(int c_idx);
	public int qnaUpdate(ViewVo vo);
}