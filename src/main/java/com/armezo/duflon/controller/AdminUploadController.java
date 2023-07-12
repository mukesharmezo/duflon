package com.armezo.duflon.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
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
	
	// Download PDf Template
	@GetMapping("/pdfTemplateDownload")
	public void downloadPdfTemplate(HttpServletResponse response) throws IOException {
		String templatePath = "static/template/AdminTemplate.xlsx";
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(templatePath);
		if (inputStream != null) {
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=AdminTemplate.xlsx");

			// Copy the file to the response output stream
			FileCopyUtils.copy(inputStream, response.getOutputStream());

			// Force the response to be downloaded instead of displayed in the browser
			response.flushBuffer();
		}
	}

		/*Resource resource = new ClassPathResource("static/pdfTemplate/AdminTemplate.xlsx");
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"));
		headers.setContentDispositionFormData("attachment", "AdminTemplate.xlsx");
		headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);*/
		/*String path = "static/pdfTemplate/AdminTemplate.xlsx";
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"AdminTemplate.xlsx\"");
		FileInputStream fis = new FileInputStream(path);
		IOUtils.copy(fis, response.getOutputStream());
		fis.close();*/
	

}
