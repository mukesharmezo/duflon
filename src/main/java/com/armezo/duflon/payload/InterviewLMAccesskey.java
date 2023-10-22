package com.armezo.duflon.payload;

public class InterviewLMAccesskey {

	private String name;
	private String hreName;
	private String accesskey;
	private Long lmId;
	private String status;       //
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public void setHreName(String hreName) {
		this.hreName = hreName;
	}
	public String getHreName() {
		return hreName;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus() {
		return status;
	}
	
	
	
	
}
