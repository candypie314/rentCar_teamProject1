package com.RentLoGo.rentCar.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("carService")
public class CarServiceImpl implements CarService{

	@Autowired
	private CarMapper carMapper;
	
	@Override
	public List<CarDTO> selectAllrentCar() {

		System.out.println("carService 실행....");
		List<CarDTO> list = carMapper.selectAllrentCar();
		System.out.println("carService 실행 후 list >>>>" + list );
		
		return list;
	}
	
	//manage rentCar
	@Override
	public List<AllCarDTO> selectManageRentCar() {

		System.out.println("carService 실행....");
		List<AllCarDTO> list = carMapper.selectManageRentCar();
		System.out.println("carService 실행 후 list >>>>" + list );
		
		return list;
	}
	
	
	//
	@Override
	public List<AllCarDTO> selectCarList(Map index) {
		
		System.out.println("carService 실행....");
		return carMapper.selectCarList(index);
	}
	
	

}
