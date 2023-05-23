package com.armezo.duflon.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.Entities.City;

public interface CityRepository extends JpaRepository<City,Integer> {
	public Optional<City> findByCityNameAndCityCode(String cityName,String cityCode);
	public Optional<City> findByCityName(String cityName);
	
	@Query("SELECT c FROM City c WHERE c.stateCode IN :stateCodes")
	public List<City> findAllCityByStateCode(List<String> stateCodes);
	
	@Query("SELECT c FROM City c WHERE c.stateCode =:stateCodes")
	public List<City> findCityByStateCode(String stateCodes);
	@Query("SELECT c FROM City c WHERE c.cityCode =:cityCode")
	public Optional<City> getCityByCityCode(String cityCode);
}
