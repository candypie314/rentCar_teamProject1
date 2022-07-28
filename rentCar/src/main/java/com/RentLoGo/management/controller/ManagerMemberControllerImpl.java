package com.RentLoGo.management.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.RentLoGo.management.model.ManagerMemberService;
import com.RentLoGo.member.model.MemberDTO;
import com.RentLoGo.member.service.MemberService;

@Controller
@RequestMapping("/managerMember")
public class ManagerMemberControllerImpl implements ManagerMemberController {

	@Autowired
	ManagerMemberService managerMemberService;
	@Autowired
	MemberService memberService;
	
	@Override
	@RequestMapping(value="/dropMember.do", method=RequestMethod.POST)
	@ResponseBody
	public List<MemberDTO> dropMember(@RequestBody Map<String, Object> id) {
		
		String memberId = (String) id.get("memberId");
		System.out.println("managerController >>> memberId >>> " + memberId );
		managerMemberService.dropMember(memberId);
		List<MemberDTO> list = memberService.selectAllMember();
		
		return list;
	}

	@Override
	@ResponseBody
	@RequestMapping(value="/searchMember.do", method=RequestMethod.POST)
		public List<MemberDTO> searchMember(@RequestBody Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String option = (String) map.get("selected");
		String value = (String) map.get("inputVal");
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		MemberDTO dto = new MemberDTO();
		
		switch(option) {
			case "id": dto.setMemberId(value);
				break;
			case "name": dto.setMemberName(value);
				break;
		}
		
		list = managerMemberService.searchIdName(dto);
		
		return list;
	}
	
	//수정완료 후 멤버목록으로
	@Override
	@RequestMapping(value="/managerMemberModify.do", method=RequestMethod.POST)
	public String ManagerMemberModify(MemberDTO dto, HttpServletRequest request) {
		System.out.println("수정 시작 >>>> ");
		System.out.println("dto >>> " + dto);
		managerMemberService.modifyMember(dto);
		
		return "redirect:/member/manage.do";
	}
}
