package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="ACCESSKEY_MASTER")
public class AccessKeyMaster{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "access_key", nullable = false)
	private String accesskey;
		
	//@DateTimeFormat(pattern = "dd-MM-yyyy")
	@Column(name="create_Date")  
	private LocalDate createdDate = LocalDate.now();
	
	@Column(name = "hre_id", nullable =false)
	private Long hreId;
	
	@Column(name = "status")
	private String status= "A";
	
	@Column(name = "test_status",nullable = false)
	private Integer testStatus=0;
	
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "modified_Date")
	private LocalDate modifiedDate;
	
	public AccessKeyMaster()
	{
		
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAccesskey() {
		return accesskey;
	}

	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedLocalDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getTestStatus() {
		return testStatus;
	}

	public void setTestStatus(Integer testStatus) {
		this.testStatus = testStatus;
	}

	public Long gethreId() {
		return hreId;
	}

	public void sethreId(Long hreId) {
		this.hreId = hreId;
	}

	public LocalDate getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(LocalDate modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
}
