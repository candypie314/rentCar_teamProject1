package com.RentLoGo.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.RentLoGo.board.model.BoardDTO;

public interface BoardController {

	String boardpage(HttpServletRequest request);
	List<BoardDTO> boardlist(Map<String, Object> title);
}
