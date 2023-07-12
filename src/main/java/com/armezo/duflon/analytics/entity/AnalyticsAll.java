package com.armezo.duflon.analytics.entity;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "analyticsAll")
public class AnalyticsAll {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private Long participantId;
	private Long hreId; // It is used, To find by Login type
	private String accesskey; // any data related to part > for registered count
	private String registered; // regStatus = 1;
	private String assessments;
	private String passFailStatus; // pass or fail > pass count
	private String offerStatus; // yes or no > offers count
	private String recruitedStatus; // yes or no > rec count
	private String hreName;
	private LocalDate recruitDate; // part reg date
	private String recSource;
	private String candidateExperience;
	private String assessmentReport; // percentage
	private String designation; // Sales or Non-Sales
	private String age;
	private String gender;
	private String region;
	private String state;
	private String city;
	// Action Points Pending
	private String assessmentStatus; // completed or not completed > assessment count
	private String interviewStatus; // Interview is completed or not, if interview score!=null, So store interview
	private String documentUploadStatus; // Check document is uploaded or not
	private String approval;
	private String hiredStatus;
	private LocalDate hiredDate;

	// Saving data for popup
	private String firstName;
	private String middleName;
	private String lastName;
	private String mobile;
	private String marksObtained;
	private LocalDate registrationDate;
	private LocalDate assessmentDate;
	private LocalDate interviewDate;
	private LocalDate modifiedDate;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getParticipantId() {
		return participantId;
	}
	public void setParticipantId(Long participantId) {
		this.participantId = participantId;
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
	public String getRegistered() {
		return registered;
	}
	public void setRegistered(String registered) {
		this.registered = registered;
	}
	public String getAssessments() {
		return assessments;
	}
	public void setAssessments(String assessments) {
		this.assessments = assessments;
	}
	public String getPassFailStatus() {
		return passFailStatus;
	}
	public void setPassFailStatus(String passFailStatus) {
		this.passFailStatus = passFailStatus;
	}
	public String getOfferStatus() {
		return offerStatus;
	}
	public void setOfferStatus(String offerStatus) {
		this.offerStatus = offerStatus;
	}
	public String getRecruitedStatus() {
		return recruitedStatus;
	}
	public void setRecruitedStatus(String recruitedStatus) {
		this.recruitedStatus = recruitedStatus;
	}
	public String getHreName() {
		return hreName;
	}
	public void setHreName(String hreName) {
		this.hreName = hreName;
	}
	public LocalDate getRecruitDate() {
		return recruitDate;
	}
	public void setRecruitDate(LocalDate recruitDate) {
		this.recruitDate = recruitDate;
	}
	public String getRecSource() {
		return recSource;
	}
	public void setRecSource(String recSource) {
		this.recSource = recSource;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCandidateExperience() {
		return candidateExperience;
	}
	public void setCandidateExperience(String candidateExperience) {
		this.candidateExperience = candidateExperience;
	}
	public String getAssessmentReport() {
		return assessmentReport;
	}
	public void setAssessmentReport(String assessmentReport) {
		this.assessmentReport = assessmentReport;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public String getDocumentUploadStatus() {
		return documentUploadStatus;
	}
	public void setDocumentUploadStatus(String documentUploadStatus) {
		this.documentUploadStatus = documentUploadStatus;
	}
	public String getHiredStatus() {
		return hiredStatus;
	}
	public void setHiredStatus(String hiredStatus) {
		this.hiredStatus = hiredStatus;
	}
	public LocalDate getHiredDate() {
		return hiredDate;
	}
	public void setHiredDate(LocalDate hiredDate) {
		this.hiredDate = hiredDate;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMarksObtained() {
		return marksObtained;
	}
	public void setMarksObtained(String marksObtained) {
		this.marksObtained = marksObtained;
	}
	public LocalDate getRegistrationDate() {
		return registrationDate;
	}
	public void setRegistrationDate(LocalDate registrationDate) {
		this.registrationDate = registrationDate;
	}
	public LocalDate getAssessmentDate() {
		return assessmentDate;
	}
	public void setAssessmentDate(LocalDate assessmentDate) {
		this.assessmentDate = assessmentDate;
	}
	public LocalDate getInterviewDate() {
		return interviewDate;
	}
	public void setInterviewDate(LocalDate interviewDate) {
		this.interviewDate = interviewDate;
	}
	public LocalDate getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(LocalDate modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	
}
