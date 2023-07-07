package com.armezo.duflon.csv;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.armezo.duflon.Entities.City;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Services.CityService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
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
import com.armezo.duflon.analytics.service.AnalyticsAllService;
import com.armezo.duflon.payload.FilterPayload;
import com.armezo.duflon.tc.entities.ModelDashboardAggregate;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class DashboardReport {

	@Autowired
	private HREService hreService;
	@Autowired
	LineManagerServiceImpl lmService;
	@Autowired
	private CityService cityService;
	@Autowired
	private AnalyticsAllService allService;

	// Show Links
	@GetMapping("/showAllLinksCSV")
	public String showLinksForCSV(@RequestParam(name = "dateFromm", required = false) String dateFromm,
			@RequestParam(name = "dateToo", required = false) String dateToo,
			@RequestParam(name = "flag", required = false) String flag, HttpSession session, Model model) {
		if (session.getAttribute("role") != null) {
			Set<HRE> dealers = new LinkedHashSet<>();
			List<Long> hreIdList = new ArrayList<Long>();
			String role = session.getAttribute("role").toString();
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				hreIdList.add(hreId);
			} else {
				List<HRE> hres = hreService.getAllHRE();
				for (HRE hre : hres) {
					hreIdList.add(hre.getId());
					dealers.add(hre);
				}
			}
			// Date YTD wise Data
			LocalDate dateFrom = LocalDate.now();
			LocalDate dateTo = LocalDate.now();
			if (dateFromm != null && dateFromm != "" && dateToo != null && dateToo != "") {
				System.out.println("Date From and to : " + dateFromm + "<>" + dateToo);
				Map<String, LocalDate> fullDate = DataProccessor.manageFiltersDate(dateFromm, dateToo);
				dateFrom = fullDate.get("from");
				dateTo = fullDate.get("to");
			} else {
				LocalDate currentDate = LocalDate.now();
				int currentMonthvalue = currentDate.getMonthValue();
				int yearValue = currentDate.getYear();
				LocalDate yearStartDate = null;
				if (currentMonthvalue < 4) {
					YearMonth yearMonth = YearMonth.of(yearValue - 1, 4);
					yearStartDate = yearMonth.atDay(1);
					// dateFrom =
					// Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				} else {
					YearMonth yearMonth = YearMonth.of(yearValue, 4);
					yearStartDate = yearMonth.atDay(1);
					// dateFrom =
					// Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				}
				dateFrom = yearStartDate;
			}
			// // Aggregate CSV Data
			OverviewPayload overview = allService.getOverviewAnalytics(hreIdList, dateFrom, dateTo);
			ActionPointsPayload action = allService.getActionPending(hreIdList, dateFrom, dateTo);
			RecruitmentSourcePayload source = allService.getRecruitmentSourceAnalytics(hreIdList, dateFrom, dateTo);
			CandidateExperiencePayload exp = allService.getCandidateExpAnalytics(hreIdList, dateFrom, dateTo);
			CandidateNonAutoExperiencePayload nonAuto = allService.getCandidateNonAutoExperience(hreIdList, dateFrom,
					dateTo);
			AssessmentReportPayload assessment = allService.getAssessmentReportAnalytics(hreIdList, dateFrom, dateTo);
			DesignationTypePayload designation = allService.getDesignationTypeAnalytics(hreIdList, dateFrom, dateTo);
			AgeWisePayload age = allService.getAgeWiseAnalytics(hreIdList, dateFrom, dateTo);
			GenderDiversityPayload gender = allService.getGenderAnalytics(hreIdList, dateFrom, dateTo);
			// Aggregates Data
			List<AnalyticsAll> analyticsAlls = allService.getDataByAnyTypeLoginByhreIds(hreIdList, dateFrom, dateTo);
			List<ModelDashboardAggregate> aggregates = getAggregateData(analyticsAlls);
			// Save Same type accesskeyList
			Set<String> overviewSet = new LinkedHashSet<String>();
			overviewSet.addAll(overview.getRegistered());
			overviewSet.addAll(overview.getAssessments());
			overviewSet.addAll(overview.getPass());
			overviewSet.addAll(overview.getOffer());
			overviewSet.addAll(overview.getRecruited());
			Set<String> actionSet = new LinkedHashSet<String>();
			actionSet.addAll(action.getAssessmentStatus());
			actionSet.addAll(action.getInterviewStatus());
			actionSet.addAll(action.getDocumentUploadStatus());
			actionSet.addAll(action.getFsdmApproval());
			Set<String> sourceSet = new LinkedHashSet<String>();
			sourceSet.addAll(source.getAdvertisement());
			sourceSet.addAll(source.getDirectWalkIn());
			sourceSet.addAll(source.getReferrals());
			sourceSet.addAll(source.getJobConsultant());
			sourceSet.addAll(source.getOthers());
			sourceSet.addAll(source.getSocialMedia());
			Set<String> expAutoSet = new LinkedHashSet<String>();
			expAutoSet.addAll(exp.getLessThan3Months());
			expAutoSet.addAll(exp.getMonths3To6());
			expAutoSet.addAll(exp.getMonths6To1Year());
			expAutoSet.addAll(exp.getYear1To2Year());
			expAutoSet.addAll(exp.getYear2To5Year());
			expAutoSet.addAll(exp.getYear5To10Year());
			Set<String> expNonAutoSet = new LinkedHashSet<String>();
			expNonAutoSet.addAll(exp.getLessThan3Months());
			expNonAutoSet.addAll(exp.getMonths3To6());
			expNonAutoSet.addAll(exp.getMonths6To1Year());
			expNonAutoSet.addAll(exp.getYear1To2Year());
			expNonAutoSet.addAll(exp.getYear2To5Year());
			expNonAutoSet.addAll(exp.getYear5To10Year());
			Set<String> assessmentSet = new LinkedHashSet<String>();
			assessmentSet.addAll(assessment.getLessThan40());
			assessmentSet.addAll(assessment.getBetween40To60());
			assessmentSet.addAll(assessment.getBetween60To80());
			assessmentSet.addAll(assessment.getMoreThan80());
			Set<String> desgSet = new LinkedHashSet<String>();
			desgSet.addAll(designation.getSales());
			desgSet.addAll(designation.getNonSales());
			Set<String> ageSet = new LinkedHashSet<String>();
			ageSet.addAll(age.getLessThan20());
			ageSet.addAll(age.getBetween20To25());
			ageSet.addAll(age.getBetween25To30());
			ageSet.addAll(age.getBetween30To35());
			ageSet.addAll(age.getBetween35To40());
			ageSet.addAll(age.getMoreThan40());
			Set<String> genderSet = new LinkedHashSet<String>();
			genderSet.addAll(gender.getMale());
			genderSet.addAll(gender.getFemale());

			// Setting Dashboard Related Data In Model
			model.addAttribute("overview", overview);
			model.addAttribute("action", action);
			model.addAttribute("source", source);
			model.addAttribute("experience", exp);
			model.addAttribute("expNonAuto", nonAuto);
			model.addAttribute("assessment", assessment);
			model.addAttribute("designation", designation);
			model.addAttribute("age", age);
			model.addAttribute("gender", gender);
			// Aggregate Only
			model.addAttribute("aggregates", aggregates);
			// Aggregate CSV Data
			model.addAttribute("overviewSet", overviewSet);
			model.addAttribute("actionSet", actionSet);
			model.addAttribute("sourceSet", sourceSet);
			model.addAttribute("expAutoSet", expAutoSet);
			model.addAttribute("expNonAutoSet", expNonAutoSet);
			model.addAttribute("assessmentSet", assessmentSet);
			model.addAttribute("desgSet", desgSet);
			model.addAttribute("ageSet", ageSet);
			model.addAttribute("genderSet", genderSet);

			// Aggregate All Data of Candidate
			model.addAttribute("overviewAll", getParticipantAllDataByAccesskeyList(overviewSet, "Overview"));
			model.addAttribute("actionAll", getParticipantAllDataByAccesskeyList(actionSet, "Action"));
			model.addAttribute("sourceAll", getParticipantAllDataByAccesskeyList(sourceSet, "Source"));
			model.addAttribute("expAutoAll", getParticipantAllDataByAccesskeyList(expAutoSet, "Auto"));
			model.addAttribute("expNonAutoAll", getParticipantAllDataByAccesskeyList(expNonAutoSet, "NonAuto"));
			model.addAttribute("assessmentAll", getParticipantAllDataByAccesskeyList(assessmentSet, "Assessment"));
			model.addAttribute("desgAll", getParticipantAllDataByAccesskeyList(desgSet, "Designation"));
			model.addAttribute("ageAll", getParticipantAllDataByAccesskeyList(ageSet, "Age"));
			model.addAttribute("genderAll", getParticipantAllDataByAccesskeyList(genderSet, "Gender"));

			// Single Points Data Of Overview
			/*
			 * model.addAttribute("registeredAll",
			 * getParticipantAllDataByAccesskeyList(overview.getRegistered(),
			 * "Registered")); model.addAttribute("asmtAll",
			 * getParticipantAllDataByAccesskeyList(overview.getAssessments(),
			 * "Assessment")); model.addAttribute("passedAll",
			 * getParticipantAllDataByAccesskeyList(overview.getPass(), "Passed"));
			 * model.addAttribute("offeredAll",
			 * getParticipantAllDataByAccesskeyList(overview.getOffer(), "Offered"));
			 * model.addAttribute("recruitedAll",
			 * getParticipantAllDataByAccesskeyList(overview.getRecruited(), "Recruited"));
			 * 
			 * // Single Points Data Of Pending Action Points
			 * model.addAttribute("asmtPendingAll",
			 * getParticipantAllDataByAccesskeyList(action.getAssessmentStatus(),
			 * "Assessment")); model.addAttribute("interviewPendingAll",
			 * getParticipantAllDataByAccesskeyList(action.getInterviewStatus(),
			 * "Interview")); model.addAttribute("documentPendingAll",
			 * getParticipantAllDataByAccesskeyList(action.getDocumentUploadStatus(),
			 * "Document")); model.addAttribute("praraambhPendingAll",
			 * getParticipantAllDataByAccesskeyList(action.getPrarambhStatus(),
			 * "Praraambh")); model.addAttribute("fsdmPendingAll",
			 * getParticipantAllDataByAccesskeyList(action.getFsdmApproval(),
			 * "FSDM Approval")); // Single Points Data Of Recruited Source Points
			 * model.addAttribute("sourceReferrals",
			 * getParticipantAllDataByAccesskeyList(source.getReferrals(), "Referrals"));
			 * model.addAttribute("sourceAdvertisement",
			 * getParticipantAllDataByAccesskeyList(source.getAdvertisement(),
			 * "Advertisement")); model.addAttribute("sourceDirect",
			 * getParticipantAllDataByAccesskeyList(source.getDirectWalkIn(),
			 * "Direct Walk-In")); model.addAttribute("sourceConsultant",
			 * getParticipantAllDataByAccesskeyList(source.getJobConsultant(),
			 * "Job Consultant")); model.addAttribute("sourceSocial",
			 * getParticipantAllDataByAccesskeyList(source.getSocialMedia(),
			 * "Social Media")); model.addAttribute("sourceOtheres",
			 * getParticipantAllDataByAccesskeyList(source.getOthers(), "Otheres")); //
			 * Single Points Data Of Experience Points model.addAttribute("exp",
			 * getParticipantAllDataByAccesskeyList(exp.getLessThan3Months(),
			 * "Less Than 3 Months"));
			 * 
			 */

			// Search Filter Data
			FilterPayload payload = new FilterPayload();
            payload.setDateFrom(dateFromm);
            payload.setDateTo(dateToo);
            model.addAttribute("payload", payload);
			// Flag Data
			model.addAttribute("flag", flag);
			

		} else {
			return "redirect:login";
		}
		return "reports";
	}

	/*
	 * // Dash board Search Filter For reports
	 * 
	 * @PostMapping("/dashboardReportFilter") public String
	 * getDashBoardReportFilterData(@RequestParam("outletCode") String outletCode,
	 * 
	 * @RequestParam("dealershipName") String
	 * dealershipName, @RequestParam("regionCode") String regionCode,
	 * 
	 * @RequestParam("stateCode") String stateCode, @RequestParam("cityCode") String
	 * cityCode, @RequestParam(required = false) String approved,
	 * 
	 * @RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String
	 * dateToo, HttpSession session, Model model) { if (session.getAttribute("role")
	 * != null) { DashboardFilterPayload filterPayload = new
	 * DashboardFilterPayload(); SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy-MM-dd"); Date date1 = null; Date date2 = null; Date
	 * dateFrom = new Date(); Date dateTo = new Date(); try { if (dateFromm != null
	 * && dateFromm != "") { date1 = sdf.parse(dateFromm); } if (dateToo != null &&
	 * dateToo != "") { date2 = sdf.parse(dateToo); date2 =
	 * DataProccessor.addTimeInDate(date2); } } catch (ParseException e) {
	 * e.printStackTrace(); } //YTD Date By Default LocalDate currentDate =
	 * LocalDate.now(); int currentMonthvalue = currentDate.getMonthValue(); int
	 * yearValue = currentDate.getYear(); LocalDate yearStartDate = null; if (date1
	 * != null && date2 != null) { dateFrom = date1; dateTo = date2; } else { if
	 * (currentMonthvalue < 4) { YearMonth yearMonth = YearMonth.of(yearValue - 1,
	 * 4); yearStartDate = yearMonth.atDay(1); dateFrom =
	 * Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant()); }
	 * else { YearMonth yearMonth = YearMonth.of(yearValue, 4); yearStartDate =
	 * yearMonth.atDay(1); dateFrom =
	 * Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant()); }
	 * }
	 * 
	 * if(approved==null || !approved.equals("2")) { approved=""; }
	 * 
	 * 
	 * if (outletCode == null) outletCode = null; if (regionCode == null) {
	 * regionCode = null; } List<HRE> dealers = new ArrayList<>(); List<Outlet>
	 * outlets = new ArrayList<>(); List<Region> regions = new ArrayList<>();
	 * List<State> states = new ArrayList<State>(); List<City> cities = new
	 * ArrayList<City>(); String role = session.getAttribute("role").toString();
	 * List<Long> hreIdList = new ArrayList<Long>(); Long dId = null; if
	 * (role.equalsIgnoreCase("HRE")) { dId =
	 * Long.parseLong(session.getAttribute("userId").toString()); Optional<HRE> dl =
	 * dealerService.getById(dId); List<Outlet> ot = outletService.findByhreId(dId);
	 * HashMap<Region, Region> outletMap = new HashMap<Region, Region>(); for
	 * (Outlet o : ot) { outlets.add(o); outletMap.put(o.getRegion(),
	 * o.getRegion()); states.add(o.getState()); cities.add(o.getCity()); }
	 * 
	 * for (Entry<Region, Region> eo : outletMap.entrySet()) {
	 * regions.add(eo.getValue()); } dealers.add(dl.get()); hreIdList.add(dId); }
	 * else if (role.equalsIgnoreCase("LM")) { int fsdmId =
	 * Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) { regions.add(r); List<Outlet> outletList =
	 * outletService.getOutletByRegion(r.getId()); for (Outlet outlet : outletList)
	 * { hreIdList.add(outlet.getDealer().getId()); dealers.add(outlet.getDealer());
	 * outlets.add(outlet); states.add(outlet.getState());
	 * cities.add(outlet.getCity()); } } } else if (role.equalsIgnoreCase("HO") ||
	 * role.equalsIgnoreCase("SA")) { List<HRE> deal =
	 * dealerService.getAllDeealer(); regions.addAll(regionService.getAllRegion());
	 * outlets.addAll(outletService.getAllOutlets()); dealers.addAll(deal);
	 * states.addAll(stateService.getAllState());
	 * cities.addAll(cityService.getAllCity()); for (Dealer dealer : deal) {
	 * hreIdList.add(dealer.getId()); } }
	 * 
	 * List<String> searchOutlets = new ArrayList<>(); if(dealershipName!=null &&
	 * dealershipName!="") { searchOutlets= new ArrayList<>(); List<Outlet>
	 * searchOutlets2=outletService.getByOutletName(dealershipName);
	 * searchOutlets2.stream().map(Outlet::
	 * getOutletCode).forEachOrdered(searchOutlets::add); }else { List<Outlet>
	 * outlets6 = new ArrayList<>(); for(Long id : hreIdList) {
	 * outlets6.addAll(outletService.getOutletByhreId(id)); }
	 * outlets6.stream().map(Outlet::getOutletCode).forEachOrdered(searchOutlets::
	 * add); }
	 * 
	 * // Use Search Criteria // Get Outlet First By Search OverviewPayload overview
	 * = allService.getOverviewAnalytics(outletCode, searchOutlets, regionCode,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * ActionPointsPayload action = allService.getActionPending(outletCode,
	 * searchOutlets, regionCode, stateCode, cityCode, approved, dateFrom, dateTo,
	 * hreIdList); RecruitmentSourcePayload source =
	 * allService.getRecruitmentSourceAnalytics(outletCode, searchOutlets,
	 * regionCode, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * CandidateExperiencePayload exp =
	 * allService.getCandidateExpAnalytics(outletCode, searchOutlets, regionCode,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * CandidateNonAutoExperiencePayload nonAuto =
	 * allService.getCandidateNonAutoExperience(outletCode, searchOutlets,
	 * regionCode, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * AssessmentReportPayload assessment =
	 * allService.getAssessmentReportAnalytics(outletCode, searchOutlets,
	 * regionCode, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * DesignationTypePayload designation =
	 * allService.getDesignationTypeAnalytics(outletCode, searchOutlets, regionCode,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList); AgeWisePayload
	 * age = allService.getAgeWiseAnalytics(outletCode, searchOutlets, regionCode,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * GenderDiversityPayload gender = allService.getGenderAnalytics(outletCode,
	 * searchOutlets, regionCode, stateCode, cityCode, approved, dateFrom, dateTo,
	 * hreIdList); //Get All Analytics List<AnalyticsAll> analyticsAlls =
	 * allService.getDataByAnyTypeLoginByhreIds(outletCode,searchOutlets,regionCode,
	 * stateCode,cityCode, approved, hreIdList,dateFrom,dateTo); //Only Aggregate
	 * Data List<ModelDashboardAggregate> aggregates =
	 * getAggregateData(analyticsAlls);
	 * 
	 * // Save Same type accesskeyList Set<String> overviewSet = new
	 * LinkedHashSet<String>(); overviewSet.addAll(overview.getRegistered());
	 * overviewSet.addAll(overview.getAssessments());
	 * overviewSet.addAll(overview.getPass());
	 * overviewSet.addAll(overview.getOffer());
	 * overviewSet.addAll(overview.getRecruited()); Set<String> actionSet = new
	 * LinkedHashSet<String>(); actionSet.addAll(action.getAssessmentStatus());
	 * actionSet.addAll(action.getInterviewStatus());
	 * actionSet.addAll(action.getDocumentUploadStatus());
	 * actionSet.addAll(action.getPrarambhStatus());
	 * actionSet.addAll(action.getFsdmApproval()); Set<String> sourceSet = new
	 * LinkedHashSet<String>(); sourceSet.addAll(source.getAdvertisement());
	 * sourceSet.addAll(source.getDirectWalkIn());
	 * sourceSet.addAll(source.getReferrals());
	 * sourceSet.addAll(source.getJobConsultant());
	 * sourceSet.addAll(source.getOthers());
	 * sourceSet.addAll(source.getSocialMedia()); Set<String> expAutoSet = new
	 * LinkedHashSet<String>(); expAutoSet.addAll(exp.getLessThan3Months());
	 * expAutoSet.addAll(exp.getMonths3To6());
	 * expAutoSet.addAll(exp.getMonths6To1Year());
	 * expAutoSet.addAll(exp.getYear1To2Year());
	 * expAutoSet.addAll(exp.getYear2To5Year());
	 * expAutoSet.addAll(exp.getYear5To10Year()); Set<String> expNonAutoSet = new
	 * LinkedHashSet<String>(); expNonAutoSet.addAll(exp.getLessThan3Months());
	 * expNonAutoSet.addAll(exp.getMonths3To6());
	 * expNonAutoSet.addAll(exp.getMonths6To1Year());
	 * expNonAutoSet.addAll(exp.getYear1To2Year());
	 * expNonAutoSet.addAll(exp.getYear2To5Year());
	 * expNonAutoSet.addAll(exp.getYear5To10Year()); Set<String> assessmentSet = new
	 * LinkedHashSet<String>(); assessmentSet.addAll(assessment.getLessThan40());
	 * assessmentSet.addAll(assessment.getBetween40To60());
	 * assessmentSet.addAll(assessment.getBetween60To80());
	 * assessmentSet.addAll(assessment.getMoreThan80()); Set<String> desgSet = new
	 * LinkedHashSet<String>(); desgSet.addAll(designation.getSales());
	 * desgSet.addAll(designation.getNonSales()); Set<String> ageSet = new
	 * LinkedHashSet<String>(); ageSet.addAll(age.getLessThan20());
	 * ageSet.addAll(age.getBetween20To25()); ageSet.addAll(age.getBetween25To30());
	 * ageSet.addAll(age.getBetween30To35()); ageSet.addAll(age.getBetween35To40());
	 * ageSet.addAll(age.getMoreThan40()); Set<String> genderSet = new
	 * LinkedHashSet<String>(); genderSet.addAll(gender.getMale());
	 * genderSet.addAll(gender.getFemale());
	 * 
	 * // Setting Dashboard Related Data In Model model.addAttribute("overview",
	 * overview); model.addAttribute("action", action); model.addAttribute("source",
	 * source); model.addAttribute("experience", exp);
	 * model.addAttribute("expNonAuto", nonAuto); model.addAttribute("assessment",
	 * assessment); model.addAttribute("designation", designation);
	 * model.addAttribute("age", age); model.addAttribute("gender", gender);
	 * 
	 * // Aggregate CSV Data model.addAttribute("overviewSet", overviewSet);
	 * model.addAttribute("actionSet", actionSet); model.addAttribute("sourceSet",
	 * sourceSet); model.addAttribute("expAutoSet", expAutoSet);
	 * model.addAttribute("expNonAutoSet", expNonAutoSet);
	 * model.addAttribute("assessmentSet", assessmentSet);
	 * model.addAttribute("desgSet", desgSet); model.addAttribute("ageSet", ageSet);
	 * model.addAttribute("genderSet", genderSet);
	 * 
	 * // Aggregate All Data of Candidate model.addAttribute("overviewAll",
	 * getParticipantAllDataByAccesskeyList(overviewSet, "Overview"));
	 * model.addAttribute("actionAll",
	 * getParticipantAllDataByAccesskeyList(actionSet, "Action"));
	 * model.addAttribute("sourceAll",
	 * getParticipantAllDataByAccesskeyList(sourceSet, "Source"));
	 * model.addAttribute("expAutoAll",
	 * getParticipantAllDataByAccesskeyList(expAutoSet, "Auto"));
	 * model.addAttribute("expNonAutoAll",
	 * getParticipantAllDataByAccesskeyList(expNonAutoSet, "NonAuto"));
	 * model.addAttribute("assessmentAll",
	 * getParticipantAllDataByAccesskeyList(assessmentSet, "Assessment"));
	 * model.addAttribute("desgAll", getParticipantAllDataByAccesskeyList(desgSet,
	 * "Designation")); model.addAttribute("ageAll",
	 * getParticipantAllDataByAccesskeyList(ageSet, "Age"));
	 * model.addAttribute("genderAll",
	 * getParticipantAllDataByAccesskeyList(genderSet, "Gender")); //Aggregates
	 * model.addAttribute("aggregates", aggregates);
	 * 
	 * // For Search filterPayload.setDealershipCode(dealershipName);
	 * filterPayload.setRegionCode(regionCode);
	 * filterPayload.setStateCode(stateCode); filterPayload.setCityCode(cityCode);
	 * filterPayload.setOutletCode(outletCode);
	 * filterPayload.setDateFrom(dateFromm); filterPayload.setDateTo(dateToo);
	 * if(approved!=null && approved.equals("2")) { filterPayload.setApproved(2);
	 * }else { filterPayload.setApproved(0); } List<HRE> dealers2 =
	 * dealers.stream().sorted((d1, d2) ->
	 * d1.getName().compareToIgnoreCase(d2.getName()))
	 * .collect(Collectors.toList()); List<Region> regions2 = regions.stream()
	 * .sorted((r1, r2) ->
	 * r1.getRegionCode().compareToIgnoreCase(r2.getRegionCode()))
	 * .collect(Collectors.toList()); List<State> states2 = states.stream()
	 * .sorted((s1, s2) -> s1.getStateName().compareToIgnoreCase(s2.getStateName()))
	 * .collect(Collectors.toList()); List<City> cities2 = cities.stream()
	 * .sorted((c1, c2) -> c1.getCityName().compareToIgnoreCase(c2.getCityName()))
	 * .collect(Collectors.toList()); List<Outlet> outlets2 = outlets.stream()
	 * .sorted((o1, o2) ->
	 * o1.getOutletName().compareToIgnoreCase(o2.getOutletName()))
	 * .collect(Collectors.toList());
	 * 
	 * List<Outlet> outlets3 = new ArrayList<>(); String temp=""; for(Outlet
	 * o:outlets2) { if(temp.equals(o.getOutletName())) { continue; }else { temp =
	 * o.getOutletName(); outlets3.add(o); } }
	 * 
	 * model.addAttribute("dealers", dealers2); model.addAttribute("regions",
	 * regions2); model.addAttribute("states", states2);
	 * model.addAttribute("cities", cities2); model.addAttribute("dealerCodeList",
	 * outlets2); model.addAttribute("dealerShipList", outlets3);
	 * model.addAttribute("payload", filterPayload);
	 * DataProccessor.setDateRange(model);
	 * 
	 * } else { return "redirect:login"; } return "reports"; }
	 */
	// Get Aggregate Data
	private List<ModelDashboardAggregate> getAggregateData(List<AnalyticsAll> analyticsAlls) {
		List<ModelDashboardAggregate> aggregates = new ArrayList<ModelDashboardAggregate>();
		Collections.sort(analyticsAlls, (a1, a2) -> a1.getModifiedDate().compareTo(a2.getModifiedDate()));
		for (AnalyticsAll analytics : analyticsAlls) {
			ModelDashboardAggregate aggregate = new ModelDashboardAggregate();
			String name = "";
			name = analytics.getFirstName();
			if (analytics.getMiddleName() != null) {
				name += " " + analytics.getMiddleName();
			}
			name += " " + analytics.getLastName();
			aggregate.setName(name);
			// Setting Outlet Related Data
			// get city name by city code
			Optional<City> cityOptional = cityService.getCityByCityCode(analytics.getCity());
			if (cityOptional.isPresent()) {
				aggregate.setDealerCity(cityOptional.get().getCityName());
			} else {
				aggregate.setDealerCity("");
			}
			aggregate.setDealership(analytics.getHreName());
			if (analytics.getDesignation() != null) {
				aggregate.setProfile(analytics.getDesignation());
			} else {
				aggregate.setProfile("");
			}
			aggregate.setMobile(analytics.getMobile());
			if (analytics.getRegistrationDate() != null) {
				aggregate.setRegistrationDate(DataProccessor.csvDateFormatting(analytics.getRegistrationDate()));
			}
			if (analytics.getAssessmentDate() != null) {
				aggregate.setAssessmentDate(DataProccessor.csvDateFormatting(analytics.getAssessmentDate()));
			}
			aggregate.setTestScore(analytics.getMarksObtained());
			if (analytics.getPassFailStatus() != null && analytics.getPassFailStatus() != "") {
				aggregate.setPassFailStatus(Integer.valueOf(analytics.getPassFailStatus()));
			}
			aggregate.setFinalDesignationCode(analytics.getDesignation());
			aggregate.setAccesskey(analytics.getAccesskey());
			aggregate.setOverview(getStatus(analytics, "Overview"));
			aggregate.setActionPoints(getStatus(analytics, "Action"));
			aggregate.setRecruitmentSource(getStatus(analytics, "Source"));
			aggregate.setSalesNonSales(getStatus(analytics, "Designation"));
			aggregate.setGender(getStatus(analytics, "Gender"));
			aggregate.setExpAuto(getStatus(analytics, "Auto"));
			aggregate.setExpNonAuto(getStatus(analytics, "NonAuto"));
			aggregate.setAgeWise(getStatus(analytics, "Age"));
			aggregate.setAssessmentReport(getStatus(analytics, "Assessment"));
			aggregates.add(aggregate);
		}
		return aggregates;
	}

	// Get Analytics All Data By Accesskey List
	public List<ModelParticpantView> getParticipantAllDataByAccesskeyList(List<String> accesskeyList, String status) {
		List<ModelParticpantView> mpvList = new ArrayList<ModelParticpantView>();
		List<AnalyticsAll> list = allService.getAllAnalyticsByAccesskeyList(accesskeyList);
		Collections.sort(list, (o1, o2) -> o2.getRegistrationDate().compareTo(o1.getRegistrationDate()));
		for (AnalyticsAll a : list) {
			ModelParticpantView mpv = new ModelParticpantView();
			String name = "";
			name = a.getFirstName();
			if (a.getMiddleName() != null) {
				name += " " + a.getMiddleName();
			}
			name += " " + a.getLastName();
			mpv.setParticipantName(name);
			// Setting Outlet Related Data
			// get city name by city code
			Optional<City> cityOptional = cityService.getCityByCityCode(a.getCity());
			if (cityOptional.isPresent()) {
				mpv.setCity(cityOptional.get().getCityName());
			} else {
				mpv.setCity("");
			}
			mpv.setHreName(a.getHreName());
			mpv.setDesignation(a.getDesignation());
			mpv.setMobile(a.getMobile());
			mpv.setAccesskey(a.getAccesskey());
			mpv.setFinalDesignationCode(a.getDesignation());
			if (a.getRegistrationDate() != null) {
				mpv.setDateOfRegistration(DataProccessor.csvDateFormatting(a.getRegistrationDate()));
			}
			if (a.getAssessmentDate() != null) {
				mpv.setAssessment_Completion_date(DataProccessor.csvDateFormatting(a.getAssessmentDate()));
			}
			mpv.setTestScore(a.getMarksObtained());
			if (a.getPassFailStatus() != null && a.getPassFailStatus() != "") {
				mpv.setPassFailStatus(Integer.valueOf(a.getPassFailStatus()));
			}
			mpv.setStatus(getStatus(a, status));
			if (status.equalsIgnoreCase("Auto")) {
				mpv.setExpAutoStatus(getStatus(a, status));
				mpv.setExpNonAutoStatus(getStatus(a, "NonAuto"));
			}
			mpvList.add(mpv);

		}
		return mpvList;
	}

	public List<ModelParticpantView> getParticipantAllDataByAccesskeyList(Set<String> accesskeyList, String status) {
		List<ModelParticpantView> mpvList = new ArrayList<ModelParticpantView>();
		List<String> acckeyList2 = new ArrayList<String>();
		acckeyList2.addAll(accesskeyList);
		List<AnalyticsAll> list = new ArrayList<AnalyticsAll>();
		if (acckeyList2 != null) {
			list = allService.getAllAnalyticsByAccesskeyList(acckeyList2);
		}
		Collections.sort(list, (o1, o2) -> o2.getModifiedDate().compareTo(o1.getModifiedDate()));
		for (AnalyticsAll a : list) {
			ModelParticpantView mpv = new ModelParticpantView();
			String name = "";
			name = a.getFirstName();
			if (a.getMiddleName() != null) {
				name += " " + a.getMiddleName();
			}
			name += " " + a.getLastName();
			mpv.setParticipantName(name);
			// Setting Outlet Related Data
			// get city name by city code
			Optional<City> cityOptional = cityService.getCityByCityCode(a.getCity());
			if (cityOptional.isPresent()) {
				mpv.setCity(cityOptional.get().getCityName());
			} else {
				mpv.setCity("");
			}
			mpv.setHreName(a.getHreName());
			mpv.setDesignation(a.getDesignation());
			mpv.setMobile(a.getMobile());
			mpv.setAccesskey(a.getAccesskey());
			mpv.setFinalDesignationCode(a.getDesignation());
			if (a.getRegistrationDate() != null) {
				mpv.setDateOfRegistration(DataProccessor.csvDateFormatting(a.getRegistrationDate()));
			}
			if (a.getAssessmentDate() != null) {
				mpv.setAssessment_Completion_date(DataProccessor.csvDateFormatting(a.getAssessmentDate()));
			}
			mpv.setTestScore(a.getMarksObtained());
			if (a.getPassFailStatus() != null && a.getPassFailStatus() != "") {
				mpv.setPassFailStatus(Integer.valueOf(a.getPassFailStatus()));
			}
			mpv.setStatus(getStatus(a, status));
			if (status.equalsIgnoreCase("Auto")) {
				mpv.setExpAutoStatus(getStatus(a, status));
				mpv.setExpNonAutoStatus(getStatus(a, "NonAuto"));
			}

			mpvList.add(mpv);

		}
		return mpvList;
	}

	// Get Status
	// Based on Status adding Status
	public String getStatus(AnalyticsAll a, String status) {
		String newStatus = "";
		if (status.equalsIgnoreCase("Overview")) {
			if (a.getRegistered() != null && Integer.valueOf(a.getRegistered()) >= 1) {
				newStatus = "Registered";
			}
			if (a.getAssessments() != null && a.getAssessments().equals("3")) {
				newStatus = "Assessment";
			}
			if (a.getPassFailStatus() != null && a.getPassFailStatus().equals("1")) {
				newStatus = "Passed";
			}
			if (a.getOfferStatus() != null && a.getOfferStatus().equalsIgnoreCase("Yes")) {
				newStatus = "Offered";
			}
			if (a.getRecruitedStatus() != null && a.getRecruitedStatus().equalsIgnoreCase("Yes")) {
				newStatus = "Recruited";
			}
		} else if (status.equalsIgnoreCase("Action")) {
			if ((a.getAssessmentStatus() == null || a.getAssessmentStatus() == ""
					|| !(a.getAssessmentStatus() != null && a.getAssessmentStatus().equals("3")))
					&& (a.getRegistered() != null && Integer.valueOf(a.getRegistered()) >= 1)) {
				newStatus = "Assessment";
			}
			if (a.getInterviewStatus().equals("Pending")) {
				newStatus = "Interview";
			}
			if (a.getDocumentUploadStatus() != null && a.getDocumentUploadStatus().equals("2")) {
				newStatus = "Document";
			}
			if (a.getHiredStatus() != null && a.getHiredStatus().equalsIgnoreCase("Y")) {
				newStatus = "Approval";
			}
		} else if (status.equalsIgnoreCase("Source")) {
			if (a.getRecSource() != null) {
				if (a.getRecSource().equalsIgnoreCase("Referrals"))
					newStatus = "Referrals";
				if (a.getRecSource().equalsIgnoreCase("Direct Walk-in"))
					newStatus = "Direct Walk-in";
				if (a.getRecSource().equalsIgnoreCase("Advertisement"))
					newStatus = "Advertisement";
				if (a.getRecSource().equalsIgnoreCase("Job Consultant"))
					newStatus = "Job Consultant";
				if (a.getRecSource().equalsIgnoreCase("Social Media"))
					newStatus = "Social Media";
				if (a.getRecSource().equalsIgnoreCase("Others"))
					newStatus = "Others";
			}
		} else if (status.equalsIgnoreCase("Auto")) {
			if (a.getCandidateExperience() != null && a.getCandidateExperience().length() > 0) {
				if ( Double.valueOf(a.getCandidateExperience())>0 && Double.valueOf(a.getCandidateExperience()) < 3)
					newStatus = "Between 0-3 Months";
				if (Double.valueOf(a.getCandidateExperience()) >= 3 && Double.valueOf(a.getCandidateExperience()) < 6)
					newStatus = "Between 3-6 Months";
				if (Double.valueOf(a.getCandidateExperience()) >= 6 && Double.valueOf(a.getCandidateExperience()) < 12)
					newStatus = "Between 6-12 Months";
				if (Double.valueOf(a.getCandidateExperience()) >= 12 && Double.valueOf(a.getCandidateExperience()) < 24)
					newStatus = "Between 1-2 Years";
				if (Double.valueOf(a.getCandidateExperience()) >= 24 && Double.valueOf(a.getCandidateExperience()) < 60)
					newStatus = "Between 2-5 Years";
				if (Double.valueOf(a.getCandidateExperience()) >= 60
						&& Double.valueOf(a.getCandidateExperience()) < 120)
					newStatus = "Between 5-10 Years";
				if (Double.valueOf(a.getCandidateExperience()) >= 120)
					newStatus = "More Than 10 Years";
			}
		} else if (status.equalsIgnoreCase("Assessment")) {
			if (a.getAssessmentReport() != null && a.getAssessmentReport().length() > 0) {
				if (Integer.valueOf(a.getAssessmentReport()) < 40)
					newStatus = "Less than 40";
				if (Integer.valueOf(a.getAssessmentReport()) >= 40 && Integer.valueOf(a.getAssessmentReport()) < 60)
					newStatus = "Between 40-60";
				if (Integer.valueOf(a.getAssessmentReport()) >= 60 && Integer.valueOf(a.getAssessmentReport()) < 80)
					newStatus = "Between 60-80";
				if (Integer.valueOf(a.getAssessmentReport()) > 80)
					newStatus = "More than 80";
			}
		} else if (status.equalsIgnoreCase("Designation")) {
			if (a.getDesignation() != null && a.getDesignation().length() > 0) {
				if (a.getDesignation().equalsIgnoreCase("Manager"))
					newStatus = "Manager";
				if (a.getDesignation().equalsIgnoreCase("Sales Support"))
					newStatus = "Sales Support";
			}
		} else if (status.equalsIgnoreCase("Gender")) {
			if (a.getGender() != null && a.getGender().length() > 0) {
				if (a.getGender().equalsIgnoreCase("Male") || a.getGender().equalsIgnoreCase("M"))
					newStatus = "Male";
				if (a.getGender().equalsIgnoreCase("Female") || a.getGender().equalsIgnoreCase("F"))
					newStatus = "Female";
				if (a.getGender().equalsIgnoreCase("Other") || a.getGender().equalsIgnoreCase("Transgender")
						|| a.getGender().equalsIgnoreCase("U"))
					newStatus = "Others";
			}
		} else if (status.equalsIgnoreCase("Age")) {
			if (a.getAge() != null && a.getAge().length() > 0) {
				if (Integer.valueOf(a.getAge()) < 20)
					newStatus = "Between 18-20";
				if (Integer.valueOf(a.getAge()) >= 20 && Integer.valueOf(a.getAge()) < 25)
					newStatus = "Between 20-25";
				if (Integer.valueOf(a.getAge()) >= 25 && Integer.valueOf(a.getAge()) < 30)
					newStatus = "Between 25-30";
				if (Integer.valueOf(a.getAge()) >= 30 && Integer.valueOf(a.getAge()) < 35)
					newStatus = "Between 30-35";
				if (Integer.valueOf(a.getAge()) >= 35 && Integer.valueOf(a.getAge()) < 40)
					newStatus = "Between 35-40";
				if (Integer.valueOf(a.getAge()) >= 40)
					newStatus = "More than 40";
			}
		}
		return newStatus;
	}
	/*
	 * // Dashboard CSV Report
	 * 
	 * @PostMapping("/dashboardCSVReport") public ResponseEntity<?>
	 * generateDashboardReport(@RequestParam("outletCode") String outletCode,
	 * 
	 * @RequestParam("dealershipName") String
	 * dealershipName, @RequestParam("regionCode") String regionCode,
	 * 
	 * @RequestParam("stateCode") String stateCode, @RequestParam("cityCode") String
	 * cityCode, @RequestParam("approved") String approved,
	 * 
	 * @RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String
	 * dateToo, HttpSession session) throws FileNotFoundException { if
	 * (session.getAttribute("userId") != null) { List<Long> hreIdList = new
	 * ArrayList<>(); Set<Region> regions = new LinkedHashSet<Region>(); String role
	 * = session.getAttribute("role").toString(); SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy-MM-dd"); Date date1 = null; Date date2 = null; Date
	 * dateFrom = new Date(); Date dateTo = new Date(); try { if (dateFromm != null
	 * && dateFromm != "") { date1 = sdf.parse(dateFromm); } if (dateToo != null &&
	 * dateToo != "") { date2 = sdf.parse(dateToo); date2 =
	 * DataProccessor.addTimeInDate(date2); } } catch (ParseException e) {
	 * e.printStackTrace(); } //YTD Date By Default LocalDate currentDate =
	 * LocalDate.now(); int currentMonthvalue = currentDate.getMonthValue(); int
	 * yearValue = currentDate.getYear(); LocalDate yearStartDate = null; if (date1
	 * != null && date2 != null) { dateFrom = date1; dateTo = date2; } else { if
	 * (currentMonthvalue < 4) { YearMonth yearMonth = YearMonth.of(yearValue - 1,
	 * 4); yearStartDate = yearMonth.atDay(1); dateFrom =
	 * Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant()); }
	 * else { YearMonth yearMonth = YearMonth.of(yearValue, 4); yearStartDate =
	 * yearMonth.atDay(1); dateFrom =
	 * Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant()); }
	 * } // Checkbox value change if(approved==null || !approved.equals("2")) {
	 * approved=""; } // get dealer id list Set<Outlet> outlets = new
	 * LinkedHashSet<Outlet>(); if (role.equalsIgnoreCase("HRE")) { Long hreId =
	 * Long.parseLong(session.getAttribute("userId").toString()); List<Outlet> out =
	 * outletService.getOutletByhreId(hreId); outlets.addAll(out);
	 * out.stream().map(Outlet::getRegion).forEachOrdered(regions::add);
	 * hreIdList.add(hreId); } else if (role.equalsIgnoreCase("LM")) { int fsdmId =
	 * Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) { regions.add(r); List<Outlet> outletList =
	 * outletService.getOutletByRegion(r.getId()); for (Outlet outlet : outletList)
	 * { outlets.add(outlet); hreIdList.add(outlet.getDealer().getId()); } } } else
	 * if (role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) { List<HRE>
	 * dealers = dealerService.getAllDeealer();
	 * regions.addAll(regionService.getAllRegion());
	 * dealers.stream().map(Dealer::getId).forEachOrdered(hreIdList::add); }
	 * List<Region> regionList = new ArrayList<Region>(); // Check region Code if
	 * (regionCode != null && regionCode != "") { Optional<Region> region =
	 * regionService.getReagion(regionCode); if (region.isPresent()) {
	 * regionList.add(region.get()); } } else { regionList.addAll(regions); }
	 * List<String> searchOutlets = new ArrayList<>(); if(dealershipName!=null &&
	 * dealershipName!="") { searchOutlets= new ArrayList<>(); List<Outlet>
	 * searchOutlets2=outletService.getByOutletName(dealershipName);
	 * searchOutlets2.stream().map(Outlet::
	 * getOutletCode).forEachOrdered(searchOutlets::add); }else { List<Outlet>
	 * outlets6 = new ArrayList<>(); for(Long id : hreIdList) {
	 * outlets6.addAll(outletService.getOutletByhreId(id)); }
	 * outlets6.stream().map(Outlet::getOutletCode).forEachOrdered(searchOutlets::
	 * add); }
	 * 
	 * 
	 * XSSFWorkbook workbook = new XSSFWorkbook(); XSSFSheet sheet =
	 * workbook.createSheet("DashboardReport"); XSSFCellStyle style =
	 * workbook.createCellStyle(); //
	 * style.setFillBackgroundColor(IndexedColors.BRIGHT_GREEN.getIndex()); //
	 * style.setFillPattern(FillPatternType.BIG_SPOTS); XSSFFont font =
	 * workbook.createFont(); font.setBold(true); style.setFont(font);
	 * 
	 * Row row = null; row = sheet.createRow(0); Cell cell = null; cell =
	 * row.createCell(0); cell.setCellValue("Bird View"); cell = row.createCell(1);
	 * cell.setCellValue("Overview"); cell.setCellStyle(style); cell =
	 * row.createCell(2); cell.setCellValue("Overview"); sheet.addMergedRegion(new
	 * CellRangeAddress(0, 0, 1, 5)); cell = row.createCell(3);
	 * cell.setCellValue("Overview"); cell = row.createCell(4);
	 * cell.setCellValue("Overview"); cell = row.createCell(5);
	 * cell.setCellValue("Overview"); cell = row.createCell(6);
	 * cell.setCellValue("Action Points"); cell = row.createCell(7);
	 * cell.setCellValue("Action Points"); sheet.addMergedRegion(new
	 * CellRangeAddress(0, 0, 6, 10)); cell = row.createCell(8);
	 * cell.setCellValue("Action Points"); cell = row.createCell(9);
	 * cell.setCellValue("Action Points"); cell = row.createCell(10);
	 * cell.setCellValue("Action Points"); cell = row.createCell(11);
	 * cell.setCellValue("Recruitment Source"); cell = row.createCell(12);
	 * cell.setCellValue("Recruitment Source"); sheet.addMergedRegion(new
	 * CellRangeAddress(0, 0, 11, 16)); cell = row.createCell(13);
	 * cell.setCellValue("Recruitment Source"); cell = row.createCell(14);
	 * cell.setCellValue("Recruitment Source"); cell = row.createCell(15);
	 * cell.setCellValue("Recruitment Source"); cell = row.createCell(16);
	 * cell.setCellValue("Recruitment Source"); cell = row.createCell(17);
	 * cell.setCellValue("Profile"); sheet.addMergedRegion(new CellRangeAddress(0,
	 * 0, 17, 18)); cell = row.createCell(18); cell.setCellValue("Profile"); cell =
	 * row.createCell(19); cell.setCellValue("Gender Diversity");
	 * sheet.addMergedRegion(new CellRangeAddress(0, 0, 19, 20)); cell =
	 * row.createCell(20); cell.setCellValue("Gender Diversity"); cell =
	 * row.createCell(21); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(22); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(23); cell.setCellValue("Auto Industry Experience");
	 * sheet.addMergedRegion(new CellRangeAddress(0, 0, 21, 27)); cell =
	 * row.createCell(24); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(25); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(26); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(27); cell.setCellValue("Auto Industry Experience"); cell =
	 * row.createCell(28); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(29); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(30); cell.setCellValue("Non-Auto Industry Experience");
	 * sheet.addMergedRegion(new CellRangeAddress(0, 0, 28, 34)); cell =
	 * row.createCell(31); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(32); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(33); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(34); cell.setCellValue("Non-Auto Industry Experience"); cell =
	 * row.createCell(35); cell.setCellValue("Age Wise"); cell = row.createCell(36);
	 * cell.setCellValue("Age Wise"); sheet.addMergedRegion(new CellRangeAddress(0,
	 * 0, 35, 40)); cell = row.createCell(37); cell.setCellValue("Age Wise"); cell =
	 * row.createCell(38); cell.setCellValue("Age Wise"); cell = row.createCell(39);
	 * cell.setCellValue("Age Wise"); cell = row.createCell(40);
	 * cell.setCellValue("Age Wise"); cell = row.createCell(41);
	 * cell.setCellValue("Assessment Report"); cell = row.createCell(42);
	 * cell.setCellValue("Assessment Report"); sheet.addMergedRegion(new
	 * CellRangeAddress(0, 0, 41, 44)); cell = row.createCell(43);
	 * cell.setCellValue("Assessment Report"); cell = row.createCell(44);
	 * cell.setCellValue("Assessment Report");
	 * 
	 * for (int i = 0; i < row.getLastCellNum(); i++) {// For each cell in the row
	 * row.getCell(i).setCellStyle(style);// Set the style }
	 * 
	 * // 2nd Headers row = sheet.createRow(1); cell = row.createCell(0);
	 * if(role.equalsIgnoreCase("DL")) { cell.setCellValue("Dealership"); }else {
	 * cell.setCellValue("Regions"); } cell = row.createCell(1);
	 * cell.setCellValue("Registered"); cell = row.createCell(2);
	 * cell.setCellValue("Assessment"); cell = row.createCell(3);
	 * cell.setCellValue("Passed"); cell = row.createCell(4);
	 * cell.setCellValue("Offered"); cell = row.createCell(5);
	 * cell.setCellValue("Recruited"); cell = row.createCell(6);
	 * cell.setCellValue("Assessment"); cell = row.createCell(7);
	 * cell.setCellValue("Interview"); cell = row.createCell(8);
	 * cell.setCellValue("Documents"); cell = row.createCell(9);
	 * cell.setCellValue("Praarambh"); cell = row.createCell(10);
	 * cell.setCellValue("FSDM Approval"); cell = row.createCell(11);
	 * cell.setCellValue("Referrals"); cell = row.createCell(12);
	 * cell.setCellValue("Direct Walk In"); cell = row.createCell(13);
	 * cell.setCellValue("Advertisement"); cell = row.createCell(14);
	 * cell.setCellValue("Job Consultant"); cell = row.createCell(15);
	 * cell.setCellValue("Social Media"); cell = row.createCell(16);
	 * cell.setCellValue("Other"); cell = row.createCell(17);
	 * cell.setCellValue("Sales"); cell = row.createCell(18);
	 * cell.setCellValue("Non Sales"); cell = row.createCell(19);
	 * cell.setCellValue("Male"); cell = row.createCell(20);
	 * cell.setCellValue("Female"); cell = row.createCell(21);
	 * cell.setCellValue("Less Than 3 Months"); cell = row.createCell(22);
	 * cell.setCellValue("Between 3-6 Months"); cell = row.createCell(23);
	 * cell.setCellValue("Between 6-12 Months"); cell = row.createCell(24);
	 * cell.setCellValue("Between 1-2 Years"); cell = row.createCell(25);
	 * cell.setCellValue("Between 2-5 Years"); cell = row.createCell(26);
	 * cell.setCellValue("Between 5-10 Years"); cell = row.createCell(27);
	 * cell.setCellValue("More Than 10 Years"); cell = row.createCell(28);
	 * cell.setCellValue("Less Than 3 Months"); cell = row.createCell(29);
	 * cell.setCellValue("Between 3-6 Months"); cell = row.createCell(30);
	 * cell.setCellValue("Between 6-12 Months"); cell = row.createCell(31);
	 * cell.setCellValue("Between 1-2 Years"); cell = row.createCell(32);
	 * cell.setCellValue("Between 2-5 Years"); cell = row.createCell(33);
	 * cell.setCellValue("Between 5-10 Years"); cell = row.createCell(34);
	 * cell.setCellValue("More Than 10 Years"); cell = row.createCell(35);
	 * cell.setCellValue("Between 18-20 Years "); cell = row.createCell(36);
	 * cell.setCellValue("Between 20-25 Years"); cell = row.createCell(37);
	 * cell.setCellValue("Between 25-30 Years"); cell = row.createCell(38);
	 * cell.setCellValue("Between 30-35 Years"); cell = row.createCell(39);
	 * cell.setCellValue("Between 35-40 Years"); cell = row.createCell(40);
	 * cell.setCellValue("More Than 40 Years"); cell = row.createCell(41);
	 * cell.setCellValue("Less Than 40%"); cell = row.createCell(42);
	 * cell.setCellValue("Between 40-60%"); cell = row.createCell(43);
	 * cell.setCellValue("Between 60-80%"); cell = row.createCell(44);
	 * cell.setCellValue("More Than 80%");
	 * 
	 * for (int i = 0; i < row.getLastCellNum(); i++) {// For each cell in the row
	 * row.getCell(i).setCellStyle(style);// Set the style }
	 * 
	 * // Data based on region //Below var for Counting all regions data in one row
	 * as total int
	 * registeredCount=0,assessmentCount=0,passedCount=0,offeredCount=0,
	 * recruitedCount=0,assessmentActionCount=0,interviewCount=0,docCount=0,
	 * praarambhCount=0,fsdmApprovalCount=0,
	 * refferalCount=0,walkinCount=0,advertisementCount=0,jobCount=0,socialCount=0,
	 * otherCount=0,salesCount=0,nonSalesCount=0,maleCount=0,femaleCount=0,
	 * auto3Count=0,auto3_6Count=0,auto6_12Count=0,auto1_2Count=0,
	 * auto2_5Count=0,auto5_10Count=0,auto10MoreCount=0,non3Count=0,non3_6Count=0,
	 * non6_12Count=0,non1_2Count=0,non2_5Count=0,non5_10Count=0,non10MoreCount=0,
	 * age18_20Count=0,age20_25Count=0,
	 * age25_30Count=0,age30_35Count=0,age35_40Count=0,age40MoreCount=0,
	 * assess40Count=0,assess40_60Count=0,assess60_80Count=0,assess80MoreCount=0;
	 * int count = 2; List<Region> list=regionList.stream().sorted((r1,r2) ->
	 * r1.getRegionCode().compareToIgnoreCase(r2.getRegionCode())).collect(
	 * Collectors.toList()); for (Region r : list) { String regionCode2 =
	 * r.getRegionCode(); // Get Data by by region Code OverviewPayload overview =
	 * allService.getOverviewAnalytics(outletCode, searchOutlets, regionCode2,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * ActionPointsPayload action = allService.getActionPending(outletCode,
	 * searchOutlets, regionCode2, stateCode, cityCode, approved, dateFrom, dateTo,
	 * hreIdList); RecruitmentSourcePayload source =
	 * allService.getRecruitmentSourceAnalytics(outletCode, searchOutlets,
	 * regionCode2, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * CandidateExperiencePayload exp =
	 * allService.getCandidateExpAnalytics(outletCode, searchOutlets, regionCode2,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * CandidateNonAutoExperiencePayload nonAuto =
	 * allService.getCandidateNonAutoExperience(outletCode, searchOutlets,
	 * regionCode2, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * AssessmentReportPayload assessment =
	 * allService.getAssessmentReportAnalytics(outletCode, searchOutlets,
	 * regionCode2, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * DesignationTypePayload designation =
	 * allService.getDesignationTypeAnalytics(outletCode, searchOutlets,
	 * regionCode2, stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * AgeWisePayload age = allService.getAgeWiseAnalytics(outletCode,
	 * searchOutlets, regionCode2, stateCode, cityCode, approved, dateFrom, dateTo,
	 * hreIdList); GenderDiversityPayload gender =
	 * allService.getGenderAnalytics(outletCode, searchOutlets, regionCode2,
	 * stateCode, cityCode, approved, dateFrom, dateTo, hreIdList);
	 * 
	 * row = sheet.createRow(count); cell = row.createCell(0);
	 * if(role.equalsIgnoreCase("DL")) { for(Outlet o :outlets) {
	 * cell.setCellValue(o.getOutletName()); } }else {
	 * cell.setCellValue(regionCode2); } cell = row.createCell(1);
	 * if(!overview.getRegistered().isEmpty()) {
	 * cell.setCellValue(overview.getRegistered().size());
	 * registeredCount=registeredCount+overview.getRegistered().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(2);
	 * if(!overview.getAssessments().isEmpty()) {
	 * cell.setCellValue(overview.getAssessments().size());
	 * assessmentCount=assessmentCount+overview.getAssessments().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(3);
	 * if(!overview.getPass().isEmpty()) {
	 * cell.setCellValue(overview.getPass().size());
	 * passedCount=passedCount+overview.getPass().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(4);
	 * if(!overview.getOffer().isEmpty()) {
	 * cell.setCellValue(overview.getOffer().size());
	 * offeredCount=offeredCount+overview.getOffer().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(5);
	 * if(!overview.getRecruited().isEmpty()) {
	 * cell.setCellValue(overview.getRecruited().size());
	 * recruitedCount=recruitedCount+overview.getRecruited().size();
	 * 
	 * }else { cell.setCellValue(""); } cell = row.createCell(6);
	 * if(!action.getAssessmentStatus().isEmpty()) {
	 * cell.setCellValue(action.getAssessmentStatus().size());
	 * assessmentActionCount=assessmentActionCount+action.getAssessmentStatus().size
	 * (); }else { cell.setCellValue(""); } cell = row.createCell(7);
	 * if(!action.getInterviewStatus().isEmpty()) {
	 * cell.setCellValue(action.getInterviewStatus().size());
	 * interviewCount=interviewCount+action.getInterviewStatus().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(8);
	 * if(!action.getDocumentUploadStatus().isEmpty()) {
	 * cell.setCellValue(action.getDocumentUploadStatus().size());
	 * docCount=docCount+action.getDocumentUploadStatus().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(9);
	 * if(!action.getPrarambhStatus().isEmpty()) {
	 * cell.setCellValue(action.getPrarambhStatus().size());
	 * praarambhCount=praarambhCount+action.getPrarambhStatus().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(10);
	 * if(!action.getFsdmApproval().isEmpty()) {
	 * cell.setCellValue(action.getFsdmApproval().size());
	 * fsdmApprovalCount=fsdmApprovalCount+action.getFsdmApproval().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(11);
	 * if(!source.getReferrals().isEmpty()) {
	 * cell.setCellValue(source.getReferrals().size());
	 * refferalCount=refferalCount+source.getReferrals().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(12);
	 * if(!source.getDirectWalkIn().isEmpty()) {
	 * cell.setCellValue(source.getDirectWalkIn().size());
	 * walkinCount=walkinCount+source.getDirectWalkIn().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(13);
	 * if(!source.getAdvertisement().isEmpty()) {
	 * cell.setCellValue(source.getAdvertisement().size());
	 * advertisementCount=advertisementCount+source.getAdvertisement().size(); }else
	 * { cell.setCellValue(""); } cell = row.createCell(14);
	 * if(!source.getJobConsultant().isEmpty()) {
	 * cell.setCellValue(source.getJobConsultant().size());
	 * jobCount=jobCount+source.getJobConsultant().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(15);
	 * if(!source.getSocialMedia().isEmpty()) {
	 * cell.setCellValue(source.getSocialMedia().size());
	 * socialCount=socialCount+source.getSocialMedia().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(16);
	 * if(!source.getOthers().isEmpty()) {
	 * cell.setCellValue(source.getOthers().size());
	 * otherCount=otherCount+source.getOthers().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(17);
	 * if(!designation.getSales().isEmpty()) {
	 * cell.setCellValue(designation.getSales().size());
	 * salesCount=salesCount+designation.getSales().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(18);
	 * if(!designation.getNonSales().isEmpty()) {
	 * cell.setCellValue(designation.getNonSales().size());
	 * nonSalesCount=nonSalesCount+designation.getNonSales().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(19);
	 * if(!gender.getMale().isEmpty()) { cell.setCellValue(gender.getMale().size());
	 * maleCount=maleCount+gender.getMale().size(); }else { cell.setCellValue(""); }
	 * cell = row.createCell(20); if(!gender.getFemale().isEmpty()) {
	 * cell.setCellValue(gender.getFemale().size());
	 * femaleCount=femaleCount+gender.getFemale().size(); }else {
	 * cell.setCellValue(""); } cell = row.createCell(21);
	 * if(!exp.getLessThan3Months().isEmpty()) {
	 * cell.setCellValue(exp.getLessThan3Months().size()); auto3Count +=
	 * exp.getLessThan3Months().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(22); if(!exp.getMonths3To6().isEmpty()) {
	 * cell.setCellValue(exp.getMonths3To6().size()); auto3_6Count
	 * +=exp.getMonths3To6().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(23); if(!exp.getMonths6To1Year().isEmpty()) {
	 * cell.setCellValue(exp.getMonths6To1Year().size()); auto6_12Count
	 * +=exp.getMonths6To1Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(24); if(!exp.getYear1To2Year().isEmpty()) {
	 * cell.setCellValue(exp.getYear1To2Year().size()); auto1_2Count +=
	 * exp.getYear1To2Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(25); if(!exp.getYear2To5Year().isEmpty()) {
	 * cell.setCellValue(exp.getYear2To5Year().size()); auto2_5Count +=
	 * exp.getYear2To5Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(26); if(!exp.getYear5To10Year().isEmpty()) {
	 * cell.setCellValue(exp.getYear5To10Year().size()); auto5_10Count +=
	 * exp.getYear5To10Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(27); if(!exp.getMoreThan10Year().isEmpty()) {
	 * cell.setCellValue(exp.getMoreThan10Year().size()); auto10MoreCount +=
	 * exp.getMoreThan10Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(28); if(!nonAuto.getLessThan3Months().isEmpty()) {
	 * cell.setCellValue(nonAuto.getLessThan3Months().size()); non3Count +=
	 * nonAuto.getLessThan3Months().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(29); if(!nonAuto.getMonths3To6().isEmpty()) {
	 * cell.setCellValue(nonAuto.getMonths3To6().size()); non3_6Count +=
	 * nonAuto.getMonths3To6().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(30); if(!nonAuto.getMonths6To1Year().isEmpty()) {
	 * cell.setCellValue(nonAuto.getMonths6To1Year().size()); non6_12Count +=
	 * nonAuto.getMonths6To1Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(31); if(!nonAuto.getYear1To2Year().isEmpty()) {
	 * cell.setCellValue(nonAuto.getYear1To2Year().size()); non1_2Count +=
	 * nonAuto.getYear1To2Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(32); if(!nonAuto.getYear2To5Year().isEmpty()) {
	 * cell.setCellValue(nonAuto.getYear2To5Year().size()); non2_5Count +=
	 * nonAuto.getYear2To5Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(33); if(!nonAuto.getYear5To10Year().isEmpty()) {
	 * cell.setCellValue(nonAuto.getYear5To10Year().size()); non5_10Count +=
	 * nonAuto.getYear5To10Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(34); if(!nonAuto.getMoreThan10Year().isEmpty()) {
	 * cell.setCellValue(nonAuto.getMoreThan10Year().size()); non10MoreCount +=
	 * nonAuto.getMoreThan10Year().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(35); if(!age.getLessThan20().isEmpty()) {
	 * cell.setCellValue(age.getLessThan20().size()); age18_20Count +=
	 * age.getLessThan20().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(36); if(!age.getBetween20To25().isEmpty()) {
	 * cell.setCellValue(age.getBetween20To25().size()); age20_25Count +=
	 * age.getBetween20To25().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(37); if(!age.getBetween25To30().isEmpty()) {
	 * cell.setCellValue(age.getBetween25To30().size()); age25_30Count +=
	 * age.getBetween25To30().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(38); if(!age.getBetween30To35().isEmpty()) {
	 * cell.setCellValue(age.getBetween30To35().size()); age30_35Count +=
	 * age.getBetween30To35().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(39); if(!age.getBetween35To40().isEmpty()) {
	 * cell.setCellValue(age.getBetween35To40().size()); age35_40Count +=
	 * age.getBetween35To40().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(40); if(!age.getMoreThan40().isEmpty()) {
	 * cell.setCellValue(age.getMoreThan40().size()); age40MoreCount +=
	 * age.getMoreThan40().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(41); if(!assessment.getLessThan40().isEmpty()) {
	 * cell.setCellValue(assessment.getLessThan40().size()); assess40Count +=
	 * assessment.getLessThan40().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(42); if(!assessment.getBetween40To60().isEmpty()) {
	 * cell.setCellValue(assessment.getBetween40To60().size()); assess40_60Count +=
	 * assessment.getBetween40To60().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(43); if(!assessment.getBetween60To80().isEmpty()) {
	 * cell.setCellValue(assessment.getBetween60To80().size()); assess60_80Count +=
	 * assessment.getBetween60To80().size(); }else { cell.setCellValue(""); } cell =
	 * row.createCell(44); if(!assessment.getMoreThan80().isEmpty()) {
	 * cell.setCellValue(assessment.getMoreThan80().size()); assess80MoreCount +=
	 * assessment.getMoreThan80().size(); }else { cell.setCellValue(""); } count++;
	 * } //Setting row for total count if(role.equalsIgnoreCase("HO") ||
	 * role.equalsIgnoreCase("SA")) { row = sheet.createRow(count); cell =
	 * row.createCell(0); cell.setCellValue("Total"); cell = row.createCell(1);
	 * if(registeredCount>0) { cell.setCellValue(registeredCount); }else {
	 * cell.setCellValue(""); } cell = row.createCell(2); if(assessmentCount>0) {
	 * cell.setCellValue(assessmentCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(3); if(passedCount>0) { cell.setCellValue(passedCount); }else
	 * { cell.setCellValue(""); } cell = row.createCell(4); if(offeredCount>0) {
	 * cell.setCellValue(offeredCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(5); if(recruitedCount>0) { cell.setCellValue(recruitedCount);
	 * }else { cell.setCellValue(""); } cell = row.createCell(6);
	 * if(assessmentActionCount>0) { cell.setCellValue(assessmentActionCount); }else
	 * { cell.setCellValue(""); } cell = row.createCell(7); if(interviewCount>0) {
	 * cell.setCellValue(interviewCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(8); if(docCount>0) { cell.setCellValue(docCount); }else {
	 * cell.setCellValue(""); } cell = row.createCell(9); if(praarambhCount>0) {
	 * cell.setCellValue(praarambhCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(10); if(fsdmApprovalCount>0) {
	 * cell.setCellValue(fsdmApprovalCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(11); if(refferalCount>0) { cell.setCellValue(refferalCount);
	 * }else { cell.setCellValue(""); } cell = row.createCell(12); if(walkinCount>0)
	 * { cell.setCellValue(walkinCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(13); if(advertisementCount>0) {
	 * cell.setCellValue(advertisementCount); }else { cell.setCellValue(""); } cell
	 * = row.createCell(14); if(jobCount>0) { cell.setCellValue(jobCount); }else {
	 * cell.setCellValue(""); } cell = row.createCell(15); if(socialCount>0) {
	 * cell.setCellValue(socialCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(16); if(otherCount>0) { cell.setCellValue(otherCount); }else {
	 * cell.setCellValue(""); } cell = row.createCell(17); if(salesCount>0) {
	 * cell.setCellValue(salesCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(18); if(nonSalesCount>0) { cell.setCellValue(nonSalesCount);
	 * }else { cell.setCellValue(""); } cell = row.createCell(19); if(maleCount>0) {
	 * cell.setCellValue(maleCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(20); if(femaleCount>0) { cell.setCellValue(femaleCount); }else
	 * { cell.setCellValue(""); } cell = row.createCell(21); if(auto3Count>0) {
	 * cell.setCellValue(auto3Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(22); if(auto3_6Count>0) { cell.setCellValue(auto3_6Count);
	 * }else { cell.setCellValue(""); } cell = row.createCell(23);
	 * if(auto6_12Count>0) { cell.setCellValue(auto6_12Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(24); if(auto1_2Count>0) {
	 * cell.setCellValue(auto1_2Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(25); if(auto2_5Count>0) { cell.setCellValue(auto2_5Count);
	 * }else { cell.setCellValue(""); } cell = row.createCell(26);
	 * if(auto5_10Count>0) { cell.setCellValue(auto5_10Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(27); if(auto10MoreCount>0) {
	 * cell.setCellValue(auto10MoreCount); }else { cell.setCellValue(""); } cell =
	 * row.createCell(28); if(non3Count>0) { cell.setCellValue(non3Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(29); if(non3_6Count>0) {
	 * cell.setCellValue(non3_6Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(30); if(non6_12Count>0) { cell.setCellValue(non6_12Count);
	 * }else { cell.setCellValue(""); } cell = row.createCell(31); if(non1_2Count>0)
	 * { cell.setCellValue(non1_2Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(32); if(non2_5Count>0) { cell.setCellValue(non2_5Count); }else
	 * { cell.setCellValue(""); } cell = row.createCell(33); if(non5_10Count>0) {
	 * cell.setCellValue(non5_10Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(34); if(non10MoreCount>0) { cell.setCellValue(non10MoreCount);
	 * }else { cell.setCellValue(""); } cell = row.createCell(35);
	 * if(age18_20Count>0) { cell.setCellValue(age18_20Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(36); if(age20_25Count>0) {
	 * cell.setCellValue(age20_25Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(37); if(age25_30Count>0) { cell.setCellValue(age25_30Count);
	 * }else { cell.setCellValue(""); } cell = row.createCell(38);
	 * if(age30_35Count>0) { cell.setCellValue(age30_35Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(39); if(age35_40Count>0) {
	 * cell.setCellValue(age35_40Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(40); if(age40MoreCount>0) { cell.setCellValue(age40MoreCount);
	 * }else { cell.setCellValue(""); } cell = row.createCell(41);
	 * if(assess40Count>0) { cell.setCellValue(assess40Count); }else {
	 * cell.setCellValue(""); } cell = row.createCell(42); if(assess40_60Count>0) {
	 * cell.setCellValue(assess40_60Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(43); if(assess60_80Count>0) {
	 * cell.setCellValue(assess60_80Count); }else { cell.setCellValue(""); } cell =
	 * row.createCell(44); if(assess80MoreCount>0) {
	 * cell.setCellValue(assess80MoreCount); }else { cell.setCellValue(""); } }
	 * 
	 * String fileName = DataProccessor.getReportName("Dashboard Report"); String
	 * responseExcelUrl = fileName+".csv"; try (FileOutputStream outputStream = new
	 * FileOutputStream(responseExcelUrl)) { workbook.write(outputStream); } catch
	 * (Exception e) { } File file = new File(fileName+".csv"); HttpHeaders header =
	 * new HttpHeaders(); header.add(HttpHeaders.CONTENT_DISPOSITION,
	 * "attachment; filename= "+fileName+".csv"); header.add("Cache-Control",
	 * "no-cache, no-store, must-revalidate"); header.add("Pragma", "no-cache");
	 * header.add("Expires", "0"); InputStreamResource resource = new
	 * InputStreamResource(new FileInputStream(file)); return
	 * ResponseEntity.ok().headers(header).contentLength(file.length())
	 * .contentType(MediaType.parseMediaType("application/octet-stream")).body(
	 * resource);
	 * 
	 * } else { return null; }
	 * 
	 * }
	 */
}
