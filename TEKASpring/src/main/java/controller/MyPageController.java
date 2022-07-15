package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AttendDao;
import vo.AttendVo;

@Controller
@RequestMapping("/me/")
public class MyPageController {

	@Autowired
	HttpSession httpSession;

	AttendDao attend_dao;

	public MyPageController(AttendDao attend_dao) {
		super();
		this.attend_dao = attend_dao;
	}

	// 마이페이지로 이동하기
	@RequestMapping("mypage.do")
	public String mypage() {
		return "me/mypage";
	}

	// TODO: ajax 출석체크기능
	@RequestMapping("attend.do")
	@ResponseBody
	public int attend(AttendVo vo) {

		int res = attend_dao.insertAttend(vo);

		return res;
	}

	// ajax 달력내용 불러오기
	@RequestMapping("attendList.do")
	@ResponseBody
	public List<Map<String, String>> getAttendList(int m_idx) {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();

		// dao에서 날짜 가져오기
		List<AttendVo> attendList = attend_dao.selectAttendList(m_idx);

		// json으로 포장해서 리턴해야함 1~attendList.length {'title' : '출석', 'start' : '2022-07-14'}
		for (int i = 0; i < attendList.size(); i++) {
			map = new HashMap<String, String>();
			map.put("start", attendList.get(i).getAttend_date());
			map.put("title", "출석");
			list.add(map);
		}

		//System.out.println(list.toString());

		return list;

	}

}
