package com.RentLoGo.member.model;

import java.util.List;

public interface MemberMapper {
	
	public void memberJoin(MemberDTO member);
	
	public MemberDTO memberLogin(MemberDTO member);
	
	public void memberDelete(MemberDTO member);
	
	public void memberModify(MemberDTO member);
	
	public List<MemberDTO> selectAllMember();

}
