package com.armezo.duflon.jobportal;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "job_user_registration")
public class UserRegistration {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	private Long jobId;
	private Long hreId;
	private String accesskey;
    private String firstName;
    private String middleName;
    private String lastName;
    private String source;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthDate;
    private String education;
    private String gender;
    private Double profileExperience;
    private String mobile;
    private String email;
    @OneToMany(cascade = CascadeType.ALL)
    private List<UserSkill> skills;
    private String resume;
    private String photo;
    private String aadhar;
    private String tenTh;
    private String twelve;
    private String graduation;
    private String others;
    private String invitationStatus;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date invitationDate;
    private String assessmentStatus;
    private String interviewStatus;
    private String selectedStatus;
    private String joinedStatus;
    private Integer invitationFlag;
    private String linkedIn ;
    
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getJobId() {
		return jobId;
	}

	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}

	public Long getHreId() {
		return hreId;
	}

	public void setHreId(Long hreId) {
		this.hreId = hreId;
	}

	public String getAccesskey() {
		return accesskey;
	}

	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public String getPhoto() {
		return photo;
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
	
	public String getSource() {
		return source;
	}
	
	public void setSource(String source) {
		this.source = source;
	}

	public LocalDate getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(LocalDate birthDate) {
		this.birthDate = birthDate;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Double getProfileExperience() {
		return profileExperience;
	}

	public void setProfileExperience(Double profileExperience) {
		this.profileExperience = profileExperience;
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

	public List<UserSkill> getSkills() {
		return skills;
	}

	public void setSkills(List<UserSkill> skills) {
		this.skills = skills;
	}

	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	public String getInvitationStatus() {
		return invitationStatus;
	}

	public void setInvitationStatus(String invitationStatus) {
		this.invitationStatus = invitationStatus;
	}

	public String getAssessmentStatus() {
		return assessmentStatus;
	}

	public void setAssessmentStatus(String assessmentStatus) {
		this.assessmentStatus = assessmentStatus;
	}

	public String getInterviewStatus() {
		return interviewStatus;
	}

	public void setInterviewStatus(String interviewStatus) {
		this.interviewStatus = interviewStatus;
	}

	public String getSelectedStatus() {
		return selectedStatus;
	}

	public void setSelectedStatus(String selectedStatus) {
		this.selectedStatus = selectedStatus;
	}

	public String getJoinedStatus() {
		return joinedStatus;
	}

	public void setJoinedStatus(String joinedStatus) {
		this.joinedStatus = joinedStatus;
	}

	public Integer getInvitationFlag() {
		return invitationFlag;
	}

	public void setInvitationFlag(Integer invitationFlag) {
		this.invitationFlag = invitationFlag;
	}
	public void setInvitationDate(Date invitationDate) {
		this.invitationDate = invitationDate;
	}
	public Date getInvitationDate() {
		return invitationDate;
	}
	public void setLinkedIn(String linkedIn) {
		this.linkedIn = linkedIn;
	}
	public String getLinkedIn() {
		return linkedIn;
	}
	

	public String getAadhar() {
		return aadhar;
	}

	public void setAadhar(String aadhar) {
		this.aadhar = aadhar;
	}

	public String getTenTh() {
		return tenTh;
	}

	public void setTenTh(String tenTh) {
		this.tenTh = tenTh;
	}

	public String getTwelve() {
		return twelve;
	}

	public void setTwelve(String twelve) {
		this.twelve = twelve;
	}

	public String getGraduation() {
		return graduation;
	}

	public void setGraduation(String graduation) {
		this.graduation = graduation;
	}

	public String getOthers() {
		return others;
	}

	public void setOthers(String others) {
		this.others = others;
	}

	@Override
	public String toString() {
		return "UserRegistration [id=" + id + ", jobId=" + jobId + ", firstName=" + firstName + ", middleName="
				+ middleName + ", lastName=" + lastName + ", birthDate=" + birthDate + ", education=" + education
				+ ", mobile=" + mobile + ", email=" + email + ", skills=" + skills + ", resume=" + resume + "]";
	}
	
	
    

}
