package com.RentLoGo.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.RentLoGo.member.model.MemberDTO;
import com.RentLoGo.member.model.MemberMapper;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public void memberJoin(MemberDTO member) throws Exception {
		memberMapper.memberJoin(member);
	}
	
	@Override
	public MemberDTO memberLogin(MemberDTO member) throws Exception {
		return memberMapper.memberLogin(member);
	}
	
	@Override
	public void memberDelete(MemberDTO member) throws Exception {
		memberMapper.memberDelete(member);
	}
	
	@Override
	public void memberModify(MemberDTO member) throws Exception {
		memberMapper.memberModify(member);
	}

	@Override
	public List<MemberDTO> selectAllMember() {

		System.out.println("membermapper 실행....");
		List<MemberDTO> list = memberMapper.selectAllMember();
		System.out.println("membermapper 실행 후 list >>>>" + list );
		
		return list;
	}

}


