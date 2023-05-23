package com.armezo.duflon.controller;

import org.springframework.stereotype.Controller;

@Controller
public class HOController
{
	
	/*
    @Autowired
    ParticipantService participantserviceImpl;
    @Autowired
    CityService cityService;
    @Autowired
    RegionService regionService;
    @Autowired
    FSDMService fsdmservice;
    @Autowired
    HREService hreService;
    @Autowired
    ParentDealerService parentDealerService;
    @Autowired
    StateService stateService;
    @Autowired
    DesignationService designationService;
    @Autowired
    OutletService outletService;
    @Autowired
    InterviewScoreService interviewScoreService;
    @Autowired
    DataScienceService dataScienceService;
    
    @GetMapping({ "/viewAllParticapants" })
    private String viewAllParticipantsOnHO(final HttpSession session, Model model) {
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantInpprocessHo();
            listParticipant = this.setDataToHOProcess(participant);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            return "HO";
        }
        return "redirect:login";
    }
    
    @GetMapping({ "/viewAllCompletedParticipant" })
    public String viewAllCompletedParticipantOnHO(final HttpSession session, Model model) {
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantEmployeeHo();
            listParticipant = this.setDataToHOProcess(participant);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            return "HOEmployee";
        }
        return "redirect:login";
    }
    
    @GetMapping({ "/viewAllHoldParticipant" })
    public String viewAllHoldParticipantOnHO(final HttpSession session, Model model) {
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantHoldHo();
            listParticipant = this.setDataToHOProcess(participant);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            return "HoldParticipantHO";
        }
        return "redirect:login";
    }
    
    @GetMapping({ "/viewAllPendingApprovalParticipant" })
    public String viewAllHPendingApprovalParticipantOn(final HttpSession session, Model model) {
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        if (session.getAttribute("userId") != null) {
            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantPendingApprovel();
            listParticipant = this.setDataToHOProcess(participant);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            return "hoPendingApproval";
        }
        return "redirect:login";
    }
    
    @PostMapping({ "/hoFilter" })
    public String hoFilterPage(@RequestParam("regionCode") final String regionCode, @RequestParam("stateCode") final String stateCode, @RequestParam("cityCode") final String cityCode, @RequestParam("parentDealerCode") final String parentDealerCode, @RequestParam("fsdmId") final String fsdmId, @RequestParam("hreId") final String hreId, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, Model model) {
        final List<Long> listDealer = new ArrayList<Long>();
        Date dateFrom = null;
        Date dateTo = null;
        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (dateFromm != null && dateFromm != "") {
                dateFrom = sdf.parse(dateFromm);
            }
            if (dateToo != null && dateToo != "") {
                dateTo = sdf.parse(dateToo);
                dateTo = DataProccessor.addTimeInDate(dateTo);
            }
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        Long dId = null;
        if (hreId != null && hreId != "") {
            dId = Long.valueOf(hreId);
        }
        Integer fId = null;
        if (fsdmId != null && fsdmId != "") {
            fId = Integer.valueOf(fsdmId);
        }
        final FilterPayloadHO payload = new FilterPayloadHO(regionCode, stateCode, cityCode, parentDealerCode, fsdmId, hreId, dateFromm, dateToo);
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        final List<Outlet> outlets = (List<Outlet>)this.outletService.getOutletForHoFilter(regionCode, stateCode, cityCode, parentDealerCode, fId, dId);
       // outlets.stream().map((Function<? super Object, ?>)Outlet::getDealer).map((Function<? super Object, ?>)Dealer::getId).forEachOrdered(listDealer::add);
        outlets.stream().map(Outlet :: getDealer).map(Dealer :: getId).forEachOrdered(listDealer :: add);
        if (listDealer.size() == 0) {
            listDealer.add(0L);
        }
        if (session.getAttribute("userId") != null) {
            List<ParticipantRegistration> participants = new ArrayList<ParticipantRegistration>();
            if (dateFrom != null && dateTo != null) {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVInpprocess((List)listDealer, dateFrom, dateTo);
            }
            else {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVInpprocess((List)listDealer);
            }
            listParticipant = this.setDataToHOProcess(participants);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("payload", (Object)payload);
            return "HO";
        }
        return "redirect:login";
    }
    
    @PostMapping({ "/hoFilterPendingApprovel" })
    public String hoFilterPendingApprovel(@RequestParam("regionCode") final String regionCode, @RequestParam("stateCode") final String stateCode, @RequestParam("cityCode") final String cityCode, @RequestParam("parentDealerCode") final String parentDealerCode, @RequestParam("fsdmId") final String fsdmId, @RequestParam("hreId") final String hreId, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, Model model) {
        final List<Long> listDealer = new ArrayList<Long>();
        final FilterPayloadHO payload = new FilterPayloadHO(regionCode, stateCode, cityCode, parentDealerCode, fsdmId, hreId, dateFromm, dateToo);
        Date dateFrom = null;
        Date dateTo = null;
        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (dateFromm != null && dateFromm != "") {
                dateFrom = sdf.parse(dateFromm);
            }
            if (dateToo != null && dateToo != "") {
                dateTo = sdf.parse(dateToo);
                dateTo = DataProccessor.addTimeInDate(dateTo);
            }
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        Long dId = null;
        if (hreId != null && hreId != "") {
            dId = Long.valueOf(hreId);
        }
        Integer fId = null;
        if (fsdmId != null && fsdmId != "") {
            fId = Integer.valueOf(fsdmId);
        }
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        final List<Outlet> outlets = (List<Outlet>)this.outletService.getOutletForHoFilter(regionCode, stateCode, cityCode, parentDealerCode, fId, dId);
       // outlets.stream().map((Function<? super Object, ?>)Outlet::getDealer).map((Function<? super Object, ?>)Dealer::getId).forEachOrdered(listDealer::add);
        outlets.stream().map(Outlet :: getDealer).map(Dealer :: getId).forEachOrdered(listDealer :: add);
        if (listDealer.size() == 0) {
            listDealer.add(0L);
        }
        if (session.getAttribute("userId") != null) {
            List<ParticipantRegistration> participants = new ArrayList<ParticipantRegistration>();
            if (dateFrom != null && dateTo != null) {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVPendingApprovel((List)listDealer, dateFrom, dateTo);
            }
            else {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVPendingApprovel((List)listDealer);
            }
            listParticipant = this.setDataToHOProcess(participants);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("payload", (Object)payload);
            return "hoPendingApproval";
        }
        return "redirect:login";
    }
    
    @PostMapping({ "/hoFilterEmployee" })
    public String hoFilterEmployee(@RequestParam("regionCode") final String regionCode, @RequestParam("stateCode") final String stateCode, @RequestParam("cityCode") final String cityCode, @RequestParam("outletCode") final String outletCode, @RequestParam("dealershipName") final String dealershipName, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, Model model) {
        final List<Long> listDealer = new ArrayList<Long>();
        final DashboardFilterPayload filterPayload = new DashboardFilterPayload();
        Date dateFrom = null;
        Date dateTo = null;
        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (dateFromm != null && dateFromm != "") {
                dateFrom = sdf.parse(dateFromm);
            }
            if (dateToo != null && dateToo != "") {
                dateTo = sdf.parse(dateToo);
                dateTo = DataProccessor.addTimeInDate(dateTo);
            }
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        List<String> searchOutlets = new ArrayList<String>();
        if (dealershipName != null && dealershipName != "") {
            searchOutlets = new ArrayList<String>();
            final List<Outlet> searchOutlets2 = (List<Outlet>)this.outletService.getByOutletName(dealershipName);
           // searchOutlets2.stream().map((Function<? super Object, ?>)Outlet::getOutletCode).forEachOrdered(searchOutlets::add);
            searchOutlets2.stream().map(Outlet:: getOutletCode).forEachOrdered(searchOutlets::add);
        }
        else {
            final List<Outlet> outlets6 = (List<Outlet>)this.outletService.getAllOutlets();
            //outlets6.stream().map((Function<? super Object, ?>)Outlet::getOutletCode).forEachOrdered(searchOutlets::add);
            outlets6.stream().map(Outlet::getOutletCode).forEachOrdered(searchOutlets::add);
        }
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        final List<Outlet> outlets7 = (List<Outlet>)this.outletService.getOutletForHoNewFilter(regionCode, stateCode, cityCode, outletCode, (List)searchOutlets);
       // outlets7.stream().map((Outlet::getDealer).map((Function<? super Object, ?>)Dealer::getId).forEachOrdered(listDealer::add);
        outlets7.stream().map(Outlet :: getDealer).map(Dealer :: getId).forEachOrdered(listDealer :: add);
        if (listDealer.size() == 0) {
            listDealer.add(0L);
        }
        if (session.getAttribute("userId") != null) {
            List<ParticipantRegistration> participants = new ArrayList<ParticipantRegistration>();
            if (dateFrom != null && dateTo != null) {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVImployee((List)listDealer, dateFrom, dateTo);
            }
            else {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVImployee((List)listDealer);
            }
            listParticipant = this.setDataToHOProcess(participants);
            filterPayload.setDealershipCode(dealershipName);
            filterPayload.setRegionCode(regionCode);
            filterPayload.setStateCode(stateCode);
            filterPayload.setCityCode(cityCode);
            filterPayload.setOutletCode(outletCode);
            filterPayload.setDateFrom(dateFromm);
            filterPayload.setDateTo(dateToo);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("payload", (Object)filterPayload);
            return "HOEmployee";
        }
        return "redirect:login";
    }
    
    @PostMapping({ "/hoFilterHold" })
    public String hoFilterHold(@RequestParam("regionCode") final String regionCode, @RequestParam("stateCode") final String stateCode, @RequestParam("cityCode") final String cityCode, @RequestParam("parentDealerCode") final String parentDealerCode, @RequestParam("fsdmId") final String fsdmId, @RequestParam("hreId") final String hreId, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, Model model) {
    	System.out.println("D......ww.........");
    	final List<Long> listDealer = new ArrayList<Long>();
        Date dateFrom = null;
        Date dateTo = null;
        Date dateFromSearch=null;
		Date dateToSearch=null;
        
        LocalDate lastStart = LocalDate.now().minusDays(90);
		LocalDate lastEnd = LocalDate.now();
		DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("dd/MM/YYYY");
	    String a = lastStart.format(formatter2);
	    String b = lastEnd.format(formatter2);
		//SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
	    String fromStart = lastStart.format(formatter2);	
 	    String fromEnd= lastEnd.format(formatter2);	
	    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	    try {
			if (dateFromm != null && dateFromm != "") {
				dateFromSearch = sdf2.parse(dateFromm);
			}else {
				dateFromSearch = sdf2.parse(a);
			}
			if (dateToo != null && dateToo != "") {
				dateToSearch = sdf2.parse(dateToo);
			
			}else {
				dateToSearch = sdf2.parse(b);
			}
			Date d1 =sdf2.parse(fromStart);
			Calendar cal1 = Calendar.getInstance();
			Calendar cal2 = Calendar.getInstance();
			
			cal1.setTime(dateFromSearch);
			cal2.setTime(d1);
			if(dateFromSearch.compareTo(d1)<0) {
				dateFromSearch=sdf2.parse(fromStart);
				dateToSearch=sdf2.parse(fromEnd);
			}else {
				System.out.println("else..........");	
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
	    */
	    
        
		/*
		 * final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); try { if
		 * (dateFromm != null && dateFromm != "") { dateFrom = sdf.parse(dateFromm); }
		 * if (dateToo != null && dateToo != "") { dateTo = sdf.parse(dateToo); dateTo =
		 * DataProccessor.addTimeInDate(dateTo); } } catch (ParseException e) {
		 * e.printStackTrace(); }
		 */
	/*
        Long dId = null;
        if (hreId != null && hreId != "") {
            dId = Long.valueOf(hreId);
        }
        Integer fId = null;
        if (fsdmId != null && fsdmId != "") {
            fId = Integer.valueOf(fsdmId);
        }
        final FilterPayloadHO payload = new FilterPayloadHO(regionCode, stateCode, cityCode, parentDealerCode, fsdmId, hreId, dateFromm, dateToo);
        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        final List<Outlet> outlets = (List<Outlet>)this.outletService.getOutletForHoFilter(regionCode, stateCode, cityCode, parentDealerCode, fId, dId);
       // outlets.stream().map((Function<? super Object, ?>)Outlet::getDealer).map((Function<? super Object, ?>)Dealer::getId).forEachOrdered(listDealer::add);
        outlets.stream().map(Outlet :: getDealer).map(Dealer :: getId).forEachOrdered(listDealer :: add);
        if (listDealer.size() == 0) {
            listDealer.add(0L);
        }
        if (session.getAttribute("userId") != null) {
            List<ParticipantRegistration> participants = null;
            if (dateFrom != null && dateTo != null) {
                participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVHold((List)listDealer, dateFromSearch, dateToSearch);
            }
            else {
            	  participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVHold((List)listDealer, dateFromSearch, dateToSearch);
               // participants = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantCSVHold((List)listDealer);
            }
            listParticipant = this.setDataToHOProcess(participants);
            model = this.setDataToNewFilter(model);
            model.addAttribute("participantList", (Object)listParticipant);
            model.addAttribute("payload", (Object)payload);
            return "HoldParticipantHO";
        }
        return "redirect:login";
    }
    
    @GetMapping({ "/allStateHO" })
    @ResponseBody
    public String getAllStateByRegion(@RequestParam final String[] regions) {
        final List<String> regionList = new ArrayList<String>();
        for (final String g : regions) {
            regionList.add(g);
        }
        String stateList = "";
        List<State> statessList = new ArrayList<State>();
        statessList = (List<State>)this.stateService.getStateByRegionCode((List)regionList);
        statessList.sort(Comparator.comparing((Function<? super State, ? extends Comparable>)State::getStateName));
        for (final State s : statessList) {
            stateList = String.valueOf(String.valueOf(stateList)) + "<li><label><input type='checkbox' class='regs' id='" + s.getStateCode() + "' value='" + s.getStateCode() + "' />" + s.getStateName() + "</label> </li>";
        }
        return stateList;
    }
    
    @GetMapping({ "/allCityHO" })
    @ResponseBody
    public String getAllCityByState(@RequestParam final String[] stateCode) {
        final List<String> stateCodes = Arrays.asList(stateCode);
        String cityList = "";
        List<City> cities = new ArrayList<City>();
        if (!stateCodes.isEmpty()) {
            cities = (List<City>)this.cityService.getAllCityByStateCode((List)stateCodes);
        }
        else {
            cities = (List<City>)this.cityService.getAllCity();
        }
        cities.sort(Comparator.comparing((Function<? super City, ? extends Comparable>)City::getCityName));
        for (final City c : cities) {
            cityList = String.valueOf(String.valueOf(cityList)) + "<li><label><input type='checkbox' class='city' id='" + c.getCityCode() + "' value='" + c.getCityCode() + "' />" + c.getCityName() + "</label> </li>";
        }
        return cityList;
    }
    
    @GetMapping({ "/allParentDealerHO" })
    @ResponseBody
    public String getAllParentDealersByCity(@RequestParam final String[] cityCode) {
        final List<String> citiCodes = Arrays.asList(cityCode);
        String pdList = "";
        final Set<ParentDealer> pDealers = new LinkedHashSet<ParentDealer>();
        if (!citiCodes.isEmpty()) {
            final List<Outlet> outlets = (List<Outlet>)this.outletService.getOutletByCityCodes((List)citiCodes);
            outlets.stream().map(Outlet :: getParentDealer ).forEachOrdered(pDealers :: add);
           // outlets.stream().map((Function<? super Object, ?>)Outlet::getParentDealer).forEachOrdered(pDealers::add);
        }
        else {
            pDealers.addAll(this.parentDealerService.getAllParentDealer());
        }
       // final Map<String, String> map = pDealers.stream().collect(Collectors.toMap((Function<? super Object, ? extends String>)ParentDealer::getParentDealerCode, (Function<? super Object, ? extends String>)ParentDealer::getParentDealerName));
        Map<String, String> map = pDealers.stream().collect( Collectors.toMap(ParentDealer :: getParentDealerCode ,ParentDealer :: getParentDealerName));
        
        final Map<String, String> sortedMap = (Map<String, String>)DataProccessor.sortMapByValueStringAcs((Map)map);
        for (final Map.Entry<String, String> pd : sortedMap.entrySet()) {
            pdList = String.valueOf(pdList) + "<li><label><input type='checkbox' class='pd' id='" + pd.getKey() + "' value='" + pd.getKey() + "' />" + pd.getValue() + "</label> </li>";
        }
        return pdList;
    }
    
    @GetMapping({ "/allDealerHO" })
    @ResponseBody
    public String getAllDealerByPDCodes(@RequestParam final String[] pdCodes) {
        final List<String> pdCodeList = Arrays.asList(pdCodes);
        String dealerList = "";
        final Set<HRE> dealers = new LinkedHashSet<HRE>();
        if (!pdCodeList.isEmpty()) {
           // final List<Outlet> outlets = (List<Outlet>)this.outletService.getOutletsByPDCodes((List)pdCodeList);
        	// outlets.stream().map((Function<? super Object, ?>)Outlet::getDealer).forEachOrdered(dealers::add);
        	List<Outlet> outlets=outletService.getOutletsByPDCodes(pdCodeList);
        	outlets.stream().map(Outlet :: getDealer).forEachOrdered(dealers :: add);
        }
        for (final Dealer d : dealers) {
            dealerList = String.valueOf(String.valueOf(dealerList)) + "<li><label><input type='checkbox' class='dealer' id='" + d.getMspin() + "' value='" + d.getMspin() + "' /> " + d.getName() + "</label></li>";
        }
        return dealerList;
    }
    
    @GetMapping({ "/allFsdmHO" })
    @ResponseBody
    public String getFSDMByRegionCode(@RequestParam final String[] regions) {
        final List<String> regionList = new ArrayList<String>();
        for (final String g : regions) {
            regionList.add(g);
        }
        String fsdmList = "";
        final Set<LineManager> fsdmSet = new LinkedHashSet<LineManager>();
        if (!regionList.isEmpty()) {
            final List<Region> regionList2 = (List<Region>)this.regionService.getAllRegionByRegionCodeList((List)regionList);
          //  regionList2.stream().map((Function<? super Object, ?>)Region::getFsdm).forEachOrdered(fsdmSet::add);
            regionList2.stream().map(Region :: getFsdm).forEachOrdered(fsdmSet :: add);
        }
        else {
            fsdmSet.addAll(this.fsdmservice.getAllFSDM());
        }
        fsdmSet.stream().sorted((f1, f2) -> f1.getName().compareToIgnoreCase(f2.getName()));
        for (final FSDM f3 : fsdmSet) {
            fsdmList = String.valueOf(String.valueOf(fsdmList)) + "<li><label><input type='checkbox' class='fsdm' id='" + f3.getId() + "' value='" + f3.getId() + "' />" + f3.getName() + "</label> </li>";
        }
        return fsdmList;
    }
    
    private List<ModelParticpantView> setDataToHOProcess(final List<ParticipantRegistration> participants) {
        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
        final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        final List<Designation> designations2 = (List<Designation>)this.designationService.getAll();
       // final Map<String, String> designation = designations2.stream().collect(Collectors.toMap((Function<? super Object, ? extends String>)Designation::getDesignationCode, (Function<? super Object, ? extends String>)Designation::getDesignationName));
        Map<String, String> designation = designations2.stream().collect(Collectors.toMap(Designation  :: getDesignationCode , Designation  :: getDesignationName));
        for (final ParticipantRegistration p : participants) {
            if (p.getTestStatus() != null && (p.getTestStatus().equals("1") || p.getTestStatus().equals("3"))) {
                final ModelParticpantView modelParticpantView = new ModelParticpantView();
                if (p.getRegistration_date() != null) {
                    modelParticpantView.setDateOfRegistration(formatter.format(p.getRegistration_date()));
                }
                if (p.getTestCompletionDate() != null) {
                    modelParticpantView.setAssessment_Completion_date(formatter.format(p.getTestCompletionDate()));
                }
                modelParticpantView.setParticipantName(String.valueOf(String.valueOf(p.getFirstName())) + " " + p.getMiddleName() + " " + p.getLastName());
                modelParticpantView.setAccesskey(p.getAccessKey());
                modelParticpantView.setDesignation(p.getDesignation());
                if (p.getTotalMark() != null) {
                    modelParticpantView.setTotalMark(p.getTotalMark());
                }
                else {
                    modelParticpantView.setTotalMark("00");
                }
                if (p.getTestScore() != null) {
                    modelParticpantView.setTestScore(p.getTestScore());
                }
                else {
                    modelParticpantView.setTestScore(new StringBuilder().append(p.getAttitudeScore()).toString());
                }
                if (p.getPercentageScore() != null) {
                    modelParticpantView.setPercentageScore(p.getPercentageScore());
                }
                else if (p.getAttitudeScore() != null && p.getAttitudeScore() > 0) {
                    final int passingPer = p.getAttitudeScore() / 40 * 100;
                    modelParticpantView.setPercentageScore(new StringBuilder(String.valueOf(passingPer)).toString());
                }
                modelParticpantView.setEmail(p.getEmail());
                modelParticpantView.setMobile(p.getMobile());
                modelParticpantView.setTestStatus(p.getTestStatus());
                modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
                modelParticpantView.setPassFailStatus(p.getPassFailStatus());
                if (p.getInterviewDate() != null) {
                    final String regDate = formatter.format(p.getInterviewDate());
                    final String s = String.valueOf(String.valueOf(regDate)) + " " + p.getInterviewTime();
                    modelParticpantView.setInterViewDate(s);
                }
                else {
                    modelParticpantView.setInterViewDate("");
                }
                final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(p.getAccessKey());
                if (interView.isPresent()) {
                    modelParticpantView.setInterViewStatus(interView.get().getStatus());
                    modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
                }
                else {
                    modelParticpantView.setInterViewStatus("");
                    modelParticpantView.setInterViewPassFailStatus("");
                }
                modelParticpantView.setMspin(p.getMspin());
                modelParticpantView.setPrarambhStatus(p.getPrarambhStatus());
                if (p.getFsdmApprovalStatus() == null) {
                    modelParticpantView.setFsdmApprovalStatus("");
                }
                else if (p.getFsdmApprovalStatus().equals("1")) {
                    modelParticpantView.setFsdmApprovalStatus("Rejected");
                }
                else if (p.getFsdmApprovalStatus().equals("2")) {
                    modelParticpantView.setFsdmApprovalStatus("Approved");
                }
                else if (p.getFsdmApprovalStatus().equals("3")) {
                    modelParticpantView.setFsdmApprovalStatus("Pending");
                }
                final Optional<DataScience> d = (Optional<DataScience>)this.dataScienceService.findByAccesskey(p.getAccessKey());
                if (d.isPresent()) {
                    modelParticpantView.setDataScienceResult(DataProccessor.getStringValue(d.get().getDataScienceResult()));
                    modelParticpantView.setDataScienceReason(DataProccessor.getStringValue(d.get().getReason()));
                    modelParticpantView.setDataScienceStatus(DataProccessor.getStringValue(d.get().getStatus()));
                    modelParticpantView.setDataScienceInterViewStatus(DataProccessor.getStringValue(d.get().getInterviewStatus()));
                    modelParticpantView.setReference(DataProccessor.getStringValue(d.get().getDataScienceReferenceId()));
                    modelParticpantView.setPrediction(DataProccessor.getStringValue(d.get().getDataSciencePrediction()));
                }
                final Optional<Outlet> outlet = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(p.getOutletCode(), p.gethreId());
                if (outlet.isPresent()) {
                    modelParticpantView.setRegionCode(outlet.get().getRegion().getRegionCode());
                    modelParticpantView.setParentDealer(outlet.get().getParentDealer().getParentDealerName());
                    modelParticpantView.setDealerName(outlet.get().getOutletName());
                    modelParticpantView.setOutletCode(outlet.get().getOutletCode());
                    modelParticpantView.setCity(outlet.get().getCity().getCityName());
                    modelParticpantView.setState(outlet.get().getState().getStateName());
                }
                else {
                    modelParticpantView.setRegionCode("");
                    modelParticpantView.setParentDealer("");
                    modelParticpantView.setDealerName("");
                    modelParticpantView.setOutletCode("");
                    modelParticpantView.setCity("");
                    modelParticpantView.setState("");
                }
                modelParticpantView.setDateOfRegistration(formatter.format(p.getRegistration_date()));
                if (p.getFinalDesignation() != null) {
                    modelParticpantView.setFinalDesignation((String)designation.get(p.getFinalDesignation()));
                    modelParticpantView.setFinalDesignationCode(p.getFinalDesignation());
                }
                String fsdmReason = "";
                if (p.getFsdmFeedback() != null && !p.getFsdmFeedback().equals("")) {
                    fsdmReason = p.getFsdmFeedback();
                }
                if (p.getFsdmRejectionType() != null && !p.getFsdmRejectionType().equals("")) {
                    fsdmReason = String.valueOf(fsdmReason) + " &#013 " + p.getFsdmRejectionType();
                }
                if (p.getFsdmRejectionReason() != null && !p.getFsdmRejectionReason().equals("")) {
                    fsdmReason = String.valueOf(fsdmReason) + " &#013 " + p.getFsdmRejectionReason();
                }
                if (p.getFsdmRejectionComment() != null && !p.getFsdmRejectionComment().equals("")) {
                    fsdmReason = String.valueOf(fsdmReason) + " &#013 " + p.getFsdmRejectionComment();
                }
                modelParticpantView.setFsdmReason(fsdmReason);
                if(p.getAptitudeScore() != null) {
                modelParticpantView.setAptitude((int)p.getAptitudeScore());
                }else {
                	  modelParticpantView.setAptitude(0);	
                }
                if(p.getAttitudeScore() != null) {
                modelParticpantView.setAttitude((int)p.getAttitudeScore());
                }else {
                	 modelParticpantView.setAttitude(0);	
                }
                listParticipant.add(modelParticpantView);
            }
        }
        return listParticipant;
    }
    
    private Model setDataToNewFilter(final Model model) {
        final List<Region> regionList = (List<Region>)this.regionService.getAllRegion();
        final List<State> stateList = (List<State>)this.stateService.getAllState();
        final List<City> cityList = (List<City>)this.cityService.getAllCity();
        final List<ParentDealer> parentDealerList = (List<ParentDealer>)this.parentDealerService.getAllParentDealer();
        final List<LineManager> fsdmList = (List<LineManager>)this.fsdmservice.getAllFSDM();
        final List<HRE> dealerList = (List<HRE>)this.dealerService.getAllDeealer();
        final List<Outlet> outletList = (List<Outlet>)this.outletService.getAllOutlets();
        
      //  final List<Region> regions = regionList.stream().sorted((r1, r2) -> r1.getRegionCode().compareToIgnoreCase(r2.getRegionCode())).collect((Collector<? super Object, ?, List<Region>>)Collectors.toList());
       // final List<State> states = stateList.stream().sorted((s1, s2) -> s1.getStateName().compareToIgnoreCase(s2.getStateName())).collect((Collector<? super Object, ?, List<State>>)Collectors.toList());
       // final List<City> cities = cityList.stream().sorted((c1, c2) -> c1.getCityName().compareToIgnoreCase(c2.getCityName())).collect((Collector<? super Object, ?, List<City>>)Collectors.toList());
      //  final List<ParentDealer> parentDealers = parentDealerList.stream().sorted((p1, p2) -> p1.getParentDealerName().compareToIgnoreCase(p2.getParentDealerName())).collect((Collector<? super Object, ?, List<ParentDealer>>)Collectors.toList());
      //  final List<LineManager> fsdms = fsdmList.stream().sorted((f1, f2) -> f1.getName().compareToIgnoreCase(f2.getName())).collect((Collector<? super Object, ?, List<LineManager>>)Collectors.toList());
       // final List<HRE> dealers = dealerList.stream().sorted((d1, d2) -> d1.getName().compareToIgnoreCase(d2.getName())).collect((Collector<? super Object, ?, List<HRE>>)Collectors.toList());
       // final List<Outlet> outlets = outletList.stream().sorted((o1, o2) -> o1.getOutletCode().compareToIgnoreCase(o2.getOutletCode())).collect((Collector<? super Object, ?, List<Outlet>>)Collectors.toList());
       
        List<Region> regions = regionList.stream().sorted((r1,r2)-> r1.getRegionCode().compareToIgnoreCase(r2.getRegionCode())).collect(Collectors.toList());
    	List<State> states = stateList.stream().sorted((s1, s2)-> s1.getStateName().compareToIgnoreCase(s2.getStateName())).collect(Collectors.toList());
    	List<City> cities = cityList.stream().sorted((c1,c2)-> c1.getCityName().compareToIgnoreCase(c2.getCityName())).collect(Collectors.toList());
    	List<ParentDealer> parentDealers = parentDealerList.stream().sorted((p1,p2)->p1.getParentDealerName().compareToIgnoreCase(p2.getParentDealerName())).collect(Collectors.toList());
    	List<LineManager> fsdms = fsdmList.stream().sorted((f1,f2)->f1.getName().compareToIgnoreCase(f2.getName())).collect(Collectors.toList());
    	List<HRE> dealers = dealerList.stream().sorted((d1,d2)->d1.getName().compareToIgnoreCase(d2.getName())).collect(Collectors.toList());
    	List<Outlet> outlets = outletList.stream().sorted((o1,o2) -> o1.getOutletCode().compareToIgnoreCase(o2.getOutletCode())).collect(Collectors.toList());
    	
        final List<Outlet> outlets2 = new ArrayList<Outlet>();
        String temp = "";
        for (final Outlet o3 : outlets) {
            if (temp.equals(o3.getOutletName())) {
                continue;
            }
            temp = o3.getOutletName();
            outlets2.add(o3);
        }
       // final List<Outlet> outlets3 = outlets2.stream().sorted((o1, o2) -> o1.getOutletName().compareToIgnoreCase(o2.getOutletName())).collect((Collector<? super Object, ?, List<Outlet>>)Collectors.toList());
        List<Outlet> outlets3 = outlets2.stream().sorted((o1,o2)->o1.getOutletName().compareToIgnoreCase(o2.getOutletName())).collect(Collectors.toList());
        model.addAttribute("regions", (Object)regions);
        model.addAttribute("states", (Object)states);
        model.addAttribute("cities", (Object)cities);
        model.addAttribute("pDealers", (Object)parentDealers);
        model.addAttribute("fsdms", (Object)fsdms);
        model.addAttribute("dealers", (Object)dealers);
        model.addAttribute("dealerCodeList", (Object)outlets);
        model.addAttribute("dealerShipList", (Object)outlets3);
        return model;
    }
    
    */
}

