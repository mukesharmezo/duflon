package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.LMInterview;
import com.armezo.duflon.Entities.LMOptionalDate;
import com.armezo.duflon.Repositories.LMInterviewRepository;
import com.armezo.duflon.Repositories.LMOptionalDateRepository;

@Service
public class LMInterviewService {

	@Autowired
	private  LMInterviewRepository lMInterviewRepository;
	@Autowired
	private LMOptionalDateRepository dateRepo;
	
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

	public Long saveLmInterview(LMInterview lmInterview) {
		return lMInterviewRepository.save(lmInterview).getId();
	}

	public void saveOptionalDate(LMOptionalDate optDate) {
		dateRepo.save(optDate);
	}

	public List<LMOptionalDate> findOptionalDatesByAccesskey(String accesskey) {
		return dateRepo.findAllByAccesskey(accesskey);
	}

	public Optional<LMOptionalDate> findOptionalDateByLMIdAndAccesskey(Long lmId, String accesskey) {
		return dateRepo.findOptionalDateByLmIdAndAccesskey(lmId,accesskey);
	}
}
