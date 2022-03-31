package com.campus.myapp.vo;

public class ClubInviteVO {
	private int no;
	private String userid;
	private String username;
	private int clubno;
	private String clubid;
	private boolean isInvite;
	private boolean isSubmit;
	private int complete;
	private String createdate;
	
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getClubno() {
		return clubno;
	}
	public void setClubno(int clubno) {
		this.clubno = clubno;
	}
	public String getClubid() {
		return clubid;
	}
	public void setClubid(String clubid) {
		this.clubid = clubid;
	}
	public boolean isInvite() {
		return isInvite;
	}
	public void setInvite(boolean isInvite) {
		this.isInvite = isInvite;
	}
	public boolean isSubmit() {
		return isSubmit;
	}
	public void setSubmit(boolean isSubmit) {
		this.isSubmit = isSubmit;
	}
	public int getComplete() {
		return complete;
	}
	public void setComplete(int complete) {
		this.complete = complete;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}	

}
