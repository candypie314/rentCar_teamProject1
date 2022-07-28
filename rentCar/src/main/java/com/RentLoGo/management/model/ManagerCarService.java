package com.RentLoGo.management.model;

import java.util.List; 
import java.util.Map;

import com.RentLoGo.rentCar.model.AllCarDTO;

public interface ManagerCarService {

	public void dropCar(String number);
	//검색
	List<AllCarDTO> searchCarNumberModel(Map<String, Object> map);
	//수정
	List<AllCarDTO> modifyCar(Map<String, Object> map);
}
