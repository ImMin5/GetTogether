package com.campus.myapp.service;

import java.util.List;

import com.campus.myapp.vo.ClubInviteVO;
import com.campus.myapp.vo.ClubVO;

public interface ClubService {
	public int clubInsert(ClubVO vo);
	public List<ClubVO> clubSelect(String userid);
	public ClubVO clubSelectOne(int no);
	public List<ClubVO> clubSelectPublic(boolean ispublic,  String clubid);
	public ClubVO clubSelectAdmin(String admin, String clubid);
	public ClubVO clubSelectMember(String userid, int no);
	public int clubUpdatePost(int clubno);
	public int clubUpdateMember(int clubno);
	public int clubInsertInvite(ClubInviteVO vo);
	public int clubUpdateInfo(ClubVO vo);
	public int clubSelectName(String clubid);
	public int clubDeleteMember(int no, int clubno);
	
	public ClubInviteVO clubInviteSelect(String userid, int clubno);
	public List<ClubInviteVO> clubInviteSelectIsInvite(int clubno, boolean invite);
	public int clubInviteUpdateComplete(int no);
	public int clubInviteUpdateUsername(String userid, String username);
	
}
