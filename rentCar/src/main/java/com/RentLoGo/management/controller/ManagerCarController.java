package com.RentLoGo.management.controller;

import java.io.IOException; 

import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.RentLoGo.rentCar.model.AllCarDTO;

public interface ManagerCarController {

//렌터카조회(manage)
	public String select(HttpServletRequest request);
	public String listManageCar(HttpServletRequest request);
	
//렌터카삭제(manage)
	List<AllCarDTO> dropCar(Map<String, Object> number);
	
//검색
	List<AllCarDTO> searchCar(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
//수정
	List<AllCarDTO> ManagerCarModify(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
