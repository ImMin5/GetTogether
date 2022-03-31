package com.campus.myapp.dao;

import com.campus.myapp.vo.MemberVO;

public interface MemberDAO {
	public int memberInsert(MemberVO vo);
	public MemberVO loginCheck(MemberVO vo);
	public int idCheck(String username);
	public int usernameCheck(String username);
	public MemberVO memberSelectOne(String userid); //멤버 1명 선택
	public int memberUpdate(MemberVO vo);
}
