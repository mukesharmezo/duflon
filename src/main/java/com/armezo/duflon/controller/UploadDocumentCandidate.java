package com.armezo.duflon.controller;

import java.io.File;
import java.time.LocalDate;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class UploadDocumentCandidate {

	@Autowired
	ParticipantServiceImpl participantService;
	@Autowired
	private HREService hreService;
	@Autowired
	EventLogerService eventLogerServer;
	@Value("${client.url}")
    private String adminLink;
	@Value("${cand.link}")
	private String candLink;
	@Value("${file.path}")
    private String filePath;
	

	@GetMapping("/uploadCandidateDocument")
	public String generateAccesskey(@RequestParam("accessKey") String accessKey, HttpSession session, Model model) {

		ParticipantRegistration partcipantRegistration = null;
		Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accessKey);
		if (participant.isPresent()) {
			partcipantRegistration = participant.get();
		}
		model.addAttribute("participant", partcipantRegistration);
		return "upload-registrations";
	}

	/* File uploaded method */
	@PostMapping("/uploadByCandidate")
	public ResponseEntity<String> uploadFile(@RequestParam("accessKey") String accessKey,
			@RequestParam("file") MultipartFile file, @RequestParam("name") String name,
			@RequestParam("identity_proof") String identityProof, @RequestParam("address_proof") String addressProof) {
		String path = filePath+"/"+ accessKey + "/";
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdir();
		}
		try {
			Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accessKey);
			file.transferTo(new File(path + fileName));
			if (name.equals("photograph")) {
				participant.get().setPhotograph(accessKey + "/" + fileName);
			}
			if (name.equals("resume")) {
				participant.get().setResume(accessKey + "/" + fileName);
			}
			if (name.equals("signature")) {
				participant.get().setSignature(accessKey + "/" + fileName);
			}
			if (name.equals("identitityProof")) {
				participant.get().setIdentitityProof(accessKey + "/" + fileName);
				participant.get().setIdentitityProofName(identityProof);
				participant.get().setIdProof(identityProof);
			}
			if (name.equals("addressProof")) {
				participant.get().setAddressProof(accessKey + "/" + fileName);
				participant.get().setAddressProofName(addressProof);
			}
			if (name.equals("10th")) {
				participant.get().setQualification(accessKey + "/" + fileName);
			}
			if (name.equals("12th")) {
				participant.get().setQualification2(accessKey + "/" + fileName);
			}
			if (name.equals("Graduation")) {
				participant.get().setQualification3(accessKey + "/" + fileName);
			}
			if (name.equals("resignation")) {
				participant.get().setResignationLetter(accessKey + "/" + fileName);
			}
			if (name.equals("experience")) {
				participant.get().setExperienceletter(accessKey + "/" + fileName);
			}
			if (name.equals("salaryslip")) {
				participant.get().setSalarySlip(accessKey + "/" + fileName);
			}
			if (name.equals("other")) {
				participant.get().setDocuments(accessKey + "/" + fileName);
			}
			participant.get().setModifiedDate(LocalDate.now());
			participantService.saveFiles(participant.get());
			  eventLogin(participant.get().getHreId().intValue(),"upload Documets",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
		} catch (Exception e) {
			return ResponseEntity.ok("error");
		}
		return ResponseEntity.ok("images/" + accessKey + "/" + fileName);
	}

	@PostMapping("/savedocument")
	@ResponseBody
	public String savedcument(@RequestParam("accesskey") String accessKey, @RequestParam("status") String status) {
		String msg = "";
		Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accessKey);
		if(participant.get().getPhotograph() == null || participant.get().getSignature() == null || participant.get().getIdentitityProof() == null ||
				participant.get().getAddressProof() == null || participant.get().getQualification() == null || participant.get().getQualification2() == null ||
				participant.get().getQualification3() == null || participant.get().getResume() == null ) {
			return  "3";
		}
		if (participant.isPresent()) {
			participant.get().setDocuments_status(status);
			participant.get().setModifiedDate(LocalDate.now());
			participantService.saveFiles(participant.get());

		}
		if (status.equals("save")) {
			msg = "success";
		}
		if (status.equals("final")) {
			
			msg = "Your Documents are uploaded and your HRE is notified.\r\n" + "\r\n"
					+ "Please contact your HRE and inform that you have completed the process.";
		}
		uploaddocumentToCandidate(participant.get());
		uploaddocumentToDealer(participant.get());
		  eventLogin(participant.get().getHreId().intValue(),"upload Documets by Candidate",participant.get().getAccessKey(),participant.get().getFirstName()+
	        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
		return msg;
	}

	@PostMapping("/savedocuments")
	@ResponseBody
	public String savedcuments(@RequestParam("accesskey") String accessKey, @RequestParam("status") String status) {
		String msg = "";
		Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accessKey);
		if (participant.isPresent()) {
			if(
					DataProccessor.getStringValue(participant.get().getTitle()).equals("") || DataProccessor.getStringValue(participant.get().getFirstName()).equals("")  ||
					DataProccessor.getStringValue(participant.get().getLastName()).equals("") || DataProccessor.getStringValue(participant.get().getAddress()).equals("") ||
					DataProccessor.getStringValue(participant.get().getState()).equals("") || DataProccessor.getStringValue(participant.get().getCity()).equals("") ||
					participant.get().getPin() == null || DataProccessor.getStringValue(participant.get().getIdProof()).equals("") ||
					DataProccessor.getStringValue(participant.get().getMobile()).equals("") || 
					DataProccessor.getStringValue(participant.get().getAlternateContactNumber()).equals("") || DataProccessor.getStringValue(participant.get().getEmail()).equals("") ||
					participant.get().getAdharNumber() == null || 
				    DataProccessor.getStringValue(participant.get().getHighestQualification()).equals("") || DataProccessor.getStringValue(participant.get().getPrimaryLanguage()).equals("") ||
				    DataProccessor.getStringValue(participant.get().getSecondaryLanguage()).equals("")) {	
				return  "1";	
			}
			if(DataProccessor.getStringValue(participant.get().getEmpSalary()).equals("") || DataProccessor.getStringValue(participant.get().getGender()).equals("")){	
				return  "2";
			}
			if(DataProccessor.getStringValue(participant.get().getPhotograph()).equals("") || DataProccessor.getStringValue(participant.get().getSignature()).equals("") ||  
					DataProccessor.getStringValue(participant.get().getIdentitityProof()).equals("") || DataProccessor.getStringValue(participant.get().getAddressProof()).equals("") ||
					DataProccessor.getStringValue(participant.get().getQualification()).equals("") || DataProccessor.getStringValue(participant.get().getQualification2()).equals("") ||
					DataProccessor.getStringValue(participant.get().getQualification3()).equals("")|| DataProccessor.getStringValue(participant.get().getResume()).equals("") ) {		
				return  "3";				
			}
			
		}
		if (participant.isPresent()) {
			participant.get().setDocuments_status(status);
			participant.get().setRegStatus("3");
			participant.get().setModifiedDate(LocalDate.now());
			participantService.saveFiles(participant.get());
			  eventLogin(participant.get().getHreId().intValue(),"upload Documets by dealer",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
		}
		msg = "success";
		return msg;
	}
	
	@PostMapping("/getdocument")
	public ResponseEntity<String> getdocuments(@RequestParam("accessKey") String accessKey,
			@RequestParam("status") String status) {

		Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accessKey);
		if (participant.isPresent()) {
			participant.get().setDocuments_status(status);
			participantService.saveFiles(participant.get());
		}
		return ResponseEntity.ok("success");
	}

	private String uploaddocumentToDealer(ParticipantRegistration participant) {
		String subjectLine = "DuRecruit - Candidate documents uploaded";
		String mailBody = DataProccessor.readFileFromResource("joiningDocsUploadSuccessHRE");
		mailBody = mailBody.replace("${candidateName}",
				participant.getFirstName() + " " + participant.getMiddleName() + " " + participant.getLastName());
		HRE dealer = hreService.getById(participant.getHreId()).get();
		mailBody = mailBody.replace("${dealerName}", dealer.getName());
		mailBody = mailBody.replace("${link}", adminLink); // Docs Upload
																											// link will
		mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
		if(dealer.getEmail() != null) {
			mailBody = mailBody.replace("${email}", dealer.getEmail());	
		}else {
			mailBody = mailBody.replace("${email}", "");	
		}
		if(dealer.getMobile() != null) {
			mailBody = mailBody.replace("${mobile}", dealer.getMobile());	
		}else {
			mailBody = mailBody.replace("${mobile}", "");		
		}
		// Create Payload
		SendPayload sendP = new SendPayload();
		// sendP.setTo(to);
		sendP.setTo(dealer.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
		sendP.setCc("");
		sendP.setBcc("");
		sendP.setFrom("");

		EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(),
				sendP.getMsg(), "smtp");
		System.out.println("Email Sent for Assessment Passing");
		return "success";
	}
	
	private String uploaddocumentToCandidate(ParticipantRegistration participant) {
		String subjectLine = "DuRecruit - Candidate documents uploaded";
		String mailBody = DataProccessor.readFileFromResource("joiningDocsUploadSuccess");
		mailBody = mailBody.replace("${candidateName}",
				participant.getFirstName() + " " + participant.getMiddleName() + " " + participant.getLastName());
		HRE dealer = hreService.getById(participant.getHreId()).get();
		mailBody = mailBody.replace("${dealerName}", dealer.getName());
		mailBody = mailBody.replace("${link}", candLink); // Docs Upload
																											// link will
		mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
		if(dealer.getEmail() != null) {
			mailBody = mailBody.replace("${email}", dealer.getEmail());	
		}else {
			mailBody = mailBody.replace("${email}", "");	
		}
		if(dealer.getMobile() != null) {
			mailBody = mailBody.replace("${mobile}", dealer.getMobile());	
		}else {
			mailBody = mailBody.replace("${mobile}", "");		
		}
		// Create Payload
		SendPayload sendP = new SendPayload();
		// sendP.setTo(to);
		sendP.setTo(participant.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
		sendP.setCc("");
		sendP.setBcc("");
		sendP.setFrom("");

		EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(),
				sendP.getMsg(), "smtp");
		return "success";
	}
	
	
	/*
	private String sendEmailGenetateMSPIN(final ParticipantRegistration participant) {
		final String subjectLine = "iRecruit – MSPIN "+ participant.getMspin() +" Generated";
		String mailBody = DataProccessor.readFileFromResource("mspinGeneratedNotification");
		
		mailBody = mailBody.replace("${candidateName}", String.valueOf(participant.getFirstName()) + " "
				+ participant.getMiddleName() + " " + participant.getLastName());
		// smsMsg = smsMsg.replace("${name}", String.valueOf(participant.getFirstName())
		// + " " + participant.getMiddleName() + " " + participant.getLastName());
		final Dealer dealer = this.hreService.getById((long) participant.getHreId()).get();
		mailBody = mailBody.replace("${dealer}", dealer.getName());
		if(participant.getMspin() != null) {
		mailBody = mailBody.replace("${mspin}", participant.getMspin());
		}else {
			mailBody = mailBody.replace("${mspin}", "");
		}
		mailBody = mailBody.replace("${link}", adminLink);
		mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
		
		// smsMsg = smsMsg.replace("${accesskey}", participant.getAccessKey());
		// SmsUtility.sendSmsHandler(participant.getMobile(), smsMsg, "MSILOT");
		final SendPayload sendP = new SendPayload();
		sendP.setTo(dealer.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
		sendP.setCc("");
		sendP.setBcc("");
		sendP.setFrom("Armezo Solutions");
		try {
			EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(),
					sendP.getMsg(), "smtp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		 try {
		     if(dealer.getMobile() != null && !dealer.getMobile().equals("") ) {
			 String smsMsg = DataProccessor.getSMS("mspinGenerated");
			 String name="";
			 name += participant.getFirstName();
			 if(participant.getMiddleName() != null && !participant.getMiddleName().equals("")) {
				 name +=  " "+ participant.getFirstName(); 
			 }
			 name +=  " "+ participant.getLastName(); 
			 smsMsg = smsMsg.replace("${mspin}", participant.getMspin());
			 smsMsg = smsMsg.replace("${name}", name);
			 smsMsg = smsMsg.replace("${accesskey}", participant.getAccessKey());
		     SmsUtility.sendSmsHandler(dealer.getMobile() , smsMsg,"MSILOT" );
		     
		     String smsMsg1 = DataProccessor.getSMS("recruited");
		    // SmsUtility.sendSmsHandler(dealer.getMobile() , smsMsg1,"MSILOT" );
		     }
			}catch(Exception e) {
				e.printStackTrace();
	    }
		return "success";
	}
	*/
	 private void eventLogin(int loginId,String eventMSG,String accesskey,String name,String email) {
		 EventLoger event = new EventLoger();
         event.setAccesskey(accesskey);
         event.setEmail(email);
         event.setEventTime(LocalDate.now());
         event.setName(name);
         event.setEvent(eventMSG);
         event.setUserId(loginId);
         eventLogerServer.save(event);
	}

}
