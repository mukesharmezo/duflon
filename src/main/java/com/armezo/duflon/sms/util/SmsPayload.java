package com.armezo.duflon.sms.util;

import javax.validation.constraints.NotNull;

public class SmsPayload {
	
	private String message;
	
	@NotNull
	private String mobileNumber;
	
	@NotNull
	private String recieverName;
	
	private boolean sendStatus;
	
	private String senderName;
	
	public SmsPayload() {
	}

	public SmsPayload(String message, @NotNull String mobileNumber, @NotNull String recieverName, boolean sendStatus, String senderName) {
		super();
		this.message = message;
		this.mobileNumber = mobileNumber;
		this.recieverName = recieverName;
		this.sendStatus = sendStatus;
		this.senderName=senderName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getRecieverName() {
		return recieverName;
	}

	public void setRecieverName(String recieverName) {
		this.recieverName = recieverName;
	}

	public boolean isSendStatus() {
		return sendStatus;
	}

	public void setSendStatus(boolean sendStatus) {
		this.sendStatus = sendStatus;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	@Override
	public String toString() {
		return "SmsPayload [message=" + message + ", mobileNumber=" + mobileNumber + ", recieverName=" + recieverName
				+ ", sendStatus=" + sendStatus + ", senderName=" + senderName + "]";
	}
	
	
	
	

}
