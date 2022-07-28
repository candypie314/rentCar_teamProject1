package com.RentLoGo.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

public interface MemberJoinCodeService {

	ResponseEntity<String> checkCode(String code, String randomCode);

	void createCode(HttpServletResponse response);
}
