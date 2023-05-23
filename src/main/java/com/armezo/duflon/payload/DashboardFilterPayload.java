package com.armezo.duflon.payload;

public class DashboardFilterPayload {
	
	private String regionCode;
	private String stateCode;
	private String cityCode;
	private Long hreId;
	private String outletCode;
	private String dealershipCode;
	private String dateRange;
	private String dateFrom;
	private String dateTo;
	private Integer approved;
	

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public Long gethreId() {
		return hreId;
	}

	public void sethreId(Long hreId) {
		this.hreId = hreId;
	}

	public String getOutletCode() {
		return outletCode;
	}

	public void setOutletCode(String outletCode) {
		this.outletCode = outletCode;
	}

	public String getDateRange() {
		return dateRange;
	}

	public void setDateRange(String dateRange) {
		this.dateRange = dateRange;
	}
	
	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	
	

	public String getDateFrom() {
		return dateFrom;
	}


	public void setDateFrom(String dateFrom) {
		this.dateFrom = dateFrom;
	}


	public String getDateTo() {
		return dateTo;
	}


	public void setDateTo(String dateTo) {
		this.dateTo = dateTo;
	}
	public String getDealershipCode() {
		return dealershipCode;
	}

	public void setDealershipCode(String dealershipCode) {
		this.dealershipCode = dealershipCode;
	}
	public void setApproved(Integer approved) {
		this.approved = approved;
	}
	public Integer getApproved() {
		return approved;
	}
	
}
