package com.armezo.duflon.analytics.payload;

import java.util.List;

public class GenderDiversityPayload {
	
	private List<String> male;
	private List<String> female;
	private List<String> other;
	public List<String> getMale() {
		return male;
	}
	public void setMale(List<String> male) {
		this.male = male;
	}
	public List<String> getFemale() {
		return female;
	}
	public void setFemale(List<String> female) {
		this.female = female;
	}
	public List<String> getOther() {
		return other;
	}
	public void setOther(List<String> other) {
		this.other = other;
	}
	


}
