package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "master_data")
public class MasterData {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private String masterDescription;
	private String masterName;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getMasterName() {
		return masterName;
	}
	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}
	public String getMasterDescription() {
		return masterDescription;
	}
	public void setMasterDescription(String masterDescription) {
		this.masterDescription = masterDescription;
	}
	@Override
	public String toString() {
		return "MasterData [id=" + id + ", masterDescription=" + masterDescription + ", masterName=" + masterName + "]";
	}
	
	
	
}
