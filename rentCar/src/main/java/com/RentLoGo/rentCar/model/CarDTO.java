package com.RentLoGo.rentCar.model;

import org.springframework.stereotype.Component;

import lombok.Data;

//CREATE TABLE "car" (
//		   "car_model" VARCHAR2(20) NOT NULL, -- 차량모델
//		   "car_size"  VARCHAR2(20) NULL,     -- 차량크기
//		   "car_type"  VARCHAR2(20) NULL,     -- 차량종류
//		   "car_made"  VARCHAR2(20) NULL,     -- 제조사
//		   "car_price" VARCHAR2(20) NULL      -- 가격
//		);

@Data
@Component
public class CarDTO {
	
	private String carModel;
	private String carSize;
	private String carType;
	private String carMade;
	private String carPrice;
	
}
