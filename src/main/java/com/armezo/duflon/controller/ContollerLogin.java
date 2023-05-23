package com.armezo.duflon.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.AccessKeyMaster;
import com.armezo.duflon.Entities.AdminTable;
import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.UserLoginLog;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.AdminService;
import com.armezo.duflon.Services.CityService;
import com.armezo.duflon.Services.EventLogerServer;
import com.armezo.duflon.Services.HOService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.StateService;
import com.armezo.duflon.Services.UserLoginLogService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;

@Controller
public class ContollerLogin {

	@Autowired
	private HREService hreService;
	@Autowired
	private LineManagerServiceImpl lmService;
	@Autowired
	ParticipantServiceImpl participantService;
	@Autowired
	AccessKeyMasterService accessKeyMasterService;
	@Autowired
	CityService cityService;
	@Autowired
	StateService stateService;
	@Autowired
	InterviewScoreService interviewScoreService;
	@Autowired
	UserLoginLogService userLoginLogService;
	@Autowired
	private AdminService adminService;
	@Autowired
	EventLogerServer eventLogerServer;

	@Value("${Ap.assessmentURL}")
	private String assessmentURL;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@RequestMapping(value = "/loginPro", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPro(@RequestParam("user") String user, @RequestParam("password") String password,
			HttpSession session) {
		String errorMessage = "";
		//SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		Optional<UserLoginLog> loginLog = userLoginLogService.getloginLog(user);
		if (loginLog.isPresent()) {
			if (loginLog.get().getLastLogin() != null) {
				session.setAttribute("lastLogin", loginLog.get().getLastLogin().format(df));
			} else {
				session.setAttribute("lastLogin", LocalDate.now().format(df));
			}
			loginLog.get().setLastLogin(LocalDate.now());
			userLoginLogService.updateLoginLog(loginLog.get());
		} else {
			// toggleUtil.saveToggleForFirstTime(session);
			UserLoginLog log = new UserLoginLog();
			log.setEmpCode(user);
			log.setLastLogin(LocalDate.now());
			userLoginLogService.updateLoginLog(log);
		}

		Optional<LineManager> lmOptional = lmService.findByEmail(user);
		Optional<HRE> optionalHre = hreService.findByempCode(user);
		//Optional<HO> optionalHo = hoService.findHOByempCode(user);
		Optional<AdminTable> optionalAdmin = adminService.findAdminByEmpCode(user);
		if (lmOptional.isPresent()) {
			Optional<LineManager> lm = lmService.getByEmailAndPassword(user, password);
			if (lm.isPresent()) {
				if (lm.get().getStatus()) {
					session.setAttribute("role", "LM");
					session.setAttribute("userId", lm.get().getId());
					session.setAttribute("email", lm.get().getEmail());
					session.setAttribute("name", lm.get().getName());
					session.setAttribute("empCode", lm.get().getEmpCode());
					String region = "";
					session.setAttribute("region", region);
					eventLogin(lm.get().getId().intValue(), "LM Login");
					return "redirect:analytics";
				} else {
					errorMessage = "User is inactive";
				}
			} else {
				errorMessage = "Wrong Password";
			}

		} else if (optionalHre.isPresent()) {
			Optional<HRE> hre = hreService.getByempCodeAndPassword(user, password);
			if (hre.isPresent()) {
				if (hre.get().getStatus()) {
					if (hre.get().getEmail() != null && !hre.get().getEmail().equals("")
							&& hre.get().getEmail().length() > 0) {
						session.setAttribute("empCode", hre.get().getEmpCode());
						session.setAttribute("name", hre.get().getName());
						session.setAttribute("hreName", hre.get().getName());
						session.setAttribute("city", "Delhi");
						session.setAttribute("state", "New Delhi");
						session.setAttribute("region", "North");
						session.setAttribute("email", hre.get().getEmail());
						session.setAttribute("role", "HRE");
						session.setAttribute("userId", hre.get().getId());
						eventLogin(hre.get().getId().intValue(), "hre Login");
						return "redirect:analytics";
					} else {
						session.setAttribute("user", user);
						session.setAttribute("password", password);
						session.setAttribute("empCode", hre.get().getEmpCode());
						return "addEmailAddress";
					}
				}else {
					errorMessage = "User is inactive";
				}
			} else {
				errorMessage = "Wrong Password";
			}
		/*} else if (optionalHo.isPresent()) {
			Optional<HO> ho = hoService.getByempCodeAndPassword(user, password);
			if (ho.isPresent()) {
				if (ho.get().getStatus()) {
					if (ho.get().getEmail() != null && ho.get().getEmail() != "") {
						session.setAttribute("empCode", ho.get().getempCode());
						session.setAttribute("name", ho.get().getName());
						session.setAttribute("email", ho.get().getEmail());
						session.setAttribute("city", "India"); // dynamic value will be here
						session.setAttribute("state", "India");
						session.setAttribute("region", "India");
						session.setAttribute("role", "HO");
						session.setAttribute("userId", ho.get().getId());
						eventLogin(ho.get().getId(), "HO Login");
						return "redirect:analytics";
					} else {
						session.setAttribute("user", user);
						session.setAttribute("password", password);
						session.setAttribute("empCode", ho.get().getempCode());
						return "addEmailAddress";
					}
				}else {
					errorMessage = "User is inactive";
				}
			} else {
				errorMessage = "Wrong Password";
			}*/
		} else if (optionalAdmin.isPresent()) {
			Optional<AdminTable> ad = adminService.findByEmpCodeAndPassword(user, password);
			if (ad.isPresent()) {
				if (ad.get().getStatus()) {
					session.setAttribute("name", ad.get().getName());
					session.setAttribute("email", ad.get().getEmail());
					session.setAttribute("city", "India"); // dynamic value will be here
					session.setAttribute("state", "India");
					session.setAttribute("region", "India");
					session.setAttribute("role", "SA");
					session.setAttribute("userId", ad.get().getId());
					eventLogin(ad.get().getId(), "adminLogin");
					return "redirect:analytics";
				}else {
					errorMessage = "User is inactive";
				}
			} else {
				errorMessage = "Wrong Password";
			}
		} else {
			errorMessage = "User Not Found";
		}
		session.setAttribute("msg", errorMessage);
		return "redirect:login";
	}

	// Add email handler
	@PostMapping("/addEmailAddress")
	public String addEmailAddressToAdminLogin(HttpSession session, @RequestParam String email,
			@RequestParam String user, @RequestParam String password, @RequestParam String empCode) {
		Optional<HRE> hre = hreService.getByempCodeAndPassword(user, password);
		if (hre.isPresent()) {
			hreService.addEmailAddress(hre.get().getId(), email);
		} else {
			session.setAttribute("msgEmail", "I");
		}
		Optional<LineManager> lm = lmService.getByEmpCodeAndPassword(user, password);
		if (lm.isPresent()) {
			lmService.addEmailAddressAfterLogin(lm.get().getEmpCode(), email);
		}

		/*Optional<HO> ho = hoService.findHOByempCode(empCode);
		if (ho.isPresent()) {
			hoService.changeEmail(empCode, email);
		}*/
		eventLogin(Integer.parseInt(user), "Add Email");
		// loginPro(user, password, session);
		return "redirect:loginPro?user=" + user + "&password=" + password;
		// ?user=mayank&pass=pass
	}

	@GetMapping("/candidateLogin")
	public String candidateLogin(Model model) {
		getCapcha(model, "");
		return "candidateLogin";
	}

	@PostMapping("/candidateLoginPro")
	public String testLoginPro(@RequestParam("txtAkey") String accesskey, @RequestParam("textresult") String inResult,
			@RequestParam("calculationresult") String fResult, Model model, HttpSession session) {

		Optional<ParticipantRegistration> participant = participantService.getParticipantByAccesskey(accesskey);
		Optional<AccessKeyMaster> key = accessKeyMasterService.getAccesskey(accesskey);

		EventLoger event = new EventLoger();
		event.setAccesskey(participant.get().getAccessKey());
		event.setEmail(participant.get().getEmail());
		event.setEventTime(LocalDate.now());
		event.setName(participant.get().getFirstName() + " " + participant.get().getMiddleName() + " "
				+ participant.get().getLastName());
		event.setEvent("Candidate Login");

		if (!accesskey.equals("")) {
			if (key.isPresent()) {
				if (key.get().getStatus().equals("B")) {
					session.setAttribute("msg", "B");
					return "redirect:candidateLogin";
				}
			} else {
				session.setAttribute("msg", "I");
				return "redirect:candidateLogin";
			}
		}
		if (key.isPresent() == true && participant.isPresent() == false) {
			session.setAttribute("msg", "IN");
			return "redirect:candidateLogin";
		}

		if (participant.isPresent()) {

			if ((participant.get().getSendMailDate() != null)
					&& (participant.get().getTestStatus() == null || participant.get().getTestStatus() != null)) {
				int tm = 0;
				Long t1 = participant.get().getSendMailDate().getTime();
				Long t2 = new Date().getTime();
				if (participant.get().getReactivationDate() != null) {
					t1 = participant.get().getReactivationDate().getTime();
					tm = (int) (t2 - t1) / (60 * 60 * 1000);
					if (tm >= 48) {
						session.setAttribute("msg", "E");
						return "redirect:candidateLogin";
					}
				} else {
					tm = (int) (t2 - t1) / (60 * 60 * 1000);
					if (tm >= 72) {
						session.setAttribute("msg", "E");
						return "redirect:candidateLogin";
					}
				}
			}

			if (participant.get().getTestStatus() == null) {
				model.addAttribute("participant", participant.get());
				model.addAttribute("cityList", cityService.getAllCity());
				model.addAttribute("stateList", stateService.getAllState());
				return "redirect:instruction?accesskey=" + accesskey;
			} else if (participant.get().getDocuments_status() != null) {
				session.setAttribute("msg", "D");
				return "redirect:candidateLogin";
			} else if (Integer.parseInt(participant.get().getTestStatus()) == 1) {
				return "redirect:" + assessmentURL + "assess/alloginpro?accesskey=" + participant.get().getAccessKey();
			} else if (Integer.parseInt(participant.get().getTestStatus()) == 3) {
				Optional<InterviewScore> score = interviewScoreService.findByAccesskey(accesskey);
				if (score.isPresent()) {
					if (score.get().getStatus().equals("final")) {
						return "redirect:instructionUploadFile?accesskey=" + accesskey;
					}
				}
				session.setAttribute("msg", "C");
				return "redirect:candidateLogin";
			} else if (Integer.parseInt(participant.get().getTestStatus()) == 2) {
				participant.get().setTestStatus("1");
				participantService.saveData(participant.get());
				return "redirect:" + assessmentURL + "assess/IRCreg?accesskey=" + participant.get().getAccessKey();
			}
		}
		return "redirect:candidateLogin";
	}

	@GetMapping("/instruction")
	public String getInstruction(@RequestParam("accesskey") String accesskey, Model model) {
		model.addAttribute("accesskey", accesskey);
		Optional<ParticipantRegistration> participant = participantService.getParticipantByAccesskey(accesskey);
		if (participant.isPresent()) {
			if (participant.get().getDesignation().equals("Sales Support")) {
				return "InstructionsSalseSupport";
			}
		}
		return "Instructions";
	}

	@PostMapping("/instructionPro")
	public String getInstructionPro(@RequestParam("accesskey") String accesskey, Model model) {
		model.addAttribute("accesskey", accesskey);
		Optional<ParticipantRegistration> participant = participantService.getParticipantByAccesskey(accesskey);
		if (participant.isPresent()) {
			if (participant.get().getTestStatus() == null) {
				model.addAttribute("participant", participant.get());
				model.addAttribute("cityList", cityService.getAllCity());
				model.addAttribute("stateList", stateService.getAllState());
				model.addAttribute("gender", new ArrayList<>());

				//List listQuali = listDmsServiceImpl.getByListName("EDUCATION");
				List ListDms = new ArrayList<>();
				/*for (ListDms l : listQuali) {
					if (l.getListCode().equals("HSC") || l.getListCode().equals("SSC")) {
						continue;
					}
					ListDms.add(l);
				}*/
				model.addAttribute("qualification", ListDms);
				//model.addAttribute("language", (Object) this.listDmsServiceImpl.getByListName("LANGUAGE"));
				//model.addAttribute("title", (Object) this.listDmsServiceImpl.getByListName("TITLE_CD"));
				model.addAttribute("language", (Object) new ArrayList<>());
				model.addAttribute("title", (Object) new ArrayList<>());
				String name = "";
				name += participant.get().getFirstName();
				if (participant.get().getMiddleName() != null && !participant.get().getMiddleName().equals("")) {
					name += " " + participant.get().getMiddleName();
				}
				name += " " + participant.get().getLastName();
				model.addAttribute("candidateFirsName", participant.get().getFirstName());
				model.addAttribute("CandidateLastName", participant.get().getLastName());
				return "Participant Registration";
			}
		}
		return "login";
	}

	@GetMapping("/instructionUploadFile")
	public String getInstructionUploadFile(@RequestParam("accesskey") String accesskey, Model model) {
		model.addAttribute("accesskey", accesskey);
		return "uploadocumentInstruction";
	}

	@GetMapping("/instructionUploadFilePro")
	public String getInstructionUploadFilePro(@RequestParam("accesskey") String accesskey, Model model) {
		model.addAttribute("accesskey", accesskey);
		return "redirect:uploadCandidateDocument?accessKey=" + accesskey;
	}

	private void getCapcha(Model model, String resutl) {
		List<Object> list = getCaptcha();
		model.addAttribute("r1", list.get(0));
		model.addAttribute("r2", list.get(1));
		model.addAttribute("r3", list.get(2));
		model.addAttribute("r4", list.get(3));
		model.addAttribute("msg", resutl);
	}

	public static ArrayList<Object> getCaptcha() {
		final ArrayList<Object> captcha_details = new ArrayList<Object>();
		final Random generator = new Random();
		final int op1 = generator.nextInt(9);
		final int op2 = generator.nextInt(9);
		final int operator = generator.nextInt(3);
		int result = 0;
		final char[] operator_array = { '+', '-', '*' };
		switch (operator) {
		case 0: {
			result = op1 + op2;
			break;
		}
		case 1: {
			if (op1 >= op2) {
				result = op1 - op2;
				break;
			}
			if (op2 > op1) {
				result = op2 - op1;
				break;
			}
			break;
		}
		case 2: {
			result = op1 * op2;
			break;
		}
		}
		if (op1 >= op2) {
			captcha_details.add(op1);
			captcha_details.add(new StringBuilder().append(operator_array[operator]).toString());
			captcha_details.add(op2);
			captcha_details.add(result);
		} else {
			captcha_details.add(op2);
			captcha_details.add(new StringBuilder().append(operator_array[operator]).toString());
			captcha_details.add(op1);
			captcha_details.add(result);
		}
		return captcha_details;
	}

	@PostMapping("/logout")
	public String loginPro(HttpSession session) {
		session.invalidate();
		return "redirect:login";

	}

	@GetMapping("/termsCondition")
	public String getTermsCondition() {
		return "terms";

	}

	@GetMapping("/privacy")
	public String getPrivacy() {
		return "privacy";

	}

	@GetMapping("/session-expired")
	public String gettemp(@RequestParam("param") String param, Model model) {
		if (param != null && !param.equals("")) {
			model.addAttribute("param", param);
		} else {
			model.addAttribute("param", "");
		}
		return "session-expired";

	}

	@PostMapping("/deactivatehre")
	@ResponseBody
	public String deactivatehre(@RequestParam("empCode") String empCode) {
		if (empCode != null && !empCode.equals("")) {
			Optional<HRE> hre = hreService.findByempCode(empCode);
			hreService.deactivateHRE(false, new Date(), hre.get().getId());
			EventLoger event = new EventLoger();
			event.setAccesskey("");
			event.setEmail("");
			event.setEventTime(LocalDate.now());
			event.setName("");
			event.setEvent("deactivatate hre");
			event.setUserId(hre.get().getId().intValue());
			eventLogerServer.save(event);
		}
		return "success";
	}

	@PostMapping("/activatehre")
	@ResponseBody
	public String activatehre(@RequestParam("empCode") String empCode) {
		if (empCode != null && !empCode.equals("")) {
			Optional<HRE> hre = hreService.findByempCode(empCode);
			hreService.deactivateHRE(true, new Date(), hre.get().getId());
			EventLoger event = new EventLoger();
			event.setAccesskey("");
			event.setEmail("");
			event.setEventTime(LocalDate.now());
			event.setName("");
			event.setEvent("activatate hre");
			event.setUserId(hre.get().getId().intValue());
			eventLogerServer.save(event);
		}
		return "success";

	}

	private void eventLogin(int loginId, String eventMSG) {
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
