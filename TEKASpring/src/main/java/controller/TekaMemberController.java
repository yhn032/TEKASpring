package controller;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.teka.login.SocialLogin;
import com.ict.teka.login.SocialValue;

import dao.TekaMemberDao;
import vo.TekaMemberVo;

@Controller
@RequestMapping("/tekamember/")
public class TekaMemberController {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	TekaMemberDao member_dao;
	
	SocialValue naverSocial;

	public TekaMemberController(TekaMemberDao member_dao, SocialValue naverSocial) {
		super();
		this.member_dao = member_dao;
		this.naverSocial = naverSocial;
	}
	
	//소셜 callback
	@RequestMapping(value="login/{service}/callback", method= {RequestMethod.GET, RequestMethod.POST})
	public String socialLoginCallback(@PathVariable String service, Model model, @RequestParam String code ) throws Exception {
		SocialValue social = null;
		if(service.equals("naver")) {
			social = naverSocial;
		}else {//다른 소셜 로그인 추가하는 경우 추가하자.
			
		}
		
		//사용자가 소셜 로그인을 성공하면 code를 받아오는데, 이 코르들 이용해서 액세스 토큰을 받아야 한다. 
		SocialLogin socialLogin = new SocialLogin(social);
		TekaMemberVo userprofile = socialLogin.getUserProfile(code);
		
		//DB에 존재하는 이메일인지 확인하기.
		TekaMemberVo vo = member_dao.selectOneBySocial(userprofile.getM_naverId());
		if(vo == null) {//새로 사이트를 방문한 소셜 로그인 유저 
			//회원가입 폼으로 리다이렉트 시킨 후에 필요 정보만 받고 가입 시킨다.
			//리다이렉트 파라미터
			
			int res = member_dao.insertSocial(userprofile);
			TekaMemberVo vo2 = member_dao.selectOneBySocial(userprofile.getM_naverId());
			session.setAttribute("user", vo2);
			
			return "redirect:../../../card/mainList.do";
			
		}else {//이미 가입한 소셜 로그인 유저. 세션에 값을 담아서 보낸다. 
			
			session.setAttribute("user", vo);
			return "redirect:../../../card/mainList.do";
		}
		
	}
	
	//로그인 폼
	@RequestMapping("loginForm.do")
	public String loginForm(String url, Model model) {
		
		try {
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");	//키 쌍 생성 RSA알고리즘
			generator.initialize(1024);											//키 사이즈 1024
			KeyPair keyPair       = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey   = keyPair.getPublic(); //공유기
			PrivateKey privateKey = keyPair.getPrivate();//개인키
			
			session.setAttribute("RSA_WEB_KEY", privateKey);//개인키를 세션에 저장
			
			//공개키를 16진 문자열로 바꾸어 클라이언트에 전달하여 hidden
			RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			
			String publicKeyModulus    = publicSpec.getModulus().toString(16);
			String publicKeyExponenet  = publicSpec.getPublicExponent().toString(16);
			
			if(url != null && !url.isEmpty()) {
				request.setAttribute("url", url);
			}
			
			//네이버 소셜 로그인
			SocialLogin snsLogin = new SocialLogin(naverSocial);
			model.addAttribute("naverUrl", snsLogin.getNaverAuthURL());
			
			model.addAttribute("RSAModulus", publicKeyModulus);
			model.addAttribute("RSAExponent", publicKeyExponenet);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/tekamember/loginForm";
	}
	
	//로그인
	@RequestMapping("login.do")
	public String login(String encryptedID, String encryptedPWD, String url, Model model) {
		
		//세션에 저장한 개인키를 꺼낸다. 복호화 준비
		PrivateKey privateKey = (PrivateKey) session.getAttribute("RSA_WEB_KEY");
		
		//동일한 개인키로 중복 로그인하는 것을 방지하기 위해 값을 꺼내자마자 세션에서 삭제해버린다. 세션에 개인키가 쌓이는 것을 방지한다. 
		//로그인 시에는 항상 새로운 개인키를 이용하도록 강제한다.
		session.removeAttribute("RSA_WEB_KEY");
		
		if(privateKey == null) {
			
			throw new RuntimeException("암호화된 개인키를 찾을 수 없습니다. 새로고침을 해주세요.");
			
		}else {//개인키가 존재한다면
			
			try {
				//암호화된 데이터를 복호화 처리한다.
				String m_id  = decryptRSA(privateKey, encryptedID);
				String m_pwd = decryptRSA(privateKey, encryptedPWD);
				
				//복호화 처리된 계정 정보를 사용해서 로그인 검증을 시작한다. 
				TekaMemberVo user = member_dao.selectOneById(m_id);
				
				//id 체크
				if(user == null) {
					model.addAttribute("reason", "failId");
					return "redirect:loginForm.do";
				} //pwd체크
				
				if(!user.getM_pwd().equals(m_pwd)) {//아이디는 맞지만 비밀번호 오류
					model.addAttribute("reason", "failId");
					return "redirect:loginForm.do";
				}
				
				//로그인 성공시 복호화한 사용자 정보를 세션에 저장
				session.setAttribute("user", user);
				
				if(url != null && !url.isEmpty()) {
					return "redirect:"+url;
				}
				
				
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		//위의 조건에 걸리지 않고 정상적으로 성공했다면,,
		return "redirect:../card/mainList.do";
	}
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout() {
		session.removeAttribute("user");
		return "redirect:../card/mainList.do";
	}
	
	//회원가입 폼
	@RequestMapping("signUpForm.do")
	public String signUpForm() {
		return "tekamember/signUpForm";
	}
	
	//비동기 이메일 중복 체크
	@RequestMapping("checkEmail.do")
	@ResponseBody
	public Map checkEmail(String m_email) {
		
		TekaMemberVo vo = member_dao.selectOneByEmail(m_email);
		
		// 아이디 사용 유무 확인하기
		boolean bResult = false;
		if(vo==null) bResult = true;
		
		// json으로 변환할 map포장
		
		Map map = new HashMap();
		map.put("result", bResult);
		
		return map;
	}
	
	//비동기 아이디 중복 체크
	@RequestMapping("checkID.do")
	@ResponseBody
	public Map checkID(String m_id) {
		
		TekaMemberVo vo = member_dao.selectOneById(m_id);
		
		// 아이디 사용 유무 확인하기
		boolean bResult = false;
		if(vo==null) bResult = true;
		
		// json으로 변환할 map포장
		Map map = new HashMap();
		map.put("result", bResult);
		
		return map;
	}
	
	//비동기 아이디 중복 체크
	@RequestMapping("checkNickname.do")
	@ResponseBody
	public Map checkNickname(String m_nickname) {
		
		TekaMemberVo vo = member_dao.selectOneByNickname(m_nickname);
		
		// 아이디 사용 유무 확인하기
		boolean bResult = false;
		if(vo==null) bResult = true;
		
		// json으로 변환할 map포장
		Map map = new HashMap();
		map.put("result", bResult);
		
		return map;
	}
	
	//회원가입
	@RequestMapping("signUp.do")
	public String signUp(TekaMemberVo vo) {
		
		// 삽입
		member_dao.insertMember(vo);
		
		// 로그인 하도록 유도
		return "redirect:loginForm.do";
	}
	
	
	private String decryptRSA(PrivateKey privateKey, String m_id) {
		// TODO Auto-generated method stub
		String decryptedValue = "";
		try {
			Cipher cipher = Cipher.getInstance("RSA");
			
			byte[] encryptedBytes = hexToByteArray(m_id);
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("# 복호화 에러 발생 : " + e.getMessage());
		}
		return decryptedValue;
	}
	
	
	//16진 문자열을 다시 바이트 배열로 바꾸는 작업
	private byte[] hexToByteArray(String m_id) {
		// TODO Auto-generated method stub
		if(m_id == null || m_id.length()%2 != 0) {
			return new byte[] {};
		}
		
		byte[] bytes = new byte[m_id.length()/2];
		for(int i=0; i< m_id.length(); i+=2) {
			byte val = (byte) Integer.parseInt(m_id.substring(i, i+2), 16);
			bytes[(int) Math.floor(i/2)] = val;
		}
		
		return bytes;
	}
	
	
}
