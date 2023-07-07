package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.MasterData;
import com.armezo.duflon.Repositories.MasterDataRepository;

@Service
public class MasterDataService {
	
	@Autowired
	private MasterDataRepository repository;

	public List<MasterData> getAllMasterData() {
		return repository.findAll();
	}

	public void saveMasterData(MasterData master) {
		repository.save(master);
	}

	public Optional<MasterData> getMasterDataById(Long id) {
		return repository.findById(id);
	}

	public void deleteMaster(MasterData masterData) {
		repository.delete(masterData);
	}

	public List<String> getAllMasterDataByMasterName(String masterName) {
		return repository.findAllMasterDescriptionByMasterName(masterName);
	}

}
