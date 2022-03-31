package com.campus.myapp;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class HomeController {
	
	
	@GetMapping("/")
	public ModelAndView home(HttpSession session) {
		System.out.println("logstatus : " + session.getAttribute("logStatus"));
		System.out.println("logstatus : " + session.getAttribute("logId"));
		ModelAndView mav = new ModelAndView();
		
		if((String)session.getAttribute("logStatus") != null || (String)session.getAttribute("logId") != null) {
			mav.setViewName("redirect:main");
		}
		else
			mav.setViewName("home");
		return mav;
	}
	
}
