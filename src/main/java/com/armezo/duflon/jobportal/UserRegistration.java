package com.armezo.duflon.jobportal;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.CascadeType;
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
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthDate;
    private String education;
    private String mobile;
    private String email;
    @OneToMany(cascade = CascadeType.ALL)
    private List<UserSkill> skills;
    private String resume;
    private String invitationStatus;
    private String assessmentStatus;
    private String interviewStatus;
    private String selectedStatus;
    private String joinedStatus;
    private Integer invitationFlag;
    
    public UserRegistration() {
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}
	
	public String getAccesskey() {
		return accesskey;
	}
	
	public Long getJobId() {
		return jobId;
	}
	
	public void setJobId(Long jobId) {
		this.jobId = jobId;
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

	public void setBirthDate(LocalDate birthDate) {
		this.birthDate = birthDate;
	}
	
	public LocalDate getBirthDate() {
		return birthDate;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
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
	
	public void setInvitationFlag(Integer invitationFlag) {
		this.invitationFlag = invitationFlag;
	}
	public Integer getInvitationFlag() {
		return invitationFlag;
	}
	public Long gethreId() {
		return hreId;
	}
	public void sethreId(Long hreId) {
		this.hreId = hreId;
	}
	public String getInvitationStatus() {
		return invitationStatus;
	}

	public void setInvitationStatus(String invitationStatus) {
		this.invitationStatus = invitationStatus;
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
	
	public void setAssessmentStatus(String assessmentStatus) {
		this.assessmentStatus = assessmentStatus;
	}
	
	public String getAssessmentStatus() {
		return assessmentStatus;
	}

	public void setJoinedStatus(String joinedStatus) {
		this.joinedStatus = joinedStatus;
	}

	@Override
	public String toString() {
		return "UserRegistration [id=" + id + ", jobId=" + jobId + ", firstName=" + firstName + ", middleName="
				+ middleName + ", lastName=" + lastName + ", birthDate=" + birthDate + ", education=" + education
				+ ", mobile=" + mobile + ", email=" + email + ", skills=" + skills + ", resume=" + resume + "]";
	}
	
	
    

}
