package com.RentLoGo.rentCar.model;

import java.util.List;
import java.util.Map;

public interface CarService {

	public List<CarDTO> selectAllrentCar();
	
	/* manage rentCar*/
	public List<AllCarDTO> selectManageRentCar();
	
	// 상품리스트
	public List<AllCarDTO> selectCarList(Map index);
}
