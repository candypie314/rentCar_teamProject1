package com.RentLoGo.management.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface MailController {

	void sendMail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException, ServletException;
}
