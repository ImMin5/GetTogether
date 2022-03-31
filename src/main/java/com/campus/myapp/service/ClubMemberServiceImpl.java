package com.campus.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.campus.myapp.dao.ClubMemberDAO;
import com.campus.myapp.vo.ClubMemberVO;


@Service
public class ClubMemberServiceImpl implements ClubMemberService {
	
	@Inject
	ClubMemberDAO dao;
	
	@Override
	public int clubMemberInsert(ClubMemberVO vo) {
		return dao.clubMemberInsert(vo);
	}

	@Override
	public List<ClubMemberVO> clubMemberSelect(String userid) {
		return dao.clubMemberSelect(userid);
	}

	@Override
	public Integer clubMemberCheck(String userid, int clubid) {
		return dao.clubMemberCheck(userid, clubid);
	}

	@Override
	public ClubMemberVO clubMemberSelectOne(String userid, int clubno) {
		return dao.clubMemberSelectOne(userid, clubno);
	}

	@Override
	public List<ClubMemberVO> clubMemberSelectAll(int clubno) {
		return dao.clubMemberSelectAll(clubno);
	}

	@Override
	public int clubMemberUpdateUsername(String userid, String username) {
		return dao.clubMemberUpdateUsername(userid, username);
	}
	
}
