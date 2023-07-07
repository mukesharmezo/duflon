package com.armezo.duflon.controller;

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

import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.client.RestClientReattemp;
import com.armezo.duflon.payload.FilterPayload;
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
	public String getEmployeeDealer(
			@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
			HttpSession session, Model model) {
		
		List<ModelParticpantView> listParticipant = new ArrayList<>();
		Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
		if (session.getAttribute("userId") != null) {
			long hreId = Long.parseLong(session.getAttribute("userId").toString());
			final Optional<HRE> hre = (Optional<HRE>)this.hreService.getById(hreId);
			//SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			List<ParticipantRegistration> participant = participantserviceImpl.getEmployee(hreId,"Y", map.get("from"),map.get("to"));
			
		
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
			FilterPayload payload = new FilterPayload();
            payload.setDateFrom(dateFromm);
            payload.setDateTo(dateToo);
			model.addAttribute("payload", payload);
			model.addAttribute("hreId", (Object)hreId);
			model.addAttribute("pass", DataProccessor.getPassFailStatusMap());

		}else {
			return "redirect:login";
		}
		model.addAttribute("participantList", listParticipant);
		return "employeeDealer";
	}
}
