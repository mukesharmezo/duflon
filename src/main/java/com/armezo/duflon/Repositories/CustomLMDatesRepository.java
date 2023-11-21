package com.armezo.duflon.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.CustomLMDates;

@Repository
public interface CustomLMDatesRepository extends JpaRepository<CustomLMDates, Long> {

	@Query("SELECT c FROM CustomLMDates c WHERE c.lmId = :lmId AND c.accesskey = :accesskey")
	Optional<CustomLMDates> findByLmIdAndAccesskey(Long lmId, String accesskey);

	List<CustomLMDates> findByAccesskey(String accesskey);

}
