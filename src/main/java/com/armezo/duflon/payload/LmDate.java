package com.armezo.duflon.payload;

import java.util.List;

public class LmDate {

	private List<Long> dateId;
	private Long lmId;
	private String accesskey;
	public List<Long> getDateId() {
		return dateId;
	}
	public void setDateId(List<Long> dateId) {
		this.dateId = dateId;
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
	
	
}
