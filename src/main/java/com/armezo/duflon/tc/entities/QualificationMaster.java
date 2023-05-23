package com.armezo.duflon.tc.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "qualification_master")
public class QualificationMaster {
	
	@Id
	@Column(name = "qualid")
	private Integer qualId;

	
	@Column(name = "qualification")
	private String qualification;

	
	@Column(name = "status")
	private String status;


	public QualificationMaster() {
		super();
		// TODO Auto-generated constructor stub
	}


	public QualificationMaster(Integer qualId, String qualification, String status) {
		super();
		this.qualId = qualId;
		this.qualification = qualification;
		this.status = status;
	}


	public Integer getQualId() {
		return qualId;
	}


	public void setQualId(Integer qualId) {
		this.qualId = qualId;
	}


	public String getQualification() {
		return qualification;
	}


	public void setQualification(String qualification) {
		this.qualification = qualification;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	@Override
	public String toString() {
		return "QualificationMaster [qualId=" + qualId + ", qualification=" + qualification + ", status=" + status
				+ "]";
	}
	
	

}
