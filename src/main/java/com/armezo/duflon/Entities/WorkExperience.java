package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "work_experience")
public class WorkExperience {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "w_id")
	private Long wid;
	
	@Column(name = "Auto_Industry_Experience")
	private String autoIndustryExperience;
	
	@Column(name = "Company_Name")
	private String companyName;
	
	
	@Column(name = "Exp_In_Mths")
	private Integer expInMths;
	
	@Column(name = "Previous_Designation")
	private String previousDesignation;
	
	@Column(name = "Work_Area")
	private String workArea;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "from_Date")
	private LocalDate fromDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "to_Date")
	private LocalDate toDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Id", referencedColumnName = "Id")
	private ParticipantRegistration participantRegistration;

	public Long getWid() {
		return wid;
	}

	public void setWid(Long wid) {
		this.wid = wid;
	}

	
	public String getAutoIndustryExperience() {
		return autoIndustryExperience;
	}

	public void setAutoIndustryExperience(String autoIndustryExperience) {
		this.autoIndustryExperience = autoIndustryExperience;
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

	public ParticipantRegistration getParticipantRegistration() {
		return participantRegistration;
	}

	public void setParticipantRegistration(ParticipantRegistration participantRegistration) {
		this.participantRegistration = participantRegistration;
	}

	public LocalDate getFromDate() {
		return fromDate;
	}

	public void setFromDate(LocalDate fromDate) {
		this.fromDate = fromDate;
	}

	public LocalDate getToDate() {
		return toDate;
	}

	public void setToDate(LocalDate toDate) {
		this.toDate = toDate;
	}

	@Override
	public String toString() {
		return "WorkExperience [wid=" + wid + ", autoIndustryExperience=" + autoIndustryExperience + ", companyName="
				+ companyName + ", expInMths=" + expInMths + ", previousDesignation=" + previousDesignation
				+ ", workArea=" + workArea + ", participantRegistration=" + participantRegistration + "]";
	}

	

}
