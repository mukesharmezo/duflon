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
@Table(name = "family_details")
public class FamilyDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "f_id")
	private Long fid;
	
	@Column(name = "member_name")
	private String memberName;
	
	@Column(name = "relation_ship")
	private String relationship;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Id", referencedColumnName = "Id")
	private ParticipantRegistration participantRegistration;

	public FamilyDetails() {
		super();
	}

	public FamilyDetails(Long fid, String memberName, String relationship,
			ParticipantRegistration participantRegistration) {
		super();
		this.fid = fid;
		this.memberName = memberName;
		this.relationship = relationship;
		this.participantRegistration = participantRegistration;
	}

	public Long getFid() {
		return fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getRelationship() {
		return relationship;
	}

	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}

	public ParticipantRegistration getParticipantRegistration() {
		return participantRegistration;
	}

	public void setParticipantRegistration(ParticipantRegistration participantRegistration) {
		this.participantRegistration = participantRegistration;
	}

	@Override
	public String toString() {
		return "FamilyDetails [fid=" + fid + ", memberName=" + memberName + ", relationship=" + relationship
				+ ", participantRegistration=" + participantRegistration + "]";
	}
	
	

}
