package com.RentLoGo.rentCar.model;

import org.springframework.stereotype.Component;

import lombok.Data;

//CREATE TABLE "rent_car" (
//		   "car_number"   VARCHAR2(20) NOT NULL, -- 차량번호
//		   "car_model"    VARCHAR2(20) NULL,     -- 차량모델
//		   "car_color"    VARCHAR2(20) NULL,     -- 차량색상
//		   "car_distance" INTEGER      NULL      -- 주행거리
//		);

@Data
@Component
public class RentCarDTO {
	
	private String carNumber;
	private String carModel;
	private String carColor;
	private String carDistance;
	
}


