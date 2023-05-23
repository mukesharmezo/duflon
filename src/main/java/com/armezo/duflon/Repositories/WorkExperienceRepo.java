package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.armezo.duflon.Entities.WorkExperience;

public interface WorkExperienceRepo extends JpaRepository<WorkExperience, Long> {

	Optional<WorkExperience> findByWid(Long wid);
}