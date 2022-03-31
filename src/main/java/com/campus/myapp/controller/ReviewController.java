package com.campus.myapp.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.campus.myapp.service.ClubMemberService;
import com.campus.myapp.service.ClubService;
import com.campus.myapp.service.ReviewService;
import com.campus.myapp.vo.ClubMemberVO;
import com.campus.myapp.vo.ClubVO;
import com.campus.myapp.vo.MemberVO;
import com.campus.myapp.vo.ReviewVO;

@RestController
public class ReviewController {
	
	@Inject
	ReviewService service;
	@Inject
	ClubService serviceC;
	@Inject
	ClubMemberService serviceCM;
	
	//reivew view
	@GetMapping("/main/club/{clubno}/review/{reivewno}")
	public ModelAndView review(@PathVariable("clubno") int clubno, @PathVariable("reivewno") int reviewno, HttpServletRequest requset ,HttpSession session ) {
		String userid = (String)session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
		
		
		
		try {
			ClubVO cvo = serviceC.clubSelectOne(clubno);
			ReviewVO rvo = service.reviewSelectOne(reviewno,clubno);
			
			if(rvo == null) {
				System.out.println("잘못된 접근");
				mav.setViewName("redirect:/main");
				return mav;
			}
			//클럽에 속한 멤버인지 검사
			if(serviceCM.clubMemberCheck(userid, rvo.getClubno()) == 0) {
				System.out.println(userid+"는 클럽에 속한 멤버가 아님");
				mav.setViewName("redirect:main");
				return mav;
			}
			System.out.println(userid+"는 클럽에 속한 멤버가 맞음");
			
			//클럽 관리자의 닉네임을 전달
			ClubMemberVO adminvo = serviceCM.clubMemberSelectOne(cvo.getClubadmin(),clubno);
			mav.addObject("clubadmin", adminvo.getUsername());
			
			//클럽의 관리자 권한			
			mav.addObject("cvo", cvo);
			mav.addObject("rvo", rvo);
			mav.setViewName("review/review");
		}
		catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/main");
		}
		
		return mav;
	}
	
	//review 폼 view
	@GetMapping("/main/club/{clubno}/review_form")
	public ModelAndView reviewForm(@PathVariable("clubno") int clubno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		ClubVO cvo = serviceC.clubSelectOne(clubno);
		mav.addObject("cvo", cvo);
		mav.setViewName("review/review_form");
		return mav;
	}
	
	
	// review 폼 ok
	@PostMapping("/main/review/reviewOk/{clubno}")
	public ResponseEntity<String> reviewForm(@PathVariable("clubno") int clubno, ReviewVO vo,HttpServletRequest request, HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		String username = (String)session.getAttribute("logName");
		String ip = request.getRemoteAddr();
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		String msg = "";
		vo.setUserid(userid);
		vo.setUsername(username);
		vo.setIp(ip);
		vo.setClubno(clubno);
		
		try {
			service.reviewInsert(vo);
			serviceC.clubUpdatePost(clubno);
			msg = getSuccessMessage("리뷰 작성완료",request.getContextPath()+"/main/club/"+clubno);
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			msg= getFailMessage("리뷰 작성 실패...");
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		}
		
		return entity;
	}
	//reivew 수정 view
	
	@GetMapping("/main/club/{clubno}/review/{reviewno}/edit")
	public ModelAndView reviewEdit(@PathVariable("clubno") int clubno, @PathVariable("reviewno") int reviewno ,HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
		ReviewVO rvo = service.reviewSelectOne(reviewno,clubno);
		
		if(!rvo.getUserid().equals(userid)) {
			mav.setViewName("redirect:/main/club/"+clubno+"/review");
		}
		ClubVO cvo = serviceC.clubSelectOne(clubno);
		mav.addObject("cvo", cvo);
		mav.addObject("rvo", rvo);
		
		mav.setViewName("review/review_edit");
		return mav;
		
	}
	
	//review 수정 ok
	@PostMapping("/main/review/editOk")
	public ResponseEntity<String> reviewEditOk(ReviewVO vo, HttpSession session, HttpServletRequest request){
		String userid = (String)session.getAttribute("logId");
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		String msg = "";
		
		try {
			vo.setUserid(userid);
			System.out.println("리뷰 결과 : "+ service.reviewUpdate(vo));
			
			msg =getSuccessMessage("리뷰 수정 완료.",request.getContextPath()+"/main/club/"+vo.getClubno()+"/review/"+vo.getNo());
			entity = new ResponseEntity<String>(msg,headers, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			msg = getFailMessage("리뷰 수정 실패");
			entity = new ResponseEntity<String>(msg,headers, HttpStatus.BAD_REQUEST);
		} 
		
		return entity;
	}
	
	//review 삭제
	@PostMapping("/main/review/deleteOk")
	public ResponseEntity<HashMap<String,String>> reviewDelte(int no, int clubno,  HttpServletRequest request){
		
		
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<>();
		
		try {
			service.reviewDelete(no);
			result.put("msg", "success");
			result.put("redirect", request.getContextPath()+"/main/club/"+clubno);
			result.put("status","200");
			serviceC.clubUpdatePost(clubno);
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			
		}catch(Exception e) {
			result.put("msg", "fail");
			result.put("redirect", request.getContextPath()+"/main/club/"+clubno+"/review/"+no);
			result.put("status","400");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
	
		//


		return entity;
	}
	//글 수정 메세지
			public String getSuccessMessage(String msg, String url) {
				String alert = "<script>";
				alert += "alert('"+msg+".\\n');";
				alert += "location.href='"+url+"';";
				alert += "</script> ";
			
				return alert;
			}
			public String getFailMessage(String msg) {
				String alert = "<script>";
				alert += "alert('"+msg+".\\n');";
				alert += "history.back();";
				alert += "</script> ";	
				return alert;
			}
}
