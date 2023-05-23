package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.armezo.duflon.Entities.EmergencyContact;

public interface EmergencyContactRepo extends JpaRepository<EmergencyContact, Long> {
	
	
	Optional<EmergencyContact> findById(Long id);

}
