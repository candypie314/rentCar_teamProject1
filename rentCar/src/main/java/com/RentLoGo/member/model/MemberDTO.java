package com.RentLoGo.member.model;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDTO {
	private String memberId;
	private String memberPw;
	private String memberClass;
	private String memberName;
	private String memberBirth;
	private String memberPhone;
	private String memberEmail;
	private Date memberDate;
}
