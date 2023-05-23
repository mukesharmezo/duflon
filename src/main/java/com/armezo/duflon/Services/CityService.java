package com.armezo.duflon.Services;

import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.City;
import com.armezo.duflon.Entities.State;
import com.armezo.duflon.Repositories.CityRepository;

@Service
@Transactional
public class CityService {

	@Autowired
	private CityRepository  cityRepository;
	
	public List<City> saveAllCity(List<City> cityList){
		return cityRepository.saveAll(cityList);
	}
	
	public City saveCity(City city){
		return cityRepository.save(city);
	}
	
	public Optional<City> getCity(String cityName){
		return cityRepository.findByCityName(cityName);
	}
	
	public List<City> getAllCity(){
		return cityRepository.findAll();
	}
	
	public boolean checkDuplicate(final String cityName, final String cityCode) {
        boolean ischecked = false;
        final Optional<City> city = (Optional<City>)this.cityRepository.findByCityNameAndCityCode(cityName, cityCode);
        if (city.isPresent()) {
            ischecked = true;
        }
        return ischecked;
    }
	  
	  public List<City> getAllCityByStateCode(List<String> stateCodes) { 
		 List<City> cityList=cityRepository.findAllCityByStateCode(stateCodes);
		  System.out.println("In Service"+stateCodes+"  "+cityList); 
		  return cityList; 
	  }
	  
	  public List<City> getAllCityByStateCode(String stateCodes) { 
			 List<City> cityList=cityRepository.findCityByStateCode(stateCodes);
			return cityList; 
		  }

	public Optional<City> getCityByCityCode(String cityCode) {
		return cityRepository.getCityByCityCode(cityCode);
	}
	 
} 
