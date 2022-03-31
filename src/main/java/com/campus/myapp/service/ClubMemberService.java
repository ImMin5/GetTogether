package com.campus.myapp.service;

import java.util.List;

import com.campus.myapp.vo.ClubMemberVO;

public interface ClubMemberService {
	public int clubMemberInsert(ClubMemberVO vo);
	public List<ClubMemberVO>  clubMemberSelect(String userid);
	public Integer clubMemberCheck(String userid, int clubid);
	public ClubMemberVO clubMemberSelectOne(String userid, int clubno);
	public List<ClubMemberVO> clubMemberSelectAll(int clubno);
	public int clubMemberUpdateUsername(String userid, String username);
}
