package com.armezo.duflon.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.DataListService;
import com.armezo.duflon.Services.EmergencyContactService;
import com.armezo.duflon.Services.ErrorLoggerService;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.FamilyDetailService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.MasterDataService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;

@Controller
public class CandidateRegistrationController {
	
	@Autowired
    private ParticipantServiceImpl participantservice;
    @Autowired
    private HREService hreService;
    @Autowired
    private FamilyDetailService familyDetailService;
    @Autowired
    private EmergencyContactService emergencyContactService;
    @Autowired
    private WorkExperienceService workExperienceService;
    @Autowired
    InterviewScoreService interviewScoreService;
    @Autowired
    EventLogerService eventLogerServer;
    @Autowired
    private ErrorLoggerService errorService;
    @Autowired
    private DataListService dlService;
    @Autowired
	private MasterDataService masterDataService;
	
	
	@GetMapping({ "/getPersonalDetailsPart" })
    public String getParticipantPersonalDetailsPart(@RequestParam("accesskey") final String accesskey, final Model model) {
        	String locationCode="";
            final Optional<ParticipantRegistration> participantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
            final ParticipantRegistration participant = participantOptional.get();
            model.addAttribute("language", (Object)this.dlService.getByListName("LANGUAGE"));
            List<String> educaions = masterDataService.getAllMasterDataByMasterName("Education");
            model.addAttribute("educations", educaions);
            model.addAttribute("title", (Object)this.dlService.getByListName("TITLE_CD"));
            model.addAttribute("ID", (Object)this.dlService.getByListName("ID"));
            model.addAttribute("gender", (Object)this.dlService.getByListName("GENDER"));
            model.addAttribute("personal", (Object)participant);
            model.addAttribute("locationCode", locationCode);
            return "personal-details-part";
    }
	
	 @GetMapping({ "/getempdetailsPart" })
	    public String getParticipantEmploymentDetails(final ParticipantRegistration participantRegistration, @RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("emp", (Object)participant.get());
	        
	        return "employment-details-part";
	    }
	 
	 @GetMapping({ "/getgeneraldetailsPart" })
	    public String getParticipantGeneralDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("general", (Object)participant.get());
	        final List<String> martialStatus = new ArrayList<String>();
	        martialStatus.add("Married");
	        martialStatus.add("Single");
	        martialStatus.add("Divorced");
	        model.addAttribute("martialStatus", (Object)martialStatus);
	        model.addAttribute("blodgroup", (Object)this.dlService.getByListName("BLOOD_GRP"));
	        return "general-details-part";
	    }
	 
	 @GetMapping({ "/getWorkExperiencePart" })
	    public String getParticipantWorkExperienceDetails(@RequestParam("accesskey") final String accesskey,@RequestParam("param") final String param,
	    		final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            if (participant.get().getExperience() != null && participant.get().getExperience().equals("fresher")) {
	                model.addAttribute("workexperience", (Object)participant.get());
	                return "work-experience";
	            }
	            if (participant.get().getExperience() != null) {
	                participant.get().getExperience().equals("experience");
	            }
	        }
	        participant.get().getWorkExperience();
	        model.addAttribute("workexperience", (Object)participant.get());
	        return "work-experience-part";
	    }
	 
	 @GetMapping({ "/getWorkExperienceExpPart" })
	    public String getParticipantWorkExperienceExpDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            final List<WorkExperience> participantWorkExp = (List<WorkExperience>)participant.get().getWorkExperience();
	            model.addAttribute("workexperienceExp", (Object)participant.get());
	            model.addAttribute("participantWorkExp", (Object)participantWorkExp);
	        }
	        else {
	            model.addAttribute("workexperienceExp", (Object)new ParticipantRegistration());
	            model.addAttribute("participantWorkExp", (Object)new ArrayList());
	        }
	        return "work-experience-exp-part";
	    }
	 
	 @GetMapping({ "/getfamilydetailsPart" })
	    public String getParticipantFamilyDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("partcipant", (Object)participant.get());
	        participant.get().getFamilyDetails();
	        model.addAttribute("relationship", (Object)this.dlService.getByListName("ENQUIRY_RELATION"));
	        if (participant.get().getFamilyDetails().size() > 0) {
	            model.addAttribute("familyDetail", (Object)participant.get().getFamilyDetails());
	        }
	        else {
	            model.addAttribute("familyDetail", (Object)new ArrayList());
	        }
	        return "family-member-details-part";
	    }
	 
	 @GetMapping({ "/getEmergencyContactPart" })
	    public String getParticipantEmergencyContact(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("emergencyContact", (Object)participant.get());
	        final List<EmergencyContact> emergency = (List<EmergencyContact>)participant.get().getEmergencyContact();
	        model.addAttribute("emergency", (Object)emergency);
	        return "emergency-contact-part";
	    }
	 
	 @GetMapping({ "/uploadDocomentPart" })
	    public String uploadDocument(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("participant", (Object)participant.get());
	        return "upload-documents-part";
	    }
	 
	 
	 
	 
	 
	 
	 

}
