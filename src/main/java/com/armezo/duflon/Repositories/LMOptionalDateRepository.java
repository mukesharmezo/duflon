package com.armezo.duflon.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.LMOptionalDate;

@Repository
public interface LMOptionalDateRepository extends JpaRepository<LMOptionalDate, Long> {

	List<LMOptionalDate> findAllByAccesskey(String accesskey);

	Optional<LMOptionalDate> findOptionalDateByLmIdAndAccesskey(Long lmId, String accesskey);

}
