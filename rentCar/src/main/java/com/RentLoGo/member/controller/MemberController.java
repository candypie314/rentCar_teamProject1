package com.RentLoGo.member.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.RentLoGo.member.model.MemberDTO;

public interface MemberController {
	
	String form(HttpServletRequest request);
	
	//인증코드 발송
	public String verify(MemberDTO dto, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException;
	public String reVerify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	//코드가 일치하는지 확인
	public ResponseEntity<String> checkCode(Map<String, Object> inputCode, HttpSession session, HttpServletRequest request);
	
	public String join(HttpSession session, RedirectAttributes redirect);
	
	//로그인
	public String login(HttpServletRequest request);
	public String login(HttpServletRequest request, MemberDTO member, RedirectAttributes rttr) throws Exception;
	
	//로그아웃
	public String logoutMainGET(HttpServletRequest request) throws Exception;
	
	//회원정보수정
	public String modifyForm(HttpServletRequest request);
	public String modify(MemberDTO member, RedirectAttributes redirect);
	
	//회원탈퇴
	public String deleteForm(HttpServletRequest request);
	public String delete(MemberDTO member, RedirectAttributes redirect);
	
	//회원조회(manage)
	public String select(HttpServletRequest request);
}
