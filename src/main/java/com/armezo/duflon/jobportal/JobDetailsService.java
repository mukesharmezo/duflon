package com.armezo.duflon.jobportal;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JobDetailsService {
	
	@Autowired
	private JobDetailsRepository jobDetailsRepository;
	
	//Save Job Details
	public void saveJobDetails(JobDetails jobDetails) {
		jobDetailsRepository.save(jobDetails);
	}
	//Get Job Details By Id
	public Optional<JobDetails> getJobDetailsById(Long jobId) {
		return jobDetailsRepository.findById(jobId);
	}
	// Get All Job Details
	public List<JobDetails> getAllJobDetails(){
		List<JobDetails> jobList = jobDetailsRepository.findAll();
		return jobList;
	}
	// Get All Active Job Details
	public List<JobDetails> getAllActiveJobDetails(){
		return jobDetailsRepository.getAllApprovedJobs();
	}
	public void deleteJobByJobId(Long jobId) {
		jobDetailsRepository.deleteById(jobId);
	}
	public List<JobDetails> getJobDetailsByhreId(Long hreId) {
		return jobDetailsRepository.getJobDetailsByHRId(hreId);
	}
	
	public List<JobDetails> getActiveJobByhreId(Long hreId) {
		return jobDetailsRepository.getApprovedJobByHreId(hreId);
	}

}
