package com.RentLoGo.member.service;

import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.util.CookieGenerator;

@Service("codeService")
public class MemberJoinCodeServiceImpl implements MemberJoinCodeService {

	@Override
	public ResponseEntity<String> checkCode(String code, String randomCode) {

		String result = randomCode.equals(code) ? "true": "false"; 
		
		System.out.println("result >>> " + result);
		
		ResponseEntity<String> entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
	}

	@Override
	public void createCode(HttpServletResponse response) {

		String str = "0123456789!@#$%^&*";
		String randomCode = "";
		
		for(int i = 0; i < 6; i++) {
			Random random = new Random();
			int index = random.nextInt(18);
			randomCode += str.charAt(index);
		}
		
		CookieGenerator cookie = new CookieGenerator();
		cookie.setCookieMaxAge(180);
		cookie.setCookieName("randomCode");
		cookie.addCookie(response, randomCode);
		
		System.out.println("cookie >>> " + cookie);
		System.out.println("쿠키 생성 완료!!!!");
	}

}
