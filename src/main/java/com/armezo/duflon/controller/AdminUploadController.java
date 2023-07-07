package com.armezo.duflon.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.armezo.duflon.Services.AdminTypeService;

@Controller
public class AdminUploadController {
	
	@Autowired
	private AdminTypeService adminTypeService;
	
	//Show Upload Page
	@GetMapping("/uploadAdmin")
	public String showAdminUploadPage(HttpSession session) {
		return "admin-upload";
	}
	//Upload Admin
	@PostMapping(value="/uploadAdminData")
	@ResponseBody
	public String uploadAdminData(@RequestParam("adminType") String adminType ,@RequestParam("dataFile") MultipartFile dataFile) {
		String message=adminTypeService.uploadAdminData(adminType, dataFile);
		return message;
	}

}
