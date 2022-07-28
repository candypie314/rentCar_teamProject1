package com.RentLoGo.management.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.RentLoGo.management.model.MailService;
import com.RentLoGo.member.model.MemberDTO;

@Controller
@RequestMapping("/mail")
@EnableAsync
public class MailControllerImpl implements MailController {

	@Autowired
	private MailService mailService;
	
	@Override
	@RequestMapping("/sendMail.do")
	@ResponseBody
	public void sendMail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
		
		Cookie[] allCookies = request.getCookies();
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		String randomCode = "";
		for(int i = 0; i < allCookies.length; i++) {
			if(allCookies[i].getName().equals("randomCode")) {
				randomCode = allCookies[i].getValue();
			}
		}
		
		System.out.println("mailController >> randomCode >>>" + randomCode);
		
		StringBuffer sb = new StringBuffer();
		sb.append("<html><body>").
		append("<meta http-equiv='Content-Type' content='text/html'; charset=utf-8>").
		append("<h1>가입 인증 메일입니다.</h1>").
		append("<br/>").
		append("<h3 style='display: inline-block;'>인증 코드:&nbsp;&nbsp;&nbsp;</h3>").
		append("<b>"+ randomCode +"</b>").
		append("</body></html>");
		
		String str = sb.toString();
		
		mailService.sendMail(member.getMemberEmail(), "인증코드 발송메일", str);
		
		request.setAttribute("status", "verification");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/member/memberForm.do");
		dispatcher.forward(request, response);
	}
}
