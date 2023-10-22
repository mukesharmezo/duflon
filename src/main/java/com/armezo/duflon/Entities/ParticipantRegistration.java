package com.armezo.duflon.Entities;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "participant")
public class ParticipantRegistration {

	
	 @Id
	    @GeneratedValue(strategy = GenerationType.AUTO)
	    @Column(name = "id")
	    private Long Id;
	    @Column(name =  "access_key")
	    private String  accessKey;
	    @Column(name = "Status")
	    private String status;
	    @Column(name = "hre_name")
	    private String hreName;
	    @Column(name = "hre_Id")
	    private Long hreId;
	    @Column(name = "Title")
	    private String title;
	    @Column(name = "First_Name")
	    private String firstName;
	    @Column(name = "Middle_Name")
	    private String middleName;
	    @Column(name = "Last_Name")
	    private String lastName;
	    @Column(name = "Address")
	    private String address;
	    @Column(name = "city")
	    private String city;
	    @Column(name = "state")
	    private String state;
	    @Column(name = "pin_code")
	    private Integer pin;
	    @Column(name = "Id_Proof")
	    private String idProof;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "Birth_Date")
	    private LocalDate birthDate;
	    @Column(name = "Mobile")
	    private String mobile;	 
	    @Column(name = "Email")
	    private String email;
	    @Column(name = "Highest_Qualification")
	    private String highestQualification;
	    @Column(name = "adhar_number")
	    private Long adharNumber;
	    @Column(name = "Primary_Language")
	    private String primaryLanguage;
	    @Column(name = "Secondary_Language")
	    private String secondaryLanguage;
	    @Column(name = "Designation")
	    private String designation;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "Interview_Date")
	    private LocalDate interviewDate;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "Interview_Date2")
	    private LocalDate interviewDate2;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "joining_Date")
	    private LocalDate joiningDate;
	    @Column(name = "Emp_Salary")
	    private String empSalary;
	    @Column(name = "Gender")
	    private String gender;
	    @Column(name = "Pf_Number")
	    private String pfNumber;
	    @Column(name = "Bank_Account_Number")
	    private String bankAccountNumber;
	    @Column(name = "Tehsil")
	    private String tehsil;
	    @Column(name = "Village")
	    private String village;
	    @Column(name = "Aptitude_Score")
	    private Integer aptitudeScore;
	    @Column(name = "Attitude_Score")
	    private Integer attitudeScore;
	    @Column(name = "section_3")
	    private Integer section3;
	    @Column(name = "InterView_Score")
	    private Integer interviewScore;
	    @Column(name = "InterView_Score2")
	    private Integer interviewScore2;
	    @Column(name = "Psychometric_Score")
	    private Integer psychometricScore;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "Assessment_Date")
	    private LocalDate assessmentDate;
	    @Column(name = "Name")
	    private String cname;
	    @Column(name = "contact_no")
	    private String contactNo;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "Anniversary_Date")
	    private LocalDate anniversaryDate;
	    @Column(name = "Martial_Status")
	    private String martialStatus;
	    @Column(name = "Married")
	    private String married;
	    @Column(name = "Single")
	    private String single;
	    @Column(name = "Divorce")
	    private String divorce;
	    @Column(name = "Blood_Group")
	    private String bloodGroup;
	    @Column(name = "Fresher")
	    private String fresher;
	    @Column(name = "experience")
	    private String experience;
	    @Column(name = "Sr_No")
	    private Integer srNo;
	    @Column(name = "total")
	    private Integer total;
	    @Column(name = "source")
	    private String source;
	    @Column(name = "Company_Name")
	    private String companyName;
	    @Column(name = "Exp_In_Mths")
	    private Integer expInMths;
	    @Column(name = "Previous_Designation")
	    private String previousDesignation;
	    @Column(name = "Work_Area")
	    private String workArea;
	    @Column(name = "photograph")
	    private String photograph;
	    @Column(name = "signature")
	    private String signature;
	    @Column(name = "identitityProof")
	    private String identitityProof;    
	    @Column(name = "identitity_proof_name")
	    private String identitityProofName;    
	    @Column(name = "addressProof")
	    private String addressProof;
	    @Column(name = "address_proofName")
	    private String addressProofName;
	    @Column(name = "qualification")
	    private String qualification;
	    @Column(name = "qualification2")
	    private String qualification2;
	    @Column(name = "qualification3")
	    private String qualification3;
	    @Column(name = "resignationLetter")
	    private String resignationLetter;
	    @Column(name = "experienceletter")
	    private String experienceletter;
	    @Column(name = "salaryslip")
	    private String salarySlip;
	    @Column(name = "documents")
	    private String documents;
	    @Column(name = "resume")
	    private String resume;
	    @Column(name = "adhar")
	    private String adhar;
	    @Column(name = "test_status")
	    private String testStatus;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "registration_Date")
	    private LocalDate    registration_Date;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "test_completion_Date")
	    private LocalDate testCompletionDate;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "send_mail_Date")
	    private Date sendMailDate;
	    @Column(name = "other")
	    private String other;
	    @Column(name = "regStatus")
	    private String regStatus;
	    @Column(name = "interview_time")
	    private String interviewTime;
	    @Column(name = "interview_time2")
	    private String interviewTime2;
	    @Column(name = "testScore")
	    private String testScore;		
		@Column(name = "totalMark")
		private String totalMark;		
		@Column(name = "percentage_score")
		private String percentageScore;		
	    @Column(name = "passFailStatus")
	    private int passFailStatus;
	    @OneToMany(fetch = FetchType.LAZY, mappedBy = "participantRegistration", cascade = { CascadeType.ALL })
	    private List<FamilyDetails> familyDetails;
	    @OneToMany(fetch = FetchType.LAZY, mappedBy = "participantRegistration", cascade = { CascadeType.ALL })
	    private List<EmergencyContact> emergencyContact;
	    @OneToMany(fetch = FetchType.LAZY, mappedBy = "participantRegistration", cascade = { CascadeType.ALL })
	    private List<WorkExperience> workExperience;	    
	    @Column(name = "documents_status")
		private String documents_status;
	    @Column(name = "Alternate_Contact_Number")
	    private String alternateContactNumber;
	    @Column(name = "reactivation_Date")
	    private Date reactivationDate;	    
	    @Column(name = "personal_flag")
		private String personalFlag;
	    @Column(name = "employment_flag")
		private String employmentFlag;
	    @Column(name = "general_flag")
		private String generalFlag;
	    @Column(name = "work_flag")
		private String workFlag;
	    @Column(name = "family_flag")
		private String familyFlag;
	    @Column(name = "emergency_flag")
		private String emergencyFlag;		    
	    @Column(name = "re_atamp_status")
		private String reAtampStatus;
	    @Column(name = "re_atamp_count")
	  	private Integer reAtampCount;
	    @Column(name = "age")
	    private String age;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "modified_Date")
	    private LocalDate modifiedDate;
	    @Column(name = "question_report_status")
	    private Integer questionReportStatus;
	    @Column(name = "interview_address")
	    private String interviewAddress;
	    @Column(name = "interview_address2")
	    private String interviewAddress2;
	    @Column(name = "hired_status")
	    private String hiredStatus;
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    @Column(name = "hired_date")
	    private LocalDate hiredDate;
	    @Column(name = "emp_code")
	    private String empCode;
	    @Column(name = "uan")
	    private String uan;
	    @Column(name = "epfo")
	    private String epfo;
	    @Column(name = "bank_name")
	    private String bankName;
	    @Column(name = "ifsc_code")
	    private String ifscCode;
	    @Column(name = "int_count")
	    private Integer interviewerCount;
	    @Column(name = "int_count2")
	    private Integer interviewerCount2;
	    @Column(name = "part_status")
	    private String participantStatus;
	    @Column(name = "user_type")
	    private String userType;
	    
	    
		public Long getId() {
			return Id;
		}
		public void setId(Long id) {
			Id = id;
		}
		public String getAccessKey() {
			return accessKey;
		}
		public void setAccessKey(String accessKey) {
			this.accessKey = accessKey;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getFirstName() {
			return firstName;
		}
		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}
		public String getMiddleName() {
			return middleName;
		}
		public void setMiddleName(String middleName) {
			this.middleName = middleName;
		}
		public String getLastName() {
			return lastName;
		}
		public void setLastName(String lastName) {
			this.lastName = lastName;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getCity() {
			return city;
		}
		public void setCity(String city) {
			this.city = city;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public Integer getPin() {
			return pin;
		}
		public void setPin(Integer pin) {
			this.pin = pin;
		}
		public String getIdProof() {
			return idProof;
		}
		public void setIdProof(String idProof) {
			this.idProof = idProof;
		}
		public String getHreName() {
			return hreName;
		}
		public void setHreName(String hreName) {
			this.hreName = hreName;
		}
		public Long getHreId() {
			return hreId;
		}
		public void setHreId(Long hreId) {
			this.hreId = hreId;
		}
		public LocalDate getBirthDate() {
			return birthDate;
		}
		public void setBirthDate(LocalDate birthDate) {
			this.birthDate = birthDate;
		}
		public void setSection3(Integer section3) {
			this.section3 = section3;
		}
		public Integer getSection3() {
			return section3;
		}
		public String getMobile() {
			return mobile;
		}
		public void setMobile(String mobile) {
			this.mobile = mobile;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getHighestQualification() {
			return highestQualification;
		}
		public void setHighestQualification(String highestQualification) {
			this.highestQualification = highestQualification;
		}
		public Long getAdharNumber() {
			return adharNumber;
		}
		public void setAdharNumber(Long adharNumber) {
			this.adharNumber = adharNumber;
		}
		public String getPrimaryLanguage() {
			return primaryLanguage;
		}
		public void setPrimaryLanguage(String primaryLanguage) {
			this.primaryLanguage = primaryLanguage;
		}
		public String getSecondaryLanguage() {
			return secondaryLanguage;
		}
		public void setSecondaryLanguage(String secondaryLanguage) {
			this.secondaryLanguage = secondaryLanguage;
		}
		public String getDesignation() {
			return designation;
		}
		public void setDesignation(String designation) {
			this.designation = designation;
		}
		public LocalDate getInterviewDate() {
			return interviewDate;
		}
		public void setInterviewDate(LocalDate interviewDate) {
			this.interviewDate = interviewDate;
		}
		public LocalDate getInterviewDate2() {
			return interviewDate2;
		}
		public void setInterviewDate2(LocalDate interviewDate2) {
			this.interviewDate2 = interviewDate2;
		}
		public LocalDate getJoiningDate() {
			return joiningDate;
		}
		public void setJoiningDate(LocalDate joiningDate) {
			this.joiningDate = joiningDate;
		}
		public String getEmpSalary() {
			return empSalary;
		}
		public void setEmpSalary(String empSalary) {
			this.empSalary = empSalary;
		}
		public String getGender() {
			return gender;
		}
		public void setGender(String gender) {
			this.gender = gender;
		}
		public String getPfNumber() {
			return pfNumber;
		}
		public void setPfNumber(String pfNumber) {
			this.pfNumber = pfNumber;
		}
		public String getBankAccountNumber() {
			return bankAccountNumber;
		}
		public void setBankAccountNumber(String bankAccountNumber) {
			this.bankAccountNumber = bankAccountNumber;
		}
		public String getTehsil() {
			return tehsil;
		}
		public void setTehsil(String tehsil) {
			this.tehsil = tehsil;
		}
		public String getVillage() {
			return village;
		}
		public void setVillage(String village) {
			this.village = village;
		}
		public Integer getAptitudeScore() {
			return aptitudeScore;
		}
		public void setAptitudeScore(Integer aptitudeScore) {
			this.aptitudeScore = aptitudeScore;
		}
		public Integer getAttitudeScore() {
			return attitudeScore;
		}
		public void setAttitudeScore(Integer attitudeScore) {
			this.attitudeScore = attitudeScore;
		}
		public Integer getInterviewScore() {
			return interviewScore;
		}
		public void setInterviewScore(Integer interviewScore) {
			this.interviewScore = interviewScore;
		}
		public Integer getInterviewScore2() {
			return interviewScore2;
		}
		public void setInterviewScore2(Integer interviewScore2) {
			this.interviewScore2 = interviewScore2;
		}
		public Integer getPsychometricScore() {
			return psychometricScore;
		}
		public void setPsychometricScore(Integer psychometricScore) {
			this.psychometricScore = psychometricScore;
		}
		public LocalDate getAssessmentDate() {
			return assessmentDate;
		}
		public void setAssessmentDate(LocalDate assessmentDate) {
			this.assessmentDate = assessmentDate;
		}
		public String getCname() {
			return cname;
		}
		public void setCname(String cname) {
			this.cname = cname;
		}
		public String getContactNo() {
			return contactNo;
		}
		public void setContactNo(String contactNo) {
			this.contactNo = contactNo;
		}
		public LocalDate getAnniversaryDate() {
			return anniversaryDate;
		}
		public void setAnniversaryDate(LocalDate anniversaryDate) {
			this.anniversaryDate = anniversaryDate;
		}
		public String getMartialStatus() {
			return martialStatus;
		}
		public void setMartialStatus(String martialStatus) {
			this.martialStatus = martialStatus;
		}
		public String getMarried() {
			return married;
		}
		public void setMarried(String married) {
			this.married = married;
		}
		public String getSingle() {
			return single;
		}
		public void setSingle(String single) {
			this.single = single;
		}
		public String getDivorce() {
			return divorce;
		}
		public void setDivorce(String divorce) {
			this.divorce = divorce;
		}
		public String getBloodGroup() {
			return bloodGroup;
		}
		public void setBloodGroup(String bloodGroup) {
			this.bloodGroup = bloodGroup;
		}
		public String getFresher() {
			return fresher;
		}
		public void setFresher(String fresher) {
			this.fresher = fresher;
		}
		public String getExperience() {
			return experience;
		}
		public void setExperience(String experience) {
			this.experience = experience;
		}
		public Integer getSrNo() {
			return srNo;
		}
		public void setSrNo(Integer srNo) {
			this.srNo = srNo;
		}
		public Integer getTotal() {
			return total;
		}
		public void setTotal(Integer total) {
			this.total = total;
		}
		public String getSource() {
			return source;
		}
		public void setSource(String source) {
			this.source = source;
		}
		public String getCompanyName() {
			return companyName;
		}
		public void setCompanyName(String companyName) {
			this.companyName = companyName;
		}
		public Integer getExpInMths() {
			return expInMths;
		}
		public void setExpInMths(Integer expInMths) {
			this.expInMths = expInMths;
		}
		public String getPreviousDesignation() {
			return previousDesignation;
		}
		public void setPreviousDesignation(String previousDesignation) {
			this.previousDesignation = previousDesignation;
		}
		public String getWorkArea() {
			return workArea;
		}
		public void setWorkArea(String workArea) {
			this.workArea = workArea;
		}
		public String getPhotograph() {
			return photograph;
		}
		public void setPhotograph(String photograph) {
			this.photograph = photograph;
		}
		public String getSignature() {
			return signature;
		}
		public void setSignature(String signature) {
			this.signature = signature;
		}
		public String getIdentitityProof() {
			return identitityProof;
		}
		public void setIdentitityProof(String identitityProof) {
			this.identitityProof = identitityProof;
		}
		public String getIdentitityProofName() {
			return identitityProofName;
		}
		public void setIdentitityProofName(String identitityProofName) {
			this.identitityProofName = identitityProofName;
		}
		public String getAddressProof() {
			return addressProof;
		}
		public void setAddressProof(String addressProof) {
			this.addressProof = addressProof;
		}
		public String getAddressProofName() {
			return addressProofName;
		}
		public void setAddressProofName(String addressProofName) {
			this.addressProofName = addressProofName;
		}
		public String getQualification() {
			return qualification;
		}
		public void setQualification(String qualification) {
			this.qualification = qualification;
		}
		public String getQualification2() {
			return qualification2;
		}
		public void setQualification2(String qualification2) {
			this.qualification2 = qualification2;
		}
		public String getQualification3() {
			return qualification3;
		}
		public void setQualification3(String qualification3) {
			this.qualification3 = qualification3;
		}
		public String getResignationLetter() {
			return resignationLetter;
		}
		public void setResignationLetter(String resignationLetter) {
			this.resignationLetter = resignationLetter;
		}
		public String getExperienceletter() {
			return experienceletter;
		}
		public void setExperienceletter(String experienceletter) {
			this.experienceletter = experienceletter;
		}
		public String getSalarySlip() {
			return salarySlip;
		}
		public void setSalarySlip(String salarySlip) {
			this.salarySlip = salarySlip;
		}
		public String getDocuments() {
			return documents;
		}
		public void setDocuments(String documents) {
			this.documents = documents;
		}
		public String getResume() {
			return resume;
		}
		public void setResume(String resume) {
			this.resume = resume;
		}
		public String getAdhar() {
			return adhar;
		}
		public void setAdhar(String adhar) {
			this.adhar = adhar;
		}
		public String getTestStatus() {
			return testStatus;
		}
		public void setTestStatus(String testStatus) {
			this.testStatus = testStatus;
		}
		public LocalDate getRegistration_Date() {
			return registration_Date;
		}
		public void setRegistration_Date(LocalDate registration_Date) {
			this.registration_Date = registration_Date;
		}
		public LocalDate getTestCompletionDate() {
			return testCompletionDate;
		}
		public void setTestCompletionDate(LocalDate testCompletionDate) {
			this.testCompletionDate = testCompletionDate;
		}
		public Date getSendMailDate() {
			return sendMailDate;
		}
		public void setSendMailDate(Date sendMailDate) {
			this.sendMailDate = sendMailDate;
		}
		public String getOther() {
			return other;
		}
		public void setOther(String other) {
			this.other = other;
		}
		public String getRegStatus() {
			return regStatus;
		}
		public void setRegStatus(String regStatus) {
			this.regStatus = regStatus;
		}
		public String getInterviewTime() {
			return interviewTime;
		}
		public void setInterviewTime(String interviewTime) {
			this.interviewTime = interviewTime;
		}
		public String getInterviewTime2() {
			return interviewTime2;
		}
		public void setInterviewTime2(String interviewTime2) {
			this.interviewTime2 = interviewTime2;
		}
		public String getTestScore() {
			return testScore;
		}
		public void setTestScore(String testScore) {
			this.testScore = testScore;
		}
		public String getTotalMark() {
			return totalMark;
		}
		public void setTotalMark(String totalMark) {
			this.totalMark = totalMark;
		}
		public String getPercentageScore() {
			return percentageScore;
		}
		public void setPercentageScore(String percentageScore) {
			this.percentageScore = percentageScore;
		}
		public int getPassFailStatus() {
			return passFailStatus;
		}
		public void setPassFailStatus(int passFailStatus) {
			this.passFailStatus = passFailStatus;
		}
		public List<FamilyDetails> getFamilyDetails() {
			return familyDetails;
		}
		public void setFamilyDetails(List<FamilyDetails> familyDetails) {
			this.familyDetails = familyDetails;
		}
		public List<EmergencyContact> getEmergencyContact() {
			return emergencyContact;
		}
		public void setEmergencyContact(List<EmergencyContact> emergencyContact) {
			this.emergencyContact = emergencyContact;
		}
		public List<WorkExperience> getWorkExperience() {
			return workExperience;
		}
		public void setWorkExperience(List<WorkExperience> workExperience) {
			this.workExperience = workExperience;
		}
		public String getDocuments_status() {
			return documents_status;
		}
		public void setDocuments_status(String documents_status) {
			this.documents_status = documents_status;
		}
		public String getAlternateContactNumber() {
			return alternateContactNumber;
		}
		public void setAlternateContactNumber(String alternateContactNumber) {
			this.alternateContactNumber = alternateContactNumber;
		}
		public Date getReactivationDate() {
			return reactivationDate;
		}
		public void setReactivationDate(Date reactivationDate) {
			this.reactivationDate = reactivationDate;
		}
		public String getPersonalFlag() {
			return personalFlag;
		}
		public void setPersonalFlag(String personalFlag) {
			this.personalFlag = personalFlag;
		}
		public String getEmploymentFlag() {
			return employmentFlag;
		}
		public void setEmploymentFlag(String employmentFlag) {
			this.employmentFlag = employmentFlag;
		}
		public String getGeneralFlag() {
			return generalFlag;
		}
		public void setGeneralFlag(String generalFlag) {
			this.generalFlag = generalFlag;
		}
		public String getWorkFlag() {
			return workFlag;
		}
		public void setWorkFlag(String workFlag) {
			this.workFlag = workFlag;
		}
		public String getFamilyFlag() {
			return familyFlag;
		}
		public void setFamilyFlag(String familyFlag) {
			this.familyFlag = familyFlag;
		}
		public String getEmergencyFlag() {
			return emergencyFlag;
		}
		public void setEmergencyFlag(String emergencyFlag) {
			this.emergencyFlag = emergencyFlag;
		}
		public String getReAtampStatus() {
			return reAtampStatus;
		}
		public void setReAtampStatus(String reAtampStatus) {
			this.reAtampStatus = reAtampStatus;
		}
		public Integer getReAtampCount() {
			return reAtampCount;
		}
		public void setReAtampCount(Integer reAtampCount) {
			this.reAtampCount = reAtampCount;
		}
		public String getAge() {
			return age;
		}
		public void setAge(String age) {
			this.age = age;
		}
		public LocalDate getModifiedDate() {
			return modifiedDate;
		}
		public void setModifiedDate(LocalDate modifiedDate) {
			this.modifiedDate = modifiedDate;
		}
		public Integer getQuestionReportStatus() {
			return questionReportStatus;
		}
		public void setQuestionReportStatus(Integer questionReportStatus) {
			this.questionReportStatus = questionReportStatus;
		}
		public String getInterviewAddress() {
			return interviewAddress;
		}
		public void setInterviewAddress(String interviewAddress) {
			this.interviewAddress = interviewAddress;
		}
		public String getInterviewAddress2() {
			return interviewAddress2;
		}
		public void setInterviewAddress2(String interviewAddress2) {
			this.interviewAddress2 = interviewAddress2;
		}
		public void setHiredStatus(String hiredStatus) {
			this.hiredStatus = hiredStatus;
		}
		public String getHiredStatus() {
			return hiredStatus;
		}
		public LocalDate getHiredDate() {
			return hiredDate;
		}
		public void setHiredDate(LocalDate hiredDate) {
			this.hiredDate = hiredDate;
		}
		public void setEmpCode(String empCode) {
			this.empCode = empCode;
		}
		public String getEmpCode() {
			return empCode;
		}
		public String getUan() {
			return uan;
		}
		public void setUan(String uan) {
			this.uan = uan;
		}
		public String getEpfo() {
			return epfo;
		}
		public void setEpfo(String epfo) {
			this.epfo = epfo;
		}
		public String getBankName() {
			return bankName;
		}
		public void setBankName(String bankName) {
			this.bankName = bankName;
		}
		public String getIfscCode() {
			return ifscCode;
		}
		public void setIfscCode(String ifscCode) {
			this.ifscCode = ifscCode;
		}
		public Integer getInterviewerCount() {
			return interviewerCount;
		}
		public void setInterviewerCount(Integer interviewerCount) {
			this.interviewerCount = interviewerCount;
		}
		public Integer getInterviewerCount2() {
			return interviewerCount2;
		}
		public void setInterviewerCount2(Integer interviewerCount2) {
			this.interviewerCount2 = interviewerCount2;
		}
		public void setParticipantStatus(String participantStatus) {
			this.participantStatus = participantStatus;
		}
		public String getParticipantStatus() {
			return participantStatus;
		}
		public void setUserType(String userType) {
			this.userType = userType;
		}
		public String getUserType() {
			return userType;
		}
		
		
		
	
	
}
