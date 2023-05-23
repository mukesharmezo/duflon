package com.armezo.duflon.payload;

import java.util.List;

public class HOFilterPayload {
	
	private List<String> regions;
	private List<String> states;
	private List<String> cities;
	private List<String> parentDealer;
	private List<Long> dealers;
	private List<Integer> fsdms;
	private String dateRange;
	
	public HOFilterPayload() {
	}
	public HOFilterPayload(List<String> regions, List<String> states, List<String> cities, List<String> parentDealer,
			List<Long> dealers, List<Integer> fsdms, String dateRange) {
		super();
		this.regions = regions;
		this.states = states;
		this.cities = cities;
		this.parentDealer = parentDealer;
		this.dealers = dealers;
		this.fsdms = fsdms;
		this.dateRange = dateRange;
	}
	public List<String> getRegions() {
		return regions;
	}
	public void setRegions(List<String> regions) {
		this.regions = regions;
	}
	public List<String> getStates() {
		return states;
	}
	public void setStates(List<String> states) {
		this.states = states;
	}
	public List<String> getCities() {
		return cities;
	}
	public void setCities(List<String> cities) {
		this.cities = cities;
	}
	public List<String> getParentDealer() {
		return parentDealer;
	}
	public void setParentDealer(List<String> parentDealer) {
		this.parentDealer = parentDealer;
	}
	public List<Long> getDealers() {
		return dealers;
	}
	public void setDealers(List<Long> dealers) {
		this.dealers = dealers;
	}
	public List<Integer> getFsdms() {
		return fsdms;
	}
	public void setFsdms(List<Integer> fsdms) {
		this.fsdms = fsdms;
	}
	public String getDateRange() {
		return dateRange;
	}
	public void setDateRange(String dateRange) {
		this.dateRange = dateRange;
	}
	@Override
	public String toString() {
		return "HOFilterPayload [regions=" + regions + ", states=" + states + ", cities=" + cities + ", parentDealer="
				+ parentDealer + ", dealers=" + dealers + ", fsdms=" + fsdms + ", dateRange=" + dateRange + "]";
	}
	
	
	

}
