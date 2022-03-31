package com.campus.myapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends  HandlerInterceptorAdapter{
	
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception 
	{
		HttpSession session = request.getSession();
		
		String logStatus = (String)session.getAttribute("logStatus");
		
		if(logStatus != null && logStatus.equals("Y")) {
			return true;
		}
		else {
			response.sendRedirect(request.getContextPath());
			return false;
		}
				
	}
}
