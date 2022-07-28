package com.RentLoGo.management.model;

import java.util.List; 
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.RentLoGo.rentCar.model.AllCarDTO;

@Service("managerCarService")
public class ManagerCarServiceImpl implements ManagerCarService {

	@Autowired
	ManagerCarMapper managerCarMapper;
//삭제
	@Override
	public void dropCar(String number) {

		System.out.println("ManagerCarService >>> mapper >> dropCar 실행");
		managerCarMapper.dropCar(number);
	}
	
//검색
	@Override
	public List<AllCarDTO> searchCarNumberModel(Map<String, Object> map) {
		List<AllCarDTO> list = managerCarMapper.searchCarNumberModel(map);
		return list;
	}

//수정
	@Override
	public List<AllCarDTO> modifyCar(Map<String, Object> map) {
		List<AllCarDTO> list = managerCarMapper.modifyCar(map);
		return list;
	}
}
