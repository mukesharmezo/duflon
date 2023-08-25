package com.armezo.duflon.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.LMInterview;

@Repository
public interface LMInterviewRepository extends JpaRepository<LMInterview,Long>{

	List<LMInterview> findByAccesskey(String accsskey);
	@Modifying
    @Query("DELETE FROM LMInterview l WHERE l.accesskey = :accesskey")
	void deleteByAccesskey(String accesskey);
}
