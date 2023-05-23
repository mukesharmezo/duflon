package com.armezo.duflon.analytics.payload;

import java.util.List;

public class AssessmentReportPayload {
	
	private List<String> lessThan40;
	private List<String> between40To60;
	private List<String> between60To80;
	private List<String> moreThan80;
	public List<String> getLessThan40() {
		return lessThan40;
	}
	public void setLessThan40(List<String> lessThan40) {
		this.lessThan40 = lessThan40;
	}
	public List<String> getBetween40To60() {
		return between40To60;
	}
	public void setBetween40To60(List<String> between40To60) {
		this.between40To60 = between40To60;
	}
	public List<String> getBetween60To80() {
		return between60To80;
	}
	public void setBetween60To80(List<String> between60To80) {
		this.between60To80 = between60To80;
	}
	public List<String> getMoreThan80() {
		return moreThan80;
	}
	public void setMoreThan80(List<String> moreThan80) {
		this.moreThan80 = moreThan80;
	}
	
	
}
