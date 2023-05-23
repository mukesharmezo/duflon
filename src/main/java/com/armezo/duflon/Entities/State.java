package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="state")
public class State {
	 	
	 
	    
	    @Id
	    @GeneratedValue(strategy = GenerationType.AUTO)
	    private Long stateId;
	    private String stateName;
	    private String stateCode;
	    private String  regionCode;
	    private Boolean status;
	    
		public Long getStateId() {
			return stateId;
		}
		public void setStateId(Long stateId) {
			this.stateId = stateId;
		}
		public String getStateName() {
			return stateName;
		}
		public void setStateName(String stateName) {
			this.stateName = stateName;
		}
		public String getStateCode() {
			return stateCode;
		}
		public void setStateCode(String stateCode) {
			this.stateCode = stateCode;
		}
		public String getRegionCode() {
			return regionCode;
		}
		public void setRegionCode(String regionCode) {
			this.regionCode = regionCode;
		}
		public Boolean getStatus() {
			return status;
		}
		public void setStatus(Boolean status) {
			this.status = status;
		}
	    
	  
		
}
