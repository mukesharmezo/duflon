package com.armezo.duflon.Services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Repositories.HreRepository;

@Service
@Transactional
public class HREService {

	@Autowired
	private HreRepository hreRepository;
	
	
	

	public List<HRE>  saveAll(List<HRE>tdmList){
		return hreRepository.saveAll(tdmList);
	}
	
	public List<HRE>  getAllHRE(){
		return hreRepository.findAll();
	}
	
	public Optional<HRE>  getByempCodeAndPassword(String empCode,String password){
		return hreRepository.findByEmpCodeAndPassword(empCode,password);
	}
	
	public Optional<HRE>  getById(long id){
		return hreRepository.findById(id);
	}
	
	
	public boolean checkDuplicate(final String empCode) {
        boolean ischecked = false;
        final Optional<HRE> HRE = hreRepository.findByEmpCode(empCode);
        if (HRE.isPresent()) {
            ischecked = true;
        }
        return ischecked;
    }
	
	public Optional<HRE> getByempCode(final String empCode) {
       
		return   hreRepository.findByEmpCode(empCode);   
    }
	public Optional<HRE> getByPassword(String password){
		return hreRepository.findByPassword(password);
	}
	
	public Optional<HRE> findByempCodeAndEmail(String empCode,String email) {
		return hreRepository.findByEmpCodeAndEmail(empCode, email);
	}

	public HRE save(HRE d) {
		return hreRepository.save(d);
	}

	public void addEmailAddress(Long id, String email) {
		hreRepository.addEmailAddress(id,email);
		
	}


	public void changePassword(String empCode, String newPassword) {
		hreRepository.changePassword(empCode, newPassword);
	}


	public Optional<HRE> findByempCode(String empCode) {
		return hreRepository.findByEmpCode(empCode);
	}


	public void changeEmail(String empCode, String newEmail) {
		hreRepository.changeEmail(empCode,newEmail);
	}
	
	public void deactivateHRE(boolean status,Date deactivationDate, Long id) {
		hreRepository.deactivateHRE(status,deactivationDate,id);
	}
	
	public List<HRE> findByAll() {
		return hreRepository.findAll();
	}

	public Optional<HRE> findByEmail(String email) {
		return hreRepository.findByEmail(email);
	}
}
