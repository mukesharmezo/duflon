package com.armezo.duflon.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
    public String getHoldEmployeeDealer(final HttpSession session, Model model) {
        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final long hreId = Long.parseLong(session.getAttribute("userId").toString());
           // final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            final Optional<HRE> hre = (Optional<HRE>)this.hreService.getById(hreId);
           
            
            LocalDate lastStart = LocalDate.now().minusDays(90);
    		LocalDate lastEnd = LocalDate.now();
    		DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("dd/MM/YYYY");
    		
    		//Calendar cal = Calendar.getInstance();
    		//cal.add(Calendar.MONTH, -3);
    		//Date result = cal.getTime();
    	   /* 	
    	    String a = lastStart.format(formatter2);
    	    String b = lastEnd.format(formatter2);
    		SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
    		
    		
    		Date dateFrom = null;
    		Date dateTo = null;
    		try {
    			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    			
    			//String dateTo2 = sdf.format(result);
    			dateFrom=sdf1.parse(a);
    			dateTo=sdf1.parse(b);
    			dateTo = DataProccessor.addTimeInDate(dateTo);	
    			System.out.println(dateFrom+"......"+dateTo+"....."+hreId);
    		} catch (ParseException e1) {
    		
    		}*/
            
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getHoldEmployee(hreId, "H",lastStart,lastEnd);
           
    		
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
			model.addAttribute("participantList", (Object)listParticipant);
			model=DataProccessor.setDateRange(model);
			model.addAttribute("hreId", (Object)hreId);
			model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
            return "emloyeeHoldDealer";
        }
        return "redirect:login";
    }
    /*
    @GetMapping({ "/viewHoldEmployeeByFSDM" })
    public String getHoldEmployeeFSDM(final HttpSession session, final Model model) {
        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        List<Outlet> dealerCodeList = new ArrayList<Outlet>();
        final List<Designation> designations2 = (List<Designation>)this.designationService.getAll();
        Map<String, String> designation = designations2.stream().collect(Collectors.toMap(Designation  :: getDesignationCode , Designation  :: getDesignationName));
        if (session.getAttribute("userId") != null) {
            final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
            final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            final List<Long> list = new ArrayList<Long>();
            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
            for (final Region r : f.get().getRegion()) {
                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
                for (final Outlet outlet : outletLsit) {
                	dealerCodeList.add(outlet);
                    list.add(outlet.getDealer().getId());
                }
            }
            final List<ParticipantRegistration> participant = participantserviceImpl.getParticipantByhreIdLsit(list);
            for (final ParticipantRegistration p : participant) {
                final Optional<HRE> dealer = (Optional<HRE>)this.hreService.getById((long)p.gethreId());
                if (p.getStatus() != null && p.getStatus().equals("H")) {
                    final ModelParticpantView modelParticpantView = new ModelParticpantView();
                    modelParticpantView.setParticipantName(String.valueOf(p.getFirstName()) + " " + p.getMiddleName() + " " + p.getLastName());
                    modelParticpantView.setAccesskey(p.getAccessKey());
                    modelParticpantView.setDesignation(p.getDesignation());
                    modelParticpantView.setDateOfRegistration(formatter.format(p.getRegistration_date()));
                    if (p.getTestCompletionDate() != null) {
                        modelParticpantView.setAssessment_Completion_date(formatter.format(p.getTestCompletionDate()));
                    }
                    if (p.getTotalMark() != null) {
                        modelParticpantView.setTotalMark(p.getTotalMark());
                    }
                    else {
                        modelParticpantView.setTotalMark("40");
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
                    modelParticpantView.setMspin(p.getMspin());
                    modelParticpantView.setPrarambhStatus(p.getPrarambhStatus());
                    if (p.getFsdmApprovalStatus() == null) {
                        modelParticpantView.setFsdmApprovalStatus("");
                    }
                    else if (p.getFsdmApprovalStatus().equals("1")) {
                        modelParticpantView.setFsdmApprovalStatus("Rejected");
                    }
                    else if (p.getFsdmApprovalStatus().equals("2")) {
                        modelParticpantView.setFsdmApprovalStatus("Approved");
                    }
                    else if (p.getFsdmApprovalStatus().equals("3")) {
                        modelParticpantView.setFsdmApprovalStatus("Pending");
                    }
                    modelParticpantView.setStatus("Hold");
                    modelParticpantView.setDealerCode(p.getOutletCode());
                    final Optional<Outlet> outlet2 = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(p.getOutletCode(), p.gethreId());
                    if (outlet2.isPresent()) {
                        modelParticpantView.setRegionCode(outlet2.get().getRegion().getRegionCode());
                        modelParticpantView.setParentDealer(outlet2.get().getParentDealer().getParentDealerName());
                        modelParticpantView.setDealerName(outlet2.get().getOutletName());
                        modelParticpantView.setOutletCode(outlet2.get().getOutletCode());
                        modelParticpantView.setCity(outlet2.get().getCity().getCityName());
                        modelParticpantView.setState(outlet2.get().getState().getStateName());
                    }
                    else {
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
	                   modelParticpantView.setAptitude(p.getAptitudeScore());
	                   modelParticpantView.setAttitude(p.getAttitudeScore());
	                   modelParticpantView.setFsdmReason(fsdmReason);
                    listParticipant.add(modelParticpantView);
                }
            }
            final List<Designation> designations3 = designationService.getAll();
            DataProccessor.setDateRange(model);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("dealerCodeList", dealerCodeList);
            model.addAttribute("designations", (Object)designations3);
            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
            return "viewHoldEmployeeByFSDM";
        }
        return "redirect:login";
    }
    */
    @GetMapping({ "/viewAllHoldParticipantLM" })
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
            final List<HRE> dealers = (List<HRE>)this.hreService.getAllDeealer();
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
    /*
    //Dealer Hold Filter
    @PostMapping({ "/holdFilterParticipant" })
    public String dealerFilters(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
			@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
			@RequestParam("dateFromm") String dateFromm,@RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
    	
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
		Date dateFromSearch=null;
		Date dateToSearch=null;
		Long hreId=0L;	
		LocalDate lastStart = LocalDate.now().minusDays(90);	
		LocalDate lastEnd = LocalDate.now();
 		DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 	    String fromStart = lastStart.format(formatter2);	
 	    String fromEnd= lastEnd.format(formatter2);	
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		try {
			//dateFrom=sdf2.parse(fromStart);
			if (dateFromm != null && dateFromm != "") {
				dateFromSearch = sdf2.parse(dateFromm);
			}
			if (dateToo != null && dateToo != "") {
				dateToSearch = sdf2.parse(dateToo);
			
			}
			
			//System.out.println("cal.1............"+dateFrom+"....."+dateFromm);
			Date d1 =sdf2.parse(fromStart);
		
			//System.out.println("cal.2........."+d1+"..."+fromStart+"............"+d1.compareTo(dateFrom));
			Calendar cal1 = Calendar.getInstance();
			Calendar cal2 = Calendar.getInstance();
			
			cal1.setTime(dateFromSearch);
			cal2.setTime(d1);
			if(dateFromSearch.compareTo(d1)<0) {
				dateFromSearch=sdf2.parse(fromStart);
				dateToSearch=sdf2.parse(fromEnd);
			}else {
				System.out.println("else..........");	
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if (session.getAttribute("userId") != null) {
			//check data 
			if(outletCode==null )
				outletCode="";
			if(candidateName==null)
				candidateName="";
			if(uniqueCode==null) {
				uniqueCode="";
			}
			if(designation==null)
				designation="";
			if(mspin==null)
				mspin="";
			List<Integer> passFStatus = new ArrayList<>();
			if(passFailStatus=="") {
					passFStatus.add(1);
					passFStatus.add(0);
				}else {
					passFStatus.add(Integer.valueOf(passFailStatus));
				}
			
			hreId = Long.parseLong(session.getAttribute("userId").toString());
			final Optional<HRE> dealer = (Optional<HRE>)this.hreService.getById(hreId);
			final List<Designation> designations2 = (List<Designation>)this.designationService.getAll();
			Map<String, String> designation3 = designations2.stream().collect(Collectors.toMap(Designation  :: getDesignationCode , Designation  :: getDesignationName));
			Map<String, String> SalesDesignation = designations2.stream().filter(p ->p.getCategory().equals("Sales")).collect(Collectors.toMap(Designation  :: getDesignationCode , Designation  :: getDesignationName));
			final String status = "H";
			List<ParticipantRegistration> participantList=null;
			if(dateFromSearch!=null && dateToSearch!=null)
			{
				participantList = participantserviceImpl.getParticipantOnHoldByFilterData(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,hreId,dateFromSearch,dateToSearch,status);
			}else {
				participantList= participantserviceImpl.getParticipantOnHoldByFilterData2(outletCode, candidateName, designation, mspin, passFStatus, hreId, uniqueCode,status);
			}
            listParticipant = setDataToMPVByDealer(participantList, dealer);
            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
            final List<Designation> designations = designationService.getAll();
          //Adding data to Search 
            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,dateFromm);
            filterPayload.setDateFrom(dateFromm);
            filterPayload.setDateTo(dateToo);
            model.addAttribute("payload", filterPayload);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("outlets", (Object)outlets);
            model.addAttribute("designations", (Object)designations);
            model = DataProccessor.setDateRange(model);
            model.addAttribute("hreId", (Object)hreId);
            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
            return "emloyeeHoldDealer";
        }
        return "redirect:login";
    }
    //Status Filter For Hold Employee
    @PostMapping({ "/completionStatusHold" })
	public String checkCompletionProcessFilter(@RequestParam(required = false) final String interview,
			@RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, final HttpSession session, Model model) {
		List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
		List<Long> hreIdList = new ArrayList<Long>();
		FilterPayload payload = new FilterPayload();
		Integer interviewSearch = null;
		String praraambhSearch = prarambh;
		List<String> fsdmSearch=new ArrayList<String>();
		if (interview != null) {
			interviewSearch = 0;
			payload.setInterview("check");
		}
		if (prarambh != null) {
			payload.setPraraambh("check");
			praraambhSearch = "2";
		}
		if(fsdm!=null) {
			payload.setFsdmApproved("check");
			 fsdmSearch.add("1");
			 }

		if (session.getAttribute("userId") != null) {
			Long hreId = Long.parseLong(session.getAttribute("userId").toString());
			hreIdList.add(hreId);
			final Optional<HRE> dealer = hreService.getById(hreId);
			final List<ParticipantRegistration> list = participantserviceImpl.findParticipantsByCompletionFilterOnHold(interviewSearch, praraambhSearch, fsdmSearch, hreIdList);
			listParticipant = setDataToMPVByDealer(list, dealer);
			model = DataProccessor.setDateRange(model);
			model.addAttribute("participantList", (Object) listParticipant);
			model.addAttribute("outlets", (Object) outlets);
			model.addAttribute("designations", (Object) designations);
			model.addAttribute("hreId", (Object) hreId);
			model.addAttribute("payload", (Object) payload);
			return "emloyeeHoldDealer";
		}
		return "redirect:login";
	}*/
    	// Set Data
    /*
	private List<ModelParticpantView> setDataToMPVByDealer(List<ParticipantRegistration> part, Optional<HRE> dealer) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		List<ModelParticpantView> listMPV = new ArrayList<>();
		  final List<Designation> designations2 = (List<Designation>)this.designationService.getAll();
          Map<String, String> designation = designations2.stream().collect(Collectors.toMap(Designation  :: getDesignationCode , Designation  :: getDesignationName));
		for (ParticipantRegistration p : part) {
			if(p.getStatus() != null && p.getStatus().equals("H")) {
			ModelParticpantView modelParticpantView = new ModelParticpantView();
			modelParticpantView.setParticipantName(p.getFirstName() + " " + p.getMiddleName() + " " + p.getLastName());
			modelParticpantView.setAccesskey(p.getAccessKey());
			modelParticpantView.setDateOfRegistration(formatter.format(p.getRegistration_date()));
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
				
			String	regDate = formatter.format(p.getInterviewDate());
			String  s =	regDate+" "+p.getInterviewTime();
			modelParticpantView.setInterViewDate(s);
			}else {
				modelParticpantView.setInterViewDate("");	
			}
			modelParticpantView.setInterViewStatus("N/A");
			modelParticpantView.setDesignation(p.getDesignation());
			if(p.getPrarambhStatus() == null) {
			modelParticpantView.setPrarambhStatus("N/A");
			}else {
				modelParticpantView.setPrarambhStatus(p.getPrarambhStatus());	
			}
			if(p.getFsdmApprovalStatus() == null) {
				modelParticpantView.setFsdmApprovalStatus("");
			}else if(p.getFsdmApprovalStatus().equals("1")) {
				modelParticpantView.setFsdmApprovalStatus("Rejected");
			}else if(p.getFsdmApprovalStatus().equals("2")) {
				modelParticpantView.setFsdmApprovalStatus("Approved");		
			}else if(p.getFsdmApprovalStatus().equals("3")) {
				modelParticpantView.setFsdmApprovalStatus("Pending");		
			}
			modelParticpantView.setStatus("Hold");
			modelParticpantView.setOutletCode(DataProccessor.getStringValue(p.getOutletCode()));
			Optional<InterviewScore> interView = interviewScoreService.findByAccesskey(p.getAccessKey());
			if(interView.isPresent()) {
				modelParticpantView.setInterViewStatus(interView.get().getStatus());
				 modelParticpantView.setInterViewPassFailStatus(DataProccessor.getStringValue(interView.get().getPass_fail_status()));
			}
			
			if (dealer.isPresent()) {
				modelParticpantView.setDealerName(DataProccessor.getStringValue(dealer.get().getName()));
				modelParticpantView.setMspin(p.getMspin());
				modelParticpantView.setPrarambhStatus(p.getPrarambhStatus());
					 
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
             if(p.getAptitudeScore() != null) {
             modelParticpantView.setAptitude(p.getAptitudeScore());
             }
           if(p.getAttitudeScore() != null) {
             modelParticpantView.setAttitude(p.getAttitudeScore());
           }
             modelParticpantView.setFsdmReason(fsdmReason);
			listMPV.add(modelParticpantView);
			}
		}
		return listMPV;
	}
*/
}
