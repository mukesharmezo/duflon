package com.armezo.duflon.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.EmergencyContactService;
import com.armezo.duflon.Services.FamilyDetailService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.analytics.entity.AnalyticsAll;
import com.armezo.duflon.analytics.service.AnalyticsAllService;

@Controller
public class DeleteCandidate {

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
	private AnalyticsAllService allService;
	
	
	public String deleteEmployee(@RequestParam("accesskey") String accesskey) {
		Optional<ParticipantRegistration>participant = participantService.findByAccesskey(accesskey);		
		Optional<InterviewScore> interviewScore = interviewScoreService.findByAccesskey(accesskey);
		List<String>list = new ArrayList<String>();
		list.add(participant.get().getAccessKey());
		for(WorkExperience w : participant.get().getWorkExperience()) {
			workExperienceService.delete(w);
		}	
		for(EmergencyContact em : participant.get().getEmergencyContact()) {
			emergencyContactService.deleteById(em.getId());	
		}		
		for(FamilyDetails l : participant.get().getFamilyDetails()) {
			familyDetailService.delete(l);
		}	
		
		if(interviewScore.isPresent()) {
			interviewScoreService.delete(interviewScore.get());
		}
		participantService.deleteParticpant(participant.get());
		accessKeyMasterService.deleteByAccesskey(accesskey);
		
		List<AnalyticsAll> alsit  = allService.getAllAnalyticsByAccesskeyList(list);
		for(AnalyticsAll a : alsit)
		 allService.deleteById(a.getId());
		return "";
	}
}
