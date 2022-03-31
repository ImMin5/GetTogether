package com.campus.myapp.service;

import com.campus.myapp.vo.MemberVO;

public interface MemberService {
	public int memberInsert(MemberVO vo);
	public MemberVO loginCheck(MemberVO vo);
	public int idCheck(String username);
	public int usernameCheck(String username);
	public MemberVO memberSelectOne(String userid);
	public int memberUpdate(MemberVO vo);
}
