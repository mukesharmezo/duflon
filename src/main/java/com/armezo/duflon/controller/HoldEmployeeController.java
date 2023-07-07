package com.armezo.duflon.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.City;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.State;
import com.armezo.duflon.Services.CityService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.StateService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.client.RestClientReattemp;
import com.armezo.duflon.payload.FilterPayload;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class HoldEmployeeController {
	@Autowired
    ParticipantServiceImpl participantserviceImpl;
    @Autowired
    CityService cityService;
    @Autowired
    LineManagerServiceImpl lmService;
    @Autowired
    HREService hreService;
    @Autowired
    StateService stateService;
    @Autowired
    InterviewScoreService interviewScoreService;
    @Autowired
    RestClientReattemp restClientReattemp;
    
    @GetMapping({ "/viewHoldHre" })
    public String getHoldEmployeeDealer(
    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
    		final HttpSession session, Model model) {
    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final long hreId = Long.parseLong(session.getAttribute("userId").toString());
           // final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            final Optional<HRE> hre = (Optional<HRE>)this.hreService.getById(hreId);
           List<ParticipantRegistration> participant = new ArrayList<>();
            LocalDate lastStart = LocalDate.now().minusDays(90);
    		LocalDate lastEnd = LocalDate.now();
    		DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("dd/MM/YYYY");
    		if(dateFromm!=null && dateFromm!="" && dateToo!=null && dateToo!="") {
    			participant= participantserviceImpl.getHoldParticipantsByFilterHRE(hreId,map.get("from"), map.get("to"));
    		}else {
    			participant = (List<ParticipantRegistration>)this.participantserviceImpl.getHoldEmployee(hreId, "H",lastStart,lastEnd);
			}
    		for (final ParticipantRegistration p : participant) {
                if (p.getStatus() != null && p.getStatus().equals("H")) {
                    final ModelParticpantView modelParticpantView = new ModelParticpantView();
                    modelParticpantView.setParticipantName(String.valueOf(p.getFirstName()) + " " + p.getMiddleName() + " " + p.getLastName());
                    modelParticpantView.setAccesskey(p.getAccessKey());
                    modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(formatter2));
                    if (p.getTestCompletionDate() != null) {
                        modelParticpantView.setAssessment_Completion_date(p.getTestCompletionDate().format(formatter2));
                    }
                    if (p.getTestStatus() != null) {
                        modelParticpantView.setTestStatus(p.getTestStatus());
                        modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
                        modelParticpantView.setPassFailStatus((int)p.getPassFailStatus());
                    }
                    else {
                        modelParticpantView.setTestStatus("");
                    }
                    modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
                    if (p.getPassFailStatus() != 0) {
                        modelParticpantView.setPassFailStatus(p.getPassFailStatus());
                    }
                    else {
                        modelParticpantView.setPassFailStatus(0);
                    }
                    modelParticpantView.setEmail(p.getEmail());
                    modelParticpantView.setMobile(p.getMobile());
                    if (p.getTestScore() != null) {
                        modelParticpantView.setTestScore(p.getTestScore());
                    }
                    else {
                        modelParticpantView.setTestScore("0");
                    }
                    if (p.getPercentageScore() != null) {
                        modelParticpantView.setPercentageScore(p.getPercentageScore());
                    }
                    else {
                        modelParticpantView.setPercentageScore("0");
                    }
                    if (p.getTotalMark() != null) {
                        modelParticpantView.setTotalMark(p.getTotalMark());
                    }
                    else {
                        modelParticpantView.setTotalMark("40");
                    }
                    if (p.getInterviewDate() != null) {
                        final String regDate = p.getInterviewDate().format(formatter2);
                        final String s = String.valueOf(regDate) + " " + p.getInterviewTime();
                        modelParticpantView.setInterViewDate(s);
                    }
                    else {
                        modelParticpantView.setInterViewDate("");
                    }
                    modelParticpantView.setDesignation(p.getDesignation());
                    modelParticpantView.setStatus("Hold");
                    final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(p.getAccessKey());
                    if (interView.isPresent()) {
                        modelParticpantView.setInterViewStatus(DataProccessor.getStringValue(interView.get().getStatus()));
                        modelParticpantView.setInterViewPassFailStatus(DataProccessor.getStringValue(interView.get().getPass_fail_status()));
                    }
                    if (hre.isPresent()) {
                        modelParticpantView.setHreName(DataProccessor.getStringValue(hre.get().getName()));
                    }
	                   modelParticpantView.setAptitude(DataProccessor.getIntegerValue(p.getAptitudeScore()));
	                   modelParticpantView.setAttitude(DataProccessor.getIntegerValue(p.getAttitudeScore()));
                    listParticipant.add(modelParticpantView);
                }
            }
    		FilterPayload payload = new FilterPayload();
            payload.setDateFrom(dateFromm);
            payload.setDateTo(dateToo);
			model.addAttribute("payload", payload);
			model.addAttribute("participantList", (Object)listParticipant);
			model.addAttribute("hreId", (Object)hreId);
			model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
            return "emloyeeHoldDealer";
        }
        return "redirect:login";
    }
    
    @GetMapping({ "/viewAllHoldParticipantLM2222" })
    public String viewAllHoldParticipantsOnHO(final HttpSession session, final Model model) {
        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.findAllHoldParticipantsOnHO("H");
            final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            for (final ParticipantRegistration p : participant) {
                if (p.getTestStatus() != null && (p.getTestStatus().equals("1") || p.getTestStatus().equals("3"))) {
                    final ModelParticpantView modelParticpantView = new ModelParticpantView();
                    modelParticpantView.setParticipantName(String.valueOf(p.getFirstName()) + " " + p.getMiddleName() + " " + p.getLastName());
                    modelParticpantView.setAccesskey(p.getAccessKey());
                    modelParticpantView.setDesignation(p.getDesignation());
                    modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
                    if (p.getTestCompletionDate() != null) {
                        modelParticpantView.setAssessment_Completion_date(p.getTestCompletionDate().format(df));
                    }
                    if (p.getTotalMark() != null) {
                        modelParticpantView.setTotalMark(p.getTotalMark());
                    }
                    else {
                        modelParticpantView.setTotalMark("0");
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
                        final String regDate = formatter.format(p.getInterviewDate());
                        final String s = String.valueOf(regDate) + " " + p.getInterviewTime();
                        modelParticpantView.setInterViewDate(s);
                    }
                    else {
                        modelParticpantView.setInterViewDate("");
                    }
                    final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(p.getAccessKey());
                    if (interView.isPresent()) {
                        modelParticpantView.setInterViewStatus(DataProccessor.getStringValue(interView.get().getStatus()));
                        modelParticpantView.setInterViewPassFailStatus(DataProccessor.getStringValue(interView.get().getPass_fail_status()));
                    }
                    
	                   modelParticpantView.setAptitude(p.getAptitudeScore());
	                   modelParticpantView.setAttitude(p.getAttitudeScore());
                    listParticipant.add(modelParticpantView);
                }
            }
            final Map<String, String> regionMap = new HashMap<String, String>();
            final Map<String, String> stateMap = new HashMap<String, String>();
            final Map<String, String> cityMap = new HashMap<String, String>();
            final Map<String, String> parentDMap = new HashMap<String, String>();
            final Map<String, String> dealerMap = new HashMap<String, String>();
            final Map<String, String> fSDMMap = new HashMap<String, String>();
          
            final List<State> states = (List<State>)this.stateService.getAllState();
            for (final State st : states) {
                stateMap.put(st.getStateCode(), st.getStateName());
            }
            final List<City> cities = (List<City>)this.cityService.getAllCity();
            for (final City city : cities) {
                cityMap.put(city.getCityCode(), city.getCityName());
            }
            final List<HRE> dealers = (List<HRE>)this.hreService.getAllHRE();
            for (final HRE dl : dealers) {
                dealerMap.put(dl.getEmpCode(), dl.getName());
            }
            final List<LineManager> fsdms = (List<LineManager>)this.lmService.getAllLMs();
            for (final LineManager fsdm : fsdms) {
                fSDMMap.put(fsdm.getEmpCode(), fsdm.getName());
            }
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("regionMap", (Object)regionMap);
            model.addAttribute("stateMap", (Object)stateMap);
            model.addAttribute("cityMap", (Object)cityMap);
            model.addAttribute("parentDMap", (Object)parentDMap);
            model.addAttribute("dealerMap", (Object)dealerMap);
            model.addAttribute("FSDMMap", (Object)fSDMMap);
            return "HoldParticipantHO";
        }
        return "redirect:login";
    }
}
