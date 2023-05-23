package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.EmailTemplate;
import com.armezo.duflon.Repositories.EmailTemplateRepository;


@Service
@Transactional
public class EmailTemplateService {
private EmailTemplateRepository emailTemplateRepository;
	
	public  EmailTemplateService(EmailTemplateRepository emailTemplateRepository) {
		this.emailTemplateRepository=emailTemplateRepository;
	}
	
	public EmailTemplate addEmailTemplate(EmailTemplate emailTemplate){
		return emailTemplateRepository.save(emailTemplate);
	}
	public List<EmailTemplate> viewEmailTemplate(){
		return emailTemplateRepository.findAll();
 	}
	public Optional<EmailTemplate> getEmailById(int id){
		return emailTemplateRepository.findById(id);
 	}
	
	public EmailTemplate getEmailBody(){
		return emailTemplateRepository.getEmailBody(true).get(0);
 	}
}
