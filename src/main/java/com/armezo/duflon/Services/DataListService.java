package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.DataList;
import com.armezo.duflon.Repositories.DataListRepository;

@Service
public class DataListService {
	
	@Autowired
	private DataListRepository dlRepository;

	
	public Optional<DataList> getListByListCode(String listCode) {
		return dlRepository.findDataListByListCode(listCode);
	}

	
	public void saveList(DataList DataList) {
		dlRepository.save(DataList);
	}

	
	public List<DataList> getAllDataList() {
		return dlRepository.findAll();
	}

	
	public List<String> getBloodGroup(String listName) {
	
		return dlRepository.getBloodGroup(listName);
	}

	
	public List<DataList> getByListName(String listName) {
		return dlRepository.findByListName(listName);
	}

}
