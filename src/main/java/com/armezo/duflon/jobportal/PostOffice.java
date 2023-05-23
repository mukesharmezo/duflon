package com.armezo.duflon.jobportal;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public  class PostOffice {
	@JsonProperty("Name")
    private String name;

    @JsonProperty("Description")
    private String description;

    @JsonProperty("BranchType")
    private String branchType;

    @JsonProperty("DeliveryStatus")
    private String deliveryStatus;

    @JsonProperty("Circle")
    private String circle;

    @JsonProperty("District")
    private String district;

    @JsonProperty("Division")
    private String division;

    @JsonProperty("Region")
    private String region;

    @JsonProperty("Block")
    private String block;

    @JsonProperty("State")
    private String state;

    @JsonProperty("Country")
    private String country;

    @JsonProperty("Pincode")
    private String pincode;
    
    public PostOffice() {
	}

	public PostOffice(String name, String description, String branchType, String deliveryStatus, String circle,
			String district, String division, String region, String block, String state, String country,
			String pincode) {
		super();
		this.name = name;
		this.description = description;
		this.branchType = branchType;
		this.deliveryStatus = deliveryStatus;
		this.circle = circle;
		this.district = district;
		this.division = division;
		this.region = region;
		this.block = block;
		this.state = state;
		this.country = country;
		this.pincode = pincode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBranchType() {
		return branchType;
	}

	public void setBranchType(String branchType) {
		this.branchType = branchType;
	}

	public String getDeliveryStatus() {
		return deliveryStatus;
	}

	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getBlock() {
		return block;
	}

	public void setBlock(String block) {
		this.block = block;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Override
	public String toString() {
		return "PostOffice [name=" + name + ", description=" + description + ", branchType=" + branchType
				+ ", deliveryStatus=" + deliveryStatus + ", circle=" + circle + ", district=" + district + ", division="
				+ division + ", region=" + region + ", block=" + block + ", state=" + state + ", country=" + country
				+ ", pincode=" + pincode + "]";
	}
	
    

}
