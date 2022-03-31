package com.campus.myapp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.campus.myapp.service.ClubMemberService;
import com.campus.myapp.service.ClubService;
import com.campus.myapp.service.MemberService;
import com.campus.myapp.service.ReviewService;
import com.campus.myapp.vo.ClubInviteVO;
import com.campus.myapp.vo.ClubMemberVO;
import com.campus.myapp.vo.ClubVO;
import com.campus.myapp.vo.MemberVO;
import com.campus.myapp.vo.ReviewVO;

@RestController
public class ClubController {
	
	@Inject
	ClubService service;
	@Inject
	ClubMemberService serviceCM;
	@Inject
	MemberService serviceM;
	@Inject
	ReviewService serviceR;
	
	private String defaultThumbnail = "thumbnail_01.jpg";
	
	//로그인후의 main 페이지 view
	@GetMapping("/main")
	public ModelAndView main(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		
		//userid가 소속된 클럽을 구하는 과정
		List<ClubVO> clubList = service.clubSelect(userid);
		
		//공개된 클럽의 목록을 구하는 과정
		List<ClubVO> clubListPublic = service.clubSelectPublic(true,userid);
		System.out.println("소속된 클럽 수 결과: "+ clubList.size());
		mav.addObject("clublist", clubList);
		mav.addObject("clublistPublic",clubListPublic);
		mav.setViewName("main");
		return mav;
	}
	
	//클럽 생성 view
	@GetMapping("/main/club/clubForm")
	public ModelAndView clubForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/club/clubForm");
		return mav;
	}
	
	//클럽 생성 ok
	@PostMapping("/main/club/clubFormOk")
	public ResponseEntity<String> clubFormOk(ClubVO vo, HttpSession session, HttpServletRequest request){
		String userid = (String)session.getAttribute("logId");
		String username = (String)session.getAttribute("logName");
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		String msg = "";
		
		try {
			if(vo.getClubthumbnail() == null || vo.getClubthumbnail().equals("")) vo.setClubthumbnail(defaultThumbnail);
			//클럽 생성
			vo.setClubadmin(userid);
			System.out.println("club insert : " + service.clubInsert(vo));
			
			// 생성된 클럽의 정보를 받아옴 -> clubno를 알기 위해서
			vo = service.clubSelectAdmin(userid, vo.getClubid());
			
			//그룹 맴버 생성
			ClubMemberVO cvo = new ClubMemberVO();
			cvo.setClubno(vo.getNo());
			cvo.setClubid(vo.getClubid());
			cvo.setUserid(userid);
			cvo.setUsername(username);
			serviceCM.clubMemberInsert(cvo);
			
			//그룹페이지로 이동
			msg = getSuccessMessage("그룹 생성 성공",request.getContextPath()+"/main/club/"+vo.getNo()); 
			entity = new ResponseEntity<String>(msg,headers,HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//클럽 view
	@GetMapping("/main/club/{clubno}")
	public ModelAndView club(@PathVariable("clubno") int clubno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		
		//접속한 사람이 클럽의 회원인지 판별한다.
		ClubVO vo = service.clubSelectMember(userid,clubno);
		List<ReviewVO> rvo = serviceR.reviewSelect(clubno);
		
		if(vo != null) {
			//클럽의 정보를 웹페이지에 전달.
			System.out.println("clubdi : " + vo.getClubid());

			
			//클럽 관리자의 닉네임을 전달
			System.out.println(vo.getClubadmin());
			MemberVO adminvo = serviceM.memberSelectOne(vo.getClubadmin());
			mav.addObject("clubadmin", adminvo.getUsername());
			mav.addObject("rvo", rvo);
			
			//클럽의 관리자 권한
			if(vo.getClubadmin().equals(userid)) 
				mav.addObject("adminStatus","Y");
			else
				mav.addObject("adminStatus","N");
			mav.addObject("cvo", vo);
			mav.setViewName("club/club");
		}
		else {
			mav.setViewName("redirect:/main");
		}
		
		
		return mav;
	}
	
	//클럽 지도 view
	@GetMapping("/main/club_map/{clubno}")
	public ModelAndView clubMap(@PathVariable("clubno") int clubno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		
		//접속한 사람이 클럽의 회원인지 판별한다.
		ClubVO vo = service.clubSelectMember(userid,clubno);
		List<ReviewVO> rvo = serviceR.reviewSelect(clubno);
		
		if(vo != null) {
			//클럽의 정보를 웹페이지에 전달.
			System.out.println("clubdi : " + vo.getClubid());

			
			//클럽 관리자의 닉네임을 전달
			System.out.println(vo.getClubadmin());
			MemberVO adminvo = serviceM.memberSelectOne(vo.getClubadmin());
			mav.addObject("clubadmin", adminvo.getUsername());
			mav.addObject("rvo", rvo);
			//클럽의 관리자 권한
			if(vo.getClubadmin().equals(userid)) 
				mav.addObject("adminStatus","Y");
			else
				mav.addObject("adminStatus","N");
			mav.addObject("cvo", vo);
			mav.setViewName("club/club_map");
		}
		else {
			mav.setViewName("redirect:/main");
		}
		
		
		return mav;
	}
	
	//클럽 관리자 view
	@GetMapping("/main/club/{clubno}/admin")
	public ModelAndView clubAdmin(@PathVariable("clubno") int clubno, HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
		
		ClubVO cvo = service.clubSelectOne(clubno);
		
		if(userid.equals(cvo.getClubadmin())){
			//관리자 닉네임
			MemberVO adminvo = serviceM.memberSelectOne(cvo.getClubadmin());
			mav.addObject("clubadmin", adminvo.getUsername());
			//클럽멤버
			List<ClubMemberVO> clubMemberList = serviceCM.clubMemberSelectAll(clubno);
			//클럽의 리뷰
			List<ReviewVO> reviewList = serviceR.reviewSelect(clubno);
			//초대한 멤버
			List<ClubInviteVO> inviteList = service.clubInviteSelectIsInvite(clubno,true);
			//가입 요청한 멤버
			List<ClubInviteVO> submitList = service.clubInviteSelectIsInvite(clubno,false);
			
			mav.addObject("submitlist", submitList);
			mav.addObject("invitelist", inviteList);
			mav.addObject("reviewlist", reviewList);
			mav.addObject("clubmemberlist", clubMemberList);
			mav.addObject("cvo", cvo);
			mav.setViewName("club/club_admin");
		}
		else {
			mav.setViewName("redirect:/main/club/"+clubno);
		}
		return mav;
	}
	
	//클럽 가입 요청 
	@PostMapping("/main/club/submit")
	public ResponseEntity<HashMap<String, String>> clubSubmit(int clubno , HttpSession session, HttpServletRequest request){
		String userid = (String)session.getAttribute("logId");
		String username = (String)session.getAttribute("logName");
		ResponseEntity<HashMap<String, String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		try {
			
			int count = serviceCM.clubMemberCheck(userid, clubno);
			ClubInviteVO invo = service.clubInviteSelect(userid, clubno);
			System.out.println("가입 요청 결과 :" + invo);
			System.out.println("클럽에 가입 : " + count);
			
			
			//해당 클럽에 가입하지 않은 멤버일때 
			if(count == 0) {
				//가입신청 처음인 사람 + 거절당하거나 클럽에 한번 가입한적 있는 사람
				if(invo == null || invo.getComplete() > 0 ) {
					ClubVO cvo = service.clubSelectOne(clubno);
					invo = new ClubInviteVO();	
					invo.setUserid(userid);
					invo.setUsername(username);
					invo.setClubno(cvo.getNo());
					invo.setClubid(cvo.getClubid());
					service.clubInsertInvite(invo);
					
					result.put("msg", "가입 신청 완료!");
					result.put("status","200");
				}
				else if(invo.getComplete() == 0) {
					result.put("msg", "이미 가입 신청한 클럽입니다. 잠시만 기다려 주세요!");
					result.put("status", "200");
				}
			
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
			}
			else {
				result.put("msg", "이미 가입한 클럽입니다.");
				result.put("status","200");
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "가입 신청 실패");
			result.put("status","400");
			entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//클럽 초대 요청
	@PostMapping("/main/club/invite")
	public ResponseEntity<HashMap<String, String>> clubInvite(String userid, int clubno , HttpSession session, HttpServletRequest request){
		String username = (String)session.getAttribute("logName");
		ResponseEntity<HashMap<String, String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			
			int count = serviceCM.clubMemberCheck(userid, clubno);
			ClubInviteVO invo = service.clubInviteSelect(userid, clubno);
			System.out.println("가입 요청 결과 :" + invo);
			System.out.println("클럽에 가입 : " + count);
			
			if(serviceM.memberSelectOne(userid) == null) {
				result.put("msg", "존재하지 않는 아이디 입니다.");
				result.put("status", "200");
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
			}
			else if(count == 0) {
				//해당 클럽에 가입하지 않은 멤버일때 
				if(invo == null || invo.getComplete()>0) {
					ClubVO cvo = service.clubSelectOne(clubno);
					invo = new ClubInviteVO();	
					invo.setUserid(userid);
					invo.setUsername(username);
					invo.setClubno(cvo.getNo());
					invo.setClubid(cvo.getClubid());
					invo.setInvite(true);
					invo.setSubmit(false);
					service.clubInsertInvite(invo);
					
					result.put("msg", "멤버 초대 완료!");
					result.put("status","200");
					entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
				}
				else {
					//가입 신청 한사람
					result.put("msg", "이미 가입 신청한 사람입니다.");
					result.put("status", "200");				
					entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
				}
			}
			else {
				result.put("msg", "이미 클럽 멤버입니다.");
				result.put("status","200");
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "가입 신청 실패");
			result.put("status","400");
			entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	
	//클럽 멤버 가입 ok
	@PostMapping("/main/club/accept")
	public ResponseEntity<HashMap<String, String>> clubMemberAccept(String userid, String clubid, int clubno ,int ivno){
		ResponseEntity<HashMap<String, String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			MemberVO mvo = serviceM.memberSelectOne(userid);
			ClubMemberVO cmvo = new ClubMemberVO();
			cmvo.setClubid(clubid);
			cmvo.setClubno(clubno);
			cmvo.setUserid(mvo.getUserid());
			cmvo.setUsername(mvo.getUsername());
			serviceCM.clubMemberInsert(cmvo);
			service.clubUpdateMember(clubno);
			service.clubInviteUpdateComplete(ivno);
			
			result.put("msg", "멤버 가입 완료!");
			result.put("status","200");
			entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "멤버 가입 실패! 나중에 다시 시도해 주세요");
			result.put("status","400");
			entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//클럽 멤버 가입 reject
	//@RequestMapping(value="/main/club/rejcet", method = RequestMethod.POST)
	@PostMapping("/main/club/rejcet")
	public ResponseEntity<HashMap<String, String>> clubMemberReject(int ivno){
		ResponseEntity<HashMap<String, String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		try {
				service.clubInviteUpdateComplete(ivno);	
				result.put("msg", "가입요청 거절 완료!");
				result.put("status","200");
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.OK);
				
			}catch(Exception e) {
				e.printStackTrace();
				result.put("msg", "요청 실패! 나중에 다시 시도해 주세요");
				result.put("status","400");
				entity = new ResponseEntity<HashMap<String, String>>(result,HttpStatus.BAD_REQUEST);
			}
			
			return entity;
	}
	
	//클럽 정보 수정
	@PostMapping("/main/club/editOk")
	public ResponseEntity<String> clubEditOk(ClubVO voNew, HttpServletRequest requset){
		ResponseEntity<String> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html; charset=utf-8");
		String msg = "";
		try {
			int result = service.clubSelectName(voNew.getClubid());
			ClubVO voOrigin = service.clubSelectOne(voNew.getNo());
			
			//중복되지 않는 클럽이름 or 클럽이름이 이전과 같음
			if(result == 0 || voOrigin.getClubid().equals(voNew.getClubid())) {
				voOrigin.setClubid(voNew.getClubid());
				voOrigin.setClubnotice(voNew.getClubnotice());
				service.clubUpdateInfo(voOrigin);
				msg = getSuccessMessage("클럽 정보가 성공적으로 변경되었습니다.", requset.getContextPath()+"/main/club/"+voNew.getNo()+"/admin");
				entity = new ResponseEntity<String>(msg,headers,HttpStatus.OK);
			}
			else {
				//클럽이름이 이미 존재함
				msg = getFailMessage("이미 존재하는 클럽 이름 입니다.");
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			msg = getFailMessage("업데이트 실패.");
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	//클럽 멤버 강퇴
	@PostMapping("/main/club/memberDelete")
	public ResponseEntity<HashMap<String, String>> clubMemeberDelete(int no, int clubno, String clubadmin, String userid, HttpSession session,HttpServletRequest request){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String, String> result = new HashMap<>();
		try {
			if(userid.equals(clubadmin) == true) {
				
				result.put("msg", "관리자 권한을 양도하세요.");
				result.put("status", "200");
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
				
			}
			else {
				service.clubDeleteMember(no , clubno);
				service.clubUpdateMember(clubno);
				result.put("msg", "회원 탈퇴 완료");
				result.put("status", "200");
				//result.put("redirect", request.getRequestURL().toString());
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "잠시후 다시 시도해 주세요...");
			result.put("status", "400");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
			
	//클럽 host 양ㄷ
	@PostMapping("/main/club/adminUpdate")
	public ResponseEntity<HashMap<String, String>> clubAdminUpdate(int clubno, String clubadmin, String userid, String username,  HttpSession session,HttpServletRequest request){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String, String> result = new HashMap<>();
		try {
			if(userid.equals(clubadmin) == true) {
				
				result.put("msg", "본인에게 양도할 수 없습니다.");
				result.put("status", "200");
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
				
			}
			else {
				ClubVO cvo = service.clubSelectOne(clubno);
				cvo.setClubadmin(userid);
				service.clubUpdateInfo(cvo);
				result.put("msg", "그룹장 양도 완료");
				result.put("status", "200");
				//result.put("redirect", request.getRequestURL().toString());
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "잠시후 다시 시도해 주세요...");
			result.put("status", "400");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		
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
