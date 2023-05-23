package com.armezo.duflon.Repositories;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.Entities.State;

public interface StateRepository extends JpaRepository<State,Integer>{
	
public Optional<State> findByStateName(String stateName);
	
	public Optional<State> findByStateNameAndStateCode(String stateName,String stateCode);

	
	 @Query("SELECT s FROM State s WHERE s.regionCode IN :regionCode") 
	 public  List<State> getStateByRegionCode(List<String>  regionCode);
	
	  @Query("SELECT s FROM State s WHERE s.regionCode =:regionCode") 
	  public  List<State> getStateByRegionCode(String  regionCode);
	  
	  @Query("SELECT s FROM State s WHERE s.stateCode =:stateCode") 
	  public  List<State> getStateCityCode(String  stateCode);
	 

	  
}
