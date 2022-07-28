package com.RentLoGo.management.model;

import java.util.List;

import com.RentLoGo.member.model.MemberDTO;

public interface ManagerMemberService {

	void dropMember(String id);
	List<MemberDTO> searchIdName(MemberDTO dto);
//	List<MemberDTO> searchName(String name);
	void modifyMember(MemberDTO dto);
}
