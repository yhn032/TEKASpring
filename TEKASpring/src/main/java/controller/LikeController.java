package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.LikeDao;
import dao.ViewDao;
import vo.ViewVo;

@Controller
@RequestMapping("/card/")
public class LikeController {
	LikeDao like_dao;
	ViewDao view_dao;
	public LikeController(LikeDao like_dao, ViewDao view_dao) {
		super();
		this.like_dao = like_dao;
		this.view_dao = view_dao;
	}
	
	@RequestMapping("like.do")
	@ResponseBody
	public Map like(@RequestParam(required=false) int m_idx) {
		//좋아요가 0 이상인 c_idx 조회
		List<Integer> list = like_dao.checkLike(m_idx);
		
		Map map = new HashMap();
		map.put("list", list);
		
		return map;
	}

	@RequestMapping("cancelLike.do")
	public String cancelLike(ViewVo vo, @RequestParam(required=false, defaultValue="1")int page, Model model) {
		//좋아요 0으로 변경
		int res = like_dao.cancelLike(vo);
		
		model.addAttribute("page", page);
		return "redirect:../card/mainList.do";
	}
	
	@RequestMapping("insertLike.do")
	@ResponseBody
	public Map likeInsert(ViewVo vo) {
		ViewVo resVo = like_dao.selectLike(vo);
		if(resVo == null) {
			int res = view_dao.insertLiked(vo);
			resVo   = like_dao.selectLike(vo);
		}
		
		Map map = new HashMap();
		
		if(resVo.getL_like()==0) {
			int res = like_dao.insertLike(vo);
			map.put("result", true);
		}else if(resVo.getL_like()==1) {
			map.put("result", false);
		}
		
		return map;
	}
}