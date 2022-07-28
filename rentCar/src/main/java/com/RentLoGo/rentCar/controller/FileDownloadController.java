package com.RentLoGo.rentCar.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadController {

	private static String IMAGE_REPOSITORY_PATH = "C:/temp";
	
	@RequestMapping(value="/download",  method=RequestMethod.GET, produces="text/html;charset=utf-8")
	protected void download(@RequestParam("imageFileName") String imageFileName, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		File file = new File(IMAGE_REPOSITORY_PATH + "/" + imageFileName);
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName=" + imageFileName); 
		OutputStream out = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(out);
		BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
		int data;
		
		while((data = input.read()) != -1) {
			bos.write(data);
			bos.flush();
		}
		
		if(input != null) input.close();
		if(bos != null) bos.close();
		if(out != null) out.close();
		
	}
	
}
