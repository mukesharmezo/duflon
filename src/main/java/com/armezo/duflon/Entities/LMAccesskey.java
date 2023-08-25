package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "lm_Accesskey")
public class LMAccesskey {

	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 private Long id;
	 @Column(name = "accesskey", length = 50)
	 private String accesskey;
	 
	 @Column(name = "email", length = 50)
	 private String email;
	 
	 @Column(name = "lm_id", length = 50)
	 private Long lmId;
	 
	 @Column(name = "interview_status")
	 private Integer  interviewStatus;
	 	 
	 @Column(name = "date_id")
	 private String  dateId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAccesskey() {
		return accesskey;
	}

	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getLmId() {
		return lmId;
	}

	public void setLmId(Long lmId) {
		this.lmId = lmId;
	}

	public Integer getInterviewStatus() {
		return interviewStatus;
	}

	public void setInterviewStatus(Integer interviewStatus) {
		this.interviewStatus = interviewStatus;
	}

	public String getDateId() {
		return dateId;
	}

	public void setDateId(String dateId) {
		this.dateId = dateId;
	}

	
	
	 
	
	 
}
