package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ho")
public class HO {
	
	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 private Integer id;
	 private String mspin;
	 private String name;
	 private String email;
	 private String password;
	 private Boolean status;
	 
	 public HO() {
	
	 }

	public HO(Integer id, String mspin, String name, String email, String mobile, Boolean status, String password) {
		super();
		this.id = id;
		this.mspin = mspin;
		this.name = name;
		this.email = email;
		this.status = status;
		this.password = password;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMspin() {
		return mspin;
	}

	public void setMspin(String mspin) {
		this.mspin = mspin;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "HO [" + (id != null ? "id=" + id + ", " : "") + (mspin != null ? "mspin=" + mspin + ", " : "")
				+ (name != null ? "name=" + name + ", " : "") + (email != null ? "email=" + email + ", " : "")
				+ (status != null ? "status=" + status + ", " : "") + (password != null ? "password=" + password : "") + "]";
	}
	 
	 

}
