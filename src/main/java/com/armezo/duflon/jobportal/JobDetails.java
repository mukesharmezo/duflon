package com.armezo.duflon.jobportal;

import java.time.LocalDate;
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
	private String company;
	private String region;
	private String unit;
	private String business;
	private String function;
	private String product;
	private String hreName;
	private String jobCreaterNameId;
	private LocalDate jobPostDate;
	private String rejectionReasonHRE;
	private String approveReasonHRE;
	private String rejectionReasonLM;
	private String approveReasonLM;
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
	
	public void setJobPostDate(LocalDate jobPostDate) {
		this.jobPostDate = jobPostDate;
	}
	public LocalDate getJobPostDate() {
		return jobPostDate;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getJobCreaterNameId() {
		return jobCreaterNameId;
	}

	public void setJobCreaterNameId(String jobCreaterNameId) {
		this.jobCreaterNameId = jobCreaterNameId;
	}
	

	public String getRejectionReasonHRE() {
		return rejectionReasonHRE;
	}

	public void setRejectionReasonHRE(String rejectionReasonHRE) {
		this.rejectionReasonHRE = rejectionReasonHRE;
	}

	public String getApproveReasonHRE() {
		return approveReasonHRE;
	}

	public void setApproveReasonHRE(String approveReasonHRE) {
		this.approveReasonHRE = approveReasonHRE;
	}

	public String getRejectionReasonLM() {
		return rejectionReasonLM;
	}

	public void setRejectionReasonLM(String rejectionReasonLM) {
		this.rejectionReasonLM = rejectionReasonLM;
	}

	public void setApproveReasonLM(String approveReasonLM) {
		this.approveReasonLM = approveReasonLM;
	}
	
	public String getApproveReasonLM() {
		return approveReasonLM;
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
