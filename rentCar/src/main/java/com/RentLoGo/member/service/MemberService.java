package com.RentLoGo.member.service;

import java.util.List;

import com.RentLoGo.member.model.MemberDTO;

public interface MemberService {
	//회원가입
	public void memberJoin(MemberDTO member) throws Exception;
	//로그인
	public MemberDTO memberLogin(MemberDTO member) throws Exception;
	//회원탈퇴
	public void memberDelete(MemberDTO member) throws Exception;
	//회원정보수정
	public void memberModify(MemberDTO member) throws Exception;
	//회원정보조회
	public List<MemberDTO> selectAllMember();
}
