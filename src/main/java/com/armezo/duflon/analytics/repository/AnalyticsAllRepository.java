package com.armezo.duflon.analytics.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.analytics.entity.AnalyticsAll;

public interface AnalyticsAllRepository extends JpaRepository<AnalyticsAll, Long> {
	
	
	@Query("SELECT a FROM AnalyticsAll a WHERE a.hiredStatus=:approval")
	List<AnalyticsAll> findAllAnalyticsWhereFSDMApproved(String approval);

	@Query("SELECT a.accesskey FROM AnalyticsAll a WHERE (a.hreId IN :hreIds OR (:hreIds) IS NULL)")
	List<String> getAccessKeyList(List<Long> hreIds);

	@Query("SELECT a FROM AnalyticsAll a WHERE (a.hreId IN :hreId OR (:hreId) IS NULL) AND (a.recruitDate >= :dateFrom AND a.recruitDate <= :dateTo)")
	List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(List<Long> hreId, LocalDate dateFrom, LocalDate dateTo);
/*
	@Query("SELECT a FROM AnalyticsAll a WHERE (:dealerCode IS NULL OR a.dealerCode = :dealerCode OR :dealerCode='') AND (a.dealerCode IN :searchOutlets OR :searchOutlets IS NULL ) AND "
			+ "(:regionCode IS NULL OR a.region = :regionCode OR :regionCode = '') AND  (a.state = :stateCode OR :stateCode IS NULL OR :stateCode = '') AND (a.city = :cityCode OR :cityCode IS NULL OR :cityCode = '') AND "
			+ "(:approved IS NULL OR a.fsdmApproval = :approved OR :approved ='') AND (a.recruitDate >= :dateFrom AND a.recruitDate <= :dateTo) AND (a.hreId IN :hreIdList OR :hreIdList IS NULL)")
	List<AnalyticsAll> getAllAnalyticsBySearchQuery(String dealerCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			 LocalDate  dateTo, List<Long> hreIdList);

	@Query("SELECT a FROM AnalyticsAll a WHERE (:dealerCode IS NULL OR a.dealerCode = :dealerCode OR :dealerCode='') AND (a.dealerCode IN :searchOutlets OR :searchOutlets IS NULL) AND "
			+  "(:regionCode IS NULL OR a.region = :regionCode OR :regionCode = '')  AND  (a.state = :stateCode OR :stateCode IS NULL OR :stateCode = '') AND (a.city = :cityCode OR :cityCode IS NULL OR :cityCode = '') AND "
			+ "(:approved IS NULL OR a.fsdmApproval = :approved OR :approved ='') AND (a.hreId IN :hreIdList OR :hreIdList IS NULL)")
	List<AnalyticsAll> getAnalyticsBySearchData(String dealerCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, List<Long> hreIdList);
	
	@Query("SELECT a FROM AnalyticsAll a WHERE (:dealerCode IS NULL OR a.dealerCode = :dealerCode OR :dealerCode='') AND (a.dealerCode IN :searchOutlets OR :searchOutlets IS NULL) AND "
			+ "(:regionCode IS NULL OR a.region = :regionCode OR :regionCode = '') AND (a.state = :stateCode OR :stateCode IS NULL OR :stateCode = '') AND (a.city = :cityCode OR :cityCode IS NULL OR :cityCode = '') AND "
			+ "(:approved IS NULL OR a.fsdmApproval = :approved OR :approved ='') AND (a.recruitDate >= :dateFrom AND a.recruitDate <= :dateTo) AND (a.hreId IN :hreIdList OR :hreIdList IS NULL)")
	List<AnalyticsAll> getAllAnalyticsBySearchQueryFSDMApproved(String dealerCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList);
			*/
//	@Query("SELECT a FROM AnalyticsAll a WHERE (:dealerCode IS NULL OR a.dealerCode = :dealerCode OR :dealerCode='') AND (a.hreId =:hreId OR :hreId IS NULL) AND "
//			+ "(:regionCode IS NULL OR a.region = :regionCode OR :regionCode = '') AND (a.recruitDate >= :dateFrom AND a.recruitDate <= :dateTo) AND (a.hreId IN :hreIdList OR :hreIdList IS NULL)")
//	List<AnalyticsAll> getAllAnalyticsBySearchQueryFSDMApproved(String dealerCode, Long hreId, String regionCode, LocalDate dateFrom,
//			Date dateTo, List<Long> hreIdList);
	/*
	@Query("SELECT a FROM AnalyticsAll a WHERE (:dealerCode IS NULL OR a.dealerCode = :dealerCode OR :dealerCode='') AND (a.dealerCode IN :searchOutlets OR :searchOutlets IS NULL) AND "
			+  "(:regionCode IS NULL OR a.region = :regionCode OR :regionCode = '')  AND (a.state = :stateCode OR :stateCode IS NULL OR :stateCode = '') AND (a.city = :cityCode OR :cityCode IS NULL OR :cityCode = '') AND "
			+ "(:approved IS NULL OR a.fsdmApproval = :approved OR :approved ='') AND (a.hreId IN :hreIdList OR :hreIdList IS NULL)")
	List<AnalyticsAll> getAnalyticsBySearchDataFSDMAprroved(String dealerCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, List<Long> hreIdList);
*/
	@Query("SELECT a FROM AnalyticsAll a WHERE a.hreId =:hreId")
	List<AnalyticsAll> findByhreId(Long hreId);
	@Query("SELECT a FROM AnalyticsAll a WHERE a.accesskey =:accessKey")
	Optional<AnalyticsAll> findByAccesskey(String accessKey);

	@Query("SELECT a FROM AnalyticsAll a WHERE a.accesskey IN :accesskeyList OR :accesskeyList IS NULL")
	List<AnalyticsAll> findAnalyticsByAccesskeyList(List<String> accesskeyList);

	//Temporary Method
//	@Query("SELECT a FROM AnalyticsAll a WHERE a.accesskey =:accessKey")
//	List<AnalyticsAll> findAllAnalyticsByAccesskeyAndhreId(String accessKey,Long id);

	@Query("SELECT a FROM AnalyticsAll a WHERE a.accesskey =:accessKey AND a.hreId=:hreId AND a.participantId=:pId")
	Optional<AnalyticsAll> findByAccesskeyAndhreId(String accessKey, Long hreId, Long pId);
	@Query("SELECT a FROM AnalyticsAll a WHERE a.accesskey =:accessKey AND a.hreId=:hreId")
	List<AnalyticsAll> findAllAnaByAccesskeyhreId(String accessKey, Long hreId);

	
}