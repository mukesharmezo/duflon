package com.armezo.duflon.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.MasterData;

@Repository
public interface MasterDataRepository extends JpaRepository<MasterData, Long> {

	@Query("SELECT m.masterDescription FROM MasterData m WHERE m.masterName = :masterName")
	List<String> findAllMasterDescriptionByMasterName(String masterName);

}
