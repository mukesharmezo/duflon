package com.armezo.duflon.controller;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.ErrorLogger;
import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.EmergencyContactService;
import com.armezo.duflon.Services.ErrorLoggerService;
import com.armezo.duflon.Services.FamilyDetailService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.analytics.entity.AnalyticsAll;
import com.armezo.duflon.analytics.service.AnalyticsAllService;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class CandidateController {

	@Autowired
	AccessKeyMasterService accessKeyMasterService;
	@Autowired
	ParticipantServiceImpl participantService;
	@Autowired
	WorkExperienceService workExperienceService;
	@Autowired
	EmergencyContactService emergencyContactService;
	@Autowired
	FamilyDetailService familyDetailService;
	@Autowired
	InterviewScoreService interviewScoreService;
	@Autowired
	private ErrorLoggerService loggerService;
	@Autowired
	private AnalyticsAllService allService;
	
	@GetMapping("/participantModule")
	public String showParticipantModule(Model model) {
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd MMM, yyyy hh:mm:ss a");
		List<ErrorLogger> loggers = loggerService.getAllErrorLogger();
		List<ModelParticpantView> views = new ArrayList<ModelParticpantView>();
		for(ErrorLogger error : loggers) {
			//for(int i=1; i<9; i++) {
			ModelParticpantView mpv = new ModelParticpantView();
			mpv.setAccesskey(error.getAccesskey());
			mpv.setErrorMessage(error.getErrorMessage());
			String time = "";
			if(error.getErrorTime()!=null) {
				time=error.getErrorTime().format(df);
			}
			mpv.setErrorDateTime(time);
			mpv.setErrorProcess(error.getProcess());
			views.add(mpv);
			//}
		}
		model.addAttribute("errors", views);
		return "participant-module";
	}
	
	
	@GetMapping("/findParticipantByAccesskey")
	@ResponseBody
	public ModelParticpantView findEmployee(@RequestParam("accesskey") String accesskey) {
		System.out.println("Accesskey : "+accesskey);
		ModelParticpantView mpv = new ModelParticpantView();
		Optional<ParticipantRegistration> part = participantService.findByAccesskey(accesskey);
		if(part.isPresent()) {
			mpv.setAccesskey(part.get().getAccessKey());
			mpv.setParticipantName(DataProccessor.getFullNameOfParticipant(part.get()));
			mpv.setDateOfRegistration(DataProccessor.dateToString(part.get().getRegistration_Date()));
		}
		System.out.println("MV"+mpv.getDateOfRegistration());
		return mpv;
	}
	@GetMapping("/deleteCandidate")
	@ResponseBody
	public String deleteEmployee(@RequestParam("accesskey") String accesskey) {
		String message = "";
		Optional<ParticipantRegistration> participant = participantService.findByAccesskey(accesskey);
		if (participant.isPresent()) {
			Optional<InterviewScore> interviewScore = interviewScoreService.findByAccesskeyAndInterviewCount(accesskey,1);
			Optional<InterviewScore> interviewScore2 = interviewScoreService.findByAccesskeyAndInterviewCount(accesskey,2);
			List<String> list = new ArrayList<String>();
			list.add(participant.get().getAccessKey());
			for (WorkExperience w : participant.get().getWorkExperience()) {
				workExperienceService.delete(w);
			}
			for (EmergencyContact em : participant.get().getEmergencyContact()) {
				emergencyContactService.deleteById(em.getId());
			}
			for (FamilyDetails l : participant.get().getFamilyDetails()) {
				familyDetailService.delete(l);
			}
			if (interviewScore.isPresent()) {
				interviewScoreService.delete(interviewScore.get());
			}
			if (interviewScore2.isPresent()) {
				interviewScoreService.delete(interviewScore2.get());
			}
			participantService.deleteParticpant(participant.get());
			accessKeyMasterService.deleteByAccesskey(accesskey);

			List<AnalyticsAll> alsit = allService.getAllAnalyticsByAccesskeyList(list);
			for (AnalyticsAll a : alsit) {
				allService.deleteById(a.getId());
			}
			message= "Participant Data Deleted";
		} else {
			message="Participant Not Found";
		}
		return message;
	}
	
	@GetMapping("/errorLogger")
	public String errorLogger(Model model) {

		return null;
	}
}
