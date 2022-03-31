package com.campus.myapp.dao;

import java.util.List;

import com.campus.myapp.vo.ClubMemberVO;
import com.campus.myapp.vo.MemberVO;

public interface ClubMemberDAO {
	public int clubMemberInsert(ClubMemberVO vo);
	public List<ClubMemberVO>  clubMemberSelect(String userid);
	public Integer clubMemberCheck(String userid, int clubid);
	public ClubMemberVO clubMemberSelectOne(String userid, int clubno);
	public List<ClubMemberVO> clubMemberSelectAll(int clubno);
	public int clubMemberUpdateUsername(String userid, String username);
}
