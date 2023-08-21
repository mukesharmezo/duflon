package com.armezo.duflon.payload;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class InvitationPayload {

	private String name;
	private String accesskey;
	@JsonProperty("datetime")
	private List<String> datetime;

	@JsonProperty("select-email")
	private List<String> selectEmail;

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

	public List<String> getDatetime() {
		return datetime;
	}

	public void setDatetime(List<String> datetime) {
		this.datetime = datetime;
	}

	public List<String> getSelectEmail() {
		return selectEmail;
	}

	public void setSelectEmail(List<String> selectEmail) {
		this.selectEmail = selectEmail;
	}

}
