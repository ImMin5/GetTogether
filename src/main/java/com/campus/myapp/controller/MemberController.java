package com.campus.myapp.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.tags.Param;

import com.campus.myapp.service.ClubMemberService;
import com.campus.myapp.service.ClubService;
import com.campus.myapp.service.MemberService;
import com.campus.myapp.service.ReviewService;
import com.campus.myapp.vo.ClubMemberVO;
import com.campus.myapp.vo.ClubVO;
import com.campus.myapp.vo.MemberVO;

@RestController
public class MemberController {
	@Inject
	MemberService service;
	@Inject
	ClubMemberService serviceCM;
	@Inject
	ClubService serviceC;
	@Inject
	ReviewService serviceR;
	
	//회원가입 view
	@GetMapping("/signup")
	public ModelAndView signup(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/signup");
		
		return mav;
	}
	
	//회원가입ok
	@PostMapping("/member/signupOk")
	public ResponseEntity<String> signupOk(MemberVO vo, HttpSession session){
		
		System.out.println(vo.getUserid());
		System.out.println(vo.getUsername());
		System.out.println(vo.getUserpassword());
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		String msg = "";
		
		try {
			service.memberInsert(vo);
			msg = getSuccessMessage("회원 가입이 완료 되었습니다.","/myapp/login");
			entity = new ResponseEntity<String>(msg,headers, HttpStatus.OK);
		
		}catch(Exception e) {
			msg = getFailMessage("회원 가입 실패.");
			entity = new ResponseEntity<String>(msg,headers, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//로그인 view
	@GetMapping("/login")
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/login");
		return mav;
	}
	
	//로그인 ok
	@PostMapping("/member/loginOk")
	public ModelAndView loginOk(MemberVO vo, HttpSession session){
		ModelAndView mav = new ModelAndView();
		vo = service.loginCheck(vo);
		
		if(vo != null) {
			session.setAttribute("logId", vo.getUserid());
			session.setAttribute("logName", vo.getUsername());
			session.setAttribute("logStatus", "Y");
			mav.setViewName("redirect:/main");
		}else{
			mav.setViewName("redirect:/login");
		}
		
		return mav;
	}
	
	//아이디 중복체크
	@PostMapping("/member/idCheck")
	@ResponseBody
	public String idCheck(String userid){
		System.out.println("id check : " + userid);
		int result = service.idCheck(userid);
		return Integer.toString(result);
	}
	//닉네임 중복체크
	@PostMapping("/member/usernameCheck")
	@ResponseBody
	public String usernameCheck(String username){
		System.out.println("id check : " + username);
		int result = service.usernameCheck(username);
		return Integer.toString(result);
	}
	
	//로그아웃
	@GetMapping("/member/logout")
	public ModelAndView logout(HttpSession session){
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	//마이페이지
	@GetMapping("/main/mypage")
	public ModelAndView mypage(HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
		MemberVO vo = service.memberSelectOne(userid);
		
		List<ClubMemberVO> clubList = serviceCM.clubMemberSelect(userid);
		
		
		mav.addObject("clist",clubList);
		mav.addObject("vo", vo);
		mav.setViewName("member/mypage");
		return mav;
	}
	
	
	//마이페이지 수정
	@PostMapping("/main/member/editOk")
	public ResponseEntity<String> memberEditOk(MemberVO mvo, String new_userpassword , HttpSession session, HttpServletRequest request){
		String userid = (String)session.getAttribute("logId");
		
		ResponseEntity<String> entity = null;
		String msg="";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		System.out.println("새로운 비밀번호 : " + new_userpassword);
		System.out.println("비밀번호 : " + mvo.getUserpassword());
	
		
		try {
			System.out.println("start !");
			MemberVO voOrigin = service.memberSelectOne(userid);
			System.out.println("userid : " + userid);
			System.out.println("voOrigin : " + voOrigin.getUserpassword());
			if(voOrigin.getUserpassword().equals(mvo.getUserpassword())) {
				if(new_userpassword != null && new_userpassword.length() > 0) {
					System.out.println("비밀번호 변경" + new_userpassword);
					mvo.setUserpassword(new_userpassword);
				}
				mvo.setUserid(userid);
				int count = service.memberUpdate(mvo);
				count += serviceR.reviewUpdateUsername(userid, mvo.getUsername());
				count += serviceCM.clubMemberUpdateUsername(userid,mvo.getUsername());
				count += serviceC.clubInviteUpdateUsername(userid, mvo.getUsername());
				session.setAttribute("logName", mvo.getUsername());
				System.out.println("변경된 데이터 수 : " + count);
				msg = getSuccessMessage("회원정보 변경 완료",request.getContextPath()+"/main/mypage");
				entity = new ResponseEntity<String>(msg,headers, HttpStatus.OK);
			}
			else {
				msg = getSuccessMessage("비밀번호가 일치하지 않습니다.",request.getContextPath()+"/main/mypage");
				entity = new ResponseEntity<String>(msg,headers, HttpStatus.OK);
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
			msg = getFailMessage("회원정보 변경 실패");
			entity = new ResponseEntity<String>(msg,headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//
	
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
