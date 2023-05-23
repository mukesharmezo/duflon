package com.armezo.duflon.Services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.UserLoginLog;
import com.armezo.duflon.Repositories.UserLoginLogRepository;

@Service
public class UserLoginLogService {
	
	private  UserLoginLogRepository userLoginLogRepository;
	
	public UserLoginLogService(UserLoginLogRepository userLoginLogRepository) {
		this.userLoginLogRepository=userLoginLogRepository;
	}
	
	public Optional<UserLoginLog> getloginLog(String empCode){
		return userLoginLogRepository.findByEmpCode(empCode);
	}
	
	public void updateLoginLog(UserLoginLog userLoginLog){
		 userLoginLogRepository.save(userLoginLog);
	}
	

}
