package com.armezo.duflon.jobportal;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="job_user_skill")
public class UserSkill {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String skill;
    private Double experience;
    
    
    public UserSkill() {
	}
    
	
	public UserSkill(Long id, String skill, Double experience) {
		super();
		this.id = id;
		this.skill = skill;
		this.experience = experience;
	}


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public Double getExperience() {
		return experience;
	}
	public void setExperience(Double experience) {
		this.experience = experience;
	}


	@Override
	public String toString() {
		return "UserSkill [id=" + id + ", skill=" + skill + ", experience=" + experience + "]";
	}
	

	

}
