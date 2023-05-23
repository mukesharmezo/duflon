package com.armezo.duflon.analytics.service.impl;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.armezo.duflon.analytics.repository.AnalyticsAllRepository;
import com.armezo.duflon.analytics.service.AnalyticsAllService;

@Service
public class AnalyticsAllServiceImpl implements AnalyticsAllService {

	@Autowired
	private AnalyticsAllRepository analyticsRepo;
	
	//private static List<AnalyticsAll> ANALYTICSALL = new ArrayList<AnalyticsAll>();
	
	
	@Override
	public void saveAllAnalytics(AnalyticsAll analyticsAll) {
		analyticsRepo.save(analyticsAll);
	}

	@Override
	public List<AnalyticsAll> getAllAnalytics() {
		return analyticsRepo.findAll();
	}

	@Override
	public OverviewPayload getOverviewAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return overviewUtil(analyticsAlls);
	}

	@Override
	public RecruitmentSourcePayload getRecruitmentSourceAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return recruitmentSourcePayloadUtil(analyticsAlls);
	}

	@Override
	public CandidateExperiencePayload getCandidateExpAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return expUtil(analyticsAlls);
	}

	@Override
	public CandidateNonAutoExperiencePayload getCandidateNonAutoExperience(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return expNonAutoutil(analyticsAlls);
	}

	@Override
	public AssessmentReportPayload getAssessmentReportAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return asmtUtil(analyticsAlls);
	}

	@Override
	public DesignationTypePayload getDesignationTypeAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return desgUtil(analyticsAlls);
	}

	@Override
	public AgeWisePayload getAgeWiseAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return ageUtil(analyticsAlls);
	}

	@Override
	public GenderDiversityPayload getGenderAnalytics(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return genderUtil(analyticsAlls);
	}

	@Override
	public ActionPointsPayload getActionPending(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> analyticsAlls = analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return actionPointsPayloadUtil(analyticsAlls);
	}
	
	@Override
	public void saveAll(List<AnalyticsAll> analyticsAlls) {
		analyticsRepo.saveAll(analyticsAlls);
	}
	
	@Override
	public List<String> getAccessKeyList(List<Long> hreIdList) {
		return analyticsRepo.getAccessKeyList(hreIdList);
	}

	@Override
	public List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		List<AnalyticsAll> list= analyticsRepo.getDataByAnyTypeLoginByhreIds(hreIdList,dateFrom,dateTo);
		return list;
	}
	
	@Override
	public List<AnalyticsAll> getAllAnalyticsByAccesskeyList(List<String> accesskeyList) {
		List<AnalyticsAll> list=new ArrayList<AnalyticsAll>();
		if(accesskeyList!=null && !accesskeyList.isEmpty()) {
		list = analyticsRepo.findAnalyticsByAccesskeyList(accesskeyList);
		}
		return list;
	}
	
	// Util Method   cityCode, String approved
	/*
	@Override
	public OverviewPayload getOverviewAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQuery(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchData(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, hreIdList);
		}
		return overviewUtil(analyticsAlls);
	}

	@Override
	public ActionPointsPayload getActionPending(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQuery(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchData(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, hreIdList);
		}
		return actionPointsPayloadUtil(analyticsAlls);
	}

	@Override
	public RecruitmentSourcePayload getRecruitmentSourceAnalytics(String outletCode, List<String> searchOutlets,
			String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, hreIdList);
		}
		return recruitmentSourcePayloadUtil(analyticsAlls);
	}

	@Override
	public CandidateExperiencePayload getCandidateExpAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved,
			LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {

		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, hreIdList);
		}
		return expUtil(analyticsAlls);
	}

	@Override
	public CandidateNonAutoExperiencePayload getCandidateNonAutoExperience(String outletCode, List<String> searchOutlets,
			String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved,  hreIdList);
		}
		return expNonAutoutil(analyticsAlls);
	}

	@Override
	public AssessmentReportPayload getAssessmentReportAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved,
			LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved,  dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved,  hreIdList);
		}
		return asmtUtil(analyticsAlls);
	}

	@Override
	public DesignationTypePayload getDesignationTypeAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved,
			LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode,  stateCode, cityCode, approved, hreIdList);
		}
		return desgUtil(analyticsAlls);
	}

	@Override
	public AgeWisePayload getAgeWiseAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved, LocalDate dateFrom,
			LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved,  dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode, stateCode, cityCode, approved, hreIdList);
		}
		return ageUtil(analyticsAlls);
	}

	@Override
	public GenderDiversityPayload getGenderAnalytics(String outletCode, List<String> searchOutlets, String regionCode, String stateCode, String cityCode, String approved,
			LocalDate dateFrom, LocalDate dateTo, List<Long> hreIdList) {
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		if(dateFrom!=null && dateTo!=null) {
			analyticsAlls = analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode,stateCode,cityCode, approved, dateFrom, dateTo, hreIdList);
		}else {
			analyticsAlls = analyticsRepo.getAnalyticsBySearchDataFSDMAprroved(outletCode, searchOutlets, regionCode,stateCode, cityCode, approved, hreIdList);
		}
		return genderUtil(analyticsAlls);
	}
	
	@Override
	public List<AnalyticsAll> getDataByAnyTypeLoginByhreIds(String outletCode, List<String> searchOutlets,
			String regionCode, String stateCode, String cityCode, String approved, List<Long> hreIdList, LocalDate dateFrom, LocalDate dateTo) {
		return analyticsRepo.getAllAnalyticsBySearchQueryFSDMApproved(outletCode, searchOutlets, regionCode, stateCode, cityCode,approved, dateFrom, dateTo, hreIdList);
	}
	*/
	
	// Util Methods For Data Set********************************************************************************************************************************
	//1. Overview Util Method
	private static OverviewPayload overviewUtil(List<AnalyticsAll> all) {
		
		/*
		 * for (Iterator iterator = all.iterator(); iterator.hasNext();) { AnalyticsAll
		 * a = (AnalyticsAll) iterator.next(); if(a.getFsdmApproval()!=null &&
		 * a.getFsdmApproval().equals("2")) { iterator.remove(); } }
		 */
		List<String> registered=new ArrayList<String>(),assessmet=new ArrayList<String>(),pass =new ArrayList<String>(),offer=new ArrayList<String>(),recruited=new ArrayList<String>();
		for(AnalyticsAll a  : all) {
			if(a.getRegistered()!=null && Integer.valueOf(a.getRegistered())>=1) {
				registered.add(a.getAccesskey());
			}
			if(a.getAssessments()!=null && a.getAssessments().equals("3")) {
				assessmet.add(a.getAccesskey());
			}
			if(a.getPassFailStatus()!=null && a.getPassFailStatus().equals("1")) {
				pass.add(a.getAccesskey());
			}
			if(a.getOfferStatus()!=null && a.getOfferStatus().equalsIgnoreCase("Yes")) {
				offer.add(a.getAccesskey());
			}
			if(a.getRecruitedStatus()!=null && a.getRecruitedStatus().equalsIgnoreCase("Yes")) {
				recruited.add(a.getAccesskey());
			}
		}
		OverviewPayload overview= new OverviewPayload();
		overview.setRegistered(registered);
		overview.setAssessments(assessmet);
		overview.setPass(pass);
		overview.setOffer(offer);
		overview.setRecruited(recruited);
		return overview;
	}
	
	//2. Action Points Util
	private static ActionPointsPayload actionPointsPayloadUtil(List<AnalyticsAll> analyticsAlls) {
		List<String> assessmentStatus=new ArrayList<String>();
		List<String> interviewStatus =new ArrayList<String>();
		List<String> documentUpload =new ArrayList<String>();
		List<String> prarambhStatus =new ArrayList<String>();
		List<String> fsdmApproval =new ArrayList<String>();
		for(AnalyticsAll a : analyticsAlls) {
			if((a.getAssessmentStatus()==null || a.getAssessmentStatus()=="" || !(a.getAssessmentStatus()!=null && a.getAssessmentStatus().equals("3"))) && 
					(a.getRegistered()!=null && Integer.valueOf(a.getRegistered())>=1)) {
				assessmentStatus.add(a.getAccesskey());
			}
//			if(a.getAssessmentStatus().equalsIgnoreCase("Not Completed")) {
//				assessmentStatus.add(a.getAccesskey());
//			}
			if(a.getInterviewStatus().equals("Pending")) {
				interviewStatus.add(a.getAccesskey());
			}
			if(a.getDocumentUploadStatus()!=null &&  a.getDocumentUploadStatus().equals("2")) {
				documentUpload.add(a.getAccesskey());
			}
			
			//Here 1 For Pending and 2 for Completed
//			if(a.getFsdmApproval()!=null && a.getFsdmApproval().equals("3")){
//				fsdmApproval.add(a.getAccesskey());
//			}
		}
		
		ActionPointsPayload ac = new ActionPointsPayload();
		ac.setAssessmentStatus(assessmentStatus);
		ac.setInterviewStatus(interviewStatus);
		ac.setFsdmApproval(fsdmApproval);
		ac.setDocumentUploadStatus(documentUpload);
		ac.setPrarambhStatus(prarambhStatus);
		return ac;
	}
	// 3. Recruitment Source Util
	private static RecruitmentSourcePayload recruitmentSourcePayloadUtil(List<AnalyticsAll> analyticsAlls) {
		List<String> referrals = new ArrayList<String>();
		List<String> directWalk = new ArrayList<String>();
		List<String> advertisement = new ArrayList<String>();
		List<String> jobConsultant = new ArrayList<String>();
		List<String> socialMedia = new ArrayList<String>();
		List<String> others = new ArrayList<String>();
		for(AnalyticsAll analytics : analyticsAlls) {
			if(analytics.getRecSource()!=null) {
			if(analytics.getRecSource().equalsIgnoreCase("Referrals"))
				referrals.add(analytics.getAccesskey());	
			if(analytics.getRecSource().equalsIgnoreCase("Direct Walk-in"))
				directWalk.add(analytics.getAccesskey());		
			if(analytics.getRecSource().equalsIgnoreCase("Advertisement"))
				advertisement.add(analytics.getAccesskey());			
			if(analytics.getRecSource().equalsIgnoreCase("Job Consultant"))
				jobConsultant.add(analytics.getAccesskey());	
			if(analytics.getRecSource().equalsIgnoreCase("Social Media"))
				socialMedia.add(analytics.getAccesskey());	
			if(analytics.getRecSource().equalsIgnoreCase("Others"))
				others.add(analytics.getAccesskey());	
			}}
		RecruitmentSourcePayload rec = new RecruitmentSourcePayload();
		rec.setReferrals((referrals));
		rec.setDirectWalkIn((directWalk));
		rec.setAdvertisement((advertisement));
		rec.setJobConsultant((jobConsultant));
		rec.setSocialMedia((socialMedia));
		rec.setOthers((others));
		return rec;
	}
	//4. Candidate Experience
	private static CandidateExperiencePayload expUtil(List<AnalyticsAll> analyticsAlls) {
		List<String> less3 = new ArrayList<String>();
		List<String> between3To6 = new ArrayList<String>();
		List<String> between6To12 = new ArrayList<String>();
		List<String> between12To24 = new ArrayList<String>();
		List<String> between24To60 = new ArrayList<String>();
		List<String> between60To120 = new ArrayList<String>();
		List<String> more120 = new ArrayList<String>();
		for(AnalyticsAll a: analyticsAlls ) {
			if(a.getCandidateExperience()!=null && a.getCandidateExperience().length()>0 ) {
			if(Integer.valueOf(a.getCandidateExperience())<3)
				less3.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperience())>=3 && Integer.valueOf(a.getCandidateExperience())<6)
				between3To6.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperience())>=6 && Integer.valueOf(a.getCandidateExperience())<12)
				between6To12.add(a.getAccesskey());			
			if(Integer.valueOf(a.getCandidateExperience())>=12 && Integer.valueOf(a.getCandidateExperience())<24)
				between12To24.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperience())>=24 && Integer.valueOf(a.getCandidateExperience())<60)
				between24To60.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperience())>=60 && Integer.valueOf(a.getCandidateExperience())<120)
				between60To120.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperience())>=120)
				more120.add(a.getAccesskey());
		}}
		CandidateExperiencePayload can = new CandidateExperiencePayload();
		can.setLessThan3Months((less3));
		can.setMonths3To6((between3To6));
		can.setMonths6To1Year((between6To12));
		can.setYear1To2Year((between12To24));
		can.setYear2To5Year((between24To60));
		can.setYear5To10Year((between60To120));
		can.setMoreThan10Year((more120));
		return can;
	}
	// 5. Candidate Experience Non Auto Util
	private static CandidateNonAutoExperiencePayload expNonAutoutil(List<AnalyticsAll> analyticsAlls) {
		List<String> less3 = new ArrayList<String>();
		List<String> between3To6 = new ArrayList<String>();
		List<String> between6To12 = new ArrayList<String>();
		List<String> between12To24 = new ArrayList<String>();
		List<String> between24To60 = new ArrayList<String>();
		List<String> between60To120 = new ArrayList<String>();
		List<String> more120 = new ArrayList<String>();
		/*for(AnalyticsAll a: analyticsAlls ) {
			if(a.getCandidateExperienceNonAuto()!=null && a.getCandidateExperienceNonAuto().length()>0) {
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())<3)
				less3.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=3 && Integer.valueOf(a.getCandidateExperienceNonAuto())<6)
				between3To6.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=6 && Integer.valueOf(a.getCandidateExperienceNonAuto())<12)
				between6To12.add(a.getAccesskey());	
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=12 && Integer.valueOf(a.getCandidateExperienceNonAuto())<24)
				between12To24.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=24 && Integer.valueOf(a.getCandidateExperienceNonAuto())<60)
				between24To60.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=60 && Integer.valueOf(a.getCandidateExperienceNonAuto())<120)
				between60To120.add(a.getAccesskey());
			if(Integer.valueOf(a.getCandidateExperienceNonAuto())>=120)
				more120.add(a.getAccesskey());
		}}*/
		CandidateNonAutoExperiencePayload can = new CandidateNonAutoExperiencePayload();
		can.setLessThan3Months((less3));
		can.setMonths3To6((between3To6));
		can.setMonths6To1Year((between6To12));
		can.setYear1To2Year((between12To24));
		can.setYear2To5Year((between24To60));
		can.setYear5To10Year((between60To120));
		can.setMoreThan10Year((more120));
		return can;
	}
	//6. Assessment Report Util
	private static AssessmentReportPayload asmtUtil(List<AnalyticsAll> analyticsAlls) {
		List<String>  less40=new ArrayList<String>();
		List<String>  between40To60=new ArrayList<String>();
		List<String>  between60To80=new ArrayList<String>();
		List<String>  more80=new ArrayList<String>();
		
		for(AnalyticsAll a: analyticsAlls) {
			if(a.getAssessmentReport()!=null && a.getAssessmentReport().length()>0 ) {
			if(Integer.valueOf(a.getAssessmentReport())<40)
				less40.add(a.getAccesskey());
			if(Integer.valueOf(a.getAssessmentReport())>=40 && Integer.valueOf(a.getAssessmentReport())<60)
				between40To60.add(a.getAccesskey());
			if(Integer.valueOf(a.getAssessmentReport())>=60 && Integer.valueOf(a.getAssessmentReport())<80)
				between60To80.add(a.getAccesskey());
			if(Integer.valueOf(a.getAssessmentReport())>=80)
				more80.add(a.getAccesskey());
		}}
		AssessmentReportPayload asmt= new AssessmentReportPayload();
		asmt.setLessThan40((less40));
		asmt.setBetween40To60((between40To60));
		asmt.setBetween60To80((between60To80));
		asmt.setMoreThan80((more80));
		return asmt;
	}
	// 7. Sales Non Sales Util
	private static DesignationTypePayload  desgUtil(List<AnalyticsAll> analyticsAlls) {
		List<String> sales =new ArrayList<String>();
		List<String> nonSales=new ArrayList<String>();
		/*for(AnalyticsAll a:analyticsAlls) {
			if(a.getDesignationType()!=null && a.getDesignationType().length()>0) {
			if(a.getDesignationType().equalsIgnoreCase("Sales"))
				sales.add(a.getAccesskey());
			if(a.getDesignationType().equalsIgnoreCase("Sales Support"))
				nonSales.add(a.getAccesskey());
		}}
		*/
		DesignationTypePayload dsg = new DesignationTypePayload();
		dsg.setSales((sales));
		dsg.setNonSales((nonSales));		
		return dsg;
	}
	// 8. Gender Util
	private static GenderDiversityPayload genderUtil(List<AnalyticsAll> analyticsAlls) {
		List<String> male =new ArrayList<String>();
		List<String> female =new ArrayList<String>();
		List<String> other =new ArrayList<String>();
		for(AnalyticsAll a:analyticsAlls) {
			if(a.getGender()!=null && a.getGender().length()>0) {
			if(a.getGender().equalsIgnoreCase("Male") || a.getGender().equalsIgnoreCase("M"))
				male.add(a.getAccesskey());
			if(a.getGender().equalsIgnoreCase("Female") || a.getGender().equalsIgnoreCase("F"))
				female.add(a.getAccesskey());
			if(a.getGender().equalsIgnoreCase("Other") || a.getGender().equalsIgnoreCase("Transgender") || a.getGender().equalsIgnoreCase("U"))
				other.add(a.getAccesskey());
		}}
		GenderDiversityPayload gender= new GenderDiversityPayload();
		gender.setMale((male));
		gender.setFemale((female));
		gender.setOther((other));
		return gender;
	}
	//9. Age Util
	private static AgeWisePayload ageUtil(List<AnalyticsAll> analyticsAlls) {
		List<String>  less20=new ArrayList<String>();
		List<String>  between20To25=new ArrayList<String>();
		List<String>  between25To30=new ArrayList<String>();
		List<String>  between30To35=new ArrayList<String>();
		List<String>  between35To40=new ArrayList<String>();
		List<String> more40=new ArrayList<String>();
		for(AnalyticsAll a:analyticsAlls) {
			if(a.getAge()!=null && a.getAge().length()>0) {
			if(Integer.valueOf(a.getAge())<20)
				less20.add(a.getAccesskey());
			if(Integer.valueOf(a.getAge())>=20 && Integer.valueOf(a.getAge())<25)
				between20To25.add(a.getAccesskey());
			if(Integer.valueOf(a.getAge())>=25 && Integer.valueOf(a.getAge())<30)
				between25To30.add(a.getAccesskey());
			if(Integer.valueOf(a.getAge())>=30 && Integer.valueOf(a.getAge())<35)
				between30To35.add(a.getAccesskey());
			if(Integer.valueOf(a.getAge())>=35 && Integer.valueOf(a.getAge())<40)
				between35To40.add(a.getAccesskey());
			if(Integer.valueOf(a.getAge())>=40)
				more40.add(a.getAccesskey());
		}}
		AgeWisePayload age = new AgeWisePayload();
		age.setLessThan20((less20));
		age.setBetween20To25((between20To25));
		age.setBetween25To30((between25To30));
		age.setBetween30To35((between30To35));
		age.setBetween35To40((between35To40));
		age.setMoreThan40((more40));
		return age;
	}

	@Override
	public Optional<AnalyticsAll> getAnalyticsByAccesskey(String accessKey,Long hreId, Long pId) {
//		List<AnalyticsAll> alls = analyticsRepo.findAllAnaByAccesskeyhreId(accessKey,hreId);
//		AnalyticsAll ana = new AnalyticsAll();
//		if(alls.size()>=2) {
//			ana=alls.get(0);
//			
//		}
		return analyticsRepo.findByAccesskeyAndhreId(accessKey,hreId, pId);
//		return analyticsRepo.findByAccesskeyAndhreId(accessKey,hreId, pId);
	}
	
	@Override
	public void deleteById(Long id) {
		analyticsRepo.deleteById(id);
		
	}

	

}
