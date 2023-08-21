
package com.armezo.duflon.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.armezo.duflon.client.RestClientReattemp;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.payload.FilterPayload;
import com.armezo.duflon.payload.InvitationPayload;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class HreController {
	

	 @Autowired
	    ParticipantServiceImpl participantserviceImpl;
	    @Autowired
	    HREService hreService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    @Autowired
	    RestClientReattemp restClientReattemp;
	    @Autowired
	    EventLogerService eventLogerServer;
	    
	    @GetMapping({ "/viewProcess" })
	    private String getParticipantInProcess(@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, final Model model) {
	        //final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        long hreId = 0L;
	        if (session.getAttribute("userId") != null) {
	            hreId = Long.parseLong(session.getAttribute("userId").toString());	         
	            final Optional<HRE> dealer = hreService.getById(hreId);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
	            final List<ParticipantRegistration> participant = participantserviceImpl.getParticipantInpprocessForHRE(hreId, map.get("from"),map.get("to"));	          
	            HashMap<String, String> map2 = new LinkedHashMap<>();
	            map2.put("mukesh.bind@armezosolutions.com", "Interviewer 5");
	    		map2.put("df4@gm.com", "Interviewer 3");
	    		map2.put("df@gm.com", "Interviewer 1");
	    		map2.put("df5@gm.com", "Interviewer 4");
	    		map2.put("df1@gm.com", "Interviewer 2");
	    		// Convert the entries of the map2 LinkedHashMap into a list
	    		List<Map.Entry<String, String>> entryList = new ArrayList<>(map2.entrySet());
	    		// Sort the entryList based on the values (interviewer names)
	    		Collections.sort(entryList, Comparator.comparing(Map.Entry::getValue));
	    		// Create a new sorted LinkedHashMap and populate it with the sorted entries
	    		LinkedHashMap<String, String> sortedMap = new LinkedHashMap<>();
	    		for (Map.Entry<String, String> entry : entryList) {
	    		    sortedMap.put(entry.getKey(), entry.getValue());
	    		}
	    		model.addAttribute("map", sortedMap);
	            model.addAttribute("participantList",   getParticpant(participant,dealer,hreId+""));
                model.addAttribute("hreId", (Object)hreId);
                model.addAttribute("payload", payload);
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
	            System.out.println("Reattempt Called");
	            sendEmailToReAttemp(particpant.get());
	        }
	        else {
	        }
	        return "Success";
	    }
	    
	    @PostMapping("/inviteLM")
	    @ResponseBody
	    public String inviteLMForInterviewDate(@RequestBody InvitationPayload payload) {
	    	System.out.println("Calledddddddddddddd");
	    	System.out.println("Received Data: " + payload);
	        
	        List<String> datetimeList = payload.getDatetime();
	        List<String> emailList = payload.getSelectEmail();

	        System.out.println("Datetime List: " + datetimeList);
	        System.out.println("Email List: " + emailList);
			return "";
	    	
	    }
	    
	    @PostMapping({ "/fixedInterViewDate" })
	    @ResponseBody
	    public String setInterviewDate(@RequestParam("date") final String date, @RequestParam("time") final String time, @RequestParam("intCount") Integer intCount,
	    		@RequestParam("interviewAddress") final String interviewAddress, @RequestParam("emails") String emails,@RequestParam("accesskey") final String accesskey) {
	        ParticipantRegistration p = null;
	        String subStr = emails.replaceAll("[\"\\[\\]]", "");
	        String[] emailArray = subStr.split(",");
	        // Create a List to store the email addresses
	        List<String> emailList = new ArrayList<>();
	        for (String email : emailArray) {
	            emailList.add(email);
	        }
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
	                		p.setInterviewerCount(emailList.size());
	                		p.setParticipantStatus("Schedule1");
	                	}else if (intCount==2) {
							p= particpant.get();
							p.setInterviewDate2(newDate);
							p.setInterviewTime2(time);
	                		p.setInterviewAddress2(interviewAddress);
	                		p.setModifiedDate(LocalDate.now());
	                		p.setInterviewerCount2(emailList.size());
	                		p.setParticipantStatus("Schedule2");
						}
	                }
	                if (p != null) {
	                    participantserviceImpl.saveData(p);
	                    sendEmailToScheduleInterview(particpant.get(), intCount,subStr);
						
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
	    
	    private String sendEmailToScheduleInterview(final ParticipantRegistration participant, Integer intCount, String ccs) {
	        final String subjectLine = "DuRecruit- Your Job Application: Interview Notification";
	        String mailBody = DataProccessor.readFileFromResource("interviewScheduleEmail");
	        mailBody = mailBody.replace("${candidateName}", String.valueOf(participant.getFirstName()) + " " + participant.getMiddleName() + " " + participant.getLastName());
	        final HRE dealer = hreService.getById((long)participant.getHreId()).get();
	        mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        if(intCount==1) {
	        mailBody = mailBody.replace("${interviewDate}", DataProccessor.dateToString(participant.getInterviewDate()));
	        mailBody = mailBody.replace("${interviewTime}", participant.getInterviewTime());
	        mailBody = mailBody.replace("${location}", participant.getInterviewAddress());
	        }
	        if(intCount==2) {
	        	mailBody = mailBody.replace("${interviewDate}", DataProccessor.dateToString(participant.getInterviewDate2()));
	        	mailBody = mailBody.replace("${interviewTime}", participant.getInterviewTime2());
	        	mailBody = mailBody.replace("${location}", participant.getInterviewAddress2());
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
	        //Add HRE Email is CC also
	        ccs = ccs+","+dealer.getEmail();
	       
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(participant.getEmail());
	        sendP.setSubjectLine(subjectLine);
	        sendP.setMsg(mailBody);
	        sendP.setCc(ccs);
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
	        final String subjectLine = "DuRecruit - Your Job Application: Registration & Assessment";
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
	        //mailBody = mailBody.replace("${assessment}", candLink);
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(participant.getEmail());
	        sendP.setSubjectLine(subjectLine);
	        sendP.setMsg(mailBody);
	        sendP.setCc(dealer.getEmail());
	        sendP.setBcc("");
	        sendP.setFrom("Armezo Solutions");
	        try {
	        	System.out.println("Email try : "+sendP.getTo());
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
                 modelParticpantView.setDocStatus(p2.getDocuments_status());
                 modelParticpantView.setHiredStatus(p2.getHiredStatus());
                 modelParticpantView.setPartStatus(p2.getParticipantStatus());
                  listParticipant.add(modelParticpantView);
                  
	    	  }
	    	  return listParticipant;
	    }
}