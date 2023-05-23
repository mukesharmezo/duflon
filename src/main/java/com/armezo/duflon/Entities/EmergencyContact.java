package com.armezo.duflon.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "emergency_contact")
public class EmergencyContact {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "E_id")
	private Long id;
	
	@Column(name = "Name")
	private String cname;
	
	@Column(name = "contact_no")
	private String contactNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Id", referencedColumnName = "Id")
	private ParticipantRegistration participantRegistration;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public ParticipantRegistration getParticipantRegistration() {
		return participantRegistration;
	}

	public void setParticipantRegistration(ParticipantRegistration participantRegistration) {
		this.participantRegistration = participantRegistration;
	}

	@Override
	public String toString() {
		return "EmergencyContact [id=" + id + ", cname=" + cname + ", contactNo=" + contactNo
				+ ", participantRegistration=" + participantRegistration + "]";
	}

	
}
