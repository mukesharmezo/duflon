package com.armezo.duflon.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.EmailTemplate;
import com.armezo.duflon.Services.EmailTemplateService;

@Controller
//@RequestMapping("/email/template")
public class AddTemplateContoller {

	@Autowired
	private EmailTemplateService emailTemplateService;
	
	@GetMapping("/add")
	public String  addMailTemplate() {
		return "addEmailTemplate";
	}
	
	@PostMapping("/addPro")
	public String  addMailTemplate(@RequestParam("subject") String subject,@RequestParam("msgBod") String msgBod,
			Model model, HttpSession session) {
		String msg="not  saved";
		EmailTemplate emailTemplate = new  EmailTemplate();
		emailTemplate.setMassageBody(msgBod);
		emailTemplate.setSubjctLine(subject);
		emailTemplate.setStatus(true);
		
		if(emailTemplateService.addEmailTemplate(emailTemplate) != null) {
			msg = "success fully saved";
		}
		model.addAttribute("msg", msg);
		return "addEmailTemplate";
	}
	
	@GetMapping("/view")
	public String  viewMailTemplate(Model model) {
		List<EmailTemplate>templateList = emailTemplateService.viewEmailTemplate();
		model.addAttribute("templateList", templateList);
		return "list_email_template";
	}
	
	@GetMapping("/update")
	public String  updateMailTemplate(@RequestParam("id") String emailId,Model model) {
		Optional<EmailTemplate>emailTemplate = emailTemplateService.getEmailById(Integer.parseInt(emailId));
		model.addAttribute("subjectLine", emailTemplate.get().getSubjctLine());
		model.addAttribute("emailBody", emailTemplate.get().getMassageBody());
		model.addAttribute("id", emailTemplate.get().getId());
		return "update_email_template";
	}
	
	@PostMapping("/updatePro")
	public String  updateMailTemplatePro(@RequestParam("id") String id,
			@RequestParam("subject") String subject,@RequestParam("messageBody") String messageBody,Model model) {
		Optional<EmailTemplate>emailTemplate = emailTemplateService.getEmailById(Integer.parseInt(id));
		EmailTemplate template = emailTemplate.get();
		template.setMassageBody(messageBody);
		template.setSubjctLine(subject);
		emailTemplateService.addEmailTemplate(template);
		List<EmailTemplate>templateList = emailTemplateService.viewEmailTemplate();
		model.addAttribute("templateList", templateList);
		return "list_email_template";
	}	
}


