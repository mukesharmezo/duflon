package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "lm_optional_date")
public class LMOptionalDate {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private String accesskey;
	private Long lmId;
	private String optionalDate;
	
	
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
	public Long getLmId() {
		return lmId;
	}
	public void setLmId(Long lmId) {
		this.lmId = lmId;
	}
	public String getOptionalDate() {
		return optionalDate;
	}
	public void setOptionalDate(String optionalDate) {
		this.optionalDate = optionalDate;
	}
	
	
	

}
