package com.armezo.duflon.Repositories;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.ParticipantRegistration;

@Repository
@Transactional
public interface ParticipantRepository extends JpaRepository<ParticipantRegistration, Long> {


Optional<ParticipantRegistration> findByAccessKey(final String accesskey);
List<ParticipantRegistration> findByHreIdIn(final List<Long> hreId);
/*
    Optional<ParticipantRegistration> findTop1ByFirstNameIgnoreCaseAndLastNameIgnoreCaseAndEmailIgnoreCaseAndhreId(final String firstName, final String lastName, final String email, final Long hreId);
    
    Optional<ParticipantRegistration> findTop1ByAccessKey(final String accessKey);
    
    List<FamilyDetails> save(final List<FamilyDetails> familyDetails);
    
    List<ParticipantRegistration> findByhreIdOrderByModifiedDateDesc(final long hreId);


    List<ParticipantRegistration> findByhreIdIn(final List<Long> hreId);
    @Query("From ParticipantRegistration p where p.hreId In(:hreId) and (p.hiredStatus IN ('3'))  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> findByhreIdPendinApproverFSDM(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where p.hreId In(:hreId) and (p.hiredStatus IN ('1') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> findByhreIdInprocessFSDM(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where p.hreId In(:hreId) and (p.hiredStatus='2')  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> findByhreIdEmployeeFSDM(final List<Long> hreId);
    
    
    List<ParticipantRegistration> findByhreIdInAndPrarambhStatusAndTestStatusOrderByModifiedDateDesc(final List<Long> hreId, final String prarambhStatus, final String testStatus);
    */
    @Query("From ParticipantRegistration p where p.hreId = :hreId and p.hiredStatus = :hiredStatus AND p.registration_Date  BETWEEN :from AND :to  Order By modified_date DESC")
    List<ParticipantRegistration> getEmployee(final long hreId, final String hiredStatus, LocalDate from, LocalDate to);
    @Query("From ParticipantRegistration p where p.hreId =:hreId and (p.hiredStatus is NULL OR p.hiredStatus='' OR p.hiredStatus='P')  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) AND p.registration_Date  BETWEEN :from AND :to Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantInpprocessForHRE(final long hreId, LocalDate from, LocalDate to);
    @Query("From ParticipantRegistration p where (p.hiredStatus is NULL OR p.hiredStatus='' OR p.hiredStatus='P')  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL)AND p.registration_Date  BETWEEN :from AND :to Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantInpprocessHo(LocalDate from, LocalDate to);
    @Query("From ParticipantRegistration p where p.hiredStatus = ('Y')  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) AND p.registration_Date  BETWEEN :from AND :to Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantEmployeeHo(LocalDate from, LocalDate to);
    @Query("From ParticipantRegistration p where Status = 'H' AND p.registration_Date  BETWEEN :from AND :to  Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantHoldHo(LocalDate from, LocalDate to);
    
    @Query("From ParticipantRegistration p where p.hreId = :hreId AND Status = 'H' AND p.registration_Date  BETWEEN :from AND :to  Order By modified_date DESC")
    List<ParticipantRegistration> getHoldParticipantsByFilterHRE(long hreId, LocalDate from, LocalDate to);
    @Query("From ParticipantRegistration p where p.status =:status Order By modified_date DESC")
    List<ParticipantRegistration> findAllHoldParticipantByStatusOnHO(String status);
    
    @Query("From ParticipantRegistration p where p.hreId = :hreId and p.status = :status Order By modified_date DESC")
    List<ParticipantRegistration> getHoldEmployee(final long hreId, final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.hreId = :adminId AND (p.registration_Date  BETWEEN :fromDate AND :toDate) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantForDetailedByYears(final Long adminId, final LocalDate fromDate, final LocalDate toDate);
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.registration_Date  BETWEEN :fromDate AND :toDate) Order By modified_date DESC")
    List<ParticipantRegistration> findAllParticipantsByYear(final LocalDate fromDate, final LocalDate toDate);
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.hiredStatus = 'P' AND p.testStatus ='3' AND (Status not IN ('H') or Status is NULL) AND (p.registration_Date  BETWEEN :fromDate AND :toDate) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantPendingApproval(final LocalDate fromDate, final LocalDate toDate);
    
    
    /*
    
    @Query("From ParticipantRegistration p where p.hreId = :hreId and p.hiredStatus = :hiredStatus and p.testStatus = :testStatus Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantDeealer(final long hreId, final String hiredStatus, final String testStatus);
    
    
    @Query("From ParticipantRegistration p where p.hreId =:hreId and p.hiredStatus ='2' Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVImployee(final long hreId);
    
    @Query("From ParticipantRegistration p where p.hreId =:hreId and p.status ='H' Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVHold(final long hreId);
    
    @Query("From ParticipantRegistration p where p.hreId =:hreId and (p.hiredStatus IN ('1','3') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) and (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVInpprocess(@Param("hreId") final long hreId, @Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND(p.hiredStatus IN ('1','3') or p.hiredStatus is NULL) and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) and (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo)  Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantFilterInpprocess(@Param("outletCode") final String outletCode, @Param("name") final String name, @Param("designation") final String designation, @Param("mspin") final String mspin, @Param("passFailStatus") final List<Integer> passFailStatus, @Param("accessKey") final String accessKey, @Param("hreId") final Long hreId, @Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo);
    
    //@Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND(p.hiredStatus='2') and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) and (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation) AND (:mspin IS NULL OR p.mspin = :mspin) AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey) AND (p.hreId=:hreId) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) Order By modified_date DESC")
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.hiredStatus =:hiredStatus) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantFilterEmployee(@Param("outletCode") final String outletCode, @Param("name") final String name, @Param("designation") final String designation, @Param("mspin") final String mspin, @Param("passFailStatus") final List<Integer> passFailStatus, @Param("accessKey") final String accessKey, @Param("hreId") final Long hreId, @Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo, String hiredStatus);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId and (p.hiredStatus IN ('1') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL)")
    List<ParticipantRegistration> getParticipantCSVInpprocess(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId and (p.hiredStatus IN ('1') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) AND (p.registration_date >= :dateFrom AND p.registration_date <=:dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVInpprocess(final List<Long> hreId, final Date dateFrom, final Date dateTo);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId and p.hiredStatus IN ('3') and p.testStatus ='3' Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVPendingApprovel(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId and p.hiredStatus IN ('3') and p.testStatus ='3' AND (p.registration_date >= :dateFrom AND p.registration_date <=:dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVPendingApprovel(final List<Long> hreId, final Date dateFrom, final Date dateTo);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId  and p.hiredStatus ='2' Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVImployee(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where p.hreId IN :hreId and p.hiredStatus='2' AND (p.registration_date >= :dateFrom AND p.registration_date <=:dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVImployee(final List<Long> hreId, final Date dateFrom, final Date dateTo);
    

    @Query("From ParticipantRegistration p where p.hreId IN :hreId and p.status ='H' Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVHold(final List<Long> hreId);
    
    @Query("From ParticipantRegistration p where (p.hreId IN :hreId OR :hreId IS NULL) and p.status ='H' AND (p.registration_date >= :dateFrom AND p.registration_date <=:dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantCSVHold(final List<Long> hreId, final Date dateFrom, final Date dateTo);
    
    
    
    
    @Query("From ParticipantRegistration p where (p.hiredStatus IN ('3'))  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantPendingApprovel();
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.outletCode = :outletCode AND p.designation = :designation Order By modified_date DESC")
    Optional<List<ParticipantRegistration>> getParticipantByOutletCodeAndDesg(@Param("outletCode") final String outletCode, @Param("designation") final String designation);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (p.firstName LIKE %:name%) OR :name='' OR (p.lastName=:name) OR (p.middleName=:name) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (p.testCompletionDate >= :dateFrom AND p.testCompletionDate < :dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByFilterData(@Param("outletCode") final String outletCode, @Param("name") final String name, @Param("designation") final String designation, @Param("mspin") final String mspin, @Param("passFailStatus") final List<Integer> passFailStatus, @Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByFilterData(@Param("outletCode") final String outletCode, @Param("name") final String name, @Param("designation") final String designation, @Param("mspin") final String mspin, @Param("passFailStatus") final List<Integer> passFailStatus, @Param("accessKey") final String accessKey, @Param("hreId") final Long hreId, @Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.testCompletionDate >= :dateFrom AND p.testCompletionDate < :dateTo Order By modified_date DESC")
    List<ParticipantRegistration> findByDateRange(@Param("dateFrom") final Date dateFrom, @Param("dateTo") final Date dateTo);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:assessment IS NULL OR p.testCompletionDate IS NOT NULL) AND (:interview IS NULL OR p.interviewDate IS NOT NULL) AND p.testStatus IS NOT NULL Order By modified_date DESC")
    List<ParticipantRegistration> findParticipantsByCompletionFilter(@Param("assessment") final String assessment, @Param("interview") final String interview);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE  (:designation IS NULL OR p.designation=:designation OR :designation= '' ) AND (:lastName IS NULL OR p.lastName=:lastName OR :lastName= '') Order By modified_date DESC")
    Optional<List<ParticipantRegistration>> getParticipantByNullValue(@Param("designation") final String desgignation, @Param("lastName") final String lastName);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.testStatus!=null Order By modified_date DESC")
    List<ParticipantRegistration> findAllParticipantWhoseTestIsCompleted();
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.state IN :stList OR (:stList) IS NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByHOFilters(@Param("stList") final List<String> stList);
    
   // @Query("SELECT p FROM ParticipantRegistration p WHERE (p.region IN :rgList OR (:rgList) IS NULL) AND (p.state IN :stList OR (:stList) IS NULL) AND(p.city IN :ctList OR (:ctList) IS NULL) AND (p.registration_date >= :dateFrom AND p.registration_date <=:dateTo) AND (p.hreId IN :hreIds OR (:hreIds) IS NULL)")
   // List<ParticipantRegistration> findAllParticipantByHOFiltersData(final List<String> rgList, final List<String> stList, final List<String> ctList, final Date dateFrom, final Date dateTo, final List<Long> hreIds);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.status = :status Order By modified_date DESC")
    List<ParticipantRegistration> findAllHoldParticipantByStatusOnHO(final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.hiredStatus = :fsdmApproveStatus Order By modified_date DESC")
    List<ParticipantRegistration> findAllFSDMApprovedParticipantOnHO(final String fsdmApproveStatus);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId)AND  (p.hiredStatus IN ('1','3') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL)  Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByFilterData2(@Param("outletCode") final String outletCode, @Param("name") final String name, @Param("designation") final String designation, @Param("mspin") final String mspin, @Param("passFailStatus") final List<Integer> passFailStatus, @Param("hreId") final Long hreId, @Param("accessKey") final String accessKey);
    
   // @Query("SELECT p FROM ParticipantRegistration p WHERE (p.region IN :rgList OR (:rgList) IS NULL) AND (p.state IN :stList OR (:stList) IS NULL) AND(p.city IN :ctList OR (:ctList) IS NULL) AND (p.hreId IN :hreIds OR (:hreIds) IS NULL)")
   // List<ParticipantRegistration> findAllParticipantByHOFiltersData2(final List rgList, final List stList, final List ctList, final List<Long> hreIds);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.accessKey NOT IN :accessKeyList) AND p.status!=:status Order By modified_date DESC")
    List<ParticipantRegistration> getAllParticipantNotInWithAccessKeyList(final List<String> accessKeyList, final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE  p.status!=:status Order By modified_date DESC")
    List<ParticipantRegistration> getAllParticipantNotHold(final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.accessKey NOT IN :accessKeyList Order By modified_date DESC")
    List<ParticipantRegistration> getAllParticipantNotInWithAccessKeyListWithHold(final List<String> accessKeyList);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.status!='H' Order By modified_date DESC")
    List<ParticipantRegistration> findAllParticipantsOnHONotHold();
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.hreId IN :list OR (:list) IS NULL) AND (p.registration_date >= :fromDate AND p.registration_date <= :toDate) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByhreIdListAndDate(final List<Long> list, final Date fromDate, final Date toDate);
    
    
    
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.modifiedDate >= :dateFrom AND p.modifiedDate <= :dateTo) AND (p.status =:status) Order By modifiedDate DESC")
    List<ParticipantRegistration> getParticipantOnHoldByFilterData(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId, final Date dateFrom, final Date dateTo, final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.status =:status) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantOnHoldByFilterData2(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId, final String status);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId IN :list OR (:list) IS NULL) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByFilterDataForFSDM(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final List<Long> list, final Date dateFrom, final Date dateTo);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId IN :list OR (:list) IS NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantByFilterDataForFSDM2(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final List<Long> list, final String accessKey);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo) AND (p.hiredStatus =:hiredStatus) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantOnEmployeeMasterDealerByFilterData(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId, final Date dateFrom, final Date dateTo, final String hiredStatus);
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode OR :outletCode='' ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation OR :designation='') AND (:mspin IS NULL OR p.mspin = :mspin OR :mspin='') AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey OR :accessKey='') AND (p.hreId=:hreId) AND (p.hiredStatus =:hiredStatus) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantOnEmployeeMasterDealerByFilterData(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId, final String hiredStatus);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation ) AND (:mspin IS NULL OR p.mspin = :mspin) AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey) AND (p.hreId=:hreId)AND  (p.hiredStatus IN ('1','3') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantOnEmpMasterDealerByFilterData2(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation ) AND (:mspin IS NULL OR p.mspin = :mspin) AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey) AND (p.hreId=:hreId)AND  (p.hiredStatus IN ('1','3') or p.hiredStatus is NULL)  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantInporocessDealerByFilter(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (:outletCode IS NULL OR p.outletCode = :outletCode ) AND (:name IS NULL OR (LOWER(p.firstName) LIKE LOWER(:name)) OR :name='' OR (LOWER(p.lastName) LIKE LOWER(:name)) OR (LOWER(p.middleName) LIKE LOWER(:name)) OR (CONCAT(LOWER(p.firstName), ' ', LOWER(p.lastName)) LIKE LOWER(:name)) ) AND (:designation IS NULL OR p.finalDesignation = :designation ) AND (:mspin IS NULL OR p.mspin = :mspin) AND (p.passFailStatus IN :passFailStatus OR (:passFailStatus) IS NULL) AND (:accessKey IS NULL OR p.accessKey = :accessKey) AND (p.hreId=:hreId)AND  (p.hiredStatus IN ('2') )  and p.testStatus ='3' and (Status not IN ('H') or Status is NULL) Order By modified_date DESC")
    List<ParticipantRegistration> getParticipantOnEmpMasterDealerByFilterData3(final String outletCode, final String name, final String designation, final String mspin, final List<Integer> passFailStatus, final String accessKey, final Long hreId);
    */
    @Modifying(clearAutomatically = true)
    @Query("UPDATE  ParticipantRegistration set modifiedDate=now() WHERE accessKey =:accesskey")
    public  int updateModifiedDate(final String accesskey);
    /*
    @Modifying(clearAutomatically = true)
    @Query("UPDATE  ParticipantRegistration set empProductivityRefId =:empProductivityRefId WHERE accessKey =:accesskey")
    public  int updateProductivityRefID(String empProductivityRefId,final String accesskey);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE  p.oldMspin = :oldMspin ")
    List<ParticipantRegistration> getOldMSPIN(final String oldMspin);

 //Status Filter Query
    @Query("SELECT p FROM ParticipantRegistration p WHERE p.testStatus ='3' AND (Status NOT IN ('H') or Status IS NULL) AND (:interviewSearch IS NULL OR p.interviewScore>=:interviewSearch) AND (p.prarambhStatus = :praraambhSearch OR (:praraambhSearch) IS NULL) AND ((:fsdmSearch) IS NULL OR p.hiredStatus IN (:fsdmSearch)) AND (p.hreId IN :hreIdList OR (:hreIdList) IS NULL) Order By modified_date DESC")
	List<ParticipantRegistration> findParticipantsByCompletionFilterInProcess(Integer interviewSearch, String praraambhSearch, List<String> fsdmSearch, List<Long> hreIdList);

    @Query("SELECT p FROM ParticipantRegistration p WHERE p.testStatus ='3' AND (Status IN ('H')) AND (:interviewSearch IS NULL OR p.interviewScore>=:interviewSearch) AND (p.prarambhStatus = :praraambhSearch OR (:praraambhSearch) IS NULL OR :praraambhSearch='') AND ((:fsdmSearch) IS NULL OR p.hiredStatus IN (:fsdmSearch)) AND (p.hreId IN :hreIdList OR (:hreIdList) IS NULL) Order By modified_date DESC")
	List<ParticipantRegistration> findParticipantsByCompletionFilterOnHold(Integer interviewSearch, String praraambhSearch, List<String> fsdmSearch, List<Long> hreIdList);

    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.hiredStatus IN ('3')) AND p.testStatus ='3' AND (Status NOT IN ('H') OR Status IS NULL) AND (p.prarambhStatus = :praraambhSearch OR (:praraambhSearch) IS NULL OR :praraambhSearch='') AND (p.hreId IN :hreIdList OR (:hreIdList) IS NULL) Order By modified_date DESC")
	List<ParticipantRegistration> findParticipantsByCompletionFilterPendingApprovalFSDM(String praraambhSearch, List<Long> hreIdList);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.hiredStatus IN ('1','3') OR p.hiredStatus IS NULL) AND p.testStatus ='3' AND (Status IN ('H')) AND (:interviewSearch IS NULL OR p.interviewScore>=:interviewSearch) AND (p.prarambhStatus = :praraambhSearch OR (:praraambhSearch) IS NULL  OR :praraambhSearch='') AND (p.hreId IN :hreIdList OR (:hreIdList) IS NULL) Order By modified_date DESC")
	List<ParticipantRegistration> findParticipantsByCompletionFilterOnHoldWithoutFSDM(Integer interviewSearch,
			String praraambhSearch, List<Long> hreIdList);
    
    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.hiredStatus IN ('1','3') OR p.hiredStatus IS NULL) AND p.testStatus ='3' AND (Status NOT IN ('H') OR Status IS NULL) AND (:interviewSearch IS NULL OR p.interviewScore>=:interviewSearch) AND (p.prarambhStatus = :praraambhSearch OR (:praraambhSearch) IS NULL  OR :praraambhSearch='') AND (p.hreId IN :hreIdList OR (:hreIdList) IS NULL) Order By modified_date DESC")
	List<ParticipantRegistration> findParticipantsByCompletionFilterInProcessWithoutFSDM(Integer interviewSearch,
			String praraambhSearch, List<Long> hreIdList);

    
    @Query("SELECT p FROM ParticipantRegistration p where documents_status='final' AND finalDesignation='STR' AND (mspin IS NULL or mspin='')")
   	List<ParticipantRegistration> getCandidateMPINnotGerate();
    
    
    
    
    
    @Query("From ParticipantRegistration p where p.testStatus ='3' AND (p.hreId IN :hreId OR (:hreId) IS NULL) ")
    List<ParticipantRegistration> getParticipantByhreId(List<Long> hreId);
    @Query("From ParticipantRegistration p where p.testStatus ='3' AND (p.hreId IN :hreId OR (:hreId) IS NULL) AND (p.registration_date >= :dateFrom AND p.registration_date <= :dateTo)")
    List<ParticipantRegistration> getParticipantByhreId(List<Long> hreId,Date dateFrom,Date dateTo);
    
    @Query("From ParticipantRegistration p where p.testStatus ='3'")
    List<ParticipantRegistration> getParticipantByhreId();
   
    
  
    
    @Modifying(clearAutomatically = true)
    @Query("update ParticipantRegistration  set questionReportStatus=1   where accessKey =:accesskey")
    public int updateQuestionReportStatus(String accesskey);
    
    @Modifying(clearAutomatically = true)
    @Query("update ParticipantRegistration  set prarambhStatus='2',praarambhDate = NOW(),modifiedDate =NOW()  where mspin =:mspin")
    public int updatePraaarambhtStatus(String mspin);
    
    @Modifying(clearAutomatically = true)
    @Query("update ParticipantRegistration  set prarambhStatus='2',praarambhDate =:d,modifiedDate =NOW()  where mspin =:mspin")
    public int updatePraaarambhtStatus(String mspin,Date d);
    

    @Query("SELECT p FROM ParticipantRegistration p WHERE (p.hiredStatus IN ('1','3') OR p.hiredStatus IS NULL) AND (Status NOT IN ('H') OR Status IS NULL) "
    		+ "  AND (p.modifiedDate >= :dateFrom AND p.modifiedDate <= :dateTo) ")
   	List<ParticipantRegistration> updateOnHold(Date dateFrom,Date dateTo );
    
    @Query("From ParticipantRegistration p where p.hreId In(:hreId) and (p.hiredStatus IN ('3'))  "
    		+ "and p.testStatus ='3' and (Status not IN ('H') or Status is NULL)"
    		+ "AND (p.modifiedDate >= :dateFrom AND p.modifiedDate <= :dateTo) "
    		+ " Order By modified_date DESC")
    List<ParticipantRegistration> findByhreIdPendinApproverFSDM(final List<Long> hreId,Date dateFrom,Date dateTo);
    
    

    @Query("From ParticipantRegistration p  where p.mspin =:mspin AND p.designation='Sales' And p.prarambhStatus='1'")
    Optional<ParticipantRegistration>  findByMSPIN(String mspin);
    
    @Query("From ParticipantRegistration p  where  p.designation='Sales' And p.prarambhStatus='1'")
    List<ParticipantRegistration>  findByMSPIN();
    
    @Query("From ParticipantRegistration p where prarambhStatus='1'  and (Status not IN ('H') or Status is NULL) and finalDesignation='STR'" )
    List<ParticipantRegistration> getAllPraaramStatusPendin();
*/
    
    
    
    @Query("From ParticipantRegistration p where p.testStatus ='3' and questionReportStatus=0")
    List<ParticipantRegistration> getParticipant();
    @Query("From ParticipantRegistration p  where  p.empCode =:empCode and hreId =:hreId")
    Optional<ParticipantRegistration>  findByEmployeeCode(String empCode,Long hreId);
    @Modifying(clearAutomatically = true)
    @Query("update ParticipantRegistration  set questionReportStatus=1   where accessKey =:accesskey")
    public int updateQuestionReportStatus(String accesskey);
	
    @Query("From ParticipantRegistration p where p.hreId = :hreId and p.status = :status "
    		+"AND (p.modifiedDate >= :dateFrom AND p.modifiedDate <= :dateTo) "
    		+ "Order By modified_date DESC")
    List<ParticipantRegistration> getHoldEmployee(final long hreId, final String status,LocalDate dateFrom,LocalDate dateTo);
 
    
    
}
