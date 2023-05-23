package com.armezo.duflon.analytics.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.armezo.duflon.analytics.entity.AnalyticsAll;
import com.armezo.duflon.analytics.payload.ActionPointsPayload;
import com.armezo.duflon.analytics.payload.AgeWisePayload;
import com.armezo.duflon.analytics.payload.AssessmentReportPayload;
import com.armezo.duflon.analytics.payload.CandidateExperiencePayload;
import com.armezo.duflon.analytics.payload.CandidateNonAutoExperiencePayload;
import com.armezo.duflon.analytics.payload.DesignationTypePayload;
import com.armezo.duflon.analytics.payload.GenderDiversityPayload;
import com.armezo.duflon.analytics.payload.OverviewPayload;
import com.armezo.duflon.analytics.payload.RecruitmentSourcePayload;

public interface AnalyticsAllService {
	
	void saveAllAnalytics(AnalyticsAll analyticsAll);
	void saveAll(List<AnalyticsAll> analyticsAlls);
	List<AnalyticsAll> getAllAnalytics();
	OverviewPayload getOverviewAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	RecruitmentSourcePayload getRecruitmentSourceAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	CandidateExperiencePayload getCandidateExpAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	CandidateNonAutoExperiencePayload getCandidateNonAutoExperience(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	AssessmentReportPayload getAssessmentReportAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	DesignationTypePayload getDesignationTypeAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	AgeWisePayload getAgeWiseAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	GenderDiversityPayload getGenderAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	ActionPointsPayload getActionPending(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	List<String> getAccessKeyList(List<Long> hreIdList);
	/*
	List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	
	// Filter Methods
	OverviewPayload getOverviewAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList);
	ActionPointsPayload getActionPending(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList);
	RecruitmentSourcePayload getRecruitmentSourceAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode,
			String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList);
	CandidateExperiencePayload getCandidateExpAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode,
			String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList);
	CandidateNonAutoExperiencePayload getCandidateNonAutoExperience(String outletCode, List<String> searchOutlets,
			String regionCode,  String stateCode, String cityCode, String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList);
	AssessmentReportPayload getAssessmentReportAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode,
			String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList);
	DesignationTypePayload getDesignationTypeAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode,
			String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList);
	AgeWisePayload getAgeWiseAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList);
	GenderDiversityPayload getGenderAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList);
			*/
	Optional<AnalyticsAll> getAnalyticsByAccesskey(String accessKey, Long hreId, Long pId);
	List<AnalyticsAll> getAllAnalyticsByAccesskeyList(List<String> accesskeyList);
	void deleteById(Long id);
	/*
	 * List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(String outletCode, String
	 * dealershipCode, String regionCode, String stateCode, String cityCode,
	 * List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
	 */
	List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo);
}
