package com.RentLoGo.rentCar.model;

import lombok.Data;

//CREATE TABLE "car" (
//		   "car_model" VARCHAR2(20) NOT NULL, -- 차량모델
//		   "car_size"  VARCHAR2(20) NULL,     -- 차량크기
//		   "car_type"  VARCHAR2(20) NULL,     -- 차량종류
//		   "car_made"  VARCHAR2(20) NULL,     -- 제조사
//		   "car_price" VARCHAR2(20) NULL      -- 가격
//		);

@Data
public class AllCarDTO {
	
	private CarDTO carDTO;
	private RentCarDTO rentCarDTO;
	
	
}
