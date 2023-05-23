package com.armezo.duflon.jobportal;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * @author Sunil
 *
 */
@Entity
@Table(name = "job_details")
public class JobDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long jobId;
	private Long hreId;
	private String designation;
	private String description;
	private Double salaryMin;
	private Double salaryMax;
	private String education;
	private String location;
	private String hreName;
	@Column(columnDefinition = "VARCHAR(1)")
	private String status="U";       // U: Unhold , H: Hold
	@Column(columnDefinition = "VARCHAR(1)")
	private String approvalHr="R";       // A : Approved , R: Rejected
	@Column(columnDefinition = "VARCHAR(1)")
	private String approvalLm="R";       // A : Approved , R: Rejected
	private Double profileExperience;
	
	@OneToMany(cascade = CascadeType.ALL)
	private List<JobSkill> skills;
	/*
	@ManyToMany
    @JoinTable(name = "job_skill_mapping",
               joinColumns = @JoinColumn(name = "job_id_mapping"),
               inverseJoinColumns = @JoinColumn(name = "skill_id_mapping"))
    private Set<JobSkill> skills = new HashSet<>();
	*/

	public Long getJobId() {
		return jobId;
	}

	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}

	public Long getHreId() {
		return hreId;
	}

	public void setHreId(Long hreId) {
		this.hreId = hreId;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getSalaryMin() {
		return salaryMin;
	}

	public void setSalaryMin(Double salaryMin) {
		this.salaryMin = salaryMin;
	}

	public Double getSalaryMax() {
		return salaryMax;
	}

	public void setSalaryMax(Double salaryMax) {
		this.salaryMax = salaryMax;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public void setHreName(String hreName) {
		this.hreName = hreName;
	}
	
	public String getHreName() {
		return hreName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getApprovalHr() {
		return approvalHr;
	}

	public void setApprovalHr(String approvalHr) {
		this.approvalHr = approvalHr;
	}

	public String getApprovalLm() {
		return approvalLm;
	}

	public void setApprovalLm(String approvalLm) {
		this.approvalLm = approvalLm;
	}

	public Double getProfileExperience() {
		return profileExperience;
	}

	public void setProfileExperience(Double profileExperience) {
		this.profileExperience = profileExperience;
	}

	public List<JobSkill> getSkills() {
		return skills;
	}

	public void setSkills(List<JobSkill> skills) {
		this.skills = skills;
	}

	@Override
	public String toString() {
		return "JobDetails [jobId=" + jobId + ", hreId=" + hreId + ", designation=" + designation + ", description="
				+ description + ", salaryMin=" + salaryMin + ", salaryMax=" + salaryMax + ", education=" + education
				+ ", location=" + location + ", hreName=" + hreName + ", status=" + status + ", approvalHr="
				+ approvalHr + ", approvalLm=" + approvalLm + ", profileExperience=" + profileExperience + ", skills="
				+ skills + "]";
	}

}
