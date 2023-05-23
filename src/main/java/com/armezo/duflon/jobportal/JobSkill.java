package com.armezo.duflon.jobportal;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "job_skill")
public class JobSkill {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long skillId;
	private String skillName;
	private Double requiredExperience;
//	@ManyToMany(mappedBy = "skills")
//	private Set<JobDetails> jobs= new HashSet<>();
	
	
	public Long getSkillId() {
		return skillId;
	}
	public void setSkillId(Long skillId) {
		this.skillId = skillId;
	}
	public String getSkillName() {
		return skillName;
	}
	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
	public Double getRequiredExperience() {
		return requiredExperience;
	}
	public void setRequiredExperience(Double requiredExperience) {
		this.requiredExperience = requiredExperience;
	}
//	public Set<JobDetails> getJobs() {
//		return jobs;
//	}
//	public void setJobs(Set<JobDetails> jobs) {
//		this.jobs = jobs;
//	}
//	
	

}
