package controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.StudyCardDao;
import vo.TekaMemberVo;
import vo.ViewVo;
import vo.WrongQnaVo;

@Controller
@RequestMapping("/studyCard/")
public class StudyCardController {

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	StudyCardDao studyCard_dao;

	public StudyCardController(StudyCardDao studyCard_dao) {
		super();
		this.studyCard_dao = studyCard_dao;
	}
	
	//메인 학습 페이지
	@RequestMapping("studyCardMain.do")
	public String studyCardMain(int c_idx, Model model) {
		
		List<ViewVo> list = studyCard_dao.selectCard(c_idx);
		
		model.addAttribute("list", list);
		
		return "studyCard/studyCardMain";
	}
	
	//즐겨찾기(wrongqna) 테이블에 질문 추가하기
	@RequestMapping("wrongQna.do")
	@ResponseBody
	public Map wrongQna(WrongQnaVo vo) {
		
		TekaMemberVo user = (TekaMemberVo) request.getSession().getAttribute("user");
		
		int m_idx = user.getM_idx();
		vo.setM_idx(m_idx);
		
		int res = studyCard_dao.insertWrongQnaCard(vo);
		
		Map map = new HashMap();
		if(res == 1) {//삽입에 성공했다면,,,
			map.put("res", true);
		}else {
			map.put("res", false);
		}
		
		return map;
	}
	
	//즐겨찾기(wrongqna) 테이블에 질문 삭제하기
	@RequestMapping("correctQna.do")
	@ResponseBody
	public Map CorrectQna(WrongQnaVo vo) {
		
		TekaMemberVo user = (TekaMemberVo) request.getSession().getAttribute("user");
		
		int m_idx = user.getM_idx();
		vo.setM_idx(m_idx);
		
		int res = studyCard_dao.deleteWrongQnaCard(vo);
		
		Map map = new HashMap();
		if(res == 1) {//삽입에 성공했다면,,,
			map.put("res", true);
		}else {
			map.put("res", false);
		}
		
		return map;
	}
	
	
	//즐겨찾기 초기화용 테이블의 q_idx모두 읽어오기
	@RequestMapping("checkWrong.do")
	@ResponseBody
	public Map checkWrong(WrongQnaVo vo) {
		Map map = new HashMap();
		
		List<Integer> wrongNum = studyCard_dao.selectWrongNumber(vo);

		if (wrongNum.size() > 0) {
			map.put("res", true);
			map.put("list", wrongNum);
		} else {
			map.put("res", false);
		}

		return map;
	}
	
	//학습하기
	@RequestMapping("studyCardLearn.do")
	public String studyCardLearn(Model model, int c_idx, String type) {
		TekaMemberVo user = (TekaMemberVo)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		List<ViewVo> list = studyCard_dao.selectCard(c_idx);
		
		model.addAttribute("list",list);
		model.addAttribute("type", type);
		return "studyCard/studyCardLearn";
	}
	
	//관심질문
	@RequestMapping("studyCardStar.do")
	public String studyCardStar(Model model, int c_idx, String type) {
		TekaMemberVo user = (TekaMemberVo)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		List<ViewVo> list = studyCard_dao.selectCard(c_idx);
		
		model.addAttribute("list",list);
		model.addAttribute("type", type);
		return "studyCard/studyCardStar";
	}
	
	//시험보기
	@RequestMapping("studyCardTest.do")
	public String studyCardTest(Model model, int c_idx, String type) {
		TekaMemberVo user = (TekaMemberVo)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		List<ViewVo> list = studyCard_dao.selectCard(c_idx);
		
		model.addAttribute("list",list);
		model.addAttribute("type", type);
		
		return "studyCard/studyCardTest";
	}
	
	//낱말카드
	@RequestMapping("studyCardWord.do")
	public String studyCardWord(Model model, int c_idx, String type, @RequestParam(value = "opt", required = false) String random) {
		TekaMemberVo user = (TekaMemberVo)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("reason", "sessionTimeout");
			return "redirect:../tekamember/loginForm.do";
		}
		
		List<ViewVo> list = null;
		
		if(random != null && !random.isEmpty()) {//순서를 섞으라는 명령이 들어왔다면,,,
			
			list = studyCard_dao.selectCard(c_idx);
			Collections.shuffle(list);
			
		}else {//아니면 일반 출력
			list = studyCard_dao.selectCard(c_idx);
		}
		
		model.addAttribute("list",list);
		model.addAttribute("type", type);
		return "studyCard/studyCardWord";
	}
	
	//김다정_20220713 : c_idx에 해당하는 전체 q_question 반환 (studyCardTest.jsp)
	@RequestMapping( value="selectQuestion.do", produces="text/json; charset=utf-8;" )
	@ResponseBody
	public String selectQuestion(int c_idx) {
		
		List<ViewVo> list = studyCard_dao.selectCard(c_idx);
		
		//문제의 정답 List
		List<String> q_question = new ArrayList<>();
		//문제의 오답 List
		List<String> shuffle     = new ArrayList<>();
		
		for(ViewVo vo : list) {

			q_question.add(vo.getQ_question());
			shuffle.add(vo.getQ_question());
		}

		//q_question의 요소 섞기
		Collections.shuffle(shuffle);
		
		//1번, 2번, 3번 보기를 담는 각 리스트 선언
		List<String> one = new ArrayList<>();
		List<String> two = new ArrayList<>();
		List<String> three = new ArrayList<>();
		
		
		for(int i=0; i<q_question.size(); i++) {
			
			one.add(q_question.get(i));
			two.add(shuffle.get(i));
			
			//순서 한 번 더 섞기
			Collections.shuffle(shuffle);
			three.add(shuffle.get(i));
		}
		
		//JSONArray  jsonArr = new JSONArray();
		JSONObject json    = new JSONObject();
		
		json.put("one", one);
		json.put("two", two);
		json.put("three", three);
		
		return json.toJSONString();
	}
	
}