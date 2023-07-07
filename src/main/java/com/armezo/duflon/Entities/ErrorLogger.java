package com.armezo.duflon.Entities;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "error_logger")
public class ErrorLogger {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private String accesskey;
	private LocalDateTime errorTime;
	private String errorCode;
	private String errorMessage;
	private String process;
	
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
	public LocalDateTime getErrorTime() {
		return errorTime;
	}
	public void setErrorTime(LocalDateTime errorTime) {
		this.errorTime = errorTime;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	
	

}
