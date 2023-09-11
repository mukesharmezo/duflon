package com.armezo.duflon.jobportal;

import java.util.List;

public class AdminPayload {
	
	private Long jobId;
	private Long userId;
	private String jobDesignation;
	private String jobDescription;
	private String hreName;
	private String jobPostDate;
	private String name;
	private String email;
	private String mobile;
	private List<UserSkill> skills;
	private Double matchPercentage;
	private Integer applicants;
	private Integer emails;
	private Integer interview;
	private Integer selected;
	private Integer joined;
	private Integer invitationFlag;
	private String assessmentStatus;
	private String reActivateStatus;
	
	public Long getJobId() {
		return jobId;
	}
	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public void setJobDesignation(String jobDesignation) {
		this.jobDesignation = jobDesignation;
	}
	public String getJobDesignation() {
		return jobDesignation;
	}
	public Integer getApplicants() {
		return applicants;
	}
	public void setApplicants(Integer applicants) {
		this.applicants = applicants;
	}
	public Integer getEmails() {
		return emails;
	}
	public void setEmails(Integer emails) {
		this.emails = emails;
	}
	public Integer getInterview() {
		return interview;
	}
	public void setInterview(Integer interview) {
		this.interview = interview;
	}
	public Integer getSelected() {
		return selected;
	}
	public void setSelected(Integer selected) {
		this.selected = selected;
	}
	public Integer getJoined() {
		return joined;
	}
	public void setJoined(Integer joined) {
		this.joined = joined;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public List<UserSkill> getSkills() {
		return skills;
	}
	public void setSkills(List<UserSkill> skills) {
		this.skills = skills;
	}
	public Double getMatchPercentage() {
		return matchPercentage;
	}
	public void setMatchPercentage(Double matchPercentage) {
		this.matchPercentage = matchPercentage;
	}
	public void setInvitationFlag(Integer invitationFlag) {
		this.invitationFlag = invitationFlag;
	}
	public Integer getInvitationFlag() {
		return invitationFlag;
	}
	public void setAssessmentStatus(String assessmentStatus) {
		this.assessmentStatus = assessmentStatus;
	}
	public String getAssessmentStatus() {
		return assessmentStatus;
	}
	public String getJobDescription() {
		return jobDescription;
	}
	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}
	public String getHreName() {
		return hreName;
	}
	public void setHreName(String hreName) {
		this.hreName = hreName;
	}
	public String getJobPostDate() {
		return jobPostDate;
	}
	public void setJobPostDate(String jobPostDate) {
		this.jobPostDate = jobPostDate;
	}
	public void setReActivateStatus(String reActivateStatus) {
		this.reActivateStatus = reActivateStatus;
	}
	public String getReActivateStatus() {
		return reActivateStatus;
	}
	
	

}
