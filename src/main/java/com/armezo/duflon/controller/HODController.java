package com.armezo.duflon.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class HODController {
	@Autowired
	private ParticipantServiceImpl participantService;
	@Autowired
    private InterviewScoreService interviewScoreService;
	
	@Value("${client.url}")
	private String appLink;
	@Value("${cand.link}")
	private String candLink;
	@Autowired
	private HREService hreService;
	@Autowired
	private UserService userService;
	@Autowired
	EventLogerService eventLogerServer;
	
	
	@GetMapping("/pendingForApproval")
	public String pendingForApprovalHOD(
			@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
			Model model, HttpSession session) {
		if(session.getAttribute("userId")!=null) {
			Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        List<ParticipantRegistration> participants = participantService.getAllParticipantsPendingForApproval(map.get("from"),map.get("to"));
	        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	        for (final ParticipantRegistration p : participants) {
	            if (p.getTestStatus() != null && (p.getTestStatus().equals("1") || p.getTestStatus().equals("3"))) {
	                final ModelParticpantView modelParticpantView = new ModelParticpantView();
	                if (p.getRegistration_Date() != null) {
	                    modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
	                }
	                if (p.getTestCompletionDate() != null) {
	                    modelParticpantView.setAssessment_Completion_date(p.getTestCompletionDate().format(df));
	                }
	                modelParticpantView.setParticipantName(String.valueOf(String.valueOf(p.getFirstName())) + " " + p.getMiddleName() + " " + p.getLastName());
	                modelParticpantView.setAccesskey(p.getAccessKey());
	                modelParticpantView.setDesignation(p.getDesignation());
	                if (p.getTotalMark() != null) {
	                    modelParticpantView.setTotalMark(p.getTotalMark());
	                }
	                else {
	                    modelParticpantView.setTotalMark("");
	                }
	                if (p.getTestScore() != null) {
	                    modelParticpantView.setTestScore(p.getTestScore());
	                }
	                else {
	                    modelParticpantView.setTestScore(new StringBuilder().append(p.getAttitudeScore()).toString());
	                }
	                if (p.getPercentageScore() != null) {
	                    modelParticpantView.setPercentageScore(p.getPercentageScore());
	                }
	                else if (p.getAttitudeScore() != null && p.getAttitudeScore() > 0) {
	                    final int passingPer = p.getAttitudeScore() / 40 * 100;
	                    modelParticpantView.setPercentageScore(new StringBuilder(String.valueOf(passingPer)).toString());
	                }
	                modelParticpantView.setEmail(p.getEmail());
	                modelParticpantView.setMobile(p.getMobile());
	                modelParticpantView.setTestStatus(p.getTestStatus());
	                modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
	                modelParticpantView.setPassFailStatus(p.getPassFailStatus());
	                if (p.getInterviewDate() != null) {
	                    final String regDate = p.getInterviewDate().format(df);
	                    final String s = String.valueOf(String.valueOf(regDate)) + " " + p.getInterviewTime();
	                    modelParticpantView.setInterViewDate(s);
	                }
	                else {
	                    modelParticpantView.setInterViewDate("");
	                }
	                if (p.getInterviewDate2() != null) {
	                	final String regDate = p.getInterviewDate2().format(df);
	                	final String s = String.valueOf(String.valueOf(regDate)) + " " + p.getInterviewTime2();
	                	modelParticpantView.setInterViewDate2(s);
	                }
	                else {
	                	modelParticpantView.setInterViewDate2("");
	                }
	                final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),1);
	                final Optional<InterviewScore> interView2 = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),2);
	                if (interView.isPresent()) {
	                    modelParticpantView.setInterViewStatus(interView.get().getStatus());
	                    modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
	                }
	                else {
	                    modelParticpantView.setInterViewStatus("");
	                    modelParticpantView.setInterViewPassFailStatus("");
	                }
	                if (interView2.isPresent()) {
	                	modelParticpantView.setInterViewStatus2(interView.get().getStatus());
	                	modelParticpantView.setInterViewPassFailStatus2(interView.get().getPass_fail_status());
	                }
	                else {
	                	modelParticpantView.setInterViewStatus2("");
	                	modelParticpantView.setInterViewPassFailStatus2("");
	                }
	                if(p.getAptitudeScore() != null) {
	                modelParticpantView.setAptitude((int)p.getAptitudeScore());
	                }else {
	                	  modelParticpantView.setAptitude(0);	
	                }
	                if(p.getAttitudeScore() != null) {
	                modelParticpantView.setAttitude((int)p.getAttitudeScore());
	                }else {
	                	 modelParticpantView.setAttitude(0);	
	                }
	                listParticipant.add(modelParticpantView);
	            }
	        }
	        model.addAttribute("participantList", (Object)listParticipant);
			return "HODPendingForApproval";
		}else {
			return "redirect:login";
		}
	}
	
	@PostMapping("/approveParticipant")
	@ResponseBody
	public String approveParticipant(@RequestParam("accesskey") String accesskey, HttpSession session) {
		if(session.getAttribute("userId")!=null) {
		Optional<ParticipantRegistration> partOptional = participantService.findByAccesskey(accesskey);
		if(partOptional.isPresent()) {
			partOptional.get().setHiredStatus("Y");
			partOptional.get().setHiredDate(LocalDate.now());
			partOptional.get().setJoiningDate(LocalDate.now());
			participantService.saveData(partOptional.get());
			sendEmailHiredToHRE(partOptional.get());
			sendEmailHired(partOptional.get());
			Optional<UserRegistration> userOptional = userService.getUserByAccesskey(accesskey);
            if(userOptional.isPresent()) {
            	userOptional.get().setJoinedStatus("Y");
            	userService.saveUser(userOptional.get());
            }
            eventLogin(Integer.parseInt(session.getAttribute("userId").toString()),"Approve Candidate",accesskey);
            
		}
		return "Success";
		}else {
			return "redirect:login";
		}
	}
	
	private String sendEmailHired(ParticipantRegistration participant) {
		String subjectLine="DuRecruit – Your Job Application: Hired";
		String mailBody ="";
			mailBody=DataProccessor.readFileFromResource("hiredStatus");
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
		String subjectLine="DuRecruit – Candidate: Hired";
		String mailBody=DataProccessor.readFileFromResource("hiredStatusHRE");
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
		sendP.setTo(dealer.getEmail());
		sendP.setSubjectLine(subjectLine);
		sendP.setMsg(mailBody);
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
