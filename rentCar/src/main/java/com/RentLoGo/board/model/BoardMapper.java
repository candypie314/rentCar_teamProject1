package com.RentLoGo.board.model;

import java.util.List;

public interface BoardMapper {

	public List<BoardDTO> getList();
	
	public void enroll(BoardDTO board);
}
