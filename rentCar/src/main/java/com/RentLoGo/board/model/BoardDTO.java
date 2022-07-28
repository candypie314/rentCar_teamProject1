package com.RentLoGo.board.model;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
//	   "board_num"     INTEGER       NOT NULL, -- 게시글번호
//	   "member_id"     VARCHAR2(20)  NOT NULL, -- 회원id(작성자)
//	   "board_origin"  INTEGER       NULL,     -- 원글번호
//	   "board_title"   VARCHAR2(20)  NULL,     -- 제목
//	   "board_content" VARCHAR2(200) NULL,     -- 내용
//	   "board_time"    DATE          NULL,     -- 작성시간
//	   "board_modify"  DATE          NULL      -- 최종수정시간
	   
	   private int boardNum;
	   private String memberId;
	   private int boardOrigin;
	   private String boardTitle;
	   private String boardContent;
	   private Date boardTime;
	   private Date boardModify;
	   
	   
	   
}
