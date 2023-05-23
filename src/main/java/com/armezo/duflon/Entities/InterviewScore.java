package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Interview_Score")
public class InterviewScore {
	
	@Id
	@Column(name = "Id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer Id;
	
	
	@Column(name = "accessKey")
	private String accessKey ;
	
	@Column(name = "name_a")
	private String name_a;
	
	@Column(name = "name_b")
	private String name_b;
	
	@Column(name = "name_c")
	private String name_c;
	
	@Column(name = "designation_a")
	private String designation_a;
	
	@Column(name = "designation_b")
	private String designation_b;
	
	@Column(name = "designation_c")
	private String designation_c;
	
	@Column(name = "mobile_a")
	private String mobile_a;
	
	@Column(name = "mobile_b")
	private String mobile_b;
	
	@Column(name = "mobile_c")
	private String mobile_c;
	
	@Column(name = "clarity_a")
	private String clarity_a;
	
	@Column(name = "clarity_b")
	private String clarity_b;
	
	@Column(name = "clarity_c")
	private String clarity_c;
	
	@Column(name = "presentability_a")
	private String presentability_a;
	
	@Column(name = "presentability_b")
	private String presentability_b;
	
	@Column(name = "presentability_c")
	private String presentability_c;
	
	@Column(name = "attitude_a")
	private String attitude_a;
	
	@Column(name = "attitude_b")
	private String attitude_b;
	
	@Column(name = "attitude_c")
	private String attitude_c;
	
	@Column(name = "situation_a")
	private String situation_a;
	
	@Column(name = "situation_b")
	private String situation_b;
	
	@Column(name = "situation_c")
	private String situation_c;
	
	@Column(name = "total_a")
	private String total_a;
	
	@Column(name = "total_b")
	private String total_b;
	
	@Column(name = "total_c")
	private String total_c;
	
	@Column(name = "total_avt")
	private String total_avt;
	
	@Column(name = "total")
	private String total;
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "interview_status")
	private String interviewStatus;
	
	@Column(name = "pass_fail_status")
	private String pass_fail_status;
	
	@Column(name = "percentage")
	private String percentage;
	
	private Integer interviewCount;
	

	public InterviewScore() {
	}


	public Integer getId() {
		return Id;
	}


	public void setId(Integer id) {
		Id = id;
	}


	public String getAccessKey() {
		return accessKey;
	}


	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}


	public String getName_a() {
		return name_a;
	}


	public void setName_a(String name_a) {
		this.name_a = name_a;
	}


	public String getName_b() {
		return name_b;
	}


	public void setName_b(String name_b) {
		this.name_b = name_b;
	}


	public String getName_c() {
		return name_c;
	}


	public void setName_c(String name_c) {
		this.name_c = name_c;
	}


	public String getDesignation_a() {
		return designation_a;
	}


	public void setDesignation_a(String designation_a) {
		this.designation_a = designation_a;
	}


	public String getDesignation_b() {
		return designation_b;
	}


	public void setDesignation_b(String designation_b) {
		this.designation_b = designation_b;
	}


	public String getDesignation_c() {
		return designation_c;
	}


	public void setDesignation_c(String designation_c) {
		this.designation_c = designation_c;
	}


	public String getMobile_a() {
		return mobile_a;
	}


	public void setMobile_a(String mobile_a) {
		this.mobile_a = mobile_a;
	}


	public String getMobile_b() {
		return mobile_b;
	}


	public void setMobile_b(String mobile_b) {
		this.mobile_b = mobile_b;
	}


	public String getMobile_c() {
		return mobile_c;
	}


	public void setMobile_c(String mobile_c) {
		this.mobile_c = mobile_c;
	}


	public String getClarity_a() {
		return clarity_a;
	}


	public void setClarity_a(String clarity_a) {
		this.clarity_a = clarity_a;
	}


	public String getClarity_b() {
		return clarity_b;
	}


	public void setClarity_b(String clarity_b) {
		this.clarity_b = clarity_b;
	}


	public String getClarity_c() {
		return clarity_c;
	}


	public void setClarity_c(String clarity_c) {
		this.clarity_c = clarity_c;
	}


	public String getPresentability_a() {
		return presentability_a;
	}


	public void setPresentability_a(String presentability_a) {
		this.presentability_a = presentability_a;
	}


	public String getPresentability_b() {
		return presentability_b;
	}


	public void setPresentability_b(String presentability_b) {
		this.presentability_b = presentability_b;
	}


	public String getPresentability_c() {
		return presentability_c;
	}


	public void setPresentability_c(String presentability_c) {
		this.presentability_c = presentability_c;
	}


	public String getAttitude_a() {
		return attitude_a;
	}


	public void setAttitude_a(String attitude_a) {
		this.attitude_a = attitude_a;
	}


	public String getAttitude_b() {
		return attitude_b;
	}


	public void setAttitude_b(String attitude_b) {
		this.attitude_b = attitude_b;
	}


	public String getAttitude_c() {
		return attitude_c;
	}


	public void setAttitude_c(String attitude_c) {
		this.attitude_c = attitude_c;
	}


	public String getSituation_a() {
		return situation_a;
	}


	public void setSituation_a(String situation_a) {
		this.situation_a = situation_a;
	}


	public String getSituation_b() {
		return situation_b;
	}


	public void setSituation_b(String situation_b) {
		this.situation_b = situation_b;
	}


	public String getSituation_c() {
		return situation_c;
	}


	public void setSituation_c(String situation_c) {
		this.situation_c = situation_c;
	}


	public String getTotal_a() {
		return total_a;
	}


	public void setTotal_a(String total_a) {
		this.total_a = total_a;
	}


	public String getTotal_b() {
		return total_b;
	}


	public void setTotal_b(String total_b) {
		this.total_b = total_b;
	}


	public String getTotal_c() {
		return total_c;
	}


	public void setTotal_c(String total_c) {
		this.total_c = total_c;
	}


	public String getTotal_avt() {
		return total_avt;
	}


	public void setTotal_avt(String total_avt) {
		this.total_avt = total_avt;
	}


	public String getTotal() {
		return total;
	}


	public void setTotal(String total) {
		this.total = total;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getInterviewStatus() {
		return interviewStatus;
	}


	public void setInterviewStatus(String interviewStatus) {
		this.interviewStatus = interviewStatus;
	}


	public String getPass_fail_status() {
		return pass_fail_status;
	}


	public void setPass_fail_status(String pass_fail_status) {
		this.pass_fail_status = pass_fail_status;
	}


	public String getPercentage() {
		return percentage;
	}
	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}
	public void setInterviewCount(Integer interviewCount) {
		this.interviewCount = interviewCount;
	}
	public Integer getInterviewCount() {
		return interviewCount;
	}
 
  


}
