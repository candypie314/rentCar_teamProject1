package com.RentLoGo.management.model;

import java.util.List; 
import java.util.Map;

import com.RentLoGo.rentCar.model.AllCarDTO;

public interface ManagerCarMapper {

	//렌터카 삭제
	public void dropCar(String number);
	//검색
	List<AllCarDTO> searchCarNumberModel(Map<String, Object> map);
	//수정
	List<AllCarDTO> modifyCar(Map<String, Object> map);
}
