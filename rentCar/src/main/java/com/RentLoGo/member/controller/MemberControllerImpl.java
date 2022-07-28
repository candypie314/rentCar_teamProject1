package com.RentLoGo.member.controller;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.RentLoGo.management.model.ManagerMemberService;
import com.RentLoGo.member.model.MemberDTO;
import com.RentLoGo.member.service.MemberJoinCodeService;
import com.RentLoGo.member.service.MemberService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/member")
public class MemberControllerImpl implements MemberController{

	@Autowired
	private MemberService memberService;
	@Autowired
	ManagerMemberService managerMemberService;
	@Autowired
	private MemberJoinCodeService codeService;
	
	@Override
	@RequestMapping("/memberForm.do")
	public String form(HttpServletRequest request) {
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}
	
	//인증완료 후 회원가입 마무리
	@Override
	@RequestMapping(value="/memberJoin.do", method=RequestMethod.GET)
	public String join(HttpSession session, RedirectAttributes redirect) {
		
		try {
			
			MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
			System.out.println("회원가입 member >>> " + member);
			memberService.memberJoin(member);
			redirect.addAttribute("joinResult", "finished");
			
			session.removeAttribute("memberInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/car/indexForm.do";
	}
	
	//로그인 화면
	@Override
	@RequestMapping("/login.do")
	public String login(HttpServletRequest request) {
		System.out.println("로그인 화면 >>>>>>>>>>>>>>");
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}
	
	//로그인
	@Override
	@RequestMapping(value="/memberLogin.do", method=RequestMethod.POST)
	public String login(HttpServletRequest request, MemberDTO member, RedirectAttributes rttr) throws Exception {
		
		System.out.println("member >>> " + member);
		
		HttpSession session = request.getSession();
		MemberDTO mto = null;
		mto = memberService.memberLogin(member);
		
		if(mto == null) {
			int result = 0;
			rttr.addFlashAttribute("result",result);
			System.out.println("로그인 실패 >>>>>>>>>>>>>>>> 비번 또는 아이디 틀림");
			return "redirect:/member/login.do";
		}
		
		if(mto.getMemberId().equals("admin")) {
			System.out.println("매니저 로그인 ~~~~");
			session.setAttribute("member", mto);
			return "redirect:/car/indexForm.do";
		}
		else {
			session.setAttribute("member", mto);
			System.out.println("회원 로그인 성공 ~~~~~");
			return "redirect:/car/indexForm.do";
		}

	}
	
	//로그아웃
	@Override
	@RequestMapping("/logout.do")
	public String logoutMainGET(HttpServletRequest request) throws Exception{
		
		System.out.println("logout 되었음 ~~~~~");
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return "redirect:/car/indexForm.do";

	}

	// 회원정보수정
	@Override
	@RequestMapping("/memberModifyForm.do")
	public String modifyForm(HttpServletRequest request) {
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}
	
	@Override
	@RequestMapping(value="/memberModify.do", method=RequestMethod.POST)
	public String modify(MemberDTO member, RedirectAttributes redirect) {
		
		try {
			memberService.memberModify(member);
			
			redirect.addAttribute("modifyResult", "finished");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/car/indexForm.do";
	}
	
	// 회원탈퇴
	@Override
	@RequestMapping("/memberDeleteForm.do")
	public String deleteForm(HttpServletRequest request) {
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}
	
	@Override
	@RequestMapping(value="/memberDelete.do", method=RequestMethod.POST)
	public String delete(MemberDTO member, RedirectAttributes redirect) {
		
		try {
			memberService.memberDelete(member);
			
			redirect.addAttribute("deleteResult", "finished");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/car/indexForm.do";
	}
	
	//회원목록조회페이지(manage)
	@Override
	@RequestMapping("/manage.do")
	public String select(HttpServletRequest request) {
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		List<MemberDTO> list =	memberService.selectAllMember();
		request.setAttribute("list", list);
		
		return viewName;
	}

	@Override
	@RequestMapping(value="/verify.do", method=RequestMethod.POST)
	public String verify(MemberDTO dto, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		
		codeService.createCode(response);
		session.setAttribute("memberInfo", dto);
		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/mail/sendMail.do");
//		dispatcher.forward(request, response);
//		return null;
		return "redirect:/mail/sendMail.do";
	}

	//인증번호 재요청
	@Override
	@RequestMapping(value="/resendCode.do", method=RequestMethod.POST)
	public String reVerify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		codeService.createCode(response);
		
		return "redirect:/mail/sendMail.do";
	}

	//인증번호 비교
	@Override
	@RequestMapping(value="/checkCode.do", method=RequestMethod.POST)
	public ResponseEntity<String> checkCode(@RequestBody Map<String, Object> inputCode, HttpSession session, HttpServletRequest request) {

		Cookie[] allCookies = request.getCookies();
		
		String randomCode = "";
		for(int i = 0; i < allCookies.length; i++) {
			if(allCookies[i].getName().equals("randomCode")) {
				randomCode = allCookies[i].getValue();
			}
		}
		
		System.out.println("code >>> " + inputCode.get("code"));
		String code = (String) inputCode.get("code");
		ResponseEntity<String> result = codeService.checkCode(code, randomCode);
		
		System.out.println("controller >>> result >>> " + result);
		return result;
	}

	// 카카오 인가코드 받기
	@RequestMapping("/kakaoAuth.do")
	@ResponseBody
	public String getKakaoAuth() { 
	
		String url = "https://kauth.kakao.com/oauth/authorize?client_id=d9c1879529faae92016aee6cc169aea3&redirect_uri=http://localhost:8080/rentCar/member/auth_kakao.do&response_type=code";
		return url;
	}
	
	// 카카오 연동정보 조회
	@RequestMapping("/auth_kakao.do")
	public void authKakao(@RequestParam(value = "code", required = false) String code, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ObjectMapper mapper = new ObjectMapper();
		
		String accessToken = getAccessToken(code);
		HashMap<String, Object> userInfo = getUserInfo(accessToken);

//		try {
//			String kakaoInfo = mapper.writeValueAsString(userInfo); // userInfo 맵을 json형식으로 직렬화
//			request.setAttribute("userInfo", kakaoInfo); // json 문자열 바인딩
//			System.out.println("auth userInfo >>>> " + kakaoInfo);
//		} catch (JsonProcessingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		request.setAttribute("userInfo", userInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/member/kakaoLogin.do");
		dispatcher.forward(request, response);
	}

	// accessToken으로 유저 정보 받아오기
	private HashMap<String, Object> getUserInfo(String accessToken) {

		String requestURL = "https://kapi.kakao.com/v2/user/me";
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		
		try {
			URL url = new URL(requestURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			
			// header 정보 설정
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			
			int responseCode = conn.getResponseCode();
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuffer sb = new StringBuffer();
			
			String line = "";
			
			while((line = br.readLine()) != null) {
				sb.append(line);
			}
			ObjectMapper mapper = new ObjectMapper(); 
			Map<String, Object> map = mapper.readValue(sb.toString(), HashMap.class);
			System.out.println("userinfo >> map >>> " + map);
			
			String id = String.valueOf(map.get("id"));
			String nickname = (String) ((HashMap<String, Object>)map.get("properties")).get("nickname");
			String email = (String) ((HashMap<String, Object>)map.get("kakao_account")).get("email");
			userInfo.put("id", id);
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			
			br.close();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userInfo;
	}

	//토큰 받기
	private String getAccessToken(String code) {

		String accessToken = "";
		String requestUrl = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(requestUrl); // url 객체 얻기
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // connection 객체 얻기
			conn.setRequestMethod("POST"); // 서버에 요청 방식 설정
			conn.setDoOutput(true); // 서버에 데이터를 보내기 위해 true로 설정
			
			PrintWriter pw = new PrintWriter(new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))); // 출력 스트림 가져오기
			StringBuffer sb = new StringBuffer();
			sb.append("grant_type=authorization_code"); // 요청 파라미터 설정
			sb.append("&client_id=d9c1879529faae92016aee6cc169aea3");
			sb.append("&redirect_uri=http://localhost:8080/rentCar/member/auth_kakao.do");
			sb.append("&code=" + code);
			
			pw.print(((sb.toString())));
			pw.flush();
			sb.delete(0, sb.length());
			
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			
			// 요청으로 얻은 JSON타입의 Response 메시지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			ObjectMapper mapper = new ObjectMapper(); 
			Map<String, Object> mapCode = mapper.readValue(sb.toString(), HashMap.class);
			
			accessToken = (String) mapCode.get("access_token");
			
			System.out.println("accessToken >>> " + accessToken);
			
			br.close();
			pw.close();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return accessToken;
	}
	
	// 카카오 로그인 시 회원등록 돼있으면 로그인 진행
	// 없으면 회원가입 진행
	@RequestMapping("/kakaoLogin.do")
	public void kakaoLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HashMap<String, Object> userInfo = (HashMap<String, Object>) request.getAttribute("userInfo");
		String memberId = (String) userInfo.get("id");
		String memberName = (String) userInfo.get("nickname");
		String memberEmail = (String) userInfo.get("email");
				
		MemberDTO dto = new MemberDTO();
		dto.setMemberId(memberId);
		dto.setMemberName(memberName);
		dto.setMemberEmail(memberEmail);
		dto.setMemberPw("kakao");
		dto.setMemberClass("1");
		dto.setMemberBirth("");
		dto.setMemberPhone("");
		
		System.out.println("dto >>>> " + dto);
		
		List<MemberDTO> list = managerMemberService.searchIdName(dto); // 아이디로 회원 목록 조회
		
		HttpSession session = request.getSession();
		
		if(list.size() == 0) { // 아이디 조회 후 회원이 아니라면 회원가입 진행
			System.out.println("회원가입 진행 >>> ");
			session.setAttribute("memberInfo", dto);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/member/memberJoin.do");
			dispatcher.forward(request, response);
		}else {
			MemberDTO member = memberService.memberLogin(dto);
			
			session.setAttribute("member", member);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/car/indexForm.do");
			dispatcher.forward(request, response);
		}
		
	}
	
}
