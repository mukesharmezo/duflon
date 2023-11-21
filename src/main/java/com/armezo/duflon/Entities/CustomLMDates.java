package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "custom_lm_dates")
public class CustomLMDates {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private Long lmId;
	private String accesskey;
    private String customDate1;
	private String customDate2;
	private String customDate3;
	private String customDate4;
	private String customDate5;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getLmId() {
		return lmId;
	}
	public void setLmId(Long lmId) {
		this.lmId = lmId;
	}
	public String getAccesskey() {
		return accesskey;
	}
	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}
	public String getCustomDate1() {
		return customDate1;
	}
	public void setCustomDate1(String customDate1) {
		this.customDate1 = customDate1;
	}
	public String getCustomDate2() {
		return customDate2;
	}
	public void setCustomDate2(String customDate2) {
		this.customDate2 = customDate2;
	}
	public String getCustomDate3() {
		return customDate3;
	}
	public void setCustomDate3(String customDate3) {
		this.customDate3 = customDate3;
	}
	public String getCustomDate4() {
		return customDate4;
	}
	public void setCustomDate4(String customDate4) {
		this.customDate4 = customDate4;
	}
	public String getCustomDate5() {
		return customDate5;
	}
	public void setCustomDate5(String customDate5) {
		this.customDate5 = customDate5;
	}
	
	
	
	

}
