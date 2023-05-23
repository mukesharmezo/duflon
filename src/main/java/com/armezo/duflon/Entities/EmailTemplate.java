package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="email_template")
public class EmailTemplate {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	
	@Column(length = 5000)
	private String massageBody;
	
	@Column(name="subjct_line")
	private String subjctLine;
	
	@Column(name="status")
	private boolean status;

	
	public EmailTemplate() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMassageBody() {
		return massageBody;
	}

	public void setMassageBody(String massageBody) {
		this.massageBody = massageBody;
	}

	public String getSubjctLine() {
		return subjctLine;
	}

	public void setSubjctLine(String subjctLine) {
		this.subjctLine = subjctLine;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
}
