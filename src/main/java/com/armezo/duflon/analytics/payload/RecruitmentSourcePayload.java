package com.armezo.duflon.analytics.payload;

import java.util.List;

public class RecruitmentSourcePayload {
	
	private List<String> referrals;
	private List<String> directWalkIn;
	private List<String> advertisement;
	private List<String> jobConsultant;
	private List<String> socialMedia;
	private List<String> others;
	public List<String> getReferrals() {
		return referrals;
	}
	public void setReferrals(List<String> referrals) {
		this.referrals = referrals;
	}
	public List<String> getDirectWalkIn() {
		return directWalkIn;
	}
	public void setDirectWalkIn(List<String> directWalkIn) {
		this.directWalkIn = directWalkIn;
	}
	public List<String> getAdvertisement() {
		return advertisement;
	}
	public void setAdvertisement(List<String> advertisement) {
		this.advertisement = advertisement;
	}
	public List<String> getJobConsultant() {
		return jobConsultant;
	}
	public void setJobConsultant(List<String> jobConsultant) {
		this.jobConsultant = jobConsultant;
	}
	public List<String> getSocialMedia() {
		return socialMedia;
	}
	public void setSocialMedia(List<String> socialMedia) {
		this.socialMedia = socialMedia;
	}
	public List<String> getOthers() {
		return others;
	}
	public void setOthers(List<String> others) {
		this.others = others;
	}
	
	
	
}
