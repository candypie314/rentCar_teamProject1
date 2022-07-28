package com.RentLoGo.board.service;

import java.util.List;

import com.RentLoGo.board.model.BoardDTO;

public interface BoardService {

	public void enroll(BoardDTO board);
	
	public List<BoardDTO> getList();
}
