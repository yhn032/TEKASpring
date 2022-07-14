package controller;

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
	public Map<Integer, String> getAttendList(int m_idx) {

		// dao에서 날짜 가져오기
		List<AttendVo> attendList = attend_dao.selectAttendList(m_idx);
		Map<Integer, String> map = new HashMap<Integer, String>();
		
		// map에 날짜만 담아서 포장하기
		for (int i = 0; i < attendList.size(); i++) {
			map.put(i,attendList.get(i).getAttend_date());
			System.out.println(map.get(i));
		}
		
		return map;

	}

}
