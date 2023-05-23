package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="user_login_log")
public class UserLoginLog {

	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@Column(name = "empCode")
	private String empCode;
	
	//@LocalDateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "last_login")
	private LocalDate lastLogin;
	
	public UserLoginLog() {
		
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	
	public String getEmpCode() {
		return empCode;
	}

	public LocalDate getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(LocalDate lastLogin) {
		this.lastLogin = lastLogin;
	}
	
}


