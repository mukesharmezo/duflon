package com.armezo.duflon.Services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.AccessKeyMaster;
import com.armezo.duflon.Repositories.AccessKeyMasterRepository;

@Service
@Transactional
public class AccessKeyMasterService {
	
	@Autowired
	private  AccessKeyMasterRepository accessKeyMasterRepository;
	
	public Optional<AccessKeyMaster>getAccesskey(String accesskey){
		return accessKeyMasterRepository.findByAccesskey(accesskey);
	}
	
	public AccessKeyMaster updateAccesskey(AccessKeyMaster entity){
		return accessKeyMasterRepository.save(entity);
	}
	
	public List<AccessKeyMaster> saveAccesskey(List<AccessKeyMaster> keys){
		return accessKeyMasterRepository.saveAll(keys);
	}
	
	public List<AccessKeyMaster> getByDealer(Long hreId){
		return accessKeyMasterRepository.findByhreIdOrderByModifiedDateDesc(hreId);
	}
	
	public boolean deleteByAccesskey(String accesskey){
		boolean status = false;
		Optional<AccessKeyMaster>key =	accessKeyMasterRepository.findByAccesskey(accesskey);
		if(key.isPresent()) {
		   accessKeyMasterRepository.delete(key.get());
		   status = true;
		}
		
		return status;
	}

	public List<AccessKeyMaster> getByhreIdAndDateRange(Long hreId, Date dateFrom, Date dateTo) {
		return accessKeyMasterRepository.getByhreIdAndDateRange(hreId,dateFrom,dateTo);
	}
	
	public void updateModiedDate(String accesskey) {
		 accessKeyMasterRepository.updateModiedDate(accesskey);
	}
	
	  public  void updateStatus(final String accesskey) {
		  accessKeyMasterRepository.updateStatus(accesskey); 
	  }
	  
	 public List<AccessKeyMaster> getDateRange( Date dateFrom, Date dateTo){
		  return accessKeyMasterRepository.getDateRange(dateFrom,dateTo);
	  }
	
	
	
	
}
