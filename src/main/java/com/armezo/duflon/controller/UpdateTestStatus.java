package com.armezo.duflon.controller;


import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.EventLogerServer;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.jobportal.UserRegistration;
import com.armezo.duflon.jobportal.UserService;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class UpdateTestStatus {

	    @Autowired
	    private ParticipantServiceImpl participantserviceImpl;
	    @Autowired
	    private HREService hreService;
	    @Autowired
	    private UserService userService;
	    @Autowired
	    EventLogerServer eventLogerServer;
	    @PostMapping({ "/updateTestStatus" })
	    @ResponseBody
	    public String updateAptitute(@RequestParam("accesskey") final String accesskey, @RequestParam("testScore") final double testScore,
	    		@RequestParam("testStatus") final int testStatus,@RequestParam("totalMark") final double totalMark,
	    		@RequestParam("section_1") final double section_1, @RequestParam("section_2") final double section_2) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantserviceImpl.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            participant.get().setTestStatus("3");
	            participant.get().setTestScore(new StringBuilder(String.valueOf(testScore)).toString());
	            participant.get().setTotalMark(new StringBuilder(String.valueOf(totalMark)).toString());
	            double passingPer = 0.0;
	            if (testScore > 0.0) {
	                passingPer = testScore / totalMark * 100.0;
	            }
	            double percentages=doubleRoundHalfUpWith2DecimalPlaces(0, passingPer);
	        	int percentage = (int)percentages;
	            participant.get().setPercentageScore(new StringBuilder(String.valueOf(percentage)).toString());
	            participant.get().setPassFailStatus(testStatus);
	            participant.get().setTestCompletionDate(LocalDate.now());
	            participant.get().setAptitudeScore(Integer.valueOf((int)section_1));
	            participant.get().setAttitudeScore(Integer.valueOf((int)section_2));
	            participant.get().setPsychometricScore(Integer.valueOf((int)testScore));
	            
	            participant.get().setModifiedDate(LocalDate.now());;
	            participantserviceImpl.saveData(participant.get());
	            sendEmail(participant.get(), testStatus);
	            eventLogin(participant.get().getHreId().intValue(),"Accessment Completed",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	            //Set Status in User registration
	            Optional<UserRegistration> userOptional = userService.getUserByAccesskey(accesskey);
	            if(userOptional.isPresent()) {
	            	userOptional.get().setAssessmentStatus("Y");
	            	userService.saveUser(userOptional.get());
	            }
	        }
	        return "Success";
	    }
	    
	    public static double doubleRoundHalfUpWith2DecimalPlaces(int decimalPlaces, double doubleValue){
			BigDecimal bd = new BigDecimal(doubleValue);

			// setScale is immutable
			bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
			return bd.doubleValue();
		}
	    /*
	    @PostMapping({ "/getDealerName" })
	    @ResponseBody
	    public Map<String, String> getDealerName(@RequestParam("accesskey") final String accesskey) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantserviceImpl.findByAccesskey(accesskey);
	        final Map<String, String> map = new HashMap<String, String>();
	        if (participant.isPresent()) {
	            final Optional<Outlet> outlet = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(participant.get().getOutletCode(), participant.get().gethreId());
	            if (outlet.isPresent()) {
	                map.put("dealerName", outlet.get().getDealer().getName());
	                map.put("dealerShip", outlet.get().getOutletName());
	                
	                String name = participant.get().getFirstName();
	                if (participant.get().getMiddleName() != null && !participant.get().getMiddleName().equals("")) {
	                    name = String.valueOf(String.valueOf(name)) + " " + participant.get().getMiddleName();
	                }
	                name = String.valueOf(String.valueOf(name)) + " " + participant.get().getLastName();
	                map.put("name", name);
	                map.put("message", "1");
	            }
	            else {
	                map.put("message", "0");
	            }
	        }
	        else {
	            map.put("message", "0");
	        }
	        return map;
	    }
	    */
	    private String sendEmail(final ParticipantRegistration participant, final int stattus) {
	        String subjectLine = "Duflon - Your Job Application: Thank You";
	        if (stattus == 0) {
	            subjectLine = "Duflon - Your Job Application: Thank You";
	        }
	        String mailBody = DataProccessor.readFileFromResource("passEmail");
	        if (stattus == 0) {
	            mailBody = DataProccessor.readFileFromResource("failOrReattemptEmail");
	        }
	        String name = "";
	        name = String.valueOf(String.valueOf(name)) + participant.getFirstName();
	        if (participant.getMiddleName() != null) {
	            name +=  " " + participant.getMiddleName();
	        }
	        name += " " + participant.getLastName();
	        mailBody = mailBody.replace("${candidateName}", name);
	        final HRE dealer = this.hreService.getById((long)participant.getHreId()).get();
	        if (dealer != null) {
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
	        }
	       
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(participant.getEmail());
	        sendP.setSubjectLine(subjectLine);
	        sendP.setMsg(mailBody);
	        sendP.setCc("");
	        sendP.setBcc("");
	        sendP.setFrom("Armezo Solutions");
	        try {
	            EmailUtility.sendMailDuflon(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(), sendP.getMsg(), "smtp");
	        }
	        catch (Exception e) {
	           e.printStackTrace();
	        }
	        return "success";
	    }
	    
	    private void eventLogin(int loginId,String eventMSG,String accesskey,String name,String email) {
			 EventLoger event = new EventLoger();
	         event.setAccesskey(accesskey);
	         event.setEmail(email);
	         event.setEventTime(LocalDate.now());
	         event.setName(name);
	         event.setEvent(eventMSG);
	         event.setUserId(loginId);
	         eventLogerServer.save(event);
		}
	
}
