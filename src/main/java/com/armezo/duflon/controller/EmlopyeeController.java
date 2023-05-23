package com.armezo.duflon.controller;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.client.RestClientReattemp;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class EmlopyeeController {
	
	@Autowired
	ParticipantServiceImpl participantserviceImpl;
	@Autowired
	LineManagerServiceImpl lmService;
	@Autowired
	HREService hreService;
	@Autowired
	InterviewScoreService interviewScoreService;
	@Autowired
	RestClientReattemp restClientReattemp;
	
	
	@GetMapping("/viewCompletedByHre")
	public String getEmployeeDealer(HttpSession session, Model model) {
		List<ModelParticpantView> listParticipant = new ArrayList<>();
		
		if (session.getAttribute("userId") != null) {
			long hreId = Long.parseLong(session.getAttribute("userId").toString());
			final Optional<HRE> hre = (Optional<HRE>)this.hreService.getById(hreId);
			//SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			List<ParticipantRegistration> participant = participantserviceImpl.getEmployee(hreId,"Y");
			
		
			for (ParticipantRegistration p : participant) {
				if(p.getTestStatus() !=null && Integer.parseInt(p.getTestStatus() )== 3 && (p.getHiredStatus() != null && p.getHiredStatus().equalsIgnoreCase("Y"))) {
				ModelParticpantView modelParticpantView = new ModelParticpantView();
				modelParticpantView.setParticipantName(p.getFirstName() + " " + p.getMiddleName() + " " + p.getLastName());
				modelParticpantView.setAccesskey(p.getAccessKey());
				modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
				 if(p.getTestCompletionDate() != null) {
                 	modelParticpantView.setAssessment_Completion_date(p.getTestCompletionDate().format(df));
                 }
				if(p.getTestStatus() != null) {
				modelParticpantView.setTestStatus(p.getTestStatus());
				modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));

				modelParticpantView.setPassFailStatus(Integer.valueOf(p.getPassFailStatus()));
				}else {
					modelParticpantView.setTestStatus("");
				}
				modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));	
				if(p.getPassFailStatus() != 0) {
				modelParticpantView.setPassFailStatus((p.getPassFailStatus()));
				}else {
					modelParticpantView.setPassFailStatus(0);	
				}
					
				modelParticpantView.setEmail(p.getEmail());
				modelParticpantView.setMobile(p.getMobile());
				
				if(p.getTestScore() != null) {
					modelParticpantView.setTestScore(p.getTestScore());	
				}else {
					modelParticpantView.setTestScore("0");	
				}
				if(p.getPercentageScore() != null) {
					modelParticpantView.setPercentageScore(p.getPercentageScore());
				}else {
						modelParticpantView.setPercentageScore("0");
				}
				if(p.getTotalMark() != null) {
					modelParticpantView.setTotalMark(p.getTotalMark());
				}else {
					modelParticpantView.setTotalMark("40");	
				}
				if(p.getInterviewDate() != null) {
				String	regDate = p.getInterviewDate().format(df);
				String  s =	regDate+" "+p.getInterviewTime();
				modelParticpantView.setInterViewDate(s);
				}else {
					modelParticpantView.setInterViewDate("");	
				}
				if(p.getInterviewDate2() != null) {
					String	regDate = p.getInterviewDate2().format(df);
					String  s =	regDate+" "+p.getInterviewTime2();
					modelParticpantView.setInterViewDate2(s);
				}else {
					modelParticpantView.setInterViewDate2("");	
				}
				modelParticpantView.setInterViewStatus("N/A");
				modelParticpantView.setDesignation(p.getDesignation());
				Optional<InterviewScore> interView = interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),1);
				Optional<InterviewScore> interView2 = interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),2);
				if(interView.isPresent()) {
					modelParticpantView.setInterViewStatus(interView.get().getStatus());
					 modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
				} else {
                    modelParticpantView.setInterViewStatus("");
                    modelParticpantView.setInterViewPassFailStatus("");
                }
				if(interView2.isPresent()) {
					modelParticpantView.setInterViewStatus2(interView2.get().getStatus());
					modelParticpantView.setInterViewPassFailStatus2(interView2.get().getPass_fail_status());
				} else {
					modelParticpantView.setInterViewStatus2("");
					modelParticpantView.setInterViewPassFailStatus2("");
				}
				if (hre.isPresent()) {
					modelParticpantView.setHreName(DataProccessor.getStringValue(hre.get().getName()));	 
				}
	             modelParticpantView.setAptitude(p.getAptitudeScore());
                 modelParticpantView.setAttitude(p.getAttitudeScore());
                 modelParticpantView.setHiredStatus(p.getHiredStatus());
				listParticipant.add(modelParticpantView);
				}
			}
			model.addAttribute("hreId", (Object)hreId);
			model.addAttribute("pass", DataProccessor.getPassFailStatusMap());

		}else {
			return "redirect:login";
		}
		model=DataProccessor.setDateRange(model);
		model.addAttribute("participantList", listParticipant);
		return "employeeDealer";
	}
	/*
	@GetMapping("/getEmployeeByFSDM")
	public String getEmployeeFSDM(HttpSession session, Model model) {
      List<ModelParticpantView> listParticipant = new ArrayList<>();
      List<Outlet> dealerCodeList = new ArrayList<Outlet>();
		
		if (session.getAttribute("userId") != null) {
			
			final List<Designation> designations2 = designationService.getAll();
	        final Map<String, String> designation = designations2.stream().collect(Collectors.toMap((Function<? super Designation, ? extends String>)Designation::getDesignationCode, (Function<? super Designation, ? extends String>)Designation::getDesignationName));
			
			int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
			
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			List<Long>list = new ArrayList<>();
			Optional<LineManager> f =	fsdmservice.getFSDM(fsdmId);
			for(Region r: f.get().getRegion()) {
				List<Outlet> outletList=	outletService.getOutletByRegion(r.getId());
				for(Outlet outlet: outletList) {
					dealerCodeList.add(outlet);
					list.add(outlet.getDealer().getId());
				}
			}			
			List<ParticipantRegistration> participant = participantserviceImpl.findByhreIdEmployeeFSDM(list);		
			for (ParticipantRegistration p : participant) {
				if(p.getTestStatus() !=null && Integer.parseInt(p.getTestStatus() )== 3 && (p.getFsdmApprovalStatus() != null && Integer.parseInt(p.getFsdmApprovalStatus())==2)) {
				ModelParticpantView modelParticpantView = new ModelParticpantView();				
				modelParticpantView
						.setParticipantName(p.getFirstName() + " " + p.getMiddleName() + " " + p.getLastName());
				modelParticpantView.setAccesskey(p.getAccessKey());
				modelParticpantView.setDesignation(p.getDesignation());
				if(p.getTotalMark() != null) {
					modelParticpantView.setTotalMark(p.getTotalMark());
				}else {
					modelParticpantView.setTotalMark("40");	
				}
				if(p.getTestScore() != null) {
					modelParticpantView.setTestScore(p.getTestScore());	
				}else {
					modelParticpantView.setTestScore(p.getAttitudeScore()+"");	
				}
				if(p.getPercentageScore() != null) {
					modelParticpantView.setPercentageScore(p.getPercentageScore());
				}else {
					if(p.getAttitudeScore() != null && p.getAttitudeScore()>0) {
						int  passingPer = (p.getAttitudeScore() / 40)*100;
						modelParticpantView.setPercentageScore(passingPer+"");
					}
				}
				
				modelParticpantView.setTestStatus(p.getTestStatus());
				modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));				
				modelParticpantView.setPassFailStatus(p.getPassFailStatus());
				if(p.getInterviewDate() != null) {					
					String	regDate = formatter.format(p.getInterviewDate());
					String  s =	regDate+" "+p.getInterviewTime();
					modelParticpantView.setInterViewDate(s);
				}else {
						modelParticpantView.setInterViewDate("");	
				}
				Optional<InterviewScore> interView = interviewScoreService.findByAccesskey(p.getAccessKey());
				if(interView.isPresent()) {
					modelParticpantView.setInterViewStatus(interView.get().getStatus());
					 modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
				} else {
                    modelParticpantView.setInterViewStatus("");
                    modelParticpantView.setInterViewPassFailStatus("");
                }
				modelParticpantView.setMspin(p.getMspin());
				modelParticpantView.setPrarambhStatus(p.getPrarambhStatus());

				if(p.getFsdmApprovalStatus() == null) {
					modelParticpantView.setFsdmApprovalStatus("Approval Awaited");
				}else if(p.getFsdmApprovalStatus().equals("1")){
					modelParticpantView.setFsdmApprovalStatus("Feedback Given");	
				}else if(p.getFsdmApprovalStatus().equals("2")) {
					modelParticpantView.setFsdmApprovalStatus("Approved");		
				}
				else if(p.getFsdmApprovalStatus().equals("3")) {
					modelParticpantView.setFsdmApprovalStatus("Approval Awaited");		
				}
				modelParticpantView.setDateOfRegistration(formatter.format(p.getRegistration_date()));
				 if(p.getTestCompletionDate() != null) {
                 	modelParticpantView.setAssessment_Completion_date(formatter.format(p.getTestCompletionDate()));
                 }
				modelParticpantView.setDealerCode(p.getOutletCode());
				modelParticpantView.setMobile(p.getMobile());
				final Optional<Outlet> outlet = outletService.getOutletByOutletCodeAndhreId(p.getOutletCode(),p.gethreId());
	             if(outlet.isPresent()) {
	             	modelParticpantView.setRegionCode(outlet.get().getRegion().getRegionCode());
	             	modelParticpantView.setParentDealer(outlet.get().getParentDealer().getParentDealerName());
	             	modelParticpantView.setDealerName(outlet.get().getOutletName());
	             	modelParticpantView.setOutletCode(outlet.get().getOutletCode());
	             	modelParticpantView.setCity(outlet.get().getCity().getCityName());
	             	modelParticpantView.setState(outlet.get().getState().getStateName());
	             }else {
	             	modelParticpantView.setRegionCode("");
	             	modelParticpantView.setParentDealer("");
	             	modelParticpantView.setDealerName("");
	             	modelParticpantView.setOutletCode("");
	             	modelParticpantView.setCity("");
	             	modelParticpantView.setState("");
	             }
	             if (p.getFinalDesignation() != null) {
                     modelParticpantView.setFinalDesignation((String)designation.get(p.getFinalDesignation()));
                     modelParticpantView.setFinalDesignationCode(p.getFinalDesignation());
                 }
	             String fsdmReason ="";
	             if( p.getFsdmFeedback() != null && !p.getFsdmFeedback().equals("")) {
	          	   fsdmReason = p.getFsdmFeedback();
	             }
	             if(p.getFsdmRejectionType() != null && !p.getFsdmRejectionType().equals("")) {
	          	   fsdmReason += " &#013 "+ p.getFsdmRejectionType();  
	             }
	             if(p.getFsdmRejectionReason() != null &&! p.getFsdmRejectionReason().equals("")) {
	          	   fsdmReason += " &#013 "+ p.getFsdmRejectionReason();    
	             }
	             if(p.getFsdmRejectionComment() != null &&  !p.getFsdmRejectionComment().equals("") ) {
	          	   fsdmReason += " &#013 "+ p.getFsdmRejectionComment();      
	             }
	             modelParticpantView.setFsdmReason(fsdmReason);
	             modelParticpantView.setAptitude(p.getAptitudeScore());
                 modelParticpantView.setAttitude(p.getAttitudeScore());
				listParticipant.add(modelParticpantView);
				}
			}

		}else {
			return "redirect:login";
		}
		final List<Designation> designations3 = designationService.getAll();
        DataProccessor.setDateRange(model);
        model.addAttribute("participantList", (Object)listParticipant);
        model.addAttribute("dealerCodeList", dealerCodeList);
        model.addAttribute("designations", (Object)designations3);
        model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
		return "employeeFSDM";
	}
	
	*/
	
}
