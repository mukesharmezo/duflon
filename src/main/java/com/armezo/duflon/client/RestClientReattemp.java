package com.armezo.duflon.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class RestClientReattemp {
	
	
	@Autowired
	RestTemplate restTemplate;
	 @Value("${Ap.assessmentURL}")
		private String assessmentURL;
	
	public  String callClient(String accesskey) {
		
			String url=assessmentURL+"pa/deleteAccesskey?accesskey="+accesskey;
			ResponseEntity<String> response = restTemplate.getForEntity(url,String.class);
			return response.getBody();
	}

}
