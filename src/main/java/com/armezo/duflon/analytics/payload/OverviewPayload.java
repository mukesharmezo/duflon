package com.armezo.duflon.analytics.payload;

import java.util.List;

public class OverviewPayload {
	
	private List<String> registered;
	private List<String> assessments;
	private List<String> pass;
	private List<String> offer;
	private List<String> recruited;
	
	public OverviewPayload() {
		}

	public OverviewPayload(List<String> registered, List<String> assessments, List<String> pass, List<String> offer,
			List<String> recruited) {
		super();
		this.registered = registered;
		this.assessments = assessments;
		this.pass = pass;
		this.offer = offer;
		this.recruited = recruited;
	}

	public List<String> getRegistered() {
		return registered;
	}

	public void setRegistered(List<String> registered) {
		this.registered = registered;
	}

	public List<String> getAssessments() {
		return assessments;
	}

	public void setAssessments(List<String> assessments) {
		this.assessments = assessments;
	}

	public List<String> getPass() {
		return pass;
	}

	public void setPass(List<String> pass) {
		this.pass = pass;
	}

	public List<String> getOffer() {
		return offer;
	}

	public void setOffer(List<String> offer) {
		this.offer = offer;
	}

	public List<String> getRecruited() {
		return recruited;
	}

	public void setRecruited(List<String> recruited) {
		this.recruited = recruited;
	}

	@Override
	public String toString() {
		return "OverviewPayload [registered=" + registered + ", assessments=" + assessments + ", pass=" + pass
				+ ", offer=" + offer + ", recruited=" + recruited + "]";
	}
	
	

}