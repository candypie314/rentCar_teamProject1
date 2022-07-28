package com.RentLoGo.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.RentLoGo.board.model.BoardDTO;
import com.RentLoGo.board.model.BoardMapper;

@Service("boardService")
@Repository
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public void enroll(BoardDTO board) {
		mapper.enroll(board);
	}
	
	@Override
	public List<BoardDTO> getList() {
		return mapper.getList();
	}
}
