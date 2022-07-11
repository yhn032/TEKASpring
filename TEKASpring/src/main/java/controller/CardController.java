package controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CardDao;
import dao.LikeyDao;
import dao.ViewDao;
import vo.MyCardSetVo;
import vo.TekaMemberVo;
import vo.ViewVo;


@Controller
@RequestMapping("/card/")
public class CardController {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	CardDao card_dao;
	
	ViewDao view_dao;
	
	LikeyDao likey_dao;

	public CardController(CardDao card_dao, ViewDao view_dao, LikeyDao likey_dao) {
		super();
		this.card_dao = card_dao;
		this.view_dao = view_dao;
		this.likey_dao = likey_dao;
	}
	
	//메인 페이지 호출
	@RequestMapping("main.do")
	public String main() {
		return "card/quiztisMain";
	}
	
	String sub;
	//모든 학습세트 보기
	@RequestMapping("mainList.do")
	public String mainList(String subject, String order, Model model) {
		// url 종류
		// http://localhost:9090/TEKA/card/list.do
		// http://localhost:9090/TEKA/card/list.do?subject=
		// http://localhost:9090/TEKA/card/list.do?subject=?&order=?

		if (subject != null && !subject.isEmpty()) {// 특정 주제를 원하는 경우에는 특정 주제에 부합하는 내용만을 읽어오기

			// 주제 리스트 가져오기
			List<ViewVo> list = getSubjectList(subject);
			
			// 필터가 있으면 정렬
			if (order != null && !order.isEmpty()) {
				Collections.sort(list, new ViewVoComp(order));
			}

			// 리퀘스트 바인딩
			model.addAttribute("list", list);
			model.addAttribute("subject", sub);
			
			return "card/mainList";

		} else { // 주제가 없으면 전체 리스트 보기

			// 전체 리스트 가져오기
			List<ViewVo> list = card_dao.selectList();
			
			// 필터가 있으면 정렬
			if (order != null && !order.isEmpty()) {
				Collections.sort(list, new ViewVoComp(order));
			}
			
			// 리퀘스트 바인딩
			model.addAttribute("list", list);
			
			return "card/mainList";
		}
	}
	
	
	//테스트 페이지 호출
	@RequestMapping("test.do")
	public String test() {
		return "card/test";
	}
	
	//나의 학습 세트 이동하기
	@RequestMapping("myCardList.do")
	public String myCardList(Model model) {
		TekaMemberVo user = (TekaMemberVo) session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		//나의 학습세트에 추가한 카드 불러오기
		List<ViewVo> list = card_dao.selectMyCardList(user.getM_idx());
		
		model.addAttribute("list", list);
		
		return "card/myCardList";
	}
	
	//팝업 내용 불러오기
	@RequestMapping("popup.do")
	@ResponseBody
	public Map popup(int c_idx) {
		List<ViewVo> previewList = null;
		
		//previewPopup 전체 조회
		previewList = view_dao.previewList();
		
		JSONObject json = new JSONObject();
		Map map = new HashMap();
		
		//결과저장 : c_idx에 해당하는 질문/답변
		List<String> question = new ArrayList<>();
		List<String> answer   = new ArrayList<>();
		

		for(ViewVo res : previewList) {
			
			//파라미터로 들어온 c_idx와 전체리스트의 c_idx가 일치할 때만 list에 추가
			if(c_idx==res.getC_idx()) {

				question.add(res.getQ_question());
				answer.add(res.getQ_answer());
			}
		}
		
		//응답할 데이터 저장
		map.put("question", question);
		map.put("answer", answer);
		
		//m_nickname 구하기
		previewList = view_dao.previewSelectThree(c_idx);
		
		//굳이 반복을 돌려야 하는가?
		for(ViewVo vo : previewList) {
			
			String c_title    = vo.getC_title();
			String c_content  = vo.getC_content();
			String m_nickname = vo.getM_nickname();
			
			map.put("c_title", c_title);
			map.put("c_content", c_content);
			map.put("m_nickname", m_nickname);
			//조회는 카드개수만큼 되지만, 위 데이터들은 1개씩만 필요하므로 1회 반복 후 강제탈출
			break;
		}
		
		return map;
	}
	
	@RequestMapping("cardSearch.do")
	public String cardSearch(Model model, String selectSearch, @RequestParam(required = false) String text) {
		//요청 url : /card/cardSearch.do?selectSearch=all&text=
		//          /card/cardSearch.do?selectSearch=c_title&text=길동
		
		
		//selectSearch가 null / 비어있으면 검색필터 = 전체
		if(selectSearch==null || selectSearch.isEmpty()) {
			selectSearch = "all";
		}
		
		List<ViewVo> searchList = null;
		
		Map map = new HashMap();
		
		//전체검색이 아닌 경우 검색조건
		if(!selectSearch.equals("all")) {
			
			if(selectSearch.equals("c_title")) {
				
				map.put("c_title", text);	
			
			}else if(selectSearch.equals("c_content")) {
				
				map.put("c_content", text);
			
			}else if(selectSearch.equals("m_nickname")) {
				
				map.put("m_nickname", text);	
			}
		}else {
			
			//전체카드 조회??
			searchList = card_dao.selectList();
		}
		
		searchList = card_dao.cardCondition(map);
		
		model.addAttribute("list", searchList);
		
		return "card/mainList";
	}
	
	@RequestMapping("insertCard.do")
	public String insertCard(ViewVo vo, @RequestParam("q_question") String[] q_questionStrArray,@RequestParam("q_answer") String[] q_answerStrArray) {
		//카드 질문갯수
		int c_qCnt = q_questionStrArray.length;
		//vo포장
		vo.setC_qCnt(c_qCnt);
		
		//카드 추가하기
		int cardRes = view_dao.cardInsert(vo);
		
		//c_title로 c_idx 얻어오기
		ViewVo c_idxVo = view_dao.selectCIdx(vo.getC_title());
		
		int c_idx = c_idxVo.getC_idx();
		
		//얻은 c_idx를 다시 vo에 포장
		vo.setC_idx(c_idx);
		
		//m_idx, c_idx에 해당하는 좋아요 수 insert
		int insertLiked = view_dao.insertLiked(vo);
		//내 학습세트에 추가하기
		int myCardSetRes = view_dao.myCardSetInsert(vo);
		
		//질문 추가하기
		for(int i=0; i<q_questionStrArray.length; i++) {
				
			vo.setQ_question(q_questionStrArray[i]);
			vo.setQ_answer(q_answerStrArray[i]);
			
			int Qnares = view_dao.qnaInsert(vo);
		}//for end
		
		return "redirect:myCardList.do";
	}
	
	@RequestMapping("insertCardForm.do")
	public String insertCardForm() {
		return "card/insertCard";
	}
	
	
	@RequestMapping("likeCheck.do")
	@ResponseBody
	public Map likeCheck(@RequestParam(required = false) int m_idx) {

		
		//l_likey>0인 컬럼만 list에 추가됨
		List<ViewVo> list = likey_dao.likeCheck(m_idx);
		
		Map map = new HashMap();
		map.put("liked", true);
		
		List<Integer> likedList = new ArrayList<>();
		
		for(ViewVo vo : list) {
			
			likedList.add(vo.getC_idx());
		}//for end

		map.put("likedList", likedList);
		
		return map;
	}
	@RequestMapping("deleteLiked.do")
	@ResponseBody
	public Map deleteLiked(ViewVo vo) {
		
		//좋아요한 항목 다시 0으로 변경
		int res = likey_dao.deleteLike(vo);
	
		JSONObject json = new JSONObject();
		Map map = new HashMap();
		//delete명령이 정상적으로 수행되었다면 처리된 행수 1반환
		map.put("result", 1);
		
		//현재 좋아요 수 구하기
		ViewVo resVo = likey_dao.selectLike(vo);
		
		map.put("currLike", resVo.getL_like());
		
		return map;
	}
	@RequestMapping("likeInsert.do")
	@ResponseBody
	public Map likeInsert(ViewVo vo) {
		
		JSONObject json = new JSONObject();
		Map map = new HashMap();
		
		//DB에 좋아요+1 하기 전, l_like의 값 조회
		ViewVo resVo = likey_dao.selectLike(vo);
		
		if(resVo == null) {
			int insertLiked = view_dao.insertLiked(vo);
			resVo = likey_dao.selectLike(vo);
		}
		
		//l_like가 0인 경우 좋아요+1 DB insert 
		if(resVo.getL_like()==0) {
			
			//DB insert
			int res = likey_dao.liked(vo);
			//결과 저장 -> 1 반환
			map.put("res", 1);
		
		//이미 좋아요를 눌렀다면, 0 반환
		}else if(resVo.getL_like()==1) {
			map.put("already", 0);
		}
		
		return map;
	}
	
	@RequestMapping("myCardDelete.do")
	@ResponseBody
	public Map myCardDelete(MyCardSetVo vo, Model model) {
		TekaMemberVo user = (TekaMemberVo) session.getAttribute("user");
		
		int m_idx = user.getM_idx();
		vo.setM_idx(m_idx);
		
		int res = card_dao.deleteMyCard(vo);
		
		Map map = new HashMap();
		if(res == 0) {
			map.put("result", false);
		}else {
			map.put("result", true);
		}
		
		return map;
	}
	
	@RequestMapping("myCardInsert.do")
	public String myCardInsert(Model model, MyCardSetVo vo) {
		TekaMemberVo user = (TekaMemberVo) session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		//삽입할 데이터 포장하기
		int m_idx = user.getM_idx();
		vo.setM_idx(m_idx);
		
		//카드의 추가여부를 보는 것이 아니라 -> 특정 회원에 대해서 특정 카드가 추가 되었는지를 확인해야 한다.
		MyCardSetVo vo1 = card_dao.selectCheckMyCard(vo);
		if(vo1 != null) {//값이 있다면, 있다고 알려주기
			model.addAttribute("reason", "exist");
			return "redirect:mainList.do";
		}else {
			
			int res = card_dao.insertMyCard(vo);
			model.addAttribute("reason", "success");
			return "redirect:mainList.do";
		}
		
	}
	
	// 주제 리스트를 가져오는 메서드
	private List<ViewVo> getSubjectList(String subject) {

		switch (subject) {
		case "os":
			sub = "운영체제";
			break;
		case "network":
			sub = "네트워크";
			break;
		case "algorithm":
			sub = "알고리즘";
			break;
		case "datastructure":
			sub = "자료구조";
			break;
		case "java":
			sub = "자바";
			break;
		case "spring":
			sub = "스프링";
			break;
		}

		List<ViewVo> list = card_dao.selectBySubject(sub);
		return list;

	}
	
	// 필터 리스트를 정렬하는 내부 클래스
	class ViewVoComp implements Comparator<ViewVo> {
		String order;

		public ViewVoComp(String order) {
			super();
			this.order = order;
		}

		@Override
		public int compare(ViewVo o1, ViewVo o2) {
			int ret = 0;

			if(order.equals("oldest")) {
				if (o1.getC_regdate().compareTo(o2.getC_regdate()) > 0) {
					ret = 1;
				} else if (o1.getC_regdate().compareTo(o2.getC_regdate()) < 0) {
					ret = -1;
				}
			} else if(order.equals("mostLiked")) {
				if (o1.getL_like() > o2.getL_like()) {
					ret = 1;
				} else if (o1.getL_like() < o2.getL_like()) {
					ret = -1;
				}
			} else if(order.equals("newest")) {
				if (o1.getC_regdate().compareTo(o2.getC_regdate()) < 0) {
					ret = 1;
				} else if (o1.getC_regdate().compareTo(o2.getC_regdate()) > 0) {
					ret = -1;
				}
			}
			return ret;
		}

		
	}
	
	
}
