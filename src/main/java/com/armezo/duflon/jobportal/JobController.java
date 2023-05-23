package com.armezo.duflon.jobportal;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.armezo.duflon.Entities.AccessKeyMaster;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.email.util.EmailUtility;
import com.armezo.duflon.email.util.SendPayload;
import com.armezo.duflon.utils.Accesskey;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class JobController {

	@Autowired
	private JobDetailsService jobService;
	@Autowired
	private UserService userService;
	@Autowired
	private ParticipantServiceImpl prService;
	@Autowired
	private AccessKeyMasterService accessService;
	@Autowired
	private HREService hreService;

	//private ExecutorService executorService = Executors.newFixedThreadPool(2); // Here 2 thread will be created

	
	@GetMapping("/jobCreater")
	public String showJobCreaterPage(HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			String role = session.getAttribute("role").toString();
			JobDetails job = new JobDetails();
			List<JobDetails> jobs = new ArrayList<JobDetails>();
			List<HRE> hres = new ArrayList<HRE>();
			if (role.equalsIgnoreCase("LM")) {
				jobs = jobService.getAllJobDetails();
				hres = hreService.findByAll();
			}
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				jobs = jobService.getJobDetailsByhreId(hreId);
				Optional<HRE> dlOptional = hreService.getById(hreId);
				if (dlOptional.isPresent()) {
					hres.add(dlOptional.get());
				}
			}
			model.addAttribute("job", job);
			model.addAttribute("jobs", jobs);
			model.addAttribute("hres", hres);
			return "jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Save Job Details
	@PostMapping("/saveJobDetails")
	public String saveJobDetails(@ModelAttribute("job") JobDetails job, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			String role = session.getAttribute("role").toString();
			
			Optional<HRE> optional = hreService.getById(job.getHreId());
			if (optional.isPresent()) {
				job.setHreId(optional.get().getId());
				job.setHreName(optional.get().getName());
			}
			System.out.println("Job ::: "+job);
			// Set Job Status as Active
			// job.setStatus("A");
			//jobService.saveJobDetails(job);
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Edit Job Details
	@GetMapping("/editJob")
	public String showJobDetailsToEdit(@RequestParam("jobId") Long jobId, Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			String role = session.getAttribute("role").toString();
			List<HRE> hres = new ArrayList<HRE>();
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				Optional<HRE> dlOptional = hreService.getById(hreId);
				if (dlOptional.isPresent()) {
					hres.add(dlOptional.get());
				}
			}
			if (role.equalsIgnoreCase("LM")) {
				hres = hreService.findByAll();
			}
			// Get Job By Id
			Optional<JobDetails> optional = jobService.getJobDetailsById(jobId);
			JobDetails job = new JobDetails();
			int skillLength = 1;
			if (optional.isPresent()) {
				job = optional.get();
				skillLength = optional.get().getSkills().size();
			}
			model.addAttribute("job", job);
			model.addAttribute("hres", hres);
			model.addAttribute("skillLength", skillLength);
			return "jobedit";
		} else {
			return "redirect:login";
		}
	}

	// Update Job Details
	@PostMapping("/updateJobDetails")
	public String updateJobDetails(@ModelAttribute("job") JobDetails job, Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			Optional<HRE> optional = hreService.getById(job.getHreId());
			if (optional.isPresent()) {
				job.setHreId(optional.get().getId());
				job.setHreName(optional.get().getName());
			}
			jobService.saveJobDetails(job);
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Delete Job
	@GetMapping("/deleteJob")
	public String deleteJobDetails(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			jobService.deleteJobByJobId(jobId);
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Hold Job
	@GetMapping("/rejectJobByHre")
	public String rejectJobByHre(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setApprovalHr("R");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}
	// Hold Job
	@GetMapping("/rejectJobByLM")
	public String rejectJobDetailsByLM(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setApprovalLm("R");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}
	// Hold Job
	@GetMapping("/holdJobByHre")
	public String holdJobDetails(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setStatus("H");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Hold Job
	@GetMapping("/unholdJobByHre")
	public String unholdJobDetailsByHRE(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setStatus("U");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}
	// Hold Job
	@GetMapping("/approveJobByHre")
	public String approveJobDetailsByHre(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setApprovalHr("A");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}
	// Hold Job
	@GetMapping("/approveJobByLM")
	public String unholdJobDetails(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			// Get Job By Id
			Optional<JobDetails> job = jobService.getJobDetailsById(jobId);
			if (job.isPresent()) {
				job.get().setApprovalLm("A");
				jobService.saveJobDetails(job.get());
			}
			return "redirect:jobCreater";
		} else {
			return "redirect:login";
		}
	}

	// Show All Jobs
	@GetMapping("/showAllJobs")
	public String showAllJobs(HttpSession session, Model model) {
		List<JobDetails> jobDetails = jobService.getAllActiveJobDetails();
		model.addAttribute("jobs", jobDetails);
		return "jobDetails";
	}

	@GetMapping("/applyForJob")
	public String showRegistrationPage(@RequestParam("jobId") Long jobId, Model model) {
		UserRegistration user = new UserRegistration();
		String jobTitle = "";
		user.setJobId(jobId);
		int skillLength = 1;
		List<JobSkill> skillList = new ArrayList<JobSkill>();
		// Get Job By Job Id
		Optional<JobDetails> jobOptional = jobService.getJobDetailsById(jobId);
		if (jobOptional.isPresent()) {
			jobTitle = jobOptional.get().getDesignation();
			skillList = jobOptional.get().getSkills();
		}
		List<String> skills = skillList.stream().map(JobSkill::getSkillName).collect(Collectors.toList());
		skillLength = skills.size();
		String jsonSkills = (new JSONArray(skills)).toString();
		model.addAttribute("userRegistration", user);
		model.addAttribute("skills", skills);
		model.addAttribute("jobTitle", jobTitle);
		model.addAttribute("jsonSkills", jsonSkills);
		model.addAttribute("skillLength", skillLength);
		return "jobUserRegistration";
	}

	@PostMapping("/jobUserRegistration")
	public String saveUserDetails(@ModelAttribute("userRegistration") UserRegistration user,
			@RequestParam("resumeFile") MultipartFile resume, Model model) {
		user.setResume(resume.getOriginalFilename());
		// Upload Resume
		/*
		 * String fileName = StringUtils.cleanPath(resume.getOriginalFilename()); try {
		 * Path newFolderPath = Paths.get("src/main/resources/static/files",
		 * user.getFirstName()); if (!Files.exists(newFolderPath)) {
		 * Files.createDirectory(newFolderPath); } Files.copy(resume.getInputStream(),
		 * newFolderPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING); }
		 * catch (IOException e) { e.printStackTrace(); }
		 */
		// save user details
		userService.saveUser(user);
		// Send Email
			sendEmail(user, "registration");
		String name = (user.getFirstName() == null ? "" : user.getFirstName()) + " "
				+ (user.getMiddleName() == null ? "" : user.getMiddleName()) + " "
				+ (user.getLastName() == null ? "" : user.getLastName());
		model.addAttribute("name", name);
		return "jobThankYou";
	}

	// Show Admin Home Page
	@GetMapping("/showAdminPage")
	public String adminHomePage(HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			List<JobDetails> jobs = new ArrayList<JobDetails>();
			String role = session.getAttribute("role").toString();
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				jobs = jobService.getActiveJobByhreId(hreId);
			}
			if (role.equalsIgnoreCase("LM")) {
				jobs = jobService.getAllActiveJobDetails();
			}
			List<AdminPayload> payloads = new ArrayList<AdminPayload>();
			for (JobDetails job : jobs) {
				AdminPayload payload = new AdminPayload();
				Integer applicants = 0, email = 0, interview = 0, selected = 0, joined = 0;
				// Get Registered User by JobId
				List<UserRegistration> users = userService.getAllUsersByJobId(job.getJobId());
				for (UserRegistration user : users) {
					applicants += 1;
					// Check other condition and do count
					if(user.getInvitationStatus()!=null && user.getInvitationStatus().equalsIgnoreCase("Y"))
						email +=1;
					if(user.getInterviewStatus()!=null && user.getInterviewStatus().equalsIgnoreCase("Y"))
						interview +=1;
					if(user.getSelectedStatus()!=null && user.getSelectedStatus().equalsIgnoreCase("Y"))
						selected +=1;
					if(user.getJoinedStatus()!=null && user.getJoinedStatus().equalsIgnoreCase("Y"))
						joined +=1;
				}
				// Add These all counts to payload
				payload.setJobId(job.getJobId());
				payload.setJobDesignation(job.getDesignation());
				payload.setApplicants(applicants);
				payload.setEmails(email);
				payload.setInterview(interview);
				payload.setSelected(selected);
				payload.setJoined(joined);
				// Add This Payload to List of Payloads
				payloads.add(payload);
			}
			model.addAttribute("payloads", payloads);
			return "jobAdmin";
		} else {
			return "redirect:login";
		}
	}

	// Show Analysis Page For Job
	@GetMapping("/jobAnalysis")
	public String showAnalysisPage(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			List<AdminPayload> payloads = new ArrayList<AdminPayload>();
			// Get Job By Job Id
			JobDetails job = new JobDetails();
			Optional<JobDetails> jobOptional = jobService.getJobDetailsById(jobId);
			if (jobOptional.isPresent()) {
				job = jobOptional.get();
			}
			// Get User by Job id
			List<UserRegistration> users = userService.getAllUsersByJobId(jobId);
			for (UserRegistration user : users) {
				Integer flag = 0;
				AdminPayload payload = new AdminPayload();
				String name = (user.getFirstName() == null ? "" : user.getFirstName()) + " "
						+ (user.getMiddleName() == null ? "" : user.getMiddleName()) + " "
						+ (user.getLastName() == null ? "" : user.getLastName());
				payload.setName(name);
				payload.setUserId(user.getId());
				payload.setEmail(user.getEmail());
				payload.setMobile(user.getMobile());
				// Get Required Job Skill
				List<JobSkill> jobSkills = job.getSkills();
				// Get User Skill
				List<UserSkill> userSkills = user.getSkills();
				// Calculate Matching percentage
				payload.setMatchPercentage(calculateMatchingPercentage(userSkills, jobSkills));
				payload.setSkills(userSkills);
				// Set Invitation Flag
				if (user.getInvitationFlag() != null) {
					user.setInvitationFlag(user.getInvitationFlag() + 1);
					flag = user.getInvitationFlag();
				} else {
					user.setInvitationFlag(1);
					flag = 1;
				}
				payload.setInvitationFlag(flag);
				payload.setAssessmentStatus(user.getAssessmentStatus());
				payloads.add(payload);
			}
			// Sort User By Percentage
			List<AdminPayload> payloads2 = payloads.stream()
					.sorted((a1, a2) -> a2.getMatchPercentage().compareTo(a1.getMatchPercentage()))
					.collect(Collectors.toList());
			model.addAttribute("payloads", payloads2);
			return "jobAnalysis";
		} else {
			return "redirect:login";
		}
	}

	// Send email for assessment
	@GetMapping("/sendInvitationEmail")
	public String sendInvitationEmailToUser(@RequestParam("userId") Long userId, HttpSession session, Model model) {
		if (session.getAttribute("userId") != null) {
			String role = session.getAttribute("role").toString();
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				String accesskey = "";
				// Get User by id
				Optional<UserRegistration> optional = userService.getUserByUserId(userId);
				// Generate Accesskey For this user
				if (optional.isPresent()) {
					if (optional.get().getAccesskey() != null && optional.get().getAccesskey() != "") {
						accesskey = optional.get().getAccesskey();
					} else {
						accesskey = generateAccesskeyForUser(hreId);
						optional.get().setAccesskey(accesskey);
						optional.get().setInvitationStatus("Y");
						if (optional.get().getInvitationFlag() != null) {
							optional.get().setInvitationFlag(optional.get().getInvitationFlag() + 1);
						} else {
							optional.get().setInvitationFlag(1);
						}
						// Save This Candidate Data in Participant Table
						ParticipantRegistration pr = new ParticipantRegistration();
						UserRegistration ur = optional.get();
						pr.setAccessKey(ur.getAccesskey());
						pr.setFirstName(ur.getFirstName());
						pr.setMiddleName(ur.getMiddleName());
						pr.setLastName(ur.getLastName());
						pr.setHreId(hreId);
						pr.setMobile(ur.getMobile());
						pr.setEmail(ur.getEmail());
						pr.setDesignation("Desg");
						pr.setRegStatus("2");
						pr.setTestStatus("2"); // Here taking 2, so after candidate login it will redirect to assessment
						pr.setRegistration_Date(LocalDate.now());
						pr.setSendMailDate(new Date());
						pr.setModifiedDate(LocalDate.now());
						pr.setBirthDate(ur.getBirthDate());
						//pr.setBirthDate(DataProccessor.dateToString(ur.getBirthDate()));
						// Save to db
						prService.saveData(pr);
						// Update accesskey
						accessService.updateStatus(accesskey);
						userService.saveUser(optional.get());
					}
					// Send Email
						sendEmail(optional.get(), "invitation");
					// Save this user
				}
			}
			return "Success";
		} else {
			return "redirect:login";
		}
	}

	// Util Method to calculate Matching
	public static Double calculateMatchingPercentage(List<UserSkill> userSkills, List<JobSkill> jobSkills) {
		// Get Total Skill Required For Job
		int jobSkillLength = jobSkills.size();
		Double totalMatchingPercentage = 0.0;
		Double percentageForEachSkill = (double) (100 / jobSkillLength);
		for (JobSkill jobSkill : jobSkills) {
			for (UserSkill userSkill : userSkills) {
				String us = userSkill.getSkill().toLowerCase();
				String js = jobSkill.getSkillName().toLowerCase();
				// Check Skill Match Percentage
				int matchChar = 0;
				int maxLength = Math.max(js.length(), us.length());
				for (int i = 0; i < Math.min(js.length(), us.length()); i++) {
					if (js.charAt(i) == us.charAt(i)) {
						matchChar++;
					}
				}
				double per = (double) matchChar / (double) maxLength * 100.0;
				/*
				 * if ((jobSkill.getSkillName().equalsIgnoreCase(userSkill.getSkill())) ||
				 * (jobSkill.getSkillName().contains(userSkill.getSkill())) ||
				 * (userSkill.getSkill().contains(jobSkill.getSkillName())) ) { if(js.equals(us)
				 * || js.contains(us) || us.contains(js) || js.regionMatches(0, us, 0, 4)) {
				 */
				if (per >= 50) {
					Double ratio = userSkill.getExperience() / jobSkill.getRequiredExperience();
					// Get Job and User Skill Exp
					if (ratio >= 1) {
						totalMatchingPercentage += percentageForEachSkill;
					} else if (ratio > 0 && ratio < 1) {
						totalMatchingPercentage += (percentageForEachSkill * ratio);
					} else {
						totalMatchingPercentage += 0;
					}
				}
			}
		}
		double value = totalMatchingPercentage;
		double roundedValue = Math.round(value * 100.0) / 100.0;
		if(roundedValue>99 && roundedValue<100)
			roundedValue=100;
		return roundedValue;
	}

	// Send Email Method
	public void sendEmail(UserRegistration user, String fileName) {
		String name = (user.getFirstName() == null ? "" : user.getFirstName()) + " "
				+ (user.getMiddleName() == null ? "" : user.getMiddleName()) + " "
				+ (user.getLastName() == null ? "" : user.getLastName());
		String subjectLine = "";
		String mailBody = "";
		if (fileName.equalsIgnoreCase("registration")) {
			subjectLine = "Your Job Application: Registration";
			mailBody = DataProccessor.readFileFromResource("duflonForRegistration");
		}
		if (fileName.equalsIgnoreCase("invitation")) {
			subjectLine = "Your Job Application: Assessment Invitation";
			mailBody = DataProccessor.readFileFromResource("duflonForInvitation");
			mailBody = mailBody.replace("${accesskey}", user.getAccesskey());
		}

		mailBody = mailBody.replace("${candidateName}", name);
		// Send Payload
		SendPayload sendPayload = new SendPayload();
		sendPayload.setTo(user.getEmail());
		sendPayload.setSubjectLine(subjectLine);
		sendPayload.setMsg(mailBody);
		sendPayload.setCc("");
		sendPayload.setBcc("");
		sendPayload.setFrom("Armezo Team");
		EmailUtility.sendMailDuflon(sendPayload.getTo(), "Armezo Team", "", "", subjectLine, mailBody, "smtp");
	}

	// Generate Accesskey
	public String generateAccesskeyForUser(Long hreId) {
		String accesskey = "";
		List<AccessKeyMaster> keyLsit = new ArrayList<>();
		boolean check = true;
		while (check) {
			accesskey = Accesskey.getAccesskey();
			if (!accessService.getAccesskey(accesskey).isPresent()) {
				check = false;
			}
		}
		AccessKeyMaster accessKeyMaser = new AccessKeyMaster();
		accessKeyMaser.setAccesskey(accesskey);
		accessKeyMaser.sethreId(hreId);
		accessKeyMaser.setModifiedDate(LocalDate.now());
		keyLsit.add(accessKeyMaser);
		accessService.saveAccesskey(keyLsit);
		return accesskey;
	}

}
