package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "admin_table")
public class AdminTable {

	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 private Integer id;
	@Column(name = "empCode", length = 50)
	 private String empCode;
	
	@Column(name = "password", length = 50)
	 private String password;
	
	@Column(name = "name", length = 50)
	 private String name;
	 @Column(name = "email", length = 100)
	 private String email;
	 private Boolean status;
	 
	 public AdminTable() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


public void setEmpCode(String empCode) {
	this.empCode = empCode;
}
public String getEmpCode() {
	return empCode;
}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
	
	
	 
	 
	
}
