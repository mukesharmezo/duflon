package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "lm_interview")
public class LMInterview {

	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 private Long id;
	 @Column(name = "accesskey", length = 50)
	 private String accesskey;
	 
	 @Column(name = "lm_id", length = 50)
	 private Long lmId;
	 
	 @Column(name = "slot_date", length = 50)
	 private String slotDate;

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

	public Long getLmId() {
		return lmId;
	}

	public void setLmId(Long lmId) {
		this.lmId = lmId;
	}

	public String getSlotDate() {
		return slotDate;
	}

	public void setSlotDate(String slotDate) {
		this.slotDate = slotDate;
	}

	@Override
	public String toString() {
		return "LMInterview [id=" + id + ", accesskey=" + accesskey + ", lmId=" + lmId + ", slotDate=" + slotDate + "]";
	}

	
	
	 
	 
}
