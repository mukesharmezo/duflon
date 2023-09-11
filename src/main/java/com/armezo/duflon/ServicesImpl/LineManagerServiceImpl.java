package com.armezo.duflon.ServicesImpl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Repositories.LineManagerRepository;
import com.armezo.duflon.Services.LineManagerService;

@Service
public class LineManagerServiceImpl implements LineManagerService {
	
	@Autowired
	private LineManagerRepository lmRepository;
	
	public List<LineManager> saveAllLMs(List<LineManager> lmList){
		return lmRepository.saveAll(lmList);
	}
	
	public List<LineManager> getAllLMs(){
		return lmRepository.findAll();
	}
	
	public LineManager saveLineManager(LineManager lm) {
		return lmRepository.save(lm);
	}
	
	public Optional<LineManager> getByEmailAndPassword(String email,String password){
		return lmRepository.findByEmailAndPassword(email,password);
	}
	
	public Optional<LineManager> getByPassword(String password){
		return lmRepository.findByPassword(password);
	}
	
	public Optional<LineManager> getLineManager(Long id){
		return lmRepository.findById(id);
	}
	
	public boolean checkDuplicate(final String empCode) {
        boolean ischecked = false;
        final Optional<LineManager> fsdm = (Optional<LineManager>)this.lmRepository.findByEmpCode(empCode);
        if (fsdm.isPresent()) {
            ischecked = true;
        }
        return ischecked;
    }

	public Optional<LineManager> findByempCodeAndEmail(String empCode,String email) {
		return lmRepository.findByEmpCodeAndEmail(empCode, email);
	}
	
	public void addEmailAddressAfterLogin(String empCode, String email) {
		lmRepository.addEmailAddressAfterLogin(empCode,email);
	}
	public void changePassword(String empCode, String confirmPassword) {
		lmRepository.changePasswordByEmpCode(empCode,confirmPassword);
	}
	public Optional<LineManager> findByempCode(String empCode) {
		return lmRepository.findByEmpCode(empCode);
	}

	public void changeEmail(String empCode, String newEmail) {
		lmRepository.changeEmail(empCode, newEmail);
		
	}
	public void changeEmailById(Long id,String email ) {
		lmRepository.changeEmailById(id, email);
	}
	public Optional<LineManager>findByIdAndEmail(Long id,String email){
		return lmRepository.findByIdAndEmail(id, email);
	}
	@Transactional
	public void updatePassword( Long id,String password) {
		lmRepository.updatePassword(  id, password);
	}

	public Optional<LineManager> findByEmail(String user) {
		return lmRepository.findByEmail(user);
	}

	public Optional<LineManager> getByEmpCodeAndPassword(String user, String password) {
		return lmRepository.findByEmpCodeAndPassword(user,password);
	}

	public Optional<LineManager> findById(Long lmId) {
		return lmRepository.findById(lmId);
	}

}
