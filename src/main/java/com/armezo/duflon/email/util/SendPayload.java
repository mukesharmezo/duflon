package com.armezo.duflon.email.util;

public class SendPayload {
	
	private String name;

	private String emailId;

	private String mobileNo;
	private Boolean sentStatus;	

	public String to;
	
	public String from;

	public String cc;

	public String bcc;

	public String msg;

	public String subjectLine;
	
	public String sendDate;

	public SendPayload() {

	}

	public SendPayload(String name, String emailId, String mobileNo, String candidateCode,
			Boolean sentStatus, String to, String from, String cc, String bcc, String msg, String subjectLine,String sendDate) {
		this.name = name;
		this.emailId = emailId;
		this.mobileNo = mobileNo;
		this.sentStatus = sentStatus;
		this.to = to;
		this.from = from;
		this.cc = cc;
		this.bcc = bcc;
		this.msg = msg;
		this.subjectLine = subjectLine;
		this.sendDate=sendDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public Boolean getSentStatus() {
		return sentStatus;
	}

	public void setSentStatus(Boolean sentStatus) {
		this.sentStatus = sentStatus;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}
	
	public String getFrom() {
		return from;
	}
	
	public void setFrom(String from) {
		this.from = from;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getBcc() {
		return bcc;
	}

	public void setBcc(String bcc) {
		this.bcc = bcc;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getSubjectLine() {
		return subjectLine;
	}

	public void setSubjectLine(String subjectLine) {
		this.subjectLine = subjectLine;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
}
