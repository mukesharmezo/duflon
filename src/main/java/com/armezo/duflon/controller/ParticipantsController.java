package com.armezo.duflon.controller;

import java.io.File;
import java.time.LocalDate;
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

import com.armezo.duflon.Entities.DataList;
import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.DataListService;
import com.armezo.duflon.Services.EmergencyContactService;
import com.armezo.duflon.Services.EventLogerServer;
import com.armezo.duflon.Services.FamilyDetailService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
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
	    EventLogerServer eventLogerServer;
	    @Autowired
	    private DataListService dlService;
	    @Value("${Ap.assessmentURL}")
	    private String assessmentURL;
	    @Value("${Ap.dmsURL}")
		private String dmsURL;
	    @Value("${Ap.candLink}")
		private String candLink;
	    @Value("${Ap.adminLink}")
	    private String adminLink;
	    
	    
	    @PostMapping({ "/upload" })
	    public ResponseEntity<String> uploadFile(@RequestParam("accessKey") final String accessKey, @RequestParam("file") final MultipartFile file, @RequestParam("name") final String name, @RequestParam("identity_proof") final String identityProof, @RequestParam("address_proof") final String addressProof) {
	        final String path = "/home/msilazuser01/irecruit/" + accessKey + "/";
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
	    
	    /*
	    @ExceptionHandler({ TypeMismatchException.class })
	    @PostMapping({ "/reg" })
	    public String addParticipants(@ModelAttribute("participantRegistration") @Validated final ParticipantRegistration participantRegistration, final BindingResult result) {    	
	    	final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(participantRegistration.getAccessKey());
	        participant.get().setBirthDate(participantRegistration.getBirthDate());
	        participant.get().setMobile(participantRegistration.getMobile());
	        participant.get().setGender(participantRegistration.getGender());
	        participant.get().setAddress(participantRegistration.getAddress());
	        participant.get().setCity(participantRegistration.getCity());
	        participant.get().setState(participantRegistration.getState());
	        participant.get().setPin(participantRegistration.getPin());
	        participant.get().setHighestQualification(participantRegistration.getHighestQualification());
	        participant.get().setAdharNumber(participantRegistration.getAdharNumber());
	        participant.get().setTwoWheeler(participantRegistration.getTwoWheeler());
	        participant.get().setFourWheeler(participantRegistration.getFourWheeler());
	        if (participantRegistration.getTwoWheeler() != null) {
	            participant.get().setKnowDriving(participantRegistration.getTwoWheeler());
	        }
	        participant.get().setOwnTwoWheeler(participantRegistration.getOwnTwoWheeler());
	        participant.get().setOwnFourWheeler(participantRegistration.getOwnFourWheeler());
	        participant.get().setTitle(participantRegistration.getTitle());
	        participant.get().setSource(participantRegistration.getSource());
	        participant.get().setTotal(participantRegistration.getTotal());
	        participant.get().setExperience(participantRegistration.getExperience());
	        participant.get().setFresher(participantRegistration.getFresher());
	        participant.get().setAutoIndustryExperience(participantRegistration.getAutoIndustryExperience());
	        participant.get().setNonAutoIndustryExperience(participantRegistration.getNonAutoIndustryExperience());
	        participant.get().setRegStatus("2");
	        participant.get().setTestStatus("1");
	        participant.get().setPrimaryLanguage(participantRegistration.getPrimaryLanguage());
	        participant.get().setSecondaryLanguage(participantRegistration.getSecondaryLanguage());
	        participant.get().setMartialStatus(participantRegistration.getMartialStatus());
	        participant.get().setWorkedWithMSILBefore(participantRegistration.getWorkedWithMSILBefore());
	        participant.get().setOldMspin(participantRegistration.getOldMspin());
	        participant.get().setMsilExp(participantRegistration.getMsilExp());
	        participant.get().setKnowDriving(participantRegistration.getKnowDriving());
	        participant.get().setAge(participantRegistration.getAge());
	        participant.get().setMdsCertified(participantRegistration.getMdsCertified());
	        participant.get().setDL(participantRegistration.getDL());
	        participant.get().setOldMspin(participantRegistration.getOldMspin());
	        participant.get().setOldMSPINStatus(participantRegistration.getOldMSPINStatus());
	        participant.get().setModifiedDate(LocalDate.now());
	        if (participant.get().getDesignation() != null && participant.get().getDesignation().equals("Sales") && participantRegistration.getWorkedWithMSILBefore() != null && participantRegistration.getWorkedWithMSILBefore().equals("No")) {
	            participant.get().setFinalDesignation("STR");
	        }
	        final ParticipantRegistration p = this.participantservice.saveData((ParticipantRegistration)participant.get());
	        if (participant.get().getDesignation().equals("Sales")) {
	            final Optional<DataScience> dataScience = (Optional<DataScience>)this.dataScienceService.findByAccesskey(participantRegistration.getAccessKey());
	            if (dataScience.isPresent()) {
	                dataScience.get().setFirstName(p.getFirstName());
	                dataScience.get().setMiddleName(p.getMiddleName());
	                dataScience.get().setLastName(p.getLastName());
	                if (p.getTotal() != null) {
	                    dataScience.get().setTotal(p.getTotal().toString());
	                }
	                dataScience.get().setWorkedWithMSILBefore(p.getWorkedWithMSILBefore());
	                dataScience.get().setOldMspin(p.getOldMspin());
	                dataScience.get().setMsilExp(p.getMsilExp());
	                final Optional<String> city = (Optional<String>)this.stateCityPinDmsService.getStateByCityCode(p.getCity());
	                if (city.isPresent()) {
	                    dataScience.get().setResidenceOf((String)city.get());
	                }
	                if (p.getAutoIndustryExperience() == null || p.getAutoIndustryExperience() == 0) {
	                    dataScience.get().setAutoIndustryExperience("No");
	                }
	                else {
	                    dataScience.get().setAutoIndustryExperience("Yes");
	                }
	                if (p.getTwoWheeler() != null) {
	                    dataScience.get().setKnowDriving(p.getTwoWheeler());
	                }
	                if (p.getFourWheeler() != null) {
	                    dataScience.get().setKnowDriving(p.getFourWheeler());
	                }
	                dataScience.get().setDL(p.getDL());
	                dataScience.get().setMdsCertified(p.getMdsCertified());
	                dataScience.get().setOwnTwoWheeler(p.getOwnTwoWheeler());
	                dataScience.get().setHighestQualification(p.getHighestQualification());
	                dataScience.get().setGender(p.getGender());
	                dataScience.get().setAge(p.getAge());
	                dataScience.get().setPrimaryLanguage(p.getPrimaryLanguage());
	                dataScience.get().setSecondaryLanguage(p.getSecondaryLanguage());
	                dataScience.get().setDealerCode(p.getOutletCode());
	                dataScience.get().setMartialStatus(p.getMartialStatus());
	                
	               // Optional<HRE> dealer = dealerService.getById(p.gethreId());
	               // if(dealer.isPresent()) {
	                	Optional<DataScienceDealer> data = dataScienceDealerService.getOutletCode(p.getOutletCode());
	                	if(data.isPresent()) {
	                     this.dataScienceService.save((DataScience)dataScience.get());
	                	}
	               // }*
	            }
	        }
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
            event.setEvent("Registation");
            event.setUserId(participant.get().getHreId().intValue());
            if(participant.get().getDesignation()!= null && participant.get().getDesignation().equals("Sales Support")) {
            	return "redirect:updateTestSalesSupport?accesskey="+ participant.get().getAccessKey();	
            }else {
	        return "redirect:" + this.assessmentURL + "assess/IRCreg?accesskey=" + participant.get().getAccessKey();
            }
	    }
	    */
	    @GetMapping({ "/profileDetails" })
	    public String getParticipantProfile(@RequestParam("accesskey") final String accesskey, final Model model) {
	        final Optional<ParticipantRegistration> partipantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        ParticipantRegistration  participant = new ParticipantRegistration();
	        if(partipantOptional.isPresent()) {
	        	participant = partipantOptional.get();
	        }
	        final Optional<HRE> hre = (Optional<HRE>)this.hreService.getById((long)participant.getHreId());
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
	            final List<DataList> listQuali = (List<DataList>)this.dlService.getByListName("EDUCATION");
	            final List<DataList> DataList = new ArrayList<DataList>();
	            for (final DataList l : listQuali) {
	                if (!l.getListCode().equals("HSC")) {
	                    if (l.getListCode().equals("SSC")) {
	                        continue;
	                    }
	                    DataList.add(l);
	                }
	            }
	            model.addAttribute("qualification", (Object)DataList);
	            model.addAttribute("title", (Object)this.dlService.getByListName("TITLE_CD"));
	            model.addAttribute("ID", (Object)this.dlService.getByListName("ID"));
	           
	            /*final Map<String, String> map = new HashMap<String, String>();
	            final List<Object> cityList = (List<Object>)this.stateCityPinDmsService.getAllCity();
	            for (final Object city : cityList) {
	                final Object[] obj = (Object[])city;
	                map.put((String)obj[1], (String)obj[0]);
	            }
	            final Map<String, String> mapState = new HashMap<String, String>();
	            final List<Object> stateList = (List<Object>)this.stateCityPinDmsService.getAllState();
	            for (final Object state : stateList) {
	                final Object[] obj2 = (Object[])state;
	                mapState.put((String)obj2[1], (String)obj2[0]);
	            }
	            //Doing Sorting of state
	            List<Map.Entry<String, String>> sortedState = mapState.entrySet().stream()
	            		.sorted(Map.Entry.comparingByValue()).collect(Collectors.toList());
	            Optional<Outlet> outlet = outletService.getOutletByOutletCode(participant.getOutletCode());
	            if(outlet.isPresent()) {
	            	locationCode =outlet.get().getLocation();
	            }
	            if(participant.getEmployeeCode() == null || participant.getEmployeeCode().equals("")) {
	            	
	            	//participant.setEmployeeCode(locationCode);
	            }
	            final Map<String, String> villageMap = new HashMap<String, String>();
	            final Map<String, String> TehsilMap = new HashMap<String, String>();
	            if (participantOptional.isPresent() && participantOptional.get().getTehsil() != null) {
	                final List<Object> tehshilList = (List<Object>)this.tService.findByTehsilCode(participantOptional.get().getTehsil());
	                for (final Object t : tehshilList) {
	                    final Object[] obj3 = (Object[])t;
	                    final String name = (String)obj3[0];
	                    final String code = (String)obj3[1];
	                    villageMap.put(code, name);
	                }
	                model.addAttribute("village", (Object)villageMap);
	            }
	            else {
	                model.addAttribute("village", (Object)villageMap);
	            }
	            if (participantOptional.isPresent() && participantOptional.get().getState() != null) {
	                final List<Object> tehshilList = (List<Object>)this.tService.findByStateCode(participantOptional.get().getState());
	                for (final Object t : tehshilList) {
	                    final Object[] obj3 = (Object[])t;
	                    final String name = (String)obj3[0];
	                    final String code = (String)obj3[1];
	                    TehsilMap.put(code, name);
	                }
	                model.addAttribute("tehsil", (Object)TehsilMap);
	            }
	            else {
	                model.addAttribute("tehsil", (Object)TehsilMap);
	            }
	            */
	           // model.addAttribute("stateList", (Object)sortedState);
	           // model.addAttribute("city", (Object)map);
	           // model.addAttribute("outletLsit", (Object)this.outletService.findByhreId((long)participant.gethreId()));
	            model.addAttribute("personal", (Object)participant);
	            model.addAttribute("locationCode", locationCode);
	            
	            return "personal-details";
	        }
	        return "redirect:login";
	    }
	    /*
	    @PostMapping({ "/getEmployeeCode" })
	    @ResponseBody
	    public String getEmployeeCode(final HttpSession session, @RequestParam("accesskey") final String accesskey,
	    		@RequestParam("empcode") final String empcode,@RequestParam("hreId") final String hreId, final Model model) {
	    	String msg="";
	    	Long hreId2= Long.parseLong(hreId);
	        if (session.getAttribute("userId") != null) {
	        	Optional<ParticipantRegistration> participnt =	participantservice.findByEmployeeCode(empcode,hreId2);
	        	if(participnt.isPresent()) {
	        		if(accesskey.equals(participnt.get().getAccessKey())) {
	        		}else {
	        			msg="This Employee Code already exists";	
	        		}
	        	}
	        }
	        return msg;
	    }
	    */
	    
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
	    
		/*
		 * @PostMapping({ "/getFinalDesignation" })
		 * 
		 * @ResponseBody private String getDesignation(@RequestParam("profile") final
		 * String profile) { String result = ""; final List<String> listCategary =
		 * (List<String>)this.designationService.getDesignationCategory(profile); final
		 * List<DesignationDms> designationList =
		 * (List<DesignationDms>)this.designationServiceDms.
		 * getDesignationByDesignationCode((List)listCategary); result =
		 * "<option value=''>Select</option>"; for (final DesignationDms d :
		 * designationList) { result = String.valueOf(result) + "<option value=" +
		 * d.getDesignationCode() + ">" + d.getDesignationDesc() + "</option>"; } return
		 * result; }
		 */
	    
	    @PostMapping({ "/saveEmploymentDetails" })
	    public String saveParticipantEmploymentDetails(final ParticipantRegistration participantRegistration, @RequestParam final String accessKey, @RequestParam final String btnSave) {
	        final Optional<ParticipantRegistration> participantOptional = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accessKey);
	        final ParticipantRegistration participant = participantOptional.get();
	        participant.setEmpSalary(participantRegistration.getEmpSalary());
	        participant.setGender(participantRegistration.getGender());
	        participant.setPfNumber(participantRegistration.getPfNumber());
	        participant.setBankAccountNumber(participantRegistration.getBankAccountNumber());
	        eventLogin(participant.getHreId().intValue(),"Save Employmen tDetails",participant.getAccessKey(),participant.getFirstName()+
	        		" "+participant.getLastName()+" "+participant.getLastName(),participant.getEmail());
	        if (btnSave.equals("Next")) {
	            participant.setEmploymentFlag("1");
	        }
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
	        final List<String> blodgroup = new ArrayList<String>();
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
	        final Optional<InterviewScore> interviewScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(accesskey);
	        if (interviewScore.isPresent()) {
	        	Double value = Double.parseDouble(interviewScore.get().getTotal_avt());
	        	
	            model.addAttribute("interviewScore", Math.round(value));
	        }
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
	    
	    
	   /* 
	    @Async
	    @PostMapping({ "/feedback" })
	    @ResponseBody
	    public String saveFeedback(@RequestParam("accesskey") final String accesskey, @RequestParam("feedback") final String feedback,
	    		@RequestParam("fsdmRejectionType") final String fsdmRejectionType, @RequestParam("fsdmRejectionReason") final String fsdmRejectionReason,
	    		@RequestParam("fsdmRejectionComment") final String fsdmRejectionComment) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	        	 int rejectCounter=1;
		            if(participant.get().getFsdmCounter() != null) {
		            	rejectCounter +=participant.get().getFsdmCounter();
		            }
		            participant.get().setFsdmCounter(rejectCounter);
	            participant.get().setFsdmFeedback(feedback);
	            participant.get().setFsdmApprovalStatus("1");
	            participant.get().setDocuments_status("save");
	            participant.get().setModifiedDate(LocalDate.now());
	            participant.get().setFsdmRejectionType(fsdmRejectionType);
	            participant.get().setFsdmRejectionReason(fsdmRejectionReason);
	            participant.get().setFsdmRejectionComment(fsdmRejectionComment);
	            participantservice.saveData(participant.get());
	            sendEmailThatDocsRejected(participant.get());
	           	        
	            try {
	            	if((participant.get().getFinalDesignationStatus() != null &&  participant.get().getFinalDesignationStatus().equals("1"))
	            			&& (participant.get().getPrarambhStatus() != null && participant.get().getPrarambhStatus().equals("2")) ) {
	            		 //dmsController.approverFSDM(participant.get().getAccessKey(),"M",dmsURL,"R");	
	            	
	            		 final Optional<FSDMNotification> noti = (Optional<FSDMNotification>)this.fsdmMNotificationService.getAccesskey(accesskey);
	     	            if (noti.isPresent()) {
	     	                this.fsdmMNotificationService.dellete((int)noti.get().getId());
	     	            }
	            		 
	            	}else if ((participant.get().getDesignation() != null && participant.get().getDesignation().equals("Sales Support")) && (rejectCounter ==10)) {
	            		dmsController.generateMSPIN(participant.get().getAccessKey(),dmsURL);
	            		 //dmsController.approverFSDM(participant.get().getAccessKey(),"M",dmsURL,"R");
	            		 final Optional<FSDMNotification> noti = (Optional<FSDMNotification>)this.fsdmMNotificationService.getAccesskey(accesskey);
	     	            if (noti.isPresent()) {
	     	                this.fsdmMNotificationService.dellete((int)noti.get().getId());
	     	            }
		            }else if(rejectCounter ==10 ) {
		            	 dmsController.generateMSPIN(participant.get().getAccessKey(),dmsURL);
	            		 //dmsController.approverFSDM(participant.get().getAccessKey(),"M",dmsURL,"R");	
	            		 final Optional<FSDMNotification> noti = (Optional<FSDMNotification>)this.fsdmMNotificationService.getAccesskey(accesskey);
	     	            if (noti.isPresent()) {
	     	                this.fsdmMNotificationService.dellete((int)noti.get().getId());
	     	            }
	            	}
	           
	            
	            eventLogin(participant.get().getHreId().intValue(),"feedback",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	            }catch(Exception e) {
	            	e.printStackTrace();
	            }
	            
	        }
	        return "success";
	    }
	    */
	    /*
	    @GetMapping({ "/approvel" })
	    @ResponseBody
	    public String saveApprovel(@RequestParam("accesskey") final String accesskey) {
	        final Optional<ParticipantRegistration> participant = (Optional<ParticipantRegistration>)this.participantservice.findByAccesskey(accesskey);
	        if (participant.isPresent()) {
	            participant.get().setFsdmApprovalStatus("2");
	            participant.get().setFsdmApprovalDate(LocalDate.now());
	            if(participant.get().getOldMspin() != null && participant.get().getOldMspin().length()>0 ) {
	            	participant.get().setMspin(participant.get().getOldMspin());
	            }
	            participant.get().setModifiedDate(LocalDate.now());
	            participantservice.saveData((ParticipantRegistration)participant.get());
	            try {
	                 dmsController.generateMSPIN(participant.get().getAccessKey(),dmsURL);
	            
	            	String result ="";
	            	String arr_result[] = result.split("##");
	            	if(arr_result[0] != null && arr_result[0].equals("1")) { 
	            		    participant.get().setFsdmApprovalStatus("3");
	            		    participant.get().setFsdmApprovalDate(LocalDate.now());
	     	  	            participantservice.saveData((ParticipantRegistration)participant.get());
	     	  	            
	     	             return arr_result[1];
	            	}
	                
	            this.sendEmailForDocsApproval(participant.get());            
	            final Optional<FSDMNotification> noti = (Optional<FSDMNotification>)this.fsdmMNotificationService.getAccesskey(accesskey);
	            if (noti.isPresent()) {
	                this.fsdmMNotificationService.dellete((int)noti.get().getId());
	            }
	            }catch(Exception e) {
	            	e.printStackTrace();
	            }
	            eventLogin(participant.get().getHreId().intValue(),"Save Approvel",participant.get().getAccessKey(),participant.get().getFirstName()+
		        		" "+participant.get().getLastName()+" "+participant.get().getLastName(),participant.get().getEmail());
	        }
	        return "success";
	    }
	    */
	    /*
	    private String sendEmailForDocsApproval(final ParticipantRegistration participant) {
	        final String subjectLine = "Application Documents Approved";
	        String mailBody = DataProccessor.readFileFromResource("fsdmApprovedDocs");
	        mailBody = mailBody.replace("${candidateName}", String.valueOf(String.valueOf(participant.getFirstName())) + " " + participant.getMiddleName() + " " + participant.getLastName());
	        final HRE dealer = this.hreService.getById((long)participant.getHreId()).get();
	        mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        mailBody = mailBody.replace("${link}", adminLink);
	        mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(dealer.getEmail());
	        sendP.setSubjectLine("Application Documents Approved");
	        sendP.setMsg(mailBody);
	        sendP.setCc("");
	        sendP.setBcc("");
	        sendP.setFrom("Armezo Solutions");
	        try {
	         //   EmailUtility.sendMail(sendP.getTo(), sendP.getFrom(), sendP.getCc(), sendP.getBcc(), sendP.getSubjectLine(), sendP.getMsg(), "smtp");
	        } catch (Exception e) {
	           e.printStackTrace();
	        }
	        
	        try {
	        	if(dealer.getMobile() != null && !dealer.getMobile().equals("")) {
			     //send sms for shortlisted 
				 String smsMsg = DataProccessor.getSMS("fsdmApproved");
				 String name="";
				 name += participant.getFirstName();
				 if(participant.getMiddleName() != null && !participant.getMiddleName().equals("")) {
					 name +=  " "+ participant.getFirstName(); 
				 }
				 name +=  " "+ participant.getLastName(); 
				 smsMsg = smsMsg.replace("${name}", name);
				 smsMsg = smsMsg.replace("${accesskey}", participant.getAccessKey());
			     SmsUtility.sendSmsHandler(dealer.getMobile(), smsMsg,"MSILOT" );
			     
			     String smsMsg1 = DataProccessor.getSMS("recruited");
			     smsMsg1 = smsMsg1.replace("${name}", name);
				 smsMsg1 = smsMsg1.replace("${accesskey}", participant.getAccessKey());
			       SmsUtility.sendSmsHandler(dealer.getMobile(), smsMsg1,"MSILOT" );
			   
	        }
				}catch(Exception e) {
					e.printStackTrace();
		    }
	        return "success";
	    }
	    
	    private String sendEmailThatDocsRejected(final ParticipantRegistration participant) {
	        final String subjectLine = "iRecruit- Candidate Application Rejected";
	        String mailBody = "";
	        mailBody=	DataProccessor.readFileFromResource("fsdmRejectedDocs");
	        if((participant.getFinalDesignationStatus() != null && participant.getFinalDesignationStatus().equals("1"))
	        		&& (participant.getMspin() != null && !participant.getMspin().equals(""))) { 
	        			  mailBody=	DataProccessor.readFileFromResource("fsdmSTRRejectedDocs");
	        }
	        mailBody = mailBody.replace("${candidateName}", String.valueOf(String.valueOf(participant.getFirstName())) + " " + participant.getMiddleName() + " " + participant.getLastName());
	        final Dealer dealer = this.hreService.getById((long)participant.getHreId()).get();
	        mailBody = mailBody.replace("${dealerName}", dealer.getName());
	        mailBody = mailBody.replace("${link}", adminLink);
	        if((participant.getFinalDesignationStatus() != null && participant.getFinalDesignationStatus().equals("1"))
	        		&& (participant.getMspin() != null && !participant.getMspin().equals(""))) {
	        	 mailBody = mailBody.replace("${accesskey}", participant.getMspin());
	        }else {
	        mailBody = mailBody.replace("${accesskey}", participant.getAccessKey());
	        }
	        String fsdmReason = "";
	        if (participant.getFsdmFeedback() != null && !participant.getFsdmFeedback().equals("")) {
	            fsdmReason = "<br>Reason:" + participant.getFsdmFeedback();
	        }
	        if (participant.getFsdmRejectionType() != null && !participant.getFsdmRejectionType().equals("")) {
	            fsdmReason = String.valueOf(fsdmReason) + "<br>Id Type: " + participant.getFsdmRejectionType();
	        }
	        if (participant.getFsdmRejectionReason() != null && !participant.getFsdmRejectionReason().equals("")) {
	            fsdmReason = String.valueOf(fsdmReason) + "<br>Details: " + participant.getFsdmRejectionReason();
	        }
	        if (participant.getFsdmRejectionComment() != null && !participant.getFsdmRejectionComment().equals("")) {
	            fsdmReason = String.valueOf(fsdmReason) + "<br>Comments: " + participant.getFsdmRejectionComment();
	        }
	        mailBody = mailBody.replace("${fsdmReason}", fsdmReason);
	        final SendPayload sendP = new SendPayload();
	        sendP.setTo(dealer.getEmail());
	        sendP.setSubjectLine("iRecruit- Candidate Application Rejected");
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
	        try {
			    if(dealer.getMobile() != null && !dealer.getMobile().equals("")) {
				 String smsMsg = DataProccessor.getSMS("rejected");
				 String name="";
				 name += participant.getFirstName();
				 if(participant.getMiddleName() != null && !participant.getMiddleName().equals("")) {
					 name +=  " "+ participant.getFirstName(); 
				 }
				 name +=  " "+ participant.getLastName(); 
				 smsMsg = smsMsg.replace("${name}", name);
				 smsMsg = smsMsg.replace("${accesskey}", participant.getAccessKey());
			     SmsUtility.sendSmsHandler(dealer.getMobile(), smsMsg,"MSILOT" );
			    }
				}catch(Exception e) {
					e.printStackTrace();
		    }
	        
	        return "success";
	    }
	    */
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
