package com.armezo.duflon.payload;

public class FilterPayload {
	
	 private String outlet;
	    private String name;
	    private String uniqueCode;
	    private String designation;
	    private String mspin;
	    private String passFailStatus;
	    private String dateRange;
	    private String dateFrom;
	    private String dateTo;
	    private String assessment;
	    private String interview;
	    private String praraambh;
	    private String fsdmApproved;
	    
	    public FilterPayload() {
	    }
	    
	    public FilterPayload(final String outlet, final String name, final String uniqueCode, final String designation, final String mspin, final String passFailStatus, final String dateRange) {
	        this.outlet = outlet;
	        this.name = name;
	        this.uniqueCode = uniqueCode;
	        this.designation = designation;
	        this.mspin = mspin;
	        this.passFailStatus = passFailStatus;
	        this.dateRange = dateRange;
	    }
	    
	    public String getOutlet() {
	        return this.outlet;
	    }
	    
	    public void setOutlet(final String outlet) {
	        this.outlet = outlet;
	    }
	    
	    public String getName() {
	        return this.name;
	    }
	    
	    public void setName(final String name) {
	        this.name = name;
	    }
	    
	    public String getUniqueCode() {
	        return this.uniqueCode;
	    }
	    
	    public void setUniqueCode(final String uniqueCode) {
	        this.uniqueCode = uniqueCode;
	    }
	    
	    public String getDesignation() {
	        return this.designation;
	    }
	    
	    public void setDesignation(final String designation) {
	        this.designation = designation;
	    }
	    
	    public String getMspin() {
	        return this.mspin;
	    }
	    
	    public void setMspin(final String mspin) {
	        this.mspin = mspin;
	    }
	    
	    public String getPassFailStatus() {
	        return this.passFailStatus;
	    }
	    
	    public void setPassFailStatus(final String passFailStatus) {
	        this.passFailStatus = passFailStatus;
	    }
	    
	    public String getDateRange() {
	        return this.dateRange;
	    }
	    
	    public void setDateRange(final String dateRange) {
	        this.dateRange = dateRange;
	    }
	    
	    public String getAssessment() {
	        return this.assessment;
	    }
	    
	    public void setAssessment(final String assessment) {
	        this.assessment = assessment;
	    }
	    
	    public String getInterview() {
	        return this.interview;
	    }
	    
	    public void setInterview(final String interview) {
	        this.interview = interview;
	    }
	    
	    public String getPraraambh() {
	        return this.praraambh;
	    }
	    
	    public void setPraraambh(final String praraambh) {
	        this.praraambh = praraambh;
	    }
	    
	    public String getFsdmApproved() {
	        return this.fsdmApproved;
	    }
	    
	    public void setFsdmApproved(final String fsdmApproved) {
	        this.fsdmApproved = fsdmApproved;
	    }
	    
	    public String getDateFrom() {
	        return this.dateFrom;
	    }
	    
	    public void setDateFrom(final String dateFrom) {
	        this.dateFrom = dateFrom;
	    }
	    
	    public String getDateTo() {
	        return this.dateTo;
	    }
	    
	    public void setDateTo(final String dateTo) {
	        this.dateTo = dateTo;
	    }
	    
	    @Override
	    public String toString() {
	        return "FilterPayload [outlet=" + this.outlet + ", name=" + this.name + ", uniqueCode=" + this.uniqueCode + ", designation=" + this.designation + ", mspin=" + this.mspin + ", passFailStatus=" + this.passFailStatus + ", dateRange=" + this.dateRange + ", dateFrom=" + this.dateFrom + ", dateTo=" + this.dateTo + ", assessment=" + this.assessment + ", interview=" + this.interview + ", praraambh=" + this.praraambh + ", fsdmApproved=" + this.fsdmApproved + "]";
	    }
	
}
