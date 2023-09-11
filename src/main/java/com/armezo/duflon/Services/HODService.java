package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.HOD;
import com.armezo.duflon.Repositories.HODRepository;

@Service
@Transactional
public class HODService {
	
	@Autowired
	private HODRepository hodRepository;
	
	public List<HOD> saveAllLMs(List<HOD> lmList){
		return hodRepository.saveAll(lmList);
	}
	
	public List<HOD> getAllLMs(){
		return hodRepository.findAll();
	}
	
	public HOD saveHOD(HOD lm) {
		return hodRepository.save(lm);
	}
	
	public Optional<HOD> getByEmailAndPassword(String email,String password){
		return hodRepository.findByEmailAndPassword(email,password);
	}
	
	public Optional<HOD> getByPassword(String password){
		return hodRepository.findByPassword(password);
	}
	
	public Optional<HOD> getHOD(Long id){
		return hodRepository.findById(id);
	}
	
	public boolean checkDuplicate(final String empCode) {
        boolean ischecked = false;
        final Optional<HOD> fsdm = (Optional<HOD>)this.hodRepository.findByEmpCode(empCode);
        if (fsdm.isPresent()) {
            ischecked = true;
        }
        return ischecked;
    }

	public Optional<HOD> findByempCodeAndEmail(String empCode,String email) {
		return hodRepository.findByEmpCodeAndEmail(empCode, email);
	}
	
	public void addEmailAddressAfterLogin(String empCode, String email) {
		hodRepository.addEmailAddressAfterLogin(empCode,email);
	}
	public void changePassword(String empCode, String confirmPassword) {
		hodRepository.changePasswordByEmpCode(empCode,confirmPassword);
	}
	public Optional<HOD> findByempCode(String empCode) {
		return hodRepository.findByEmpCode(empCode);
	}

	public void changeEmail(String empCode, String newEmail) {
		hodRepository.changeEmail(empCode, newEmail);
		
	}
	public void changeEmailById(Long id,String email ) {
		hodRepository.changeEmailById(id, email);
	}
	public Optional<HOD>findByIdAndEmail(Long id,String email){
		return hodRepository.findByIdAndEmail(id, email);
	}
	public void updatePassword( Long id,String password) {
		hodRepository.updatePassword(  id, password);
	}

	public Optional<HOD> findByEmail(String user) {
		return hodRepository.findByEmail(user);
	}

	public Optional<HOD> getByEmpCodeAndPassword(String user, String password) {
		return hodRepository.findByEmpCodeAndPassword(user,password);
	}

}
