package com.armezo.duflon.analytics.payload;

import java.util.List;

public class AgeWisePayload {
	
	private List<String> lessThan20; 
	private List<String> between20To25;
	private List<String> between25To30;
	private List<String> between30To35;
	private List<String> between35To40;
	private List<String> moreThan40;
	public List<String> getLessThan20() {
		return lessThan20;
	}
	public void setLessThan20(List<String> lessThan20) {
		this.lessThan20 = lessThan20;
	}
	public List<String> getBetween20To25() {
		return between20To25;
	}
	public void setBetween20To25(List<String> between20To25) {
		this.between20To25 = between20To25;
	}
	public List<String> getBetween25To30() {
		return between25To30;
	}
	public void setBetween25To30(List<String> between25To30) {
		this.between25To30 = between25To30;
	}
	public List<String> getBetween30To35() {
		return between30To35;
	}
	public void setBetween30To35(List<String> between30To35) {
		this.between30To35 = between30To35;
	}
	public List<String> getBetween35To40() {
		return between35To40;
	}
	public void setBetween35To40(List<String> between35To40) {
		this.between35To40 = between35To40;
	}
	public List<String> getMoreThan40() {
		return moreThan40;
	}
	public void setMoreThan40(List<String> moreThan40) {
		this.moreThan40 = moreThan40;
	}
	
	
}
