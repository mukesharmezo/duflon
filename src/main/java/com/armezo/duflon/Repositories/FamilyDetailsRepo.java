package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.armezo.duflon.Entities.FamilyDetails;

public interface FamilyDetailsRepo extends JpaRepository<FamilyDetails, Long> {

	Optional<FamilyDetails>findByFid(long fid);

}
