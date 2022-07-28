package com.RentLoGo.board.controller;


import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.RentLoGo.board.model.BoardDTO;
import com.RentLoGo.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardControllerImpl {

	private BoardService boardService;
	
	@RequestMapping("/board.do")
	public String boardpageString(HttpServletRequest request) {
		System.out.println("게시판 화면 진입   >>>>>>>>>>>> ");
		
		String viewName = (String) request.getAttribute("viewName");
		viewName = viewName.substring(viewName.lastIndexOf("/")+1, viewName.length());
		
		return viewName;
	}
	
	
//	@RequestMapping("/boardForm.do")
//	public void boardListGET(Model model) {
//		System.out.println("게시판 목록 페이지 진입");
//		
//		model.addAttribute("list", boardService.getList());
//	}
	
//	@RequestMapping("/board.do")
//	public String boardEnrollPOST(BoardDTO board) {
//		System.out.println("Board 게시판 " + board);
//		boardService.enroll(board);
//		
//		return "redirect:/board/board.do";
//	}
	
}
