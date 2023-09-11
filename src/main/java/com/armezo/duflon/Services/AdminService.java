package com.armezo.duflon.Services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.AdminTable;
import com.armezo.duflon.Repositories.SuperAdminRepository;


@Service
@Transactional
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
	
	public void changePassword(String empCode, String newPassword) {
		adminRepository.changePassword(empCode, newPassword);
	}

	public Optional<AdminTable> findByIdAndEmail(Long id, String oldEmail) {
		return adminRepository.findByIdAndEmail(id,oldEmail);
	}

	public void saveAdmin(AdminTable adminTable) {
		adminRepository.save(adminTable);
	}
	
}
