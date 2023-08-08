package com.armezo.duflon.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.ErrorLogger;
import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.DataListService;
import com.armezo.duflon.Services.EmergencyContactService;
import com.armezo.duflon.Services.ErrorLoggerService;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.FamilyDetailService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.MasterDataService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.utils.DataProccessor;



@Controller
@RequestMapping("")
public class ParticipantsController {

	 @Autowired
	    private ParticipantServiceImpl participantservice;
	    @Autowired
	    private HREService hreService;
	    @Autowired
	    private FamilyDetailService familyDetailService;
	    @Autowired
	    private EmergencyContactService emergencyContactService;
	    @Autowired
	    private WorkExperienceService workExperienceService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    @Autowired
	    EventLogerService eventLogerServer;
	    @Autowired
	    private ErrorLoggerService errorService;
	    @Autowired
	    private DataListService dlService;
	    @Autowired
		private MasterDataService masterDataService;
	    @Value("${file.path}")
	    private String filePath;
	    
	    
	    @PostMapping({ "/upload" })
	    public ResponseEntity<String> uploadFile(@RequestParam("accessKey") final String accessKey, @RequestParam("file") final MultipartFile file, @RequestParam("name") final String name, @RequestParam("identity_proof") final String identityProof, @RequestParam("address_proof") final String addressProof) {
	        final String path = filePath +"/"+ accessKey + "/";
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        final String fileName = StringUtils.cleanPath(file.getOriginalFilename());
	        final File directory = new File(path);
	        if (!directory.exists()) {
	            directory.mkdir();
	        }
	        try {
	            file.transferTo(new File(String.valueOf(String.valueOf(path)) + fileName));
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            ErrorLogger error = new ErrorLogger();
	            error.setAccesskey(accessKey);
	            error.setErrorMessage(e.getMessage());
	            error.setErrorTime(LocalDateTime.now());
	            error.setProcess("Upload Documents");
	            errorService.saveErrorLogger(error);
	        }
	        if (name.equals("photograph")) {
	            participant.get().setPhotograph(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("resume")) {
	            participant.get().setResume(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("signature")) {
	            participant.get().setSignature(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("identitityProof")) {
	            participant.get().setIdentitityProof(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	            participant.get().setIdentitityProofName(identityProof);
	            participant.get().setIdProof(identityProof);
	        }
	        if (name.equals("addressProof")) {
	            participant.get().setAddressProof(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	            participant.get().setAddressProofName(addressProof);
	        }
	        if (name.equals("10th")) {
	            participant.get().setQualification(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("12th")) {
	            participant.get().setQualification2(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("Graduation")) {
	            participant.get().setQualification3(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("resigningLetter")) {
	            participant.get().setResignationLetter(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("experienceletter")) {
	            participant.get().setExperienceletter(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("salaryslip")) {
	            participant.get().setSalarySlip(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        if (name.equals("documents")) {
	            participant.get().setDocuments(String.valueOf(String.valueOf(accessKey)) + "/" + fileName);
	        }
	        participant.get().setModifiedDate(LocalDate.now());
	        this.participantservice.saveFiles((ParticipantRegistration)participant.get());
	        String name1 ="";
	        name1  += participant.get().getFirstName();
	        if(participant.get().getMiddleName() != null && participant.get().getMiddleName().length()>0) {
	        	name1  +=" "+ participant.get().getMiddleName();
	        }
	        name1  +=" "+ participant.get().getLastName();
	        EventLoger event = new EventLoger();
            event.setAccesskey(participant.get().getAccessKey());
            event.setEmail(participant.get().getEmail());
            event.setEventTime(LocalDate.now());
            event.setName(name1);
            event.setEvent("Upload documents By Dealer");
            event.setUserId(participant.get().getHreId().intValue());
            eventLogerServer.save(event);
	        return (ResponseEntity<String>) ResponseEntity.ok(("images/" + accessKey + "/" + fileName));
	    }
	    
	    @GetMapping({ "/profileDetails" })
	    public String getParticipantProfile(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> partipantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        ParticipantRegistration  participant = new ParticipantRegistration();
	        if(partipantOptional.isPresent()) {
	        	participant = partipantOptional.get();
	        }
	        //final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	        String assessmentDate = "";
	        String interviewDate = "";
	        String lm = "";
	        String region = "";
	        String joiningDate = "";
	        String hreName = "";
	        String city = "";
	        String state = "";
	        String hiredDate = "";
	        
	        if (participant.getTestCompletionDate() != null) {
	            assessmentDate = participant.getTestCompletionDate().format(df);
	        }
	        if (participant.getInterviewDate() != null) {
	            interviewDate = participant.getInterviewDate().format(df);
	        }
	        if (participant.getHiredDate() != null) {
	            hiredDate =participant.getHiredDate().format(df);
	        }
	        if(participant.getJoiningDate()!=null) {
	        	joiningDate=participant.getJoiningDate().format(df);
	        }
	        //Get dealer by dealer id
	        Optional<HRE> optional = hreService.getById(participant.getHreId());
	        if(optional.isPresent())
	        	hreName=optional.get().getName();
	        model.addAttribute("hiredDate", (Object)hiredDate);
	        model.addAttribute("hreName", hreName);
	        model.addAttribute("city", (Object)city);
	        model.addAttribute("state", (Object)state);
	        model.addAttribute("lm", (Object)lm);
	        model.addAttribute("region", (Object)region);
	        model.addAttribute("Accessment_date", (Object)assessmentDate);
	        model.addAttribute("interviewDate", (Object)interviewDate);
	        model.addAttribute("joiningDate", (Object)joiningDate);
	        model.addAttribute("profile", (Object)participant);
	        return "profile";
	    }
	    
	    @GetMapping({ "/getPersonalDetails" })
	    public String getParticipantPersonalDetails(final HttpSession session, @RequestParam("accesskey") final String accesskey, final Model model) {
	        if (session.getAttribute("userId") != null) {
	        	String locationCode="";
	            final Optional<ParticipantRegistration> participantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	            final ParticipantRegistration participant = participantOptional.get();
	            model.addAttribute("language", (Object)this.dlService.getByListName("LANGUAGE"));
	            List<String> educaions = masterDataService.getAllMasterDataByMasterName("Education");
	            model.addAttribute("educations", educaions);
	            model.addAttribute("title", (Object)this.dlService.getByListName("TITLE_CD"));
	            model.addAttribute("ID", (Object)this.dlService.getByListName("ID"));
	            model.addAttribute("personal", (Object)participant);
	            model.addAttribute("locationCode", locationCode);
	            return "personal-details";
	        }
	        return "redirect:login";
	    }
	    
	    @PostMapping({ "/savePersonalDetails" })
	    public String saveParticipantPersonalDetails(@ModelAttribute("participantRegistration") @Validated final ParticipantRegistration participantRegistration, 
	    		final BindingResult result, @RequestParam final String accessKey, @RequestParam final String btnValue,HttpSession session) {
	      
	    	 Optional<ParticipantRegistration> p =	participantservice.findByEmployeeCode(participantRegistration.getEmpCode(),participantRegistration.getHreId());
	        	if(p.isPresent()) {
	        		if(accessKey.equals(p.get().getAccessKey())) {
	        		}else {	 
	        			session.setAttribute("emp_msg", "This Employee Code already exists");
	        			return "redirect:getPersonalDetails?accesskey=" + accessKey;	
	        		}
	        	}  
	    	final Optional<ParticipantRegistration> participantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        final ParticipantRegistration participant = participantOptional.get();
	        participant.setEmpCode(participantRegistration.getEmpCode());
	        participant.setTitle(participantRegistration.getTitle());
	        participant.setFirstName(participantRegistration.getFirstName());
	        participant.setMiddleName(participantRegistration.getMiddleName());
	        participant.setLastName(participantRegistration.getLastName());
	        participant.setAddress(participantRegistration.getAddress());
	        participant.setState(participantRegistration.getState());
	        participant.setCity(participantRegistration.getCity());
	        participant.setPin(participantRegistration.getPin());
	        participant.setTehsil(participantRegistration.getTehsil());
	        participant.setVillage(participantRegistration.getVillage());
	        participant.setIdProof(participantRegistration.getIdProof());
	        participant.setBirthDate(participantRegistration.getBirthDate());
	        participant.setMobile(participantRegistration.getMobile());
	        participant.setAlternateContactNumber(participantRegistration.getAlternateContactNumber());
	        participant.setEmail(participantRegistration.getEmail());
	        participant.setAdharNumber(participantRegistration.getAdharNumber());
	        participant.setHighestQualification(participantRegistration.getHighestQualification());
	        participant.setPrimaryLanguage(participantRegistration.getPrimaryLanguage());
	        participant.setSecondaryLanguage(participantRegistration.getSecondaryLanguage());
	    	 if (btnValue.equals("next")) {
		            participant.setPersonalFlag("1");
		        }
		        participant.setModifiedDate(LocalDate.now());
		        participantservice.saveData(participant);
	        eventLogin(participant.getHreId().intValue(),"Save Personal Details",participant.getAccessKey(),participant.getFirstName()+
	        		" "+participant.getLastName()+" "+participant.getLastName(),participant.getEmail());
	       
	        if(accessKey == null) {
	        	  return "redirect:getPersonalDetails?accesskey=" + accessKey;
	        }
	        if (btnValue.equalsIgnoreCase("next")) {
	            return "redirect:getempdetails?accesskey=" + accessKey;
	        }
	        if (btnValue.equalsIgnoreCase("save")) {
	            return "redirect:getPersonalDetails?accesskey=" + accessKey;
	        }
	        return "redirect:getPersonalDetails?accesskey=" + accessKey;
	    }
	    
	    @GetMapping({ "/getempdetails" })
	    public String getParticipantEmploymentDetails(final ParticipantRegistration participantRegistration, @RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("emp", (Object)participant.get());
	        model.addAttribute("gender", (Object)this.dlService.getByListName("GENDER"));
	        return "employment-details";
	    }
	    
	    @PostMapping({ "/saveEmploymentDetails" })
	    public String saveParticipantEmploymentDetails(final ParticipantRegistration participantRegistration, @RequestParam final String accessKey, @RequestParam final String btnSave) {
	        final Optional<ParticipantRegistration> participantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        final ParticipantRegistration participant = participantOptional.get();
	        participant.setEmpSalary(participantRegistration.getEmpSalary());
	        participant.setGender(participantRegistration.getGender());
	        participant.setPfNumber(participantRegistration.getPfNumber());
	        participant.setUan(participantRegistration.getUan());
	        participant.setEpfo(participantRegistration.getEpfo());
	        participant.setBankName(participantRegistration.getBankName());
	        participant.setIfscCode(participantRegistration.getIfscCode());
	        participant.setBankAccountNumber(participantRegistration.getBankAccountNumber());
	        eventLogin(participant.getHreId().intValue(),"Save Employmen tDetails",participant.getAccessKey(),participant.getFirstName()+
	        		" "+participant.getLastName()+" "+participant.getLastName(),participant.getEmail());
	        if (btnSave.equals("Next")) {
	            participant.setEmploymentFlag("1");
	        }
	        System.out.println("All Email :: "+participantRegistration.getIdentitityProofName());
	        participant.setModifiedDate(LocalDate.now());
	        this.participantservice.saveData(participant);
	        if (btnSave.equals("Save")) {
	            return "redirect:getempdetails?accesskey=" + accessKey;
	        }
	        if (btnSave.equals("Next")) {
	            return "redirect:getgeneraldetails?accesskey=" + accessKey;
	        }
	        return "redirect:getempdetails?accesskey=" + accessKey;
	    }
	    
	    @GetMapping({ "/getgeneraldetails" })
	    public String getParticipantGeneralDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("general", (Object)participant.get());
	        final List<String> martialStatus = new ArrayList<String>();
	        martialStatus.add("Married");
	        martialStatus.add("Single");
	        martialStatus.add("Divorced");
	        model.addAttribute("martialStatus", (Object)martialStatus);
	        model.addAttribute("blodgroup", (Object)this.dlService.getByListName("BLOOD_GRP"));
	        return "general-details";
	    }
	    
	    @PostMapping({ "/saveGeneralDetails" })
	    public String saveParticipantGeneralDetails(@RequestParam("accesskey") final String accesskey, @RequestParam("martialStatus") final String martialStatus, 
	    		@RequestParam("anniversary_date") final String anniversary_date, @RequestParam("blodgroup") final String blodgroup, 
	    		@RequestParam("btnStatus") final String btnStatus) {
	     
	    	final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	       // participant.get().setAnniversaryDate(anniversary_date);
	        participant.get().setBloodGroup(blodgroup);
	        participant.get().setMartialStatus(martialStatus);
	        participant.get().setAnniversaryDate(DataProccessor.parseDate(anniversary_date));
	        String url = "";
	        
	        if (btnStatus.equals("N")) {
	            participant.get().setGeneralFlag("1");
	            url = "redirect:getWorkExperience?accesskey=" + accesskey+"&param=";
	        }
	        if (btnStatus.equals("S")) {
	            url = "redirect:getgeneraldetails?accesskey=" + accesskey;
	        }
	        participant.get().setModifiedDate(LocalDate.now());
	        this.participantservice.saveData((ParticipantRegistration)participant.get());
	        eventLogin(participant.get().getHreId().intValue(),"Save General Details",participant.get().getAccessKey(),participant.get().getFirstName()+
	        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        return url;
	    }
	    
	    @GetMapping({ "/getWorkExperience" })
	    public String getParticipantWorkExperienceDetails(@RequestParam("accesskey") final String accesskey,@RequestParam("param") final String param,
	    		final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            if (participant.get().getExperience() != null && participant.get().getExperience().equals("fresher")) {
	                model.addAttribute("workexperience", (Object)participant.get());
	                return "work-experience";
	            }
	            if (participant.get().getExperience() != null) {
	                participant.get().getExperience().equals("experience");
	            }
	        }
	        participant.get().getWorkExperience();
	        model.addAttribute("workexperience", (Object)participant.get());
	        return "work-experience";
	    }
	    
	    @PostMapping({ "/saveWorkExperience" })
	    public String saveParticipantWorkExperienceDetails(@RequestParam("accessKey") final String accessKey, @RequestParam("status") final String status, @RequestParam("btnStatus") final String btnStatus, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        if (participant.isPresent()) {
	            if (status.equals("fresher")) {
	                participant.get().setFresher(status);
	                participant.get().setExperience("");
	            }
	            if (status.equals("experience")) {
	                participant.get().setFresher((String)null);
	                participant.get().setExperience("experience");
	            }
	            if (btnStatus.equals("Next")) {
	                participant.get().setWorkFlag("1");
	            }
	            participant.get().setModifiedDate(LocalDate.now());
	            this.participantservice.saveData((ParticipantRegistration)participant.get());
	            eventLogin(participant.get().getHreId().intValue(),"Save Work Experience",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        }
	        String url = "";
	        if (status.equals("fresher")) {
	            model.addAttribute("workexperience", (Object)participant.get());
	            url = "work-experience";
	        }
	        else {
	            url = "redirect:getWorkExperienceExp?accesskey=" + accessKey;
	        }
	        return url;
	    }
	    
	    @GetMapping({ "/getWorkExperienceExp" })
	    public String getParticipantWorkExperienceExpDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            final List<WorkExperience> participantWorkExp = (List<WorkExperience>)participant.get().getWorkExperience();
	            model.addAttribute("workexperienceExp", (Object)participant.get());
	            model.addAttribute("participantWorkExp", (Object)participantWorkExp);
	        }
	        else {
	            model.addAttribute("workexperienceExp", (Object)new ParticipantRegistration());
	            model.addAttribute("participantWorkExp", (Object)new ArrayList());
	        }
	        return "work-experience-exp";
	    }
	    
	    @PostMapping({ "/saveWorkExperienceExp" })
	    public String saveParticipantWorkExperienceExpDetails(@RequestParam final String accessKey, @RequestParam(required = false) final String autoIndustryExperience, @RequestParam final String companyName, @RequestParam final String expInMths, @RequestParam final String previousDesignation, @RequestParam final String workArea) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        final ArrayList<WorkExperience> ListworkExp = new ArrayList<WorkExperience>();
	        final WorkExperience workExperience = new WorkExperience();
	        workExperience.setAutoIndustryExperience(autoIndustryExperience);
	        workExperience.setCompanyName(companyName);
	        workExperience.setPreviousDesignation(previousDesignation);
	        workExperience.setExpInMths(Integer.valueOf(Integer.parseInt(expInMths)));
	        workExperience.setWorkArea(workArea);
	        workExperience.setParticipantRegistration((ParticipantRegistration)participant.get());
	        ListworkExp.add(workExperience);
	        if (participant.isPresent()) {
	            participant.get().setWorkExperience((List)ListworkExp);
	            participant.get().setWorkFlag("1");
	            participant.get().setExperience("experience");
	            participant.get().setFresher((String)null);
	            participant.get().setModifiedDate(LocalDate.now());
	            this.participantservice.saveData((ParticipantRegistration)participant.get());
	            
	            eventLogin(participant.get().getHreId().intValue(),"Save Work Experience",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        }
	        return "redirect:getWorkExperienceExp?accesskey=" + accessKey;
	    }
	    
	    @PostMapping({ "/deleteWorkExperience" })
	    @ResponseBody
	    public String deleteWorkExperienceExp(@RequestParam final String wid, @RequestParam("accesskey") final String accesskey) {
	        final Optional<WorkExperience> workExperience = (Optional<WorkExperience>)this.workExperienceService.getById(Long.valueOf(Long.parseLong(wid)));
	        if (workExperience.isPresent()) {
	            this.workExperienceService.delete((WorkExperience)workExperience.get());
	            this.participantservice.updateModifiedDate(accesskey);
	        }
	        return "success";
	    }
	    
	    @PostMapping({ "/updateWorkExperience" })
	    @ResponseBody
	    public String updateWorkExperienceExp(@RequestParam("id") final String id, @RequestParam("workArea") final String workArea, @RequestParam("previousDesignation") final String previousDesignation, @RequestParam("expInMths") final String expInMths, @RequestParam("companyName") final String companyName, @RequestParam(required = false) final String autoIndustryExperience, @RequestParam("accesskey") final String accesskey) {
	        final Optional<WorkExperience> work = (Optional<WorkExperience>)this.workExperienceService.getById(Long.valueOf(Long.parseLong(id)));
	        if (work.isPresent()) {
	            work.get().setAutoIndustryExperience(autoIndustryExperience);
	            work.get().setCompanyName(companyName);
	            work.get().setExpInMths(Integer.valueOf(Integer.parseInt(expInMths)));
	            work.get().setPreviousDesignation(previousDesignation);
	            work.get().setWorkArea(workArea);
	            this.workExperienceService.save((WorkExperience)work.get());
	            this.participantservice.updateModifiedDate(accesskey);
	        }
	        return "success";
	    }
	    
	    @GetMapping({ "/getfamilydetails" })
	    public String getParticipantFamilyDetails(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("partcipant", (Object)participant.get());
	        participant.get().getFamilyDetails();
	        model.addAttribute("relationship", (Object)this.dlService.getByListName("ENQUIRY_RELATION"));
	        if (participant.get().getFamilyDetails().size() > 0) {
	            model.addAttribute("familyDetail", (Object)participant.get().getFamilyDetails());
	        }
	        else {
	            model.addAttribute("familyDetail", (Object)new ArrayList());
	        }
	        return "family-member-details";
	    }
	    
	    @GetMapping({ "/getOneFamilyDetails" })
	    public String editFamily(@RequestParam("fid") final Long fid, final Model model) {
	        final FamilyDetails familyDetails = this.participantservice.getOneFamilyDetailsById(fid);
	        model.addAttribute("familyDetailsOne", (Object)familyDetails);
	        return "family-member-details";
	    }
	    
	    @PostMapping({ "/savefamilydetails" })
	    public String saveParticipantFamilyDetails(final FamilyDetails familyDetails, @RequestParam final String accessKey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        familyDetails.setParticipantRegistration((ParticipantRegistration)participant.get());
	        final ArrayList<FamilyDetails> Listfamily = new ArrayList<FamilyDetails>();
	        Listfamily.add(familyDetails);
	        participant.get().setFamilyDetails(Listfamily);
	        participant.get().setFamilyFlag("1");
	        participant.get().setModifiedDate(LocalDate.now());
	        this.participantservice.saveData((ParticipantRegistration)participant.get());
	        eventLogin(participant.get().getHreId().intValue(),"Save Family Details",participant.get().getAccessKey(),participant.get().getFirstName()+
	        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        return "redirect:getfamilydetails?accesskey=" + participant.get().getAccessKey();
	    }
	    
	    @GetMapping({ "/deleteOneFamilyDetails" })
	    public String deleteFamilyDetails(@RequestParam("fid") final Long fid) {
	        this.participantservice.deleteById(fid);
	        return "family-member-details";
	    }
	    
	    @PostMapping({ "/updateFamily" })
	    public String updateFamilyDetails(@RequestParam("accesskey") final String accesskey, @RequestParam("fid") final String fid, @RequestParam("member") final String member, @RequestParam("relatonShip") final String relatonShip) {
	        final Optional<FamilyDetails> familyDetails = (Optional<FamilyDetails>)this.familyDetailService.getByFid(Long.parseLong(fid));
	        if (familyDetails.isPresent()) {
	            familyDetails.get().setMemberName(member);
	            familyDetails.get().setRelationship(relatonShip);
	            this.familyDetailService.update((FamilyDetails)familyDetails.get());
	            this.participantservice.updateModifiedDate(accesskey);
	        }
	        return "family-member-details";
	    }
	    
	    @GetMapping({ "/getEmergencyContact" })
	    public String getParticipantEmergencyContact(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("emergencyContact", (Object)participant.get());
	        final List<EmergencyContact> emergency = (List<EmergencyContact>)participant.get().getEmergencyContact();
	        model.addAttribute("emergency", (Object)emergency);
	        return "emergency-contact";
	    }
	    
	    @PostMapping({ "/saveEmergencyContact" })
	    public String saveParticipantEmergencyContact(final EmergencyContact emergencyContact, @RequestParam final String accessKey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        emergencyContact.setParticipantRegistration((ParticipantRegistration)participant.get());
	        final ArrayList<EmergencyContact> emergeContact = new ArrayList<EmergencyContact>();
	        emergeContact.add(emergencyContact);
	        participant.get().setEmergencyContact(emergeContact);
	        participant.get().setEmergencyFlag("1");
	        participant.get().setModifiedDate(LocalDate.now());
	        this.participantservice.saveData((ParticipantRegistration)participant.get());
	        eventLogin(participant.get().getHreId().intValue(),"Save Emergency Contact",participant.get().getAccessKey(),participant.get().getFirstName()+
	        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        return "redirect:getEmergencyContact?accesskey=" + participant.get().getAccessKey();
	    }
	    
	    @GetMapping({ "/getOneEmergencyContact" })
	    public String getEmergencyContactById(final Model model, @RequestParam final Long id) {
	        final EmergencyContact emergencyContact = this.participantservice.getEmergencyContactById(id);
	        model.addAttribute("emergencyContact", (Object)emergencyContact);
	        return "emergency-contact";
	    }
	    
	    @PostMapping({ "/deleteEmergency" })
	    public String deleteEmergencyContact(@RequestParam final String id, @RequestParam("accesskey") final String accesskey) {
	        this.emergencyContactService.deleteById(Long.valueOf(Long.parseLong(id)));
	        this.participantservice.updateModifiedDate(accesskey);
	        return "emergency-contact";
	    }
	    
	    @PostMapping({ "/updateEmergency" })
	    public String updateParticipant(@RequestParam final String id, @RequestParam final String name, @RequestParam final String mobile, @RequestParam final String accessKey) {
	        final Optional<EmergencyContact> emergencyContact = (Optional<EmergencyContact>)this.emergencyContactService.getEmergencyContact(Long.valueOf(Long.parseLong(id)));
	        if (emergencyContact.isPresent()) {
	            emergencyContact.get().setCname(name);
	            emergencyContact.get().setContactNo(mobile);
	            this.emergencyContactService.update((EmergencyContact)emergencyContact.get());
	            this.participantservice.updateModifiedDate(accessKey);
	        }
	        return "emergency-contact";
	    }
	    
	    @GetMapping({ "/getAssessmentScore" })
	    public String getParticipantAssessmentScore(@Validated final ParticipantRegistration participantRegistration, final BindingResult result, @RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("Assmntscore", (Object)participant.get());
	        /*
	        final Optional<InterviewScore> interviewScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(accesskey);
	        if (interviewScore.isPresent()) {
	        	Double value = Double.parseDouble(interviewScore.get().getTotal_avt());
	        	
	            model.addAttribute("interviewScore", Math.round(value));
	        }
	        */
	        return "assessment-scores";
	    }
	    
	    @PostMapping({ "/saveAssessmentScore" })
	    @ResponseBody
	    public String saveParticipantAssessmentScore(final ParticipantRegistration participantRegistration, @RequestParam final String accessKey) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        this.participantservice.saveData((ParticipantRegistration)participant.get());
	        return "saved AssessmentScore success";
	    }
	    
	    @GetMapping({ "/uploadDocoment" })
	    public String uploadDocument(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("participant", (Object)participant.get());
	        return "upload-documents";
	    }
	    
	    @GetMapping({ "/finalSubmit" })
	    public String finalDocumentSubmit(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        model.addAttribute("participant", (Object)participant.get());
	        return "finalSubmit";
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
