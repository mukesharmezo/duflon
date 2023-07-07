package com.armezo.duflon.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.EventLoger;
import com.armezo.duflon.Repositories.EventLogerRepository;

@Service
public class EventLogerService {

	 @Autowired
	private EventLogerRepository eventLogerRepository;
	 
	 public void save(EventLoger event ) {
		 eventLogerRepository.save(event);
	 }
	 
}
