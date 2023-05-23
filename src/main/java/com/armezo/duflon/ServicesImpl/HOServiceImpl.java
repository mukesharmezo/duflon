package com.armezo.duflon.ServicesImpl;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.HO;
import com.armezo.duflon.Repositories.HORepository;
import com.armezo.duflon.Services.HOService;

@Service
@Transactional
public class HOServiceImpl implements HOService{

	@Autowired
	private HORepository hoRepository;

	@Override
	public void saveHO(HO ho) {
		hoRepository.save(ho);
	}

	@Override
	public void deleteHO(Integer id) {
		hoRepository.deleteById(id);
	}

	@Override
	public Optional<HO> getByMspinAndPassword(String mspin, String password) {
		return null;
		//return hoRepository.findHOByMspinAndPassword(mspin,password);
	}

	@Override
	public Optional<HO> findHOByMspin(String mspin) {
		return null;
		//return hoRepository.findByMspin(mspin);
	}

	@Override
	public void changeEmail(String mspin, String newEmail) {
		//hoRepository.changeEmail(mspin,newEmail);
	}

	@Override
	public void changePassword(String mspin, String newPassword) {
		//hoRepository.changePassword(mspin,newPassword);		
	}

	@Override
	public Optional<HO> getByMspinAndEmail(String mspin, String email) {
		return null;
		//return hoRepository.findByMspinAndEmail(mspin,email);
		
	}

	@Override
	public Optional<HO> findByIdAndEmail(int id, String email) {
		return null;
		// TODO Auto-generated method stub
		//return hoRepository.findByIdAndEmail(id,email);
	}

	@Override
	public void changeEmail(String email, int id) {
		// TODO Auto-generated method stub
		//hoRepository.changeEmailById( email,  id);
	}

	@Override
	public Optional<HO> findById(int id) {
		// TODO Auto-generated method stub
		return hoRepository.findById(id);
	}
}
