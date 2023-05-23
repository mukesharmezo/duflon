package com.armezo.duflon.Repositories;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.Entities.AccessKeyMaster;

public interface AccessKeyMasterRepository extends JpaRepository<AccessKeyMaster,Long>{
	
	Optional<AccessKeyMaster> findByAccesskey(String accesskey);
	List<AccessKeyMaster> findByhreIdOrderByModifiedDateDesc(Long hreId);
	@Query("SELECT a FROM AccessKeyMaster a WHERE (a.hreId=:hreId) AND (a.createdDate>=:dateFrom AND a.createdDate<=:dateTo)")
	List<AccessKeyMaster> getByhreIdAndDateRange(Long hreId, Date dateFrom, Date dateTo);
	
	@Modifying(clearAutomatically = true)
    @Query("UPDATE  AccessKeyMaster set modifiedDate=now() WHERE accesskey =:accesskey")
    public  void updateModiedDate(final String accesskey);
	
	@Modifying(clearAutomatically = true)
    @Query("UPDATE  AccessKeyMaster set modifiedDate=now(),status='R' WHERE accesskey =:accesskey")
    public  void updateStatus(final String accesskey);
	
	@Query("SELECT a FROM AccessKeyMaster a WHERE status='A' AND  a.createdDate>=:dateFrom AND a.createdDate<=:dateTo")
	List<AccessKeyMaster> getDateRange( Date dateFrom, Date dateTo);

}
