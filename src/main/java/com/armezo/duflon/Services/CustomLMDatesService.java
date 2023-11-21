package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.CustomLMDates;
import com.armezo.duflon.Repositories.CustomLMDatesRepository;

@Service
public class CustomLMDatesService {
	
	@Autowired
	private CustomLMDatesRepository repository;

	public Optional<CustomLMDates> getCustomDatesByLmIdAndAccesskey(Long lmId, String accesskey) {
		return repository.findByLmIdAndAccesskey(lmId,accesskey);
	}

	public void saveCustomDates(CustomLMDates customDates) {
		repository.save(customDates);
	}

	public List<CustomLMDates> getAllCustomDatesByAccesskey(String accesskey) {
		return repository.findByAccesskey(accesskey);
	}

}
