package com.armezo.duflon.jobportal;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AddressAPIResponse {
	
	@JsonProperty("Message")
    private String message;

    @JsonProperty("Status")
    private String status;

    @JsonProperty("PostOffice")
    private List<PostOffice> postOffices;

    public AddressAPIResponse() {
	}
	public AddressAPIResponse(String message, String status, List<PostOffice> postOffices) {
		super();
		this.message = message;
		this.status = status;
		this.postOffices = postOffices;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<PostOffice> getPostOffices() {
		return postOffices;
	}

	public void setPostOffices(List<PostOffice> postOffices) {
		this.postOffices = postOffices;
	}
	@Override
	public String toString() {
		return "AddressAPIResponse [message=" + message + ", status=" + status + ", postOffices=" + postOffices + "]";
	}
    
    
	
    

	
	

}
