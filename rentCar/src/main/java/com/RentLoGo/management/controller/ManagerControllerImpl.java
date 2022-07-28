package com.RentLoGo.management.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager")
public class ManagerControllerImpl implements ManagerController {

	@Override
	@RequestMapping("/*Form.do")
	public String managerForm(HttpServletRequest request) {
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}

}
