package com.armezo.duflon.controller;

import java.time.LocalDate;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HO;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Services.EventLogerServer;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.HOServiceImpl;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;

@Controller
public class ChangeController {
	@Autowired
	private LineManagerServiceImpl lmService;
	
	@Autowired
	private HREService hreService;
	
	@Autowired
	private HOServiceImpl hoService;
	 @Autowired
	 EventLogerServer eventLogerServer;
	
	@GetMapping("/showChangePasswordPage/{empCode}")
	public String showPasswordChangePage(HttpSession session, @PathVariable String empCode) {
		session.setAttribute("empCode",empCode);
		return "passwordChange";
	}
	
	@PostMapping("/changePassword")
	@ResponseBody
	public String changePasswordOfUser(HttpSession session, @RequestParam String oldPassword, 
			@RequestParam String newPassword, @RequestParam String empCode) {
		  String msg="";
		  if (session.getAttribute("userId") != null) { 
		  Long id =Long.valueOf(session.getAttribute("userId").toString());
		  String role = session.getAttribute("role").toString();
		  Optional<LineManager> lm = lmService.getLineManager(id);
		  Optional<HRE> hre  = hreService.getByempCodeAndPassword(empCode,oldPassword);
		  //Optional<HO> ho = hoService.findById(id);
		  
		  if (role.equalsIgnoreCase("LM")) {
			  if(lm.isPresent()) {
				  lm.get().setPassword(newPassword);
				  lmService.updatePassword(id,newPassword);
				  msg="1";
				  eventLogin(lm.get().getId().intValue(),"Update Password");
			  }
			} 
		  if (role.equalsIgnoreCase("HRE")) {
			 	  hreService.changePassword(empCode,newPassword);	
			 	 msg="1";
			 	 eventLogin(hre.get().getId().intValue(),"Update Password");
			 }
		  /*if (role.equalsIgnoreCase("HO")) {
			  if(ho.isPresent()) {
				  ho.get().setPassword(newPassword);
				  hoService.saveHO(ho.get());
				 msg="1";
				 eventLogin(ho.get().getId(),"Update Password");
			  }
			 }*/
		  }else {
				 msg="0"; 
			 }
		  
		  
		return msg;
	}
	
	// Change Email Id
	@GetMapping("/showChangeEmailPage")
	public String showEmailChangePage(HttpSession session, @RequestParam String empCode) {
		session.setAttribute("empCode", empCode);
		return "emailChange";
	}
	
	@PostMapping("/changeEmail")
	@ResponseBody
	public String changeEmail(HttpSession session, @RequestParam String empCode, @RequestParam String oldEmail,@RequestParam String newEmail) {
		String msg="";
		if (session.getAttribute("userId") != null) {         
		            Long id =Long.valueOf(session.getAttribute("userId").toString());
				    Optional<LineManager> lm      = lmService.findByIdAndEmail(id,oldEmail);
				    Optional<HRE> hre  = hreService.findByempCodeAndEmail(empCode,oldEmail);
				    //Optional<HO> ho          = hoService.findById(id);
				    String role = session.getAttribute("role").toString();
				    	  if (role.equalsIgnoreCase("LM")) {
				    		  if(lm.isPresent()) {
						        lmService.changeEmailById(id,newEmail);	
						        session.setAttribute("email", newEmail);
						        msg="1";
						        eventLogin(lm.get().getId().intValue(),"Update Email");
				    		  }
				    	  }
					
						if (role.equalsIgnoreCase("HRE")) {
							if(hre.isPresent()) {
					 		  hreService.changeEmail(empCode,newEmail);	
					 		  session.setAttribute("email", newEmail);
					 		  msg="1";
					 		 eventLogin(hre.get().getId().intValue(),"Update Email");
							}
						}
					
				/*		if (role.equalsIgnoreCase("HO")) {
							if(ho.isPresent()) {
								 ho.get().setEmail(newEmail);
								 hoService.saveHO(ho.get());
					 		  session.setAttribute("email", newEmail);
					 		  msg="1";
					 		 eventLogin(ho.get().getId(),"Update Email");
							}
						}*/
					}else {
						msg="0";	
					}
					 return msg;
	}
	
	private void eventLogin(int loginId,String eventMSG) {
		 EventLoger event = new EventLoger();
        event.setAccesskey("");
        event.setEmail("");
        event.setEventTime(LocalDate.now());
        event.setName("");
        event.setEvent(eventMSG);
        event.setUserId(loginId);
        eventLogerServer.save(event);
	}
}
