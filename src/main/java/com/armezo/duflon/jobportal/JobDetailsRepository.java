package com.armezo.duflon.jobportal;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface JobDetailsRepository extends JpaRepository<JobDetails, Long> {

	@Query("SELECT j FROM JobDetails j WHERE j.hreId=:hreId")
	List<JobDetails> getJobDetailsByHRId(Long hreId);

	@Query("SELECT j FROM JobDetails j WHERE j.approvalHr='A' AND j.approvalLm='A' AND j.status='U'")
	List<JobDetails> getAllApprovedJobs();

	@Query("SELECT j FROM JobDetails j WHERE j.approvalHr='A' AND j.approvalLm='A' AND j.status='U' AND j.hreId=:hreId")
	List<JobDetails> getApprovedJobByHreId(Long hreId);

}
