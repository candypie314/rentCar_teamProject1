package com.RentLoGo.management.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.RentLoGo.member.model.MemberDTO;

public interface ManagerMemberController {

	List<MemberDTO> dropMember(Map<String, Object> id);
	List<MemberDTO> searchMember(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	String ManagerMemberModify(MemberDTO dto, HttpServletRequest request);
	
}
