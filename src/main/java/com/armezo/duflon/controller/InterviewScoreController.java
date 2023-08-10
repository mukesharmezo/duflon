package com.armezo.duflon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.jobportal.UserRegistration;
import com.armezo.duflon.jobportal.UserService;
import com.armezo.duflon.utils.DataProccessor;



@Controller
public class InterviewScoreController {
	
	@Value("${pdf.exeUrl}")
	private String exeUrl;
	
	@Value("${pdf.downloadPdfFile}")
	private String downloadPath; 

	@Autowired
	InterviewScoreService interviewScoreService;
	@Autowired
	ParticipantServiceImpl participantService;
	@Autowired
	private HREService hreService;
	@Autowired
	private UserService userService;
	@Autowired
	EventLogerService eventLogerServer;
	@Value("${cand.link}")
	private String candLink;
	@Value("${client.url}")
	private String appLink;

	@GetMapping("interviewForm")
	public String interview(@RequestParam("accesskey") String accesskey, @RequestParam("interviewCount") Integer interviewCount ,Model model,HttpSession session) {
		if (session.getAttribute("userId") != null) {
		Optional<ParticipantRegistration> particpant = participantService.getParticipantByAccesskey(accesskey);
		Optional<InterviewScore> score = interviewScoreService.findByAccesskeyAndInterviewCount(accesskey, interviewCount);
		//SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		if(particpant.isPresent()) {
			model.addAttribute("designation", particpant.get().getDesignation());	
			model.addAttribute("date",particpant.get().getInterviewDate().format(df));	
			model.addAttribute("accesskey", particpant.get().getAccessKey());
			model.addAttribute("photograph", particpant.get().getPhotograph());
			//Checking 2nd interview scheduled or not
			String int2 = "check";
			if(interviewCount==1) {
				if(particpant.get().getInterviewDate2()!=null) {
					int2 = "interview2sch";
				}
				model.addAttribute("interviewerCount", particpant.get().getInterviewerCount());
			}else if (interviewCount == 2) {
				model.addAttribute("interviewerCount", particpant.get().getInterviewerCount2());
			}
			model.addAttribute("check", int2);
			if(particpant.get().getDocuments_status() == null) {
			   model.addAttribute("editStatus", 1);
			}
			if(particpant.get().getRegStatus() == null || particpant.get().getRegStatus() != "3" ) {
				   model.addAttribute("editStatus", 1);
		    }
			String name="";
			name= particpant.get().getFirstName();
			if(particpant.get().getMiddleName() != null ) {
				name = 	name+" "+particpant.get().getMiddleName();
			}
			if(particpant.get().getLastName() != null ) {
				name = 	name+" "+particpant.get().getLastName();
			}
			model.addAttribute("name", name);	
		}
		if (score.isPresent()) {
			score.get().setInterviewCount(interviewCount);
			model.addAttribute("score", score.get());
		}else {
			InterviewScore score2 = new InterviewScore();
			score2.setInterviewCount(interviewCount);
			model.addAttribute("score", score2);	
		}
		}else {
			return "redirect:login";
		}
		return "interviewForm";
	}

	@GetMapping("interviewSampmePDF")
	public String interviewSampmePDF() {
		return "interviewForm";
	}
	@PostMapping("/interview")
	@ResponseBody
	public String saveInterviewScore(@RequestParam("name_a") String name_a, @RequestParam("name_b") String name_b,
			@RequestParam("name_c") String name_c, @RequestParam("designation_a") String designation_a,
			@RequestParam("designation_b") String designation_b, @RequestParam("designation_c") String designation_c,
			@RequestParam("mobile_a") String mobile_a, @RequestParam("mobile_b") String mobile_b,
			@RequestParam("mobile_c") String mobile_c, @RequestParam("clarity_a") String clarity_a,
			@RequestParam("clarity_b") String clarity_b, @RequestParam("clarity_c") String clarity_c,
			@RequestParam("presentability_a") String presentability_a,@RequestParam("presentability_b") String presentability_b,
			@RequestParam("presentability_c") String presentability_c, @RequestParam("attitude_a") String attitude_a,
			@RequestParam("attitude_b") String attitude_b, @RequestParam("attitude_c") String attitude_c,
			@RequestParam("situation_a") String situation_a, @RequestParam("situation_b") String situation_b,
			@RequestParam("situation_c") String situation_c, @RequestParam("total_a") String total_a,
			@RequestParam("total_b") String total_b, @RequestParam("total_c") String total_c,
			@RequestParam("total_avt") String total_avt, @RequestParam("accesskey") String accesskey,
			@RequestParam("status") String status,@RequestParam("pass_fail") String pass_fail_status,
			@RequestParam("percentage") String percentage,
			@RequestParam("interviewCount") Integer interviewCount,
			@RequestParam("total")String total,HttpSession session) {
		String msg="";
		if (session.getAttribute("userId") != null) {
		Optional<InterviewScore> interviewscore = interviewScoreService.findByAccesskeyAndInterviewCount(accesskey,interviewCount);
		InterviewScore score = new InterviewScore();
		 if(interviewscore.isPresent()) {
			score = interviewscore.get();
		}else {
			score.setAccessKey(accesskey);
		}
		
		 score.setName_a(name_a);score.setName_b(name_b);score.setName_c(name_c);
			score.setDesignation_a(designation_a);score.setDesignation_b(designation_b);score.setDesignation_c(designation_c);
			score.setMobile_a(mobile_a);score.setMobile_b(mobile_b);score.setMobile_c(mobile_c);		
			score.setClarity_a(clarity_a);score.setClarity_b(clarity_b);score.setClarity_c(clarity_c);
			score.setPresentability_a(presentability_a);score.setPresentability_b(presentability_b);score.setPresentability_c(presentability_c);
			score.setAttitude_a(attitude_a);score.setAttitude_b(attitude_b);score.setAttitude_c(attitude_c);
			score.setSituation_a(situation_a);score.setSituation_b(situation_b);score.setSituation_c(situation_c);
			score.setTotal_a(total_a);score.setTotal_b(total_b);score.setTotal_c(total_c);
			score.setTotal_avt(total_avt);
			score.setDesignation_a(designation_a);
			score.setTotal(total);
			score.setStatus(status);
			score.setPass_fail_status(pass_fail_status);
			score.setPercentage(percentage);
		score.setInterviewCount(interviewCount);
		if(status.equals("final")) {
			
			if(pass_fail_status.equals("pass")) {
			   score.setInterviewStatus("Selected");
			   if(interviewCount==1) {
				   msg="Candidate is shortlisted in first round interview.\r\n"+
						   "An automated email and sms sent to candidates for this.";
			   }else if (interviewCount==2) {
			   msg="The Candidate is shortlisted in the Interview Process.\r\n" + 
			   		"\r\n" + 
			   		"You must speak with the selected candidate to complete the Joining Formalities. \r\n" + 
			   		"\r\n" + 
			   		"An Automated Email and SMS sent to Candidates for this.\r\n" + 
			   		"\r\n" + 
			   		"NOTE: You may choose to share the Letter of Intent (LOI) / Offer Letter to the selected candidate if required.";
			}}else {
				msg="The Candidate is NOT shortlisted in the Interview Process.";
				score.setInterviewStatus("Not Selected");	
			}
		}else {
		msg="save";	
		}
		interviewScoreService.saveInterviewScore(score);
		participantService.updateModifiedDate(accesskey);
		if(status.equals("final")) {
			Optional<ParticipantRegistration> particpant = participantService.getParticipantByAccesskey(accesskey);	
			if(particpant.isPresent()) {
				if(interviewCount==1) {
					particpant.get().setInterviewScore(Integer.parseInt(total));
					particpant.get().setParticipantStatus("Interview1");
					participantService.saveData(particpant.get());
					if(pass_fail_status.equals("pass")) {
						//String name=DataProccessor.getFullNameOfParticipant(particpant.get());
						sendEmailShortlisted(particpant.get(),1);	
					}
				}else if (interviewCount==2) {
					particpant.get().setInterviewScore2(Integer.parseInt(total));
					particpant.get().setParticipantStatus("Interview2");
					if(pass_fail_status.equals("pass")) {
						particpant.get().setHiredStatus("P");
						/*
						particpant.get().setHiredDate(LocalDate.now());
						if (particpant.get().getJoiningDate() == null || particpant.get().getJoiningDate().isEqual(LocalDate.MIN)) {
							particpant.get().setJoiningDate(LocalDate.now());
						}*/
						//String name=DataProccessor.getFullNameOfParticipant(particpant.get());
						sendEmailHiredToHRE(particpant.get());
						sendEmailShortlisted(particpant.get(),2);	
					}
					participantService.saveData(particpant.get());
					//Save User Registration Hire Status
					Optional<UserRegistration> userOptional = userService.getUserByAccesskey(accesskey);
			         if(userOptional.isPresent()) {
			         	userOptional.get().setInterviewStatus("Y");
			         	if(pass_fail_status.equals("pass")) {
			         		userOptional.get().setSelectedStatus("Y");
			         		userOptional.get().setJoinedStatus("");
			         	}else {
							userOptional.get().setSelectedStatus("N");
						}
			         	userService.saveUser(userOptional.get());
			         }
				}
			}
		}
		 eventLogin(Integer.parseInt(session.getAttribute("userId").toString()),"Interview",accesskey);
		//Set Status in User registration
         
		}else {
			return "redirect:login";
		}
		return msg;
	}
	
	@GetMapping("/printInterviewForm")
	public String printInterView(@RequestParam("accesskey") String accesskey, @RequestParam("interviewCount") Integer interviewCount ,Model model) {
		Optional<ParticipantRegistration> particpant = participantService.getParticipantByAccesskey(accesskey);
		Optional<InterviewScore> score = interviewScoreService.findByAccesskeyAndInterviewCount(accesskey,interviewCount);
		//SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		if(particpant.isPresent()) {
			model.addAttribute("designation", particpant.get().getDesignation());	
			if (interviewCount == 1) {
				model.addAttribute("date", particpant.get().getInterviewDate().format(df));
			}
			if (interviewCount == 2) {
				model.addAttribute("date", particpant.get().getInterviewDate2().format(df));
			}
			model.addAttribute("accesskey", particpant.get().getAccessKey());	
			model.addAttribute("photograph", particpant.get().getPhotograph());
			model.addAttribute("name", DataProccessor.getFullNameOfParticipant(particpant.get()));	
		}
		if (score.isPresent()) {
			model.addAttribute("score", score.get());
		}else {
			model.addAttribute("score", new InterviewScore());	
		}
		return "printInterviewScore";
	}
	
	@RequestMapping(path = "/downloadInterviewScore/{accesskey}", method = RequestMethod.GET)
	public ResponseEntity<Resource> download(@PathVariable("accesskey") String accesskey) throws IOException {
		File file = new File(downloadPath + accesskey + ".pdf");
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
		HttpHeaders headers = new HttpHeaders();
		headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");
		headers.add("Content-Disposition", "attachment; filename=" + accesskey + ".pdf");
		return ResponseEntity.ok().headers(headers).contentLength(file.length())
				.contentType(MediaType.parseMediaType("application/octet-stream"))
				.body(resource);
	}
	
	@RequestMapping(path = "/downloadInterviewForm", method = RequestMethod.POST)
	public ResponseEntity<Resource> downloadInterviewForm(@RequestParam("fileName") String fileName) throws IOException {
		String path="";
		if(fileName.equals("interview")) {
		   path="classpath:static/pdfTemplate/InterviewEvaluationSheet.pdf";
		}
		if(fileName.equals("suggestive")) {
			   path="classpath:static/pdfTemplate/SuggestiveQuestion.pdf";
			}
		  File file = null;
		try {
			 file = ResourceUtils.getFile(path);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
		HttpHeaders headers = new HttpHeaders();
		headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");
		if(fileName.equals("interview")) {
		headers.add("Content-Disposition", "attachment; filename=InterviewEvaluationSheet.pdf");
		}
		if(fileName.equals("suggestive")) {
			headers.add("Content-Disposition", "attachment; filename=SuggestiveQuestion.pdf");	
		}
		return ResponseEntity.ok().headers(headers).contentLength(file.length())
				.contentType(MediaType.parseMediaType("application/octet-stream"))
				.body(resource);
	}
	
	
	private String sendEmailShortlisted(ParticipantRegistration participant, int count) {
		String subjectLine="duRecruit – Your Job Application: Shortlisted";
		String mailBody ="";
		if(count==1) {
		mailBody=DataProccessor.readFileFromResource("shortlistedEmail");
		}else if (count==2) {
			mailBody=DataProccessor.readFileFromResource("hiredStatus");
		}
		//String smsMsg = DataProccessor.getSMS("shortlist");
		mailBody = mailBody.replace("${candidateName}", DataProccessor.getFullNameOfParticipant(participant));
		HRE dealer =hreService.getById(participant.getHreId()).get();
			mailBody = mailBody.replace("${dealerName}",dealer.getName());
			mailBody = mailBody.replace("${link}", candLink);      //Docs Upload link will be here
			mailBody = mailBody.replace("${accesskey}",participant.getAccessKey());
			if(dealer.getMobile() != null) {
			  mailBody = mailBody.replace("${mobile}",dealer.getMobile());
			}else {
				 mailBody = mailBody.replace("${mobile}","");	
			}
			if(dealer.getEmail() != null) {
			   mailBody = mailBody.replace("${email}",dealer.getEmail());
			}else {
				mailBody = mailBody.replace("${email}","");
			}
		//Create Payload
		SendPayload sendP = new SendPayload();
		//sendP.setTo(to);
		sendP.setTo(participant.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
		sendP.setCc(dealer.getEmail());
		sendP.setBcc("");
		sendP.setFrom("Armezo Solutions");
		EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(),
				sendP.getMsg(), "smtp");
		return "success";
	}
	private String sendEmailHiredToHRE(ParticipantRegistration participant) {
		String subjectLine="duRecruit – Your Job Application: Shortlisted";
		String mailBody=DataProccessor.readFileFromResource("hiredStatusHRE");
		//String smsMsg = DataProccessor.getSMS("shortlist");
		mailBody = mailBody.replace("${candidateName}", DataProccessor.getFullNameOfParticipant(participant));
		HRE dealer =hreService.getById(participant.getHreId()).get();
		mailBody = mailBody.replace("${dealerName}",dealer.getName());
		mailBody = mailBody.replace("${appLink}", appLink+"/login");
		mailBody = mailBody.replace("${accesskey}",participant.getAccessKey());
		if(dealer.getMobile() != null) {
			mailBody = mailBody.replace("${mobile}",dealer.getMobile());
		}else {
			mailBody = mailBody.replace("${mobile}","");	
		}
		if(dealer.getEmail() != null) {
			mailBody = mailBody.replace("${email}",dealer.getEmail());
		}else {
			mailBody = mailBody.replace("${email}","");
		}
		//Create Payload
		SendPayload sendP = new SendPayload();
		sendP.setTo(participant.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
		sendP.setCc(dealer.getEmail());
		sendP.setBcc("");
		sendP.setFrom("Armezo Solutions");
		EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(),
				sendP.getMsg(), "smtp");
		return "success";
	}
	
	
	 private void eventLogin(int loginId,String eventMSG,String accesskey) {
		 EventLoger event = new EventLoger();
         event.setAccesskey(accesskey);
         event.setEmail("");
         event.setEventTime(LocalDate.now());
         event.setName("");
         event.setEvent(eventMSG);
         event.setUserId(loginId);
         eventLogerServer.save(event);
	}

}
