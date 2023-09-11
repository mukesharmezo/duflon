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

import com.armezo.duflon.Entities.AdminTable;
import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HOD;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Services.AdminService;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.HODService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;

@Controller
public class ChangeController {
	@Autowired
	private LineManagerServiceImpl lmService;
	@Autowired
	private HREService hreService;
	 @Autowired
	 private HODService hodService;
	 @Autowired
	 private AdminService adminService;
	 @Autowired
	 EventLogerService eventLogerServer;
	
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
		  //Optional<HO> ho = hoService.findById(id);
		  
		  if (role.equalsIgnoreCase("LM")) {
			  Optional<LineManager> lm = lmService.getLineManager(id);
			  if(lm.isPresent()) {
				  lm.get().setPassword(newPassword);
				  lmService.updatePassword(id,newPassword);
				  msg="1";
				  eventLogin(lm.get().getId().intValue(),"Update Password");
			  }
			} 
		  if (role.equalsIgnoreCase("HRE")) {
			  Optional<HRE> hre  = hreService.getByempCodeAndPassword(empCode,oldPassword);
			 	  hreService.changePassword(empCode,newPassword);	
			 	 msg="1";
			 	 eventLogin(hre.get().getId().intValue(),"Update Password");
			 }
		  if (role.equalsIgnoreCase("HOD")) {
			  Optional<HOD> ho = hodService.getByEmpCodeAndPassword(empCode, oldPassword);
			  if(ho.isPresent()) {
				  hodService.changePassword(empCode, newPassword);
				 msg="1";
				 eventLogin(ho.get().getId().intValue(),"Update Password");
			  }
			 }
		  if (role.equalsIgnoreCase("SA")) {
			  Optional<AdminTable> admin = adminService.findByEmpCodeAndPassword(empCode, oldPassword);
			  if(admin.isPresent()) {
				  adminService.changePassword(empCode, newPassword);
				  msg="1";
				  eventLogin(admin.get().getId().intValue(),"Update Password");
			  }
		  }
		  
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
				    String role = session.getAttribute("role").toString();
				    	  if (role.equalsIgnoreCase("LM")) {
				    		  Optional<LineManager> lm      = lmService.findByIdAndEmail(id,oldEmail);
				    		  if(lm.isPresent()) {
						        lmService.changeEmailById(id,newEmail);	
						        session.setAttribute("email", newEmail);
						        msg="1";
						        eventLogin(lm.get().getId().intValue(),"Update Email");
				    		  }
				    	  }
					
						if (role.equalsIgnoreCase("HRE")) {
							Optional<HRE> hre  = hreService.findByempCodeAndEmail(empCode,oldEmail);
							if(hre.isPresent()) {
					 		  hreService.changeEmail(empCode,newEmail);	
					 		  session.setAttribute("email", newEmail);
					 		  msg="1";
					 		 eventLogin(hre.get().getId().intValue(),"Update Email");
							}
						}
					
						if (role.equalsIgnoreCase("HOD")) {
							Optional<HOD> hod = hodService.findByIdAndEmail(id, oldEmail);
							if(hod.isPresent()) {
								hod.get().setEmail(newEmail);
								 hodService.saveHOD(hod.get());
					 		  session.setAttribute("email", newEmail);
					 		  msg="1";
					 		 eventLogin(hod.get().getId().intValue(),"Update Email");
							}
						}
						if (role.equalsIgnoreCase("SA")) {
							Optional<AdminTable> admin = adminService.findByIdAndEmail(id, oldEmail);
							if(admin.isPresent()) {
								admin.get().setEmail(newEmail);
								adminService.saveAdmin(admin.get());
								session.setAttribute("email", newEmail);
								msg="1";
								eventLogin(admin.get().getId().intValue(),"Update Email");
							}
						}
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
