package com.RentLoGo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ViewNameInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String viewName = getViewName(request);
		request.setAttribute("viewName", viewName);
		System.out.println("interceptor viewName >>> " + viewName);
		return true;
	}
	
	private String getViewName(HttpServletRequest request) {
		
		String contextPath = request.getContextPath();
			String uri = request.getRequestURI();
		
//		System.out.println("contextPath >>> " + contextPath);
		
		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}
		
		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";"); // 요청 uri에 ';'가 있을 경우 ';'문자 위치를 구함
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?"); // 요청 uri에 '?'가 있을 경우 '?' 문자 위치를 구함
		} else {
			end = uri.length();
		}

		String viewName = uri.substring(begin, end);

		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf(".")); 
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.indexOf("/"), viewName.length()); 
		}

//		System.out.println("interceptor viewName >>> " + viewName);
		return viewName;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
