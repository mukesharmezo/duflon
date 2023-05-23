package com.armezo.duflon.analytics.payload;

import java.util.List;

public class CandidateNonAutoExperiencePayload {
	
	private List<String> lessThan3Months;
	private List<String> months3To6;
	private List<String> months6To1Year;
	private List<String> year1To2Year;
	private List<String> year2To5Year;
	private List<String> year5To10Year;
	private List<String> moreThan10Year;
	public List<String> getLessThan3Months() {
		return lessThan3Months;
	}
	public void setLessThan3Months(List<String> lessThan3Months) {
		this.lessThan3Months = lessThan3Months;
	}
	public List<String> getMonths3To6() {
		return months3To6;
	}
	public void setMonths3To6(List<String> months3To6) {
		this.months3To6 = months3To6;
	}
	public List<String> getMonths6To1Year() {
		return months6To1Year;
	}
	public void setMonths6To1Year(List<String> months6To1Year) {
		this.months6To1Year = months6To1Year;
	}
	public List<String> getYear1To2Year() {
		return year1To2Year;
	}
	public void setYear1To2Year(List<String> year1To2Year) {
		this.year1To2Year = year1To2Year;
	}
	public List<String> getYear2To5Year() {
		return year2To5Year;
	}
	public void setYear2To5Year(List<String> year2To5Year) {
		this.year2To5Year = year2To5Year;
	}
	public List<String> getYear5To10Year() {
		return year5To10Year;
	}
	public void setYear5To10Year(List<String> year5To10Year) {
		this.year5To10Year = year5To10Year;
	}
	public List<String> getMoreThan10Year() {
		return moreThan10Year;
	}
	public void setMoreThan10Year(List<String> moreThan10Year) {
		this.moreThan10Year = moreThan10Year;
	}
	
	

}
