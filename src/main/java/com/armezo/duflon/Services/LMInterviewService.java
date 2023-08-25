package com.armezo.duflon.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.LMInterview;
import com.armezo.duflon.Repositories.LMInterviewRepository;

@Service
public class LMInterviewService {

	@Autowired
	private  LMInterviewRepository lMInterviewRepository;
	
	public List<LMInterview> saveAll(List<LMInterview> lMInterview){
		
		return lMInterviewRepository.saveAll(lMInterview);
	}
	
	public void delete(LMInterview d) {
		lMInterviewRepository.delete(d);	
	}
	
	public List<LMInterview> findByAccesskey(String accsskey){
		return lMInterviewRepository.findByAccesskey( accsskey);
	}

	@Transactional
	public void deleteByAccesskey(String accesskey) {
		lMInterviewRepository.deleteByAccesskey(accesskey);
	}
}
