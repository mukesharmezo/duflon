package com.armezo.duflon.analytics.payload;

import java.util.List;

public class ActionPointsPayload {
	
	private List<String> assessmentStatus;
	private List<String> interviewStatus;
	private List<String> documentUploadStatus;
	private List<String> prarambhStatus;
	private List<String> fsdmApproval;
	public List<String> getAssessmentStatus() {
		return assessmentStatus;
	}
	public void setAssessmentStatus(List<String> assessmentStatus) {
		this.assessmentStatus = assessmentStatus;
	}
	public List<String> getInterviewStatus() {
		return interviewStatus;
	}
	public void setInterviewStatus(List<String> interviewStatus) {
		this.interviewStatus = interviewStatus;
	}
	public List<String> getDocumentUploadStatus() {
		return documentUploadStatus;
	}
	public void setDocumentUploadStatus(List<String> documentUploadStatus) {
		this.documentUploadStatus = documentUploadStatus;
	}
	public List<String> getPrarambhStatus() {
		return prarambhStatus;
	}
	public void setPrarambhStatus(List<String> prarambhStatus) {
		this.prarambhStatus = prarambhStatus;
	}
	public List<String> getFsdmApproval() {
		return fsdmApproval;
	}
	public void setFsdmApproval(List<String> fsdmApproval) {
		this.fsdmApproval = fsdmApproval;
	}

	

}
