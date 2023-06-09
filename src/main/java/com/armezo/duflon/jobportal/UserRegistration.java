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
    private String invitationStatus;
    private String assessmentStatus;
    private String interviewStatus;
    private String selectedStatus;
    private String joinedStatus;
    private Integer invitationFlag;
    
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

	@Override
	public String toString() {
		return "UserRegistration [id=" + id + ", jobId=" + jobId + ", firstName=" + firstName + ", middleName="
				+ middleName + ", lastName=" + lastName + ", birthDate=" + birthDate + ", education=" + education
				+ ", mobile=" + mobile + ", email=" + email + ", skills=" + skills + ", resume=" + resume + "]";
	}
	
	
    

}
