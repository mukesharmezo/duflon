package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.State;
import com.armezo.duflon.Repositories.StateRepository;


@Service
@Transactional
public class StateService {

	@Autowired
	private StateRepository stateRepository;
	
	public List<State> saveAll(List<State> stateList){
		return stateRepository.saveAll(stateList);
	}
	public Optional<State> getState(String stateName){
		return stateRepository.findByStateName(stateName);
	}
	public List<State> getAllState(){
		return stateRepository.findAll();
	}
	
	public  List<State> getStateCityCode(String cityCode){
		return  stateRepository.getStateCityCode( cityCode);
	}
	
	public State save(State state){
		return stateRepository.save(state);
	}
	
	public boolean checkDuplicate(final String stateName, final String statCode) {
        boolean ischecked = false;
        final Optional<State> state = stateRepository.findByStateNameAndStateCode(stateName, statCode);
        if (state.isPresent()) {
            ischecked = true;
        }
        return ischecked;
    }
	
	  public List<State> getStateByRegionCode(String regionCode) {
		  return stateRepository.getStateByRegionCode(regionCode); 
	 // return null; 
	  }
	  
	  public List<State> getStateByRegionCode(List<String> regionCode) {
		  return stateRepository.getStateByRegionCode(regionCode); 
	 // return null; 
	  }
	 
}
