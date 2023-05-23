package com.armezo.duflon.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.armezo.duflon.Entities.EmailTemplate;
import com.armezo.duflon.Services.EmailTemplateService;
import com.armezo.duflon.email.util.SendEmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.sms.util.SendSMSUtil;
import com.armezo.duflon.sms.util.SmsPayload;




@RestController
public class EmailPostController {
	
	@Autowired
	private EmailTemplateService emailTemplateService;

	@GetMapping(value = "/callEmailService")
	public String emailService() {
		
		List<SendPayload> list = new ArrayList<>();
		
		String mailBody="",subjectLine="";
		EmailTemplate emailTemplate =	emailTemplateService.getEmailBody();
		
		if(emailTemplate != null) {
			mailBody =emailTemplate.getMassageBody();
			subjectLine = emailTemplate.getSubjctLine();
		}
		mailBody = mailBody.replace("${candidateName}", "Test");
		mailBody = mailBody.replace("${link}", "test");
		mailBody = mailBody.replace("${accesskey}", "abc");
	ExecutorService executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(10);
	for(int i=0; i<10; i++) {
	SendPayload sendP = new SendPayload();
	sendP.setTo("admin@gmail.com");
	sendP.setSubjectLine(subjectLine);
	sendP.setMsg(mailBody);
	sendP.setCc("");
	sendP.setBcc("");
	list.add(sendP);
	}
	
	for(SendPayload s : list) {
	SendEmailUtility sendEmailUtility = new SendEmailUtility(s);
	Future<SendPayload> result = executor.submit(sendEmailUtility);
	}
	
	executor.shutdown();
	return "success";
	}
	
	// Sms Send handler
	@GetMapping("/sendSms")
	public String sendSms() {
		SmsPayload smsPayload = new SmsPayload();
		smsPayload.setMobileNumber("0000999988");
		smsPayload.setRecieverName("Mayank");
		smsPayload.setSenderName("Mukesh");
		String url = SendSMSUtil.sendSms(smsPayload);
		RestTemplate template = new RestTemplate();
		template.getForObject(url, String.class);
		return "Sms Sent to "+smsPayload.getRecieverName();
		
	}
	
	
}
