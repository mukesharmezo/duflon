package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="city")
public class City {
	 
		@Id
	    @GeneratedValue(strategy=GenerationType.AUTO)
		private Long id;
		private String cityName;
		private String cityCode;
		private String stateCode;
		private Boolean status = true;
		
		public City() {
		}
		
		public City(String cityName,String cityCode) {
			this.cityName=cityName;
			this.cityCode=cityCode;
		}

		public String getCityName() {
			return cityName;
		}


		public void setCityName(String cityName) {
			this.cityName = cityName;
		}


		public String getCityCode() {
			return cityCode;
		}


		public void setCityCode(String cityCode) {
			this.cityCode = cityCode;
		}


		public Boolean getStatus() {
			return status;
		}


		public void setStatus(Boolean status) {
			this.status = status;
		}

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}


		public String getStateCode() {
			return stateCode;
		}

		public void setStateCode(String stateCode) {
			this.stateCode = stateCode;
		}
		
}
