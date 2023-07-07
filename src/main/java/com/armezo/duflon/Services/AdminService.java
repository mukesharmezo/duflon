package com.armezo.duflon.Services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.AdminTable;
import com.armezo.duflon.Repositories.SuperAdminRepository;


@Service
public class AdminService {
	
	 @Autowired
     private SuperAdminRepository adminRepository;
	
	public Optional<AdminTable> findByEmpCodeAndPassword(String empCode,String password){
		return adminRepository.findByEmpCodeAndPassword(empCode,password);
	}

	public Optional<AdminTable> findAdminByEmpCode(String user) {
		return adminRepository.findAdminByEmpCode(user);
	}

	public Optional<AdminTable> findByEmail(String email) {
		return adminRepository.findByEmail(email);
	}

	public Optional<AdminTable> getById(Integer saId) {
		return adminRepository.findById(saId);
	}
}
