
package com.armezo.duflon.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import com.armezo.duflon.Services.CityService;
import com.armezo.duflon.Services.EventLogerServer;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.StateService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.client.RestClientReattemp;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.email.util.SmsUtility;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class HreController {
	

	 @Autowired
	    ParticipantServiceImpl participantserviceImpl;
	    @Autowired
	    CityService cityService;
	    @Autowired
	    HREService hreService;
	    @Autowired
	    StateService stateService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    @Autowired
	    RestClientReattemp restClientReattemp;
	    @Autowired
	    EventLogerServer eventLogerServer;
	    @Value("${Ap.candLink}")
	  	private String candLink;
	    
	    @GetMapping({ "/viewProcess" })
	    private String getDealer(final HttpSession session, final Model model) {
	        //final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        long hreId = 0L;
	        if (session.getAttribute("userId") != null) {
	            hreId = Long.parseLong(session.getAttribute("userId").toString());	         
	            final Optional<HRE> dealer = hreService.getById(hreId);
	            final List<ParticipantRegistration> participant = participantserviceImpl.getParticipantInpprocessForHRE(hreId);	          
                model.addAttribute("participantList",   getParticpant(participant,dealer,hreId+""));
                model.addAttribute("hreId", (Object)hreId);
                model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
                DataProccessor.setDateRange(model);
	            return "hiring-in-process";
	        }
	        return "redirect:login";
	    }
	    
	    @PostMapping({ "/reAttemp" })
	    @ResponseBody
	    public String reAttemp(@RequestParam("accesskey") final String accesskey) {
	        final Optional<ParticipantRegistration> particpant = participantserviceImpl.getParticipantByAccesskey(accesskey);
	        if (particpant.isPresent()) {
	        	int count =0;
	        	if(particpant.get().getReAtampCount() != null) {
	        	  count = particpant.get().getReAtampCount();
	        	}        	
	        	count++;
	            restClientReattemp.callClient(accesskey);
	            particpant.get().setTestScore("");
	            particpant.get().setTestStatus("2");
	            particpant.get().setTestCompletionDate(null);
	            particpant.get().setPassFailStatus(0);
	            particpant.get().setTotalMark((String)null);
	            particpant.get().setPercentageScore("");
	            particpant.get().setDocuments_status((String)null);
	            particpant.get().setReAtampStatus("Yes");
	            particpant.get().setModifiedDate(LocalDate.now());
	            particpant.get().setReAtampCount(count);
	            participantserviceImpl.saveData((ParticipantRegistration)particpant.get());
	            sendEmailToReAttemp(particpant.get());
               try {				
					String sms =DataProccessor.getSMS("reAttemp");
					SmsUtility.sendSmsPromotional(particpant.get().getMobile(),sms,"522225","1007606977458974398");;
				}catch(Exception e) {
					e.printStackTrace();
				}
	        }
	        else {
	        }
	        return "Success";
	    }
	    
	    @PostMapping({ "/fixedInterViewDate" })
	    @ResponseBody
	    public String setInterviewDate(@RequestParam("date") final String date, @RequestParam("time") final String time, @RequestParam("intCount") Integer intCount,
	    		@RequestParam("interviewAddress") final String interviewAddress, @RequestParam("accesskey") final String accesskey) {
	        String msg = "";
	        ParticipantRegistration p = null;
	        try {
	            final LocalDate newDate = DataProccessor.parseDate(date);
	            if (newDate != null) {
	                final Optional<ParticipantRegistration> particpant = participantserviceImpl.getParticipantByAccesskey(accesskey);
	                if (particpant.isPresent()) {
	                	if(intCount ==1) {
	                		p = particpant.get();
	                		p.setInterviewDate(newDate);
	                		p.setInterviewTime(time);
	                		p.setInterviewAddress(interviewAddress);
	                		p.setModifiedDate(LocalDate.now());
	                	}else if (intCount==2) {
							p= particpant.get();
							p.setInterviewDate2(newDate);
							p.setInterviewTime2(time);
	                		p.setInterviewAddress2(interviewAddress);
	                		p.setModifiedDate(LocalDate.now());
						}
	                }
	                if (p != null) {
	                    participantserviceImpl.saveData(p);
	                    msg = "save";
	                    sendEmailToScheduleInterview(particpant.get());
						
	                }
	            }
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            return "";
	        }
	        return accesskey;
	    }
	    
	    @PostMapping({ "holdUnHoldParticpant" })
	    @ResponseBody
	    public String setOnHoldParicipant(@RequestParam("accesskey") final String accesskey, @RequestParam("status") final String status) {
	        final Optional<ParticipantRegistration> particpant = participantserviceImpl.getParticipantByAccesskey(accesskey);
	        String msg = "";
	        if (particpant.isPresent()) {
	            particpant.get().setStatus(status);
	            particpant.get().setModifiedDate(LocalDate.now());
	            participantserviceImpl.saveData((ParticipantRegistration)particpant.get());
	        }
	        if (status.equals("H")) {
	            msg = "Candidate Holde ";
	        }
	        if (status.equals("I")) {
	            msg = "Candidate UnHold ";
	        }
	        
	        EventLoger event = new EventLoger();
            event.setAccesskey(particpant.get().getAccessKey());
            event.setEmail(particpant.get().getEmail());
            event.setEventTime(LocalDate.now());
            event.setName("");
            event.setEvent("onHold");
            event.setUserId(particpant.get().getHreId().intValue());
            eventLogerServer.save(event);
	        return msg;
	    }
	    
	    private String sendEmailToScheduleInterview(final ParticipantRegistration participant) {
	        final String subjectLine = "iRecruit- Your Job Application: Interview Notification";
	        String mailBody = DataProccessor.readFileFromResource("interviewScheduleEmail");
	        mailBody = mailBody.replace("${candidateName}", String.valueOf(participant.getFirstName()) + " " + participant.getMiddleName() + " " + participant.getLastName());
	        final HRE dealer = hreService.getById((long)participant.getHreId()).get();
	        mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        mailBody = mailBody.replace("${interviewDate}", DataProccessor.dateToString(participant.getInterviewDate()));
	        mailBody = mailBody.replace("${interviewTime}", participant.getInterviewTime());
	        if(dealer.getMobile() != null && !dealer.getMobile().equals("")) {
	           mailBody = mailBody.replace("${mobile}", dealer.getMobile());
	        }else {
	        	  mailBody = mailBody.replace("${mobile}", "");
	        }
	        if(dealer.getEmail() != null && !dealer.getEmail().equals("")) {
	           mailBody = mailBody.replace("${email}", dealer.getEmail());
	        }else {
	           mailBody = mailBody.replace("${email}", "");
	        }
	        
	        mailBody = mailBody.replace("${location}", participant.getInterviewAddress());
	       
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(participant.getEmail());
	        sendP.setSubjectLine(subjectLine);
	        sendP.setMsg(mailBody);
	        sendP.setCc(dealer.getEmail());
	        sendP.setBcc("");
	        sendP.setFrom("Armezo Solutions");
	        EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(), sendP.getMsg(), "smtp");
	        
	        
	        EventLoger event = new EventLoger();
            event.setAccesskey(participant.getAccessKey());
            event.setEmail(participant.getEmail());
            event.setEventTime(LocalDate.now());
            event.setName("");
            event.setEvent("Scheduled Interview");
            event.setUserId(participant.getHreId().intValue());
            eventLogerServer.save(event);
	        return "success";
	    }
	    
	    private String sendEmailToReAttemp(final ParticipantRegistration participant) {
	        final String subjectLine = "Duflon - Your Job Application: Registration & Assessment";
	        String mailBody = DataProccessor.readFileFromResource("reattempt");
	        mailBody = mailBody.replace("${candidateName}", String.valueOf(participant.getFirstName()) + " " + participant.getMiddleName() + " " + participant.getLastName());
	        final HRE dealer = hreService.getById((long)participant.getHreId()).get();
	        mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        String name = "";
	        name = String.valueOf(name) + participant.getFirstName();
	        if (participant.getMiddleName() != null) {
	            name = String.valueOf(name) + " " + participant.getLastName();
	        }
	        name = String.valueOf(name) + " " + participant.getLastName();
	        if(dealer.getName() != null && !dealer.getName().equals("")) {
	           mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        }else {
	        	 mailBody = mailBody.replace("${dealerName}", "");
	        }
	        if(dealer.getMobile() != null && !dealer.getMobile().equals("")) {
	             mailBody = mailBody.replace("${mobile}", dealer.getMobile());
	        }else {
	        	 mailBody = mailBody.replace("${mobile}", "");
	        }
	        if(dealer.getEmail() != null && !dealer.getEmail().equals("")) {
	            mailBody = mailBody.replace("${email}", dealer.getEmail());
	        }else {
	        	 mailBody = mailBody.replace("${email}", "");
	        }
	        mailBody = mailBody.replace("${candidateName}", name);
	        mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
	        mailBody = mailBody.replace("${assessment}", candLink);
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(participant.getEmail());
	        sendP.setSubjectLine(subjectLine);
	        sendP.setMsg(mailBody);
	        sendP.setCc(dealer.getEmail());
	        sendP.setBcc("");
	        sendP.setFrom("Armezo Solutions");
	        try {
	            EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(), sendP.getMsg(), "smtp");
	            EventLoger event = new EventLoger();
	            event.setAccesskey(participant.getAccessKey());
	            event.setEmail(participant.getEmail());
	            event.setEventTime(LocalDate.now());
	            event.setName(name);
	            event.setEvent("Reattemp");
	            event.setUserId(participant.getHreId().intValue());
	            eventLogerServer.save(event);
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "success";
	    }
	    
	    @GetMapping({ "/testing" })
	    @ResponseBody
	    public String testing() {
	        return "success";
	    }
	    /*
	    @PostMapping({ "/filterParticipant" })
	    public String dealerFilters(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			List<Integer> passFStatus = new ArrayList<>();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
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
					mspin=null;
				if(passFailStatus=="") {
					passFStatus.add(1);
					passFStatus.add(0);
				}else {
					passFStatus.add(Integer.valueOf(passFailStatus));
				}			
				hreId = Long.parseLong(session.getAttribute("userId").toString());
				Optional<HRE> dealer = hreService.getById(hreId);
				List<ParticipantRegistration> participantList=null;
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantFilterInpprocess(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,hreId,dateFrom,dateTo);
				}else {
					participantList= participantserviceImpl.getParticipantByFilterData2(outletCode, candidateName, designation, mspin, passFStatus, hreId, uniqueCode);

				}
				listParticipant = getParticpant(participantList,dealer,hreId+"");
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	            if(outletCode!=null || outletCode!="") {
	            	Map<String,String> map = new HashMap<>();	            	
	            	model.addAttribute("outletCode1", outletCode);
	            }
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("outlets", (Object)outlets);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "hiring-in-process";
	        }
	        return "redirect:login";
	    }
	    //Filter For Employee Master
	    @PostMapping({ "/filterMasterParticipant" })
	    public String dealerFiltersForEmployeeMaster(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();	        
	        final List<Designation> designations2 = designationService.getAll();	        
	        List<Integer> passFStatus= new ArrayList<>();
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (session.getAttribute("userId") != null) {
				//check data 
				if(outletCode==null )
					outletCode=null;
				if(candidateName==null)
					candidateName=null;
				if(uniqueCode==null) {
					uniqueCode=null;
				}
				if(designation==null)
					designation=null;
				if(mspin==null)
					mspin=null;
				if(passFailStatus=="") {
					passFStatus.add(1);
					passFStatus.add(0);
				}else {
					passFStatus.add(Integer.valueOf(passFailStatus));
				}
				
				hreId = Long.parseLong(session.getAttribute("userId").toString());
				Optional<HRE> dealer = hreService.getById(hreId);
				List<ParticipantRegistration> participantList=null;
				String fsdmApprovalStatus="2";
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantFilterEmployee(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,hreId,dateFrom,dateTo,fsdmApprovalStatus);
				}else {
					participantList= participantserviceImpl.getParticipantOnEmployeeMasterDealerByFilterData( outletCode,
							candidateName,  designation,  mspin,  passFStatus,  uniqueCode,
							 hreId,  fsdmApprovalStatus);
				}
	            
				listParticipant = getParticpant(participantList,dealer,hreId+"");
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	            model= getDesignation(model);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("outlets", (Object)outlets);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "employeeDealer";
	        }
	        return "redirect:login";
	    }
	    
	    @PostMapping({ "/completionProcess" })
	public String checkCompletionProcessFilter(@RequestParam(required = false) final String interview,
			@RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, final HttpSession session, Model model) {
		List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
		List<Long> hreIdList = new ArrayList<Long>();
		FilterPayload payload = new FilterPayload();
		Integer interviewSearch = null;
		String praraambhSearch = prarambh;
		List<String> fsdmSearch=new ArrayList<String>();
		if (interview != null && interview.length()>0) {
			interviewSearch = 0;
			payload.setInterview("check");
		}
		if (prarambh != null && prarambh.length()>0) {
			payload.setPraraambh("check");
			praraambhSearch = "2";
		}
		if(fsdm!=null && fsdm.length()>0) {
			payload.setFsdmApproved("check");
			 fsdmSearch.add("1");
			 }
		
		if (session.getAttribute("userId") != null) {
			Long hreId = Long.parseLong(session.getAttribute("userId").toString());
			hreIdList.add(hreId);
			final Optional<HRE> dealer = hreService.getById(hreId);
			final List<ParticipantRegistration> list = (List<ParticipantRegistration>) participantserviceImpl.findParticipantsByCompletionFilterInProcess(interviewSearch, praraambhSearch, fsdmSearch, hreIdList);
			listParticipant = getParticpant(list,dealer,hreId+"");
			final List<Outlet> outlets = outletService.findByhreId(hreId);
			final List<Designation> designations = designationService.getAll();
			model= getDesignation(model);
			model = DataProccessor.setDateRange(model);
			model.addAttribute("participantList", (Object) listParticipant);
			model.addAttribute("outlets", (Object) outlets);
			model.addAttribute("designations", (Object) designations);
			model.addAttribute("hreId", (Object) hreId);
			model.addAttribute("payload", (Object) payload);
			return "hiring-in-process";
		}
		return "redirect:login";
	}
	    
	   */
	    
	    public boolean getInterviewStatus(String interviewDate, String accesskey) {
	    	boolean check = false;
            Date d = new  Date();
        	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			
			    String dateTo2 = sdf.format(d);
                DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm aa");
                DateFormat outputformat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Date date = null;
                String output = null;
                try{
              	 date= df.parse(interviewDate);
              	 output = outputformat.format(date);
              	if(sdf.parse(dateTo2 ).compareTo(sdf.parse(output))>0) {
              		 check = true;
              	}
              	
              	else if(sdf.parse(dateTo2 ).compareTo(sdf.parse(output))<0) {
              		 check = false;
              	}else {
              		check = true;
              	}              	
                }catch(ParseException pe){
                   pe.printStackTrace();
                 }
                
                SimpleDateFormat sdformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                try {
                Date d11 = sdformat.parse( dateTo2);
                Date d22 = sdformat.parse(output);
                if(d11.compareTo(d22) >0) {
                	check = true;
                 }
                }catch(Exception e) {
                }
                return check;
	    }
	    
	
	    public List<ModelParticpantView> getParticpant(List<ParticipantRegistration> participant,Optional<HRE> dealer,String hreId){
	    	 //final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	    	 DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	    	 final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	    	for (final ParticipantRegistration p2 : participant) {
                  final ModelParticpantView modelParticpantView = new ModelParticpantView();
                  //modelParticpantView.setParticipantName(String.valueOf(String.valueOf(p2.getFirstName())) + " " + p2.getMiddleName() + " " + p2.getLastName());
                  modelParticpantView.setParticipantName(DataProccessor.getFullNameOfParticipant(p2));
                  modelParticpantView.setAccesskey(p2.getAccessKey());
                  if (p2.getRegistration_Date() != null) {
                      modelParticpantView.setDateOfRegistration(p2.getRegistration_Date().format(df));
                  }
                  if (p2.getTestCompletionDate() != null) {
                      modelParticpantView.setAssessment_Completion_date(p2.getTestCompletionDate().format(df));
                  }
                  if (p2.getTestStatus() != null) {
                      modelParticpantView.setTestStatus(p2.getTestStatus());
                      modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p2.getInterviewScore()));
                      modelParticpantView.setPassFailStatus(p2.getPassFailStatus());
                  }
                  else {
                      modelParticpantView.setTestStatus("");
                  }
                  modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p2.getInterviewScore()));
                  if (p2.getPassFailStatus() != 0) {
                      modelParticpantView.setPassFailStatus(p2.getPassFailStatus());
                  }
                  else {
                      modelParticpantView.setPassFailStatus(0);
                  }
                  modelParticpantView.setEmail(p2.getEmail());
                  modelParticpantView.setMobile(p2.getMobile());
                  if (p2.getTestScore() != null) {
                      modelParticpantView.setTestScore(p2.getTestScore());
                  }
                  else {
                      modelParticpantView.setTestScore("0");
                  }
                  if (p2.getPercentageScore() != null) {
                      modelParticpantView.setPercentageScore(p2.getPercentageScore());
                  }
                  else {
                      modelParticpantView.setPercentageScore("0");
                  }
                  if (p2.getTotalMark() != null) {
                      modelParticpantView.setTotalMark(p2.getTotalMark());
                  }
                  else {
                      modelParticpantView.setTotalMark("40");
                  }
                  if (p2.getInterviewDate() != null) {
                      final String regDate = p2.getInterviewDate().format(df);
                      final String s = String.valueOf(String.valueOf(regDate)) + ", " + p2.getInterviewTime();
                      modelParticpantView.setInterViewDate(s);   
                      System.out.println("I D 1 : "+s);
                     if( getInterviewStatus(regDate+" "+p2.getInterviewTime(),p2.getAccessKey()) ){
                  	   modelParticpantView.setIntterviewFormStatus("1");
                     }else {
                  	   modelParticpantView.setIntterviewFormStatus("0"); 
                     }
                  } else {
                    	modelParticpantView.setIntterviewFormStatus("0"); 
                        modelParticpantView.setInterViewDate("");
                  }
                  if (p2.getInterviewDate2() != null) {
                	  final String regDate = p2.getInterviewDate2().format(df);
                	  final String s = String.valueOf(String.valueOf(regDate)) + ", " + p2.getInterviewTime2();
                	  modelParticpantView.setInterViewDate2(s);   
                	  
                	  if( getInterviewStatus(regDate+" "+p2.getInterviewTime2(),p2.getAccessKey()) ){
                		  modelParticpantView.setIntterviewFormStatus2("1");
                	  }else {
                		  modelParticpantView.setIntterviewFormStatus2("0"); 
                	  }
                  } else {
                	  modelParticpantView.setIntterviewFormStatus2("0"); 
                	  modelParticpantView.setInterViewDate2("");
                  }
                  modelParticpantView.setDesignation(p2.getDesignation());
                  if (p2.getRegStatus() != null && Integer.parseInt(p2.getRegStatus()) == 3) {
                      modelParticpantView.setRegStatus("0");
                  }
                  else {
                      modelParticpantView.setRegStatus("1");
                  }
                  final Optional<InterviewScore> interView = interviewScoreService.findByAccesskeyAndInterviewCount(p2.getAccessKey(),1);
                  final Optional<InterviewScore> interView2 = interviewScoreService.findByAccesskeyAndInterviewCount(p2.getAccessKey(),2);
                  if (interView.isPresent()) {
                      modelParticpantView.setInterViewStatus(interView.get().getStatus());
                      modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
                  }else {
                      modelParticpantView.setInterViewStatus("");
                      modelParticpantView.setInterViewPassFailStatus("");
                  }
                  if(interView2.isPresent()) {
                	  modelParticpantView.setInterViewStatus2(interView2.get().getStatus());
                	  modelParticpantView.setInterViewPassFailStatus2(interView2.get().getPass_fail_status());
                  }
                  else {
                      modelParticpantView.setInterViewStatus2("");
                      modelParticpantView.setInterViewPassFailStatus2("");
                  }
                  if (dealer.isPresent()) {
                      modelParticpantView.setHreName(DataProccessor.getStringValue(dealer.get().getName()));
                  }
                
                 if(p2.getReAtampCount() != null) {
                	 modelParticpantView.setReAttempCount(p2.getReAtampCount());
   	        	}else {
   	        	 modelParticpantView.setReAttempCount(0);
   	        	}
                 modelParticpantView.setAptitude(p2.getAptitudeScore());
                 modelParticpantView.setAttitude(p2.getAttitudeScore());
                 if(p2.getInterviewAddress() != null) {
                 modelParticpantView.setInterviewAddress(p2.getInterviewAddress());
                 }else {
                	 modelParticpantView.setInterviewAddress(""); 
                 }
                 if(p2.getInterviewAddress2() != null) {
                	 modelParticpantView.setInterviewAddress2(p2.getInterviewAddress2());
                 }else {
                	 modelParticpantView.setInterviewAddress2(""); 
                 }
                 modelParticpantView.setHiredStatus(p2.getHiredStatus());
                  listParticipant.add(modelParticpantView);
                  
	    	  }
	    	  return listParticipant;
	    }
	    /*
	    private Model getDesignation(Model model) {
	    	final List<Designation> designations2 = designationService.getAll();
            final Map<String, String> SalesDesignation = designations2.stream().filter(p -> p.getCategory().equals("Sales")).collect(Collectors.toMap((Function<? super Designation, ? extends String>)Designation::getDesignationCode, (Function<? super Designation, ? extends String>)Designation::getDesignationName));
            model.addAttribute("salesDesignation", (Object)SalesDesignation);
            return model;
	    }
	    
	   */
	    
	
}