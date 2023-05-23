package com.armezo.duflon.jobportal;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class AddressController {
	
	private final RestTemplate template;
	public AddressController() {
		this.template = new RestTemplate();
	}
	
	//@GetMapping("/pincode/{pincode}")
	public List<CountryStateDistPinPayload> getAddressByPinCode(String pincode) {
		String url = "https://api.postalpincode.in/pincode/" + pincode;
        ResponseEntity<AddressAPIResponse[]> response = template.getForEntity( url, AddressAPIResponse[].class);
        List<CountryStateDistPinPayload> payloads = new ArrayList<CountryStateDistPinPayload>();
        if (response.getStatusCode() == HttpStatus.OK) {
        	AddressAPIResponse[] apiResponse = response.getBody();
            if (apiResponse != null && apiResponse.length > 0) {
            	AddressAPIResponse address = apiResponse[0];
            	if(address.getStatus().equalsIgnoreCase("Success")) {
            		for(PostOffice po : address.getPostOffices()) {
            			CountryStateDistPinPayload payload = new CountryStateDistPinPayload();
            			payload.setCountry(po.getCountry());
            			payload.setState(po.getState());
            			payload.setDistrict(po.getDistrict());
            			payload.setBlock(po.getBlock());
            			payload.setPoName(po.getName());
            			payload.setPincode(po.getPincode());
            			payloads.add(payload);
            		}
            	}
            }
        }
		return payloads;
	}
	
	//Get State and City/District by Pincode
	@PostMapping("/pincode/{pincode}")
	public ResponseEntity<CountryStateDistPinPayload> getStateCityByPincode(@PathVariable("pincode") String pincode){
		CountryStateDistPinPayload payload = new CountryStateDistPinPayload();
		List<CountryStateDistPinPayload> payloads=getAddressByPinCode(pincode);
		if(payloads.size()>0) {
			payload = payloads.get(0);
		}
		if(payload!=null) {
			return ResponseEntity.ok(payload);
		}else {
			return ResponseEntity.notFound().build();
		}
	}

}
