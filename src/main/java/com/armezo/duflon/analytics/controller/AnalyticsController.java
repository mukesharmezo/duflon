package com.armezo.duflon.analytics.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
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

import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
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
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
//@RequestMapping("/analytics")
public class AnalyticsController {

	@Autowired
	private AnalyticsAllService allService;
	@Autowired
	private ParticipantServiceImpl participantService;
	@Autowired
	private InterviewScoreService interviewService;
	@Autowired
	private HREService hreService;
	@Autowired
	private WorkExperienceService expService;

	// Insert into Analytics Table From Participants Table
	private void insertAnalyticsData(HttpSession session, List<Long> hreIdList) {
		// removing duplicated ids
		Set<Long> set = new LinkedHashSet<Long>();
		set.addAll(hreIdList);
		hreIdList.clear();
		hreIdList.addAll(set);
		List<AnalyticsAll> analyticsAlls = new ArrayList<AnalyticsAll>();
		List<String> accessKeyList = allService.getAccessKeyList(hreIdList);
		List<ParticipantRegistration> partList = participantService.getParticipantByhreIdLsit(hreIdList);

//		for(ParticipantRegistration p : partList) {
//			if(p.getStatus()!=null && p.getStatus().equalsIgnoreCase("H")) {
//				partList.remove(p);
//			}
//		}
		for (Iterator<ParticipantRegistration> iterator = partList.iterator(); iterator.hasNext();) {
			ParticipantRegistration p = (ParticipantRegistration) iterator.next();
			if ((p.getStatus() != null && p.getStatus().equalsIgnoreCase("H"))
					|| (p.getRegStatus() != null && p.getRegStatus().equals("1"))) {
				Optional<AnalyticsAll> ana = allService.getAnalyticsByAccesskey(p.getAccessKey(), p.getHreId(),
						p.getId());
				if (ana.isPresent()) {
					allService.deleteById(ana.get().getId());
				}
				iterator.remove();
			}
		}
		if (!partList.isEmpty()) {
			for (ParticipantRegistration part : partList) {
				String interviewStatus = "", age = "";
				AnalyticsAll analytics = new AnalyticsAll();
				if (accessKeyList.contains(part.getAccessKey())) {
					Optional<AnalyticsAll> a = allService.getAnalyticsByAccesskey(part.getAccessKey(), part.getHreId(),
							part.getId());
					if (a.isPresent()) {
						analytics = a.get();
						analytics.setId(a.get().getId());
					}
				}
				analytics.setParticipantId(part.getId());
				analytics.setHreId(part.getHreId());
				analytics.setAccesskey(part.getAccessKey());
				analytics.setRegistered(part.getRegStatus());
				analytics.setAssessments(part.getTestStatus());
				analytics.setPassFailStatus(String.valueOf(part.getPassFailStatus()));
				analytics.setAssessmentStatus(part.getTestStatus());
				analytics.setRecruitDate(part.getRegistration_Date());
				analytics.setHreName(part.getHreName());
				analytics.setRecSource(part.getSource());
				Integer workExpe = 0;
				if (part.getExperience() != null) {
					List<WorkExperience> workList = part.getWorkExperience();
					for (WorkExperience work : workList) {
						workExpe = workExpe + work.getExpInMths();
					}
				}
				analytics.setCandidateExperience(String.valueOf(workExpe));
				analytics.setAssessmentReport(part.getPercentageScore());
				analytics.setDesignation(part.getDesignation());
				LocalDate birthDate = LocalDate.now();

				if (part.getBirthDate() != null) {
					birthDate = part.getBirthDate();
					age = DataProccessor.getAgeFromLocalDate(birthDate);
				}
				analytics.setAge(age);
				analytics.setGender(part.getGender());
				Optional<InterviewScore> iScore = interviewService.findByAccesskeyAndInterviewCount(part.getAccessKey(),
						2);
				if (part.getPassFailStatus() == 1) {
					// Document
					if (part.getDocuments_status() == null) {
						analytics.setDocumentUploadStatus("2");
					}
					// Interview
					if (part.getDocuments_status() != null && part.getDocuments_status().equalsIgnoreCase("final")) {
						if (iScore.isPresent()) {
							interviewStatus = "Completed";
							InterviewScore is = iScore.get();
							if ((is.getStatus() != null && is.getStatus().equalsIgnoreCase("final"))
									&& (is.getPass_fail_status() != null
											&& is.getPass_fail_status().equalsIgnoreCase("pass"))) {
								analytics.setOfferStatus("Yes");
							}
							if (iScore.get().getStatus() == null || iScore.get().getStatus().equals("save")) {
								interviewStatus = "Pending";
							}
						} else {
							interviewStatus = "Pending";
						}
					}
				}
				if (part.getHiredStatus() != null) {
					if (part.getHiredStatus().equals("Y")) {
						analytics.setRecruitedStatus("Yes");
					}else if (part.getHiredStatus().equalsIgnoreCase("P")) {
						analytics.setApproval("P");
						analytics.setRecruitedStatus("No");
					}
				}
				analytics.setInterviewStatus(interviewStatus);
				if (iScore.isPresent() && iScore.get().getPass_fail_status() != null
						&& iScore.get().getPass_fail_status().equals("pass")) {
					if (part.getDocuments_status() != null && part.getDocuments_status().equalsIgnoreCase("final")) {
						analytics.setDocumentUploadStatus("1");
					} else {
						analytics.setDocumentUploadStatus("2");
					}
				}
				// setting popup data
				analytics.setHreName(part.getHreName());
				analytics.setFirstName(part.getFirstName());
				analytics.setMiddleName(part.getMiddleName());
				analytics.setLastName(part.getLastName());
				analytics.setMarksObtained(part.getTestScore());
				analytics.setMobile(part.getMobile());
				analytics.setRegistrationDate(part.getRegistration_Date());
				analytics.setAssessmentDate(part.getTestCompletionDate());
				if (part.getModifiedDate() != null) {
					analytics.setModifiedDate(part.getModifiedDate());
				} else {
					analytics.setModifiedDate(part.getRegistration_Date());
				}
				analytics.setInterviewDate(part.getInterviewDate());
				analyticsAlls.add(analytics);
			} // for
			allService.saveAll(analyticsAlls);
		}
	}

	@GetMapping("/analytics")
	public String showAllAnalytics(@RequestParam(name = "dateFromm", required = false) String dateFromm,
			@RequestParam(name = "dateToo", required = false) String dateToo, Model model, HttpSession session) {
		if (session.getAttribute("role") != null) {
			Set<HRE> hres = new LinkedHashSet<>();
			String role = session.getAttribute("role").toString();
			List<Long> hreIdList = new ArrayList<Long>();
			if (role.equalsIgnoreCase("HRE")) {
				Long hreId = Long.parseLong(session.getAttribute("userId").toString());
				Optional<HRE> dl = hreService.getById(hreId);
				hres.add(dl.get());
				hreIdList.add(hreId);
			} else if (role.equalsIgnoreCase("LM") || role.equalsIgnoreCase("SA") || role.equalsIgnoreCase("HOD")) {
				List<HRE> hres2 = hreService.getAllHRE();
				for (HRE hre : hres2) {
					hreIdList.add(hre.getId());
				}
			} else {
				return "redirect:login";
			}
			// allService.getDataByAnyTypeLoginByhreIds(hreIdList);
			insertAnalyticsData(session, hreIdList);

			// Date YTD wise Data
			LocalDate dateFrom = LocalDate.now();
			LocalDate dateTo = LocalDate.now();
			if (dateFromm != null && dateFromm != "" && dateToo != null && dateToo != "") {
				System.out.println("Date From and to : "+dateFromm+"<>"+dateToo);
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
			// Get All objects
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
			model.addAttribute("overview", overview);
			model.addAttribute("action", action);
			model.addAttribute("source", source);
			model.addAttribute("experience", exp);
			model.addAttribute("expNonAuto", nonAuto);
			model.addAttribute("assessment", assessment);
			model.addAttribute("designation", designation);
			model.addAttribute("age", age);
			model.addAttribute("gender", gender);

			// For Search
			/*
			 * List<HRE> dealers2 = dealers.stream().sorted((d1, d2) ->
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
			 * .collect(Collectors.toList()); List<Outlet> outlets3 = new ArrayList<>();
			 * String temp=""; for(Outlet o:outlets2) { if(temp.equals(o.getOutletName())) {
			 * continue; }else { temp = o.getOutletName(); outlets3.add(o); } }
			 * model.addAttribute("dealers", dealers2); model.addAttribute("regions",
			 * regions2); model.addAttribute("states", states2);
			 * model.addAttribute("cities", cities2); model.addAttribute("dealerCodeList",
			 * outlets2); model.addAttribute("dealerShipList", outlets3);
			 */
			FilterPayload payload = new FilterPayload();
            payload.setDateFrom(dateFromm);
            payload.setDateTo(dateToo);
            model.addAttribute("payload", payload);
			model.addAttribute("defaultDate", DataProccessor.getYTDDateInString(dateFrom,dateTo));
			return "deshboard";
		} else {
			return "redirect:login";
		}
	}

	// Search Option
	/*
	 * @PostMapping("/dashboardFilter") public String
	 * searchDashboard(@RequestParam("outletCode") String outletCode,
	 * 
	 * @RequestParam("dealershipName") String
	 * dealershipName, @RequestParam("regionCode") String regionCode,
	 * 
	 * @RequestParam("stateCode") String stateCode, @RequestParam("cityCode") String
	 * cityCode, @RequestParam(required = false) String approved,
	 * 
	 * @RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String
	 * dateToo, HttpSession session, Model model) { if
	 * (session.getAttribute("userId") != null) { SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy-MM-dd"); DashboardFilterPayload filterPayload = new
	 * DashboardFilterPayload(); Date date1 = null; Date date2 = null; Date dateFrom
	 * = new Date(); Date dateTo = new Date(); try { if (dateFromm != null &&
	 * dateFromm != "") { date1 = sdf.parse(dateFromm); } if (dateToo != null &&
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
	 * 
	 * 
	 * if (outletCode == null) outletCode = null; if (regionCode == null) {
	 * regionCode = null; } Set<HRE> dealers = new LinkedHashSet<>(); Set<Outlet>
	 * outlets = new LinkedHashSet<>(); Set<Region> regions = new LinkedHashSet<>();
	 * Set<State> states = new LinkedHashSet<State>(); Set<City> cities = new
	 * LinkedHashSet<City>(); String role = session.getAttribute("role").toString();
	 * List<Long> hreIdList = new ArrayList<Long>(); Long dId = null; if
	 * (role.equalsIgnoreCase("HRE")) { dId =
	 * Long.parseLong(session.getAttribute("userId").toString()); Optional<HRE> dl =
	 * hreService.getById(dId); List<Outlet> ot = outletService.findByhreId(dId);
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
	 * role.equalsIgnoreCase("SA")) { List<HRE> deal = hreService.getAllDeealer();
	 * regions.addAll(regionService.getAllRegion());
	 * outlets.addAll(outletService.getAllOutlets()); dealers.addAll(deal);
	 * states.addAll(stateService.getAllState());
	 * cities.addAll(cityService.getAllCity()); for (Dealer dealer : deal) {
	 * hreIdList.add(dealer.getId()); } } List<String> searchOutlets = new
	 * ArrayList<>(); if(dealershipName!=null && dealershipName!="") {
	 * searchOutlets= new ArrayList<>(); List<Outlet>
	 * searchOutlets2=outletService.getByOutletName(dealershipName);
	 * searchOutlets2.stream().map(Outlet::
	 * getOutletCode).forEachOrdered(searchOutlets::add); }else { List<Outlet>
	 * outlets6 = new ArrayList<>(); for(Long id : hreIdList) {
	 * outlets6.addAll(outletService.getOutletByhreId(id)); }
	 * outlets6.stream().map(Outlet::getOutletCode).forEachOrdered(searchOutlets::
	 * add); } // Get All objects OverviewPayload overview =
	 * allService.getOverviewAnalytics(outletCode, searchOutlets, regionCode,
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
	 * hreIdList); model.addAttribute("overview", overview);
	 * model.addAttribute("action", action); model.addAttribute("source", source);
	 * model.addAttribute("experience", exp); model.addAttribute("expNonAuto",
	 * nonAuto); model.addAttribute("assessment", assessment);
	 * model.addAttribute("designation", designation); model.addAttribute("age",
	 * age); model.addAttribute("gender", gender); // For Search
	 * filterPayload.setDealershipCode(dealershipName);
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
	 * o.getOutletName(); outlets3.add(o); } } model.addAttribute("dealers",
	 * dealers2); model.addAttribute("regions", regions2);
	 * model.addAttribute("states", states2); model.addAttribute("cities", cities2);
	 * model.addAttribute("dealerCodeList", outlets2); model.addAttribute("payload",
	 * filterPayload); model.addAttribute("dealerShipList", outlets3);
	 * model.addAttribute("defaultDate", DataProccessor.getYTDDateInString());
	 * DataProccessor.setDateRange(model); return "deshboard"; } else { return
	 * "redirect:login"; } }
	 */

	// Get Data By accesskey
	@GetMapping("/analyticsByAccesskey")
//	@ResponseBody
	public String getParticipantByAccesskeyList(@RequestParam String accesskeyList, @RequestParam String status,
			Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			List<String> accesskeyList2 = new ArrayList<String>();
			if (accesskeyList != null && accesskeyList.length() > 5) {
				String[] array = accesskeyList.split(",");
				for (String s : array) {
					s = s.replaceAll("\"", "");
					s = s.replaceAll("\\s+", "");
					accesskeyList2.add(s);
				}
			}
			List<ModelParticpantView> mpvList = new ArrayList<ModelParticpantView>();
			List<AnalyticsAll> list = allService.getAllAnalyticsByAccesskeyList(accesskeyList2);
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
				mpv.setDesignation(a.getDesignation());
				mpv.setMobile(a.getMobile());
				mpv.setAccesskey(a.getAccesskey());
				if (a.getRegistrationDate() != null) {
					mpv.setDateOfRegistration(DataProccessor.dateToString(a.getRegistrationDate()));
				}
				if (a.getAssessmentDate() != null) {
					mpv.setAssessment_Completion_date(DataProccessor.dateToString(a.getAssessmentDate()));
				}
				mpv.setTestScore(a.getMarksObtained());
				if (a.getPassFailStatus() != null && a.getPassFailStatus() != "") {
					mpv.setPassFailStatus(Integer.valueOf(a.getPassFailStatus()));
				}
				// Based on Status adding Status
				if (status.equalsIgnoreCase("Overview")) {
					if (a.getRegistered() != null && Integer.valueOf(a.getRegistered()) >= 1) {
						mpv.setStatus("Registered");
					}
					if (a.getAssessments() != null && a.getAssessments().equals("3")) {
						mpv.setStatus("Assessment");
					}
					if (a.getPassFailStatus() != null && a.getPassFailStatus().equals("1")) {
						mpv.setStatus("Passed");
					}
					if (a.getOfferStatus() != null && a.getOfferStatus().equalsIgnoreCase("Yes")) {
						mpv.setStatus("Offered");
					}
					if (a.getRecruitedStatus() != null && a.getRecruitedStatus().equalsIgnoreCase("Yes")) {
						mpv.setStatus("Recruited");
					}
				} else if (status.equalsIgnoreCase("Action")) {
					if (a.getAssessmentStatus() != null && a.getAssessmentStatus().equals("2")) {
						mpv.setStatus("Assessment");
					}
					if (a.getInterviewStatus().equals("Pending")) {
						mpv.setStatus("Interview");
					}
					if (a.getDocumentUploadStatus() != null && a.getDocumentUploadStatus().equals("2")) {
						mpv.setStatus("Document");
					}
					if (a.getHiredStatus() != null && a.getHiredStatus().equals("Y")) {
						mpv.setStatus("Approval");
					}
				} else if (status.equalsIgnoreCase("Source")) {
					if (a.getRecSource() != null) {
						if (a.getRecSource().equalsIgnoreCase("Referrals"))
							mpv.setStatus("Referrals");
						if (a.getRecSource().equalsIgnoreCase("Direct Walk-in"))
							mpv.setStatus("Direct Walk-in");
						if (a.getRecSource().equalsIgnoreCase("Advertisement"))
							mpv.setStatus("Advertisement");
						if (a.getRecSource().equalsIgnoreCase("Job Consultant"))
							mpv.setStatus("Job Consultant");
						if (a.getRecSource().equalsIgnoreCase("Social Media"))
							mpv.setStatus("Social Media");
						if (a.getRecSource().equalsIgnoreCase("Others"))
							mpv.setStatus("Others");
					}
				} else if (status.equalsIgnoreCase("Auto")) {
					if (a.getCandidateExperience() != null && a.getCandidateExperience().length() > 0) {
						if (Integer.valueOf(a.getCandidateExperience()) < 3)
							mpv.setStatus("Between 0-3 Months");
						if (Integer.valueOf(a.getCandidateExperience()) >= 3
								&& Integer.valueOf(a.getCandidateExperience()) < 6)
							mpv.setStatus("Between 3-6 Months");
						if (Integer.valueOf(a.getCandidateExperience()) >= 6
								&& Integer.valueOf(a.getCandidateExperience()) < 12)
							mpv.setStatus("Between 6-12 Months");
						if (Integer.valueOf(a.getCandidateExperience()) >= 12
								&& Integer.valueOf(a.getCandidateExperience()) < 24)
							mpv.setStatus("Between 1-2 Years");
						if (Integer.valueOf(a.getCandidateExperience()) >= 24
								&& Integer.valueOf(a.getCandidateExperience()) < 60)
							mpv.setStatus("Between 2-5 Years");
						if (Integer.valueOf(a.getCandidateExperience()) >= 60
								&& Integer.valueOf(a.getCandidateExperience()) < 120)
							mpv.setStatus("Between 5-10 Years");
						if (Integer.valueOf(a.getCandidateExperience()) >= 120)
							mpv.setStatus("More Than 10 Years");
					}
				} else if (status.equalsIgnoreCase("Assessment")) {
					if (a.getAssessmentReport() != null && a.getAssessmentReport().length() > 0) {
						if (Integer.valueOf(a.getAssessmentReport()) < 40)
							mpv.setStatus("Less than 40");
						if (Integer.valueOf(a.getAssessmentReport()) >= 40
								&& Integer.valueOf(a.getAssessmentReport()) < 60)
							mpv.setStatus("Between 40-60");
						if (Integer.valueOf(a.getAssessmentReport()) >= 60
								&& Integer.valueOf(a.getAssessmentReport()) < 80)
							mpv.setStatus("Between 60-80");
						if (Integer.valueOf(a.getAssessmentReport()) > 80)
							mpv.setStatus("More than 80");
					} else if (status.equalsIgnoreCase("Designation")) {
						if (a.getDesignation() != null && a.getDesignation().length() > 0) {
							if (a.getDesignation().equalsIgnoreCase("Manager"))
								mpv.setStatus("Manager");
							if (a.getDesignation().equalsIgnoreCase("Sales Support"))
								mpv.setStatus("Sales Support");
						}
					} else if (status.equalsIgnoreCase("Gender")) {
						if (a.getGender() != null && a.getGender().length() > 0) {
							if (a.getGender().equalsIgnoreCase("Male") || a.getGender().equalsIgnoreCase("M"))
								mpv.setStatus("Male");
							if (a.getGender().equalsIgnoreCase("Female") || a.getGender().equalsIgnoreCase("F"))
								mpv.setStatus("Female");
							if (a.getGender().equalsIgnoreCase("Other") || a.getGender().equalsIgnoreCase("Transgender")
									|| a.getGender().equalsIgnoreCase("U"))
								mpv.setStatus("Others");
						}
					} else if (status.equalsIgnoreCase("Age")) {
						if (a.getAge() != null && a.getAge().length() > 0) {
							if (Integer.valueOf(a.getAge()) < 20)
								mpv.setStatus("Between 18-20");
							if (Integer.valueOf(a.getAge()) >= 20 && Integer.valueOf(a.getAge()) < 25)
								mpv.setStatus("Between 20-25");
							if (Integer.valueOf(a.getAge()) >= 25 && Integer.valueOf(a.getAge()) < 30)
								mpv.setStatus("Between 25-30");
							if (Integer.valueOf(a.getAge()) >= 30 && Integer.valueOf(a.getAge()) < 35)
								mpv.setStatus("Between 30-35");
							if (Integer.valueOf(a.getAge()) >= 35 && Integer.valueOf(a.getAge()) < 40)
								mpv.setStatus("Between 35-40");
							if (Integer.valueOf(a.getAge()) >= 40)
								mpv.setStatus("More than 40");
						}
					}
				}
				mpvList.add(mpv);
			}
			model.addAttribute("participantList", mpvList);
			model.addAttribute("status", status);
			return "dashboardData";
		} // session
		else {
			return "redirect:login";
		}
	}

	/*
	 * // Dynamic Drop down
	 * 
	 * @PostMapping("/stateByRegionCode")
	 * 
	 * @ResponseBody public String getStateByRegion(@RequestParam String regionCode,
	 * HttpSession session) { if (session.getAttribute("userId") != null) { String
	 * role = session.getAttribute("role").toString(); String stateOption =
	 * "<option value=''>State</option>"; Set<State> states = new
	 * LinkedHashSet<State>(); List<Outlet> outletList = new ArrayList<Outlet>(); if
	 * (role.equalsIgnoreCase("HRE")) { Long hreId =
	 * Long.parseLong(session.getAttribute("userId").toString()); outletList =
	 * outletService.getOutletByhreId(hreId); //
	 * outletList.stream().map(Outlet::getState).forEachOrdered(states::add); } else
	 * if (role.equalsIgnoreCase("LM")) { if (regionCode != null && regionCode !=
	 * "") { outletList = outletService.getOutletByRegionCode(regionCode); } else {
	 * int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) { outletList =
	 * outletService.getOutletByRegion(r.getId()); } } } else if
	 * (role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) { if (regionCode
	 * != null && regionCode != "") { outletList =
	 * outletService.getOutletByRegionCode(regionCode); } else {
	 * states.addAll(stateService.getAllState()); } }
	 * outletList.stream().map(Outlet::getState).forEachOrdered(states::add);
	 * List<State> states2 = new ArrayList<State>(); if(regionCode!=null &&
	 * regionCode!="") { states2 =
	 * stateService.getStateByRegionCode(regionCode).stream() .sorted((s1, s2) ->
	 * s1.getStateName().compareToIgnoreCase(s2.getStateName()))
	 * .collect(Collectors.toList()); }else {
	 * states2=states.stream().sorted((s1,s2)->s1.getStateName().compareToIgnoreCase
	 * (s2.getStateName())).collect(Collectors.toList()); } for (State s : states2)
	 * { stateOption = String.valueOf(stateOption) + "<option value='" +
	 * s.getStateCode() + "'>" + s.getStateName() + "</option>"; } return
	 * stateOption; } else { return "redirect:login"; } }
	 * 
	 * @PostMapping("/cityByStateCode")
	 * 
	 * @ResponseBody public String getCityByStateCode(@RequestParam String
	 * stateCode, HttpSession session) { if (session.getAttribute("userId") != null)
	 * { String cityOption = "<option value=''>City </option>"; Set<City> cities =
	 * new LinkedHashSet<>(); Set<Outlet> outlets = new LinkedHashSet<>(); String
	 * role = session.getAttribute("role").toString(); if
	 * (role.equalsIgnoreCase("HRE")) { Long hreId =
	 * Long.parseLong(session.getAttribute("userId").toString());
	 * outlets.addAll(outletService.getOutletByhreId(hreId)); } else if
	 * (role.equalsIgnoreCase("LM")) { if (stateCode != null && stateCode != "") {
	 * outlets.addAll(outletService.getOutletByStateCode(stateCode)); } else { int
	 * fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) {
	 * outlets.addAll(outletService.getOutletByRegion(r.getId())); } } } else if
	 * (role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) { if (stateCode
	 * != null && stateCode != "") {
	 * outlets.addAll(outletService.getOutletByStateCode(stateCode)); } else {
	 * cities.addAll(cityService.getAllCity()); } }
	 * outlets.stream().map(Outlet::getCity).forEachOrdered(cities::add); List<City>
	 * cities2 = new ArrayList<City>(); if(stateCode!=null && stateCode!="") {
	 * cities2=cityService.getAllCityByStateCode(stateCode).stream() .sorted((c1,
	 * c2) -> c1.getCityName().compareToIgnoreCase(c2.getCityName()))
	 * .collect(Collectors.toList()); }else { cities2=cities.stream() .sorted((c1,
	 * c2) -> c1.getCityName().compareToIgnoreCase(c2.getCityName()))
	 * .collect(Collectors.toList()); } for (City c : cities2) { cityOption =
	 * String.valueOf(cityOption) + "<option value='" + c.getCityCode() + "'>" +
	 * c.getCityName() + "</option>"; } return cityOption; } else { return
	 * "redirect:login"; } }
	 * 
	 * @PostMapping("/dealershipByCityCode")
	 * 
	 * @ResponseBody public String getDealersByCityCode(@RequestParam String
	 * cityCode, HttpSession session) { if (session.getAttribute("userId") != null)
	 * { String dealershipOption = "<option value=''>Dealership </option>";
	 * Set<Outlet> outlets = new LinkedHashSet<>(); List<String> cityCodeList = new
	 * ArrayList<>(); cityCodeList.add(cityCode); String role =
	 * session.getAttribute("role").toString(); if (role.equalsIgnoreCase("HRE")) {
	 * Long hreId = Long.parseLong(session.getAttribute("userId").toString());
	 * outlets.addAll(outletService.getOutletByhreId(hreId)); } else if
	 * (role.equalsIgnoreCase("LM")) { if (cityCode != null && cityCode != "") {
	 * outlets.addAll(outletService.getOutletByCityCodes(cityCodeList)); } else {
	 * int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) {
	 * outlets.addAll(outletService.getOutletByRegion(r.getId())); } } } else if
	 * (role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) { if (cityCode
	 * != null && cityCode != "") {
	 * outlets.addAll(outletService.getOutletByCityCodes(cityCodeList)); } else {
	 * outlets.addAll(outletService.getAllOutlets()); } } List<Outlet> outlets2 =
	 * outlets.stream() .sorted((o1, o2) ->
	 * o1.getOutletName().compareToIgnoreCase(o2.getOutletName()))
	 * .collect(Collectors.toList()); //Removing duplicate Dealership List<Outlet>
	 * outlets3 = new ArrayList<>(); String temp=""; for(Outlet o:outlets2) {
	 * if(temp.equals(o.getOutletName())) { continue; }else { temp =
	 * o.getOutletName(); outlets3.add(o); } }
	 * 
	 * for (Outlet d : outlets3) { dealershipOption =
	 * String.valueOf(dealershipOption) + "<option value='" + d.getOutletName() +
	 * "'>" + d.getOutletName() + "</option>"; } return dealershipOption; } //
	 * session else { return "redirect:login"; } }
	 * 
	 * @PostMapping("/outletByOutletCode")
	 * 
	 * @ResponseBody public String getoutletByOutletCode(@RequestParam String
	 * outletCode, HttpSession session) { if (session.getAttribute("userId") !=
	 * null) { String role = session.getAttribute("role").toString(); Set<Outlet>
	 * outlets = new LinkedHashSet<Outlet>(); if (role.equalsIgnoreCase("HRE")) {
	 * Long dId = Long.parseLong(session.getAttribute("userId").toString()); if
	 * (outletCode != null && outletCode != "") { //Optional<Outlet> out =
	 * outletService.getOutletByOutletCodeAndhreId(outletCode, dId); //if
	 * (out.isPresent()) { // outlets.add(out.get()); //}
	 * 
	 * List<Outlet> out = outletService.getByOutletName(outletCode,dId);
	 * 
	 * for (Outlet o: out) { outlets.add(o); } } else {
	 * outlets.addAll(outletService.findByhreId(dId)); } } else if
	 * (role.equalsIgnoreCase("LM")) { if (outletCode != null && outletCode != "") {
	 * //Optional<Outlet> out = outletService.getOutletByOutletCode(outletCode);
	 * List<Outlet> out = outletService.getByOutletName(outletCode); for (Outlet o:
	 * out) { outlets.add(o); } } else { int fsdmId =
	 * Integer.parseInt(session.getAttribute("userId").toString());
	 * Optional<LineManager> f = fsdmService.getFSDM(fsdmId); for (Region r :
	 * f.get().getRegion()) {
	 * outlets.addAll(outletService.getOutletByRegion(r.getId())); } } } else if
	 * (role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) { if (outletCode
	 * != null && outletCode != "") { //Optional<Outlet> out =
	 * outletService.getOutletByOutletCode(outletCode); ///if (out.isPresent()) { //
	 * outlets.add(out.get()); //} List<Outlet> out =
	 * outletService.getByOutletName(outletCode); for (Outlet o: out) {
	 * outlets.add(o); } } else { outlets.addAll(outletService.getAllOutlets()); } }
	 * String outletOption = "<option value=''>Dealer Code </option>"; List<Outlet>
	 * outList = new ArrayList<Outlet>();
	 * outList=outlets.stream().sorted((o1,o2)->o1.getOutletName().
	 * compareToIgnoreCase(o2.getOutletName())).collect(Collectors.toList()); for
	 * (Outlet o : outList) { outletOption = String.valueOf(outletOption) +
	 * "<option value='" + o.getOutletCode() + "'>" + o.getOutletCode() +
	 * "</option>"; } return outletOption; } // session else { return
	 * "redirect:login"; } } //FSDM by RegionCode
	 * 
	 * @PostMapping("/fsdmByRegionCode")
	 * 
	 * @ResponseBody public String getFSDMByRegionCode(@RequestParam String
	 * regionCode, HttpSession session) { if (session.getAttribute("userId") !=
	 * null) { String fsdmOption = "<option value=''>FSDM </option>";
	 * List<LineManager> fsdms = new ArrayList<LineManager>(); if(regionCode!=null
	 * && regionCode!="") { Optional<Region> region
	 * =regionService.getReagion(regionCode); if(region.isPresent()) {
	 * fsdms.add(region.get().getFsdm()); } }else { fsdms=fsdmService.getAllFSDM();
	 * } List<LineManager> fsdms2 = fsdms.stream().sorted((f1,f2)->
	 * f1.getName().compareToIgnoreCase(f2.getName())).collect(Collectors.toList());
	 * for(FSDM f : fsdms2) {
	 * fsdmOption=String.valueOf(fsdmOption)+"<option value='"+f.getId()+"'>"
	 * +f.getName()+"</option>"; } return fsdmOption; }else { return
	 * "redirect:login"; } }
	 * 
	 * //Parent Dealer by CityCode
	 * 
	 * @PostMapping("/parentDealerByCityCode")
	 * 
	 * @ResponseBody public String getParentDealerByCityCode(@RequestParam String
	 * cityCode, HttpSession session) { if (session.getAttribute("userId") != null)
	 * { String pdOption = "<option value=''>Parent Dealer</option>"; List<Outlet>
	 * outlets = new ArrayList<Outlet>(); List<String> cityCodeList = new
	 * ArrayList<String>(); Set<ParentDealer> parentDealers = new
	 * LinkedHashSet<ParentDealer>(); if(cityCode!=null && cityCode!="") {
	 * cityCodeList.add(cityCode);
	 * outlets=outletService.getOutletByCityCodes(cityCodeList);
	 * outlets.stream().map(Outlet::getParentDealer).forEachOrdered(parentDealers::
	 * add); }else { parentDealers.addAll(parentDealerService.getAllParentDealer());
	 * } List<ParentDealer> pDealers =
	 * parentDealers.stream().sorted((p1,p2)->p1.getParentDealerName().
	 * compareToIgnoreCase(p2.getParentDealerName())).collect(Collectors.toList());
	 * for(ParentDealer p : pDealers) {
	 * pdOption=String.valueOf(pdOption)+"<option value='"+p.getParentDealerCode()+
	 * "'>" +p.getParentDealerCode()+"-"+p.getParentDealerName()+"</option>"; }
	 * return pdOption; }else { return "redirect:login"; } } // FSDM by Parent
	 * Dealer Code
	 * 
	 * @PostMapping("/fsdmByParentDealer")
	 * 
	 * @ResponseBody public String getFSDMByParentDealer(@RequestParam String
	 * pdCode) { String fsdmOption = "<option value=''>FSDM</option>";
	 * Set<LineManager> fsdms = new LinkedHashSet<LineManager>(); List<Outlet>
	 * outlets = new ArrayList<Outlet>(); List<String> pdCodeList = new
	 * ArrayList<String>(); if(pdCode!=null && pdCode!="") { pdCodeList.add(pdCode);
	 * outlets = outletService.getOutletsByPDCodes(pdCodeList);
	 * outlets.stream().map(Outlet::getRegion).map(Region::getFsdm).forEachOrdered(
	 * fsdms::add); }
	 * 
	 * for(FSDM f : fsdms) {
	 * fsdmOption=String.valueOf(fsdmOption)+"<option value='"+f.getId()+"'>"
	 * +f.getName()+"</option>"; }
	 * 
	 * return fsdmOption; } //Get Dealer By FSDM
	 * 
	 * @PostMapping("/dealerByFSDM")
	 * 
	 * @ResponseBody public String getDealerByFSDMId(@RequestParam String fsdmId ) {
	 * String dealerOption = "<option value=''>Dealer</option>"; Integer fId = null;
	 * Set<Outlet> outlets = new LinkedHashSet<Outlet>(); Set<HRE> dealers = new
	 * LinkedHashSet<HRE>();
	 * 
	 * if(fsdmId!=null && fsdmId!="") { fId=Integer.valueOf(fsdmId); //Get Outlet by
	 * FID List<Region> regions =regionService.getRegionByFSDMId(fId); for(Region r
	 * : regions) {
	 * outlets.addAll(outletService.getOutletByRegionCode(r.getRegionCode())); }
	 * outlets.stream().map(Outlet::getDealer).forEachOrdered(dealers::add);
	 * List<HRE> dealers2 =
	 * dealers.stream().sorted((d1,d2)->d1.getName().compareToIgnoreCase(d2.getName(
	 * ))).collect(Collectors.toList()); for(Dealer d : dealers2) {
	 * dealerOption=String.valueOf(dealerOption)+"<option value='"+d.getId()+"'>"+d.
	 * getName()+"</option>"; } } return dealerOption; }
	 * 
	 * //Dealer By Parent Dealer Code
	 * 
	 * @PostMapping("/dealerByParentDealerCode")
	 * 
	 * @ResponseBody public String getDealerByParentDealerCode(@RequestParam String
	 * pdCode, HttpSession session) { if (session.getAttribute("userId") != null) {
	 * String dealerOption = "<option value=''>Dealer</option>"; Set<HRE> dealers =
	 * new LinkedHashSet<HRE>(); List<Outlet> outlets = new ArrayList<Outlet>();
	 * List<String> pdCodeList = new ArrayList<String>(); if(pdCode!=null &&
	 * pdCode!="") { pdCodeList.add(pdCode); outlets=
	 * outletService.getOutletsByPDCodes(pdCodeList);
	 * outlets.stream().map(Outlet::getDealer).forEachOrdered(dealers::add); }else {
	 * dealers.addAll(dealerService.getAllDeealer()); } List<HRE> dealers2 =
	 * dealers.stream().sorted((d1,d2)->d1.getName().compareToIgnoreCase(d2.getName(
	 * ))).collect(Collectors.toList()); for(Dealer d : dealers2) {
	 * dealerOption=String.valueOf(dealerOption)+"<option value='"+d.getId()+"'>"+d.
	 * getName()+"</option>"; } return dealerOption; }else { return
	 * "redirect:login"; }
	 * 
	 * }
	 * 
	 */
}
