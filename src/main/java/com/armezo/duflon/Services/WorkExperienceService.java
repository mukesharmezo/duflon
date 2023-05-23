package com.armezo.duflon.Services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Repositories.WorkExperienceRepo;

@Service
public class WorkExperienceService {

	private WorkExperienceRepo workExperienceRepo;
	
	public WorkExperienceService(WorkExperienceRepo workExperienceRepo) {
		this.workExperienceRepo=workExperienceRepo;
	}
	
	
	public Optional<WorkExperience>  getById(Long wid){
		return workExperienceRepo.findById(wid);
	}
	
	public void save(WorkExperience workExperience) {
		workExperienceRepo.save(workExperience);
	}
	public void delete(WorkExperience workExperience) {
		workExperienceRepo.delete(workExperience);
	}
	
}
