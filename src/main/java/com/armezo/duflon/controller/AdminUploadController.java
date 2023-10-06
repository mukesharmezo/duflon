package com.armezo.duflon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
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
	
	// Download XLSX Template
	@PostMapping("/pdfTemplateDownload")
	public ResponseEntity<Resource> downloadTemplate(HttpServletResponse response) throws IOException {
		String templatePath = "classpath:static/pdfTemplate/AdminTemplate.xlsx";
		File file = null;
		try {
			file = ResourceUtils.getFile(templatePath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
		HttpHeaders headers = new HttpHeaders();
		headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");
		headers.add("Content-Disposition", "attachment; filename=AdminTemplate.xlsx");
		return ResponseEntity.ok().headers(headers).contentLength(file.length())
				.contentType(
						MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
				.body(resource);
	}
}
