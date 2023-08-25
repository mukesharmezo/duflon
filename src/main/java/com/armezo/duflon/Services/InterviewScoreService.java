package com.armezo.duflon.Services;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Repositories.InterviewScoreRepo;

@Service
@Transactional
public class InterviewScoreService {

	@Autowired
	private InterviewScoreRepo interviewScoreRepo;
	
	public InterviewScore saveInterviewScore(InterviewScore interviewScore) {
		return interviewScoreRepo.save(interviewScore);
		
	}
//	public Optional<InterviewScore> findByAccesskey(String accesskey) {
//     return interviewScoreRepo.findByAccessKey(accesskey);		
//	}
	
	public void delete(InterviewScore interviewScore) {
	      interviewScoreRepo.delete(interviewScore);
	}
	public Optional<InterviewScore> findByAccesskeyAndInterviewCount(String accesskey, Integer interviewCount) {
		return interviewScoreRepo.findByAccessKeyAndInterviewCount(accesskey, interviewCount);
	}
}

