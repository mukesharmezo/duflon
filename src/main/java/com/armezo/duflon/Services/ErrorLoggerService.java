package com.armezo.duflon.Services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.ErrorLogger;
import com.armezo.duflon.Repositories.ErrorLogerRepository;

@Service
public class ErrorLoggerService {
	
	@Autowired
	private ErrorLogerRepository loggerRepo;
	
	//save Error Logger
	public void saveErrorLogger(ErrorLogger logger) {
		loggerRepo.save(logger);
	}
	
	//get All Error Logger
	public List<ErrorLogger> getAllErrorLogger() {
		return loggerRepo.findAll().stream().sorted((e1,e2) -> e1.getErrorTime().compareTo(e2.getErrorTime())).collect(Collectors.toList());
	}

}
