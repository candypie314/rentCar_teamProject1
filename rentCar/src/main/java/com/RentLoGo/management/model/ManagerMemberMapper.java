package com.RentLoGo.management.model;

import java.util.List;

import com.RentLoGo.member.model.MemberDTO;

public interface ManagerMemberMapper {

	//회원삭제
	void dropMember(String memberId);
	List<MemberDTO> searchIdName(MemberDTO dto);
//	List<MemberDTO> searchName(String name);
	void modifyMember(MemberDTO dto);
}
