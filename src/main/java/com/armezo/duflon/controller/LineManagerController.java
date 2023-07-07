package com.armezo.duflon.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.StateService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.payload.FilterPayload;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class LineManagerController {

	    @Autowired
	    ParticipantServiceImpl participantserviceImpl;
	    @Autowired
	    LineManagerServiceImpl lmService;
	    @Autowired
	    HREService hreService;
	    @Autowired
	    StateService stateService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    
	    @GetMapping({ "/viewAllParticapants" })
	    private String viewAllParticipantsOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantInpprocessLM( map.get("from"),map.get("to"));
	            listParticipant = this.setDataToHOProcess(participant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "LmInProcess";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllCompletedParticipant" })
	    public String viewAllCompletedParticipantOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantEmployeeLM( map.get("from"),map.get("to"));
	            listParticipant = this.setDataToHOProcess(participant);
	            model.addAttribute("participantList", (Object)listParticipant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            return "LmEmployee";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllHoldParticipantLM" })
	    public String viewAllHoldParticipantOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantHoldLM( map.get("from"),map.get("to"));
	            listParticipant = this.setDataToHOProcess(participant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "LmHoldParticipant";
	        }
	        return "redirect:login";
	    }
	    
	    private List<ModelParticpantView> setDataToHOProcess(final List<ParticipantRegistration> participants) {
	        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        //final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
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
	        return listParticipant;
	    }
	    
	    // Set Data in Process*************************************	    
	    private ModelParticpantView setDataToMPV(ParticipantRegistration p) {
	    	final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	    	DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	    	final ModelParticpantView modelParticpantView = new ModelParticpantView();
            modelParticpantView.setParticipantName(String.valueOf(p.getFirstName()) + " " + p.getMiddleName() + " " + p.getLastName());
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
                modelParticpantView.setTestScore("");
            }
            if (p.getPercentageScore() != null) {
                modelParticpantView.setPercentageScore(p.getPercentageScore());
            }
            else {
                modelParticpantView.setPercentageScore("");
            }
            modelParticpantView.setTestStatus(p.getTestStatus());
            modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
            modelParticpantView.setPassFailStatus(p.getPassFailStatus());
            if (p.getInterviewDate() != null) {
                final String regDate = formatter.format(p.getInterviewDate());
                final String s = String.valueOf(regDate) + ", " + p.getInterviewTime();
                modelParticpantView.setInterViewDate(s);
            }
            else {
                modelParticpantView.setInterViewDate("");
            }
            final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(p.getAccessKey());
            if (interView.isPresent()) {
                modelParticpantView.setInterViewStatus(interView.get().getStatus());
                modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
            }
            modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
            modelParticpantView.setAptitude(p.getAptitudeScore());
            modelParticpantView.setAttitude(p.getAttitudeScore());
            return modelParticpantView;
	    }
}
