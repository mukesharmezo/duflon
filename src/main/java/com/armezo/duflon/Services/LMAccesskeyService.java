package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.LMAccesskey;
import com.armezo.duflon.Repositories.LMAccesskeyRepository;

@Service
public class LMAccesskeyService {

	@Autowired
	LMAccesskeyRepository lMAccesskeyRepository;
	
	
	public void save(LMAccesskey lMAccesskey) {
		lMAccesskeyRepository.save(lMAccesskey);
	}
	
	public  List<LMAccesskey>  getInterviewAccesskey(){
		return lMAccesskeyRepository.getInterviewAccesskey();
	}
	
	public Optional<LMAccesskey> findByAccesskeyAndLmId(String accesskey,Long lmId) {
	return 	lMAccesskeyRepository.findByAccesskeyAndLmId( accesskey, lmId);
	}

	public List<LMAccesskey> findByAccesskey(String accesskey) {
		return lMAccesskeyRepository.findByAccesskey(accesskey);
	}

	@Transactional
	public void deleteByAccesskey(String accesskey) {
		lMAccesskeyRepository.deleteByAccesskey(accesskey);
	}

	public List<LMAccesskey> getInterviewAccesskeyByLMId(Long lmId) {
		return lMAccesskeyRepository.findByLmId(lmId);
	}

	public List<LMAccesskey> findOtherLM(String accesskey, Long lmId) {
		return lMAccesskeyRepository.findOtherLM(accesskey,lmId);
	}
}
