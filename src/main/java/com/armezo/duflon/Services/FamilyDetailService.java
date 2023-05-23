package com.armezo.duflon.Services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Repositories.FamilyDetailsRepo;

@Service
public class FamilyDetailService {

	private FamilyDetailsRepo familyDetailsRepo;
	
	private FamilyDetailService(FamilyDetailsRepo familyDetailsRepo) {
		this.familyDetailsRepo=familyDetailsRepo;
	}

	public void update(FamilyDetails familyDetails) {
		familyDetailsRepo.save(familyDetails);
	}
	
	public Optional<FamilyDetails> getByFid(long fid){
		return familyDetailsRepo.findByFid(fid);
	}
	
	public void delete(FamilyDetails damilyDetails){
		 familyDetailsRepo.delete(damilyDetails);
	}
}
