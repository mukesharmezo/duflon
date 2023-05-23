package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name="hre")
public class HRE {
	
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
    private String name;
    private String email;
    private String empCode;
    private String department;
    private String location;
    private String mobile;
    private String password;
    private LocalDate deactivationDate;
    private Boolean status;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "line_manager_id")
    private LineManager lineManager;
    
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setDeactivationDate(LocalDate deactivationDate) {
		this.deactivationDate = deactivationDate;
	}
	public LocalDate getDeactivationDate() {
		return deactivationDate;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public LineManager getLineManager() {
		return lineManager;
	}
	public void setLineManager(LineManager lineManager) {
		this.lineManager = lineManager;
	}
	
    
    
    

}
