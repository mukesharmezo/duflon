package com.armezo.duflon.jobportal;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	//Get All Users
	public List<UserRegistration> getAllUsers(){
		return userRepository.findAll();
	}
	//Save User Details
	public void saveUser(UserRegistration user) {
		userRepository.save(user);
	}
	public List<UserRegistration> getAllUsersByJobId(Long jobId) {
		return userRepository.findUserByJobId(jobId);
	}
	public Optional<UserRegistration> getUserByUserId(Long userId) {
		return userRepository.findById(userId);
	}
	public Optional<UserRegistration> getUserByAccesskey(String accesskey) {
		return userRepository.getUserByAccesskey(accesskey);
	}
	

}
