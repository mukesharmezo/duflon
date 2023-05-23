package com.armezo.duflon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
@EnableJpaAuditing
@ServletComponentScan
@EnableScheduling
public class DuflonApplication extends SpringBootServletInitializer {

	@Bean
	public RestTemplate restTemplate() {
	    return new RestTemplate();
	}
	
	public static void main(String[] args) {
		SpringApplication.run(DuflonApplication.class, args);
		
		
	}
	
	

}
