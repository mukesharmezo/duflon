package com.armezo.duflon.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.LMAccesskey;

@Repository
public interface LMAccesskeyRepository extends JpaRepository<LMAccesskey,Long>{

	@Query("Select l FROM LMAccesskey l  where l.interviewStatus is null OR interviewStatus = 0")
	List<LMAccesskey>  getInterviewAccesskey();
	

	Optional<LMAccesskey>  findByAccesskeyAndLmId(String accesskey,Long lmId);

	@Query("SELECT l FROM LMAccesskey l WHERE l.accesskey=:accesskey")
	List<LMAccesskey> findByAccesskey(String accesskey);

	@Modifying
    @Query("DELETE FROM LMAccesskey l WHERE l.accesskey = :accesskey")
	void deleteByAccesskey(String accesskey);

	@Query("SELECT l FROM LMAccesskey l WHERE l.lmId=:lmId")
	List<LMAccesskey> findByLmId(Long lmId);


	@Query("SELECT l FROM LMAccesskey l WHERE l.accesskey=:accesskey AND l.lmId !=:lmId")
	List<LMAccesskey> findOtherLM(String accesskey, Long lmId);
}
