package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "line_manager")
public class LineManager {
	
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
    private String name;
    private String email;
    private String empCode;
    private String mobile;
    private String password;
    private LocalDate deactivationDate;
    private Boolean status;
    
    
    
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
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getEmpCode() {
		return empCode;
	}
}
