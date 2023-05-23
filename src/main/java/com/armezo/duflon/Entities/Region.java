package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="region")
public class Region {
	  	@Id
	    @GeneratedValue(strategy=GenerationType.AUTO)
		private Integer id;
		private String  regionCode;
		private String  regionName;
	    private Boolean status;
	    
	    
		public Region() {
		}


		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getRegionCode() {
			return regionCode;
		}
		public void setRegionCode(String regionCode) {
			this.regionCode = regionCode;
		}


		public String getRegionName() {
			return regionName;
		}


		public void setRegionName(String regionName) {
			this.regionName = regionName;
		}


		public Boolean getStatus() {
			return status;
		}


		public void setStatus(Boolean status) {
			this.status = status;
		}
		
		
		
		
}
