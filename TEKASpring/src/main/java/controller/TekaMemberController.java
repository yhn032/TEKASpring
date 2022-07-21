package controller;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.Cipher;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	SocialValue googleSocial;
	
	JavaMailSender mailSenderNaver;
	JavaMailSender mailSenderGoogle;

	public TekaMemberController(TekaMemberDao member_dao, SocialValue naverSocial, SocialValue googleSocial, JavaMailSender mailSenderNaver, JavaMailSender mailSenderGoogle) {
		super();
		this.member_dao = member_dao;
		this.naverSocial = naverSocial;
		this.googleSocial = googleSocial;
		this.mailSenderNaver = mailSenderNaver;
		this.mailSenderGoogle = mailSenderGoogle;
	}
	
	//소셜 callback
	@RequestMapping(value="login/{service}/callback", method= {RequestMethod.GET, RequestMethod.POST})
	public String socialLoginCallback(@PathVariable String service, Model model, @RequestParam String code ) throws Exception {
		SocialValue social = null;
		if(service.equals("naver")) {
			social = naverSocial;
		}else {//다른 소셜 로그인 추가하는 경우 추가하자.
			social = googleSocial;
		}
		
		//사용자가 소셜 로그인을 성공하면 code를 받아오는데, 이 코드를 이용해서 액세스 토큰을 받아야 한다. 
		SocialLogin socialLogin = new SocialLogin(social);
		TekaMemberVo userprofile = socialLogin.getUserProfile(code);
		
		//이메일을 통해서 DB에 존재하는 이메일인지 확인하기.
		TekaMemberVo vo = member_dao.selectOneByEmail(userprofile.getM_email());
		
		if(vo == null) {//새로 사이트를 방문한 소셜 로그인 유저 (웹 서비스에서 사용할 닉네임을 입력받고 회원 가입 시킨다.)
			
			//소셜에 따라서 닉네임을 입력받고 DB에 저장한다.
			if(social.isNaver()) {//네이버 로그인 으로 접근 한 경우 
				model.addAttribute("m_naverId", userprofile.getM_naverId());
				model.addAttribute("m_email", userprofile.getM_email());
				model.addAttribute("service", "naver");
				
			}else if (social.isGoogle()) {//구글 로그인으로 접근하 경우
				model.addAttribute("m_googleId", userprofile.getM_googleId());
				model.addAttribute("m_email", userprofile.getM_email());
				model.addAttribute("service", "google");
			}
			
			return "redirect:../../socialSignUpForm.do";
			
		}else {//이미 가입한 소셜 로그인 유저. 세션에 값을 담아서 보낸다. 
			
			//등록된 이메일이 소셜로그인을 통한 이메일인지, 회원가입을 통한 이메일인지 확인한다.
			TekaMemberVo isSocial = null;
			if(social.isNaver()) {//네이버 로그인 으로 접근 한 경우 
				isSocial = member_dao.selectOneByNaver(userprofile.getM_naverId());
				
			}else if (social.isGoogle()) {//구글 로그인으로 접근하 경우
				isSocial = member_dao.selectOneByGoogle(userprofile.getM_googleId());
		
			}
			
			
			
			if(isSocial == null) {//그냥 일반 가입자인데, 소셜로그인으로 접근한 경우-> id/pwd찾게해야한다. 이메일 중복 불가
				model.addAttribute("reason", "social");
				return "redirect:../../../tekamember/loginForm.do";
				
			}else {//소셜로 로그인한 가입자이다. -> 바로 로그인
				session.setAttribute("user", vo);
				return "redirect:../../../card/mainList.do";
			}
			
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
			SocialLogin snsLogin1 = new SocialLogin(naverSocial);
			model.addAttribute("naverUrl", snsLogin1.getNaverAuthURL());
			
			//구글 소셜 로그인 
			model.addAttribute("googleUrl", "https://accounts.google.com/o/oauth2/v2/auth?client_id=198068799318-er96pvmv6huodj5lpvmkco7obqqsq8th.apps.googleusercontent.com&redirect_uri=http://localhost:9090/teka/tekamember/login/google/callback&response_type=code&scope=email%20profile%20openid");
			
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
					model.addAttribute("reason", "failPwd");
					return "redirect:loginForm.do";
				}
				
				//로그인 성공시 복호화한 사용자 정보를 세션에 저장
				session.setAttribute("user", user);
				
				if(url != null && !url.isEmpty()) {
					model.addAttribute("m_idx", user.getM_idx());
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
	
	//소셜 회원가입 폼
	@RequestMapping("socialSignUpForm.do")
	public String socialSignUpForm() {
		return "tekamember/socialSignUpForm";
	}
	
	//소셜 회원가입
	@RequestMapping("socialSignUp.do")
	public String socialSignUp(TekaMemberVo vo, String service) {
		//소셜 id, 닉네임, 이메일이 들어온다.
		// 삽입
		TekaMemberVo vo2 = null;
		if(service.equalsIgnoreCase("naver")) {
			vo.setM_id("naverUser");
			member_dao.insertSocialNaver(vo);
			vo2 = member_dao.selectOneByNaver(vo.getM_naverId());
		}else if(service.equalsIgnoreCase("google")) {
			vo.setM_id("googleUser");
			member_dao.insertSocialGoogle(vo);
			vo2 = member_dao.selectOneByGoogle(vo.getM_googleId());
		}
		
		session.setAttribute("user", vo2);
		
		// 로그인성공시키기
		return "redirect:../card/main.do";
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
	
	//비밀번호 찾기 
	@RequestMapping("findPWD.do")
	public String findPWD() {
		return "tekamember/findPwd";
	}
	
	//이메일 발송을 위한 정보 받기 -> 비밀번호 찾기는 일반 회원가입 사용자만이 가능하다.
	@RequestMapping("findAuth.do")
	@ResponseBody
	public Map findAuth(TekaMemberVo vo, Model model) {
		
		Map map = new HashMap();
		
		//사용자가 작성한 아이디를 기준으로 존재하는 사용자인지 확인한다.(id는 회원가입시 중복 체크를 했기 때문에 유니크하다.)
		TekaMemberVo isUser = member_dao.selectOneById(vo.getM_id());
		
		if(isUser != null) {//회원가입이 되어있는, 존재하는 사용자라면
			Random r = new Random();
			int num = r.nextInt(999999); //랜덤 난수 
			
			StringBuilder sb = new StringBuilder();
			// DB에 저장된 email            입력받은 email
			if(isUser.getM_email().equals(vo.getM_email())) {//이메일 정보 또한 동일하다면 
				String email = isUser.getM_email();
				String social = email.substring(email.indexOf('@')+1, email.indexOf('.'));
				System.out.println(social);
				String setFrom = "";
				if(social.equals("naver")) {
					setFrom = "ict04@naver.com";//발신자 이메일
				}else if(social.equals("gmail")) {
					setFrom = "kimbang990410@gmail.com";//발신자 이메일
				}
				
				System.out.println(setFrom);
				String title = "[TEKA] 비밀번호 변경 인증 이메일입니다.";
				sb.append(String.format("안녕하세요 %s님\n", isUser.getM_nickname()));
				sb.append(String.format("TEKA 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
				String content = sb.toString();
				
				try {
					
					if(social.equals("naver")) {
						
						MimeMessage msg = mailSenderNaver.createMimeMessage();
						MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
						
						msgHelper.setFrom(setFrom);
						msgHelper.setTo(email);
						msgHelper.setSubject(title);
						msgHelper.setText(content);
						
						//메일 전송
						mailSenderNaver.send(msg);
					}else if(social.equals("gmail")) {
						MimeMessage msg = mailSenderGoogle.createMimeMessage();
						MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
						
						msgHelper.setFrom(setFrom);
						msgHelper.setTo(email);
						msgHelper.setSubject(title);
						msgHelper.setText(content);
						
						//메일 전송
						mailSenderGoogle.send(msg);
						
					}
					
				}catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				
				//성공적으로 메일을 보낸 경우
				map.put("status", true);
				map.put("num", num);
				map.put("m_idx", isUser.getM_idx());
				return map;
				
			}else {//존재하지 않는 이메일인 경우 -> 가입되지 않은 사용자 -> 회원가입 할래?
				
				map.put("status", false);
				map.put("reason", "failEmail");
				
				return map;
				
			}
		}else {//가입되어 있지 않은 사용자 -> 아이디가 존재하지 않음
			map.put("status", false);
			map.put("reason", "failId");
			return map;
		}
		
	}
	
	//아이디 찾기 폼
	@RequestMapping("findID.do")
	public String FindID() {
		return "tekamember/findId";
	}
	
	//아이디를 찾기 위해 이메일로 회원조회하기
	@RequestMapping("checkEmailForId.do")
	public String checkEmailForId(String m_email, Model model) {
		
		TekaMemberVo user = member_dao.selectOneByEmail(m_email);
		
		if(user == null) {//존재하지 않는 사용자
			model.addAttribute("reason", "failEmail");
			return "redirect:findID.do";
		}else {//존재 하는 사용자
			String m_id = user.getM_id();
			
			if(m_id.equalsIgnoreCase("naverUser")) {//소셜 로그인 유저라면 아이디가 없음
				model.addAttribute("reason", "social");
				return "redirect:findID.do";
			}else if (m_id.equalsIgnoreCase("googleUser")) {
				model.addAttribute("reason", "social");
				return "redirect:findID.do";
			}
			
			model.addAttribute("m_id", m_id);
			return "tekamember/findIdResult";
		}
		
		
		
	}
	
	//비밀번호 찾기 결고 확인
	@RequestMapping("resPWD.do")
	public String resPWD(int m_idx, Model model) {
		
		TekaMemberVo user = member_dao.selectOneByIdx(m_idx);
		model.addAttribute("vo", user);
		
		return "tekamember/findPwdResult";
	}
	
	//비밀번호 변경 폼
	@RequestMapping("newPWD.do")
	public String newPWD(int m_idx, Model model) {
		
		TekaMemberVo user = member_dao.selectOneByIdx(m_idx);
		model.addAttribute("vo", user);
		
		return "tekamember/newPwd";
	}
	
	//비밀번호 변경하기
	@RequestMapping("updatePwd.do")
	public String updatePwd(TekaMemberVo vo) {
		int res = member_dao.updatePwd(vo);
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
	
	//관리자 페이지 이동
	@RequestMapping("register.do")
	public String registerPage(Model model) {
		
		List<TekaMemberVo> list = member_dao.selectRegister();
		model.addAttribute("list", list);
		
		return "tekamember/registerPage";
	}
	
	//회원 삭제
	@RequestMapping("memberDelete.do")
	public String memberDelete(Map map, int m_idx, int register_idx) {
		
		map.put("m_idx", m_idx);
		map.put("register_idx", register_idx);
		
		// 카드테이블 m_idx 변경
		int updateRes = member_dao.memberUpdate(map);
		// m_idx 삭제
		int delRes    = member_dao.memberDelete(m_idx); 
		
		return "redirect:register.do";
	}
	
}
