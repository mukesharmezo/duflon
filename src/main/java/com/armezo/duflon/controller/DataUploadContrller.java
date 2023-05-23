package com.armezo.duflon.controller;

import org.springframework.stereotype.Controller;



@Controller
public class DataUploadContrller {
	/*
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
    
 
    
	@GetMapping(value = "/uploadCity")
	public String uploadCity() {
		return "uploadCity";
	}

	@PostMapping({ "/uploadCityPro" })
	public String uploadCityPro(@RequestParam("file") final MultipartFile file, final Model model) {
		final List<City> cityList = new ArrayList<City>();
		final List<City> duplicatecityList = new ArrayList<City>();
		XSSFWorkbook workbook = null;
		XSSFSheet worksheet = null;

		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			worksheet = workbook.getSheetAt(0);
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {

				final XSSFRow row = worksheet.getRow(i);
				if(row != null) {
				if (row != null && row.getCell(0) != null && row.getCell(1) != null) {
					
					final String cityName = row.getCell(0).getStringCellValue();
					final String cityCode = row.getCell(1).getNumericCellValue()+"";
					final String stateCode = row.getCell(2).getStringCellValue();
					if (cityService.checkDuplicate(cityName, cityCode)) {
						final City city = new City();
						city.setCityName(cityName);
						city.setCityCode(cityCode);
						duplicatecityList.add(city);
					} else {
						final City city = new City();
						city.setCityName(cityName);
						city.setCityCode(cityCode);
						city.setStateCode(stateCode);
						city.setStatus(true);
						cityList.add(city);

					}
				}
				}
				model.addAttribute("save_city", cityService.saveAllCity(cityList));
				model.addAttribute("duplicate_city", (Object) duplicatecityList);
			
			}
		} catch (Exception e) {
		e.printStackTrace();
			return "redirect:uploadCity?msgError=Invalid Formatt"+e;
		}
		return "uploadCity";
	}
	
	
	@GetMapping(value = "/uploadState")
	public String uploadState() {
		return "uploadState";
	}

	@PostMapping({ "/uploadStatePro" })
	public String uploadStatePro(@RequestParam("file") final MultipartFile file, final Model model) {
		final List<State> stateList = new ArrayList<State>();
		final List<State> duplicateStateList = new ArrayList<State>();
		XSSFWorkbook workbook = null;
		XSSFSheet worksheet = null;

		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			worksheet = workbook.getSheetAt(0);
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {
				
				final XSSFRow row = worksheet.getRow(i);
				if(row != null) {
				if (row != null && row.getCell(0) != null && row.getCell(1) != null ) {
					final String stateName = row.getCell(0).getStringCellValue();
					final String stateCode = row.getCell(1).getStringCellValue();
					final String regionCode = row.getCell(2).getStringCellValue();
					if (stateService.checkDuplicate(stateName, stateCode)) {
						final State state = new State();
						state.setStateName(stateName);
						state.setStateCode(stateCode);
						duplicateStateList.add(state);
					} else {
						final State state = new State();
						state.setStateName(stateName);
						state.setStateCode(stateCode);
						state.setRegionCode(regionCode);
						state.setStatus(true);
						stateList.add(state);
					}
				}
				}
				model.addAttribute("save_state", stateService.saveAll(stateList));
				model.addAttribute("duplicate_state", (Object) duplicateStateList);
			}
		} catch (Exception e) {
			System.out.println("Error..." + e);
			return "redirect:uploadState?msgError=Invalid Formatt";
		}
		return "uploadState";
	}
	//
	
	@GetMapping(value = "/uploadRegion")
	public String uploadRegion() {
		return "uploadRegion";
	}

	@PostMapping({ "/uploadRegionPro" })
	public String uploadRegionPro(@RequestParam("file") final MultipartFile file, final Model model) {
		final List<LineManager> fsdmList = new ArrayList<LineManager>();
		final List<LineManager> duplicatefsdmList = new ArrayList<LineManager>();
		XSSFWorkbook workbook = null;
		XSSFSheet worksheet = null;

		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			worksheet = workbook.getSheetAt(0);
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); ++i) {
				
				final XSSFRow row = worksheet.getRow(i);

				if (row != null && row.getCell(0) != null) {
					
					 String mobile="";
					final String mspin = row.getCell(0).getStringCellValue();
					final String name = row.getCell(1).getStringCellValue();
					final String email = row.getCell(2).getStringCellValue();
					 if(row.getCell(3).getStringCellValue() != null) {
					     mobile = row.getCell(3).getStringCellValue();
					 }
					final String regionCode = row.getCell(4).getStringCellValue();
					String[] egionCodes = regionCode.split(",");
					
					if (fsdmservice.checkDuplicate(mspin)) {
						final FSDM fsdm = new FSDM();
						fsdm.setMspin(mspin);
						fsdm.setName(name);
						fsdm.setEmail(email);
						fsdm.setMobile(mobile);
						
						duplicatefsdmList.add(fsdm);
					} else {
						final FSDM fsdm = new FSDM();
						fsdm.setMspin(mspin);
						fsdm.setName(name);
						fsdm.setEmail(email);
						fsdm.setPassword(genratePasswordFSDM());
						fsdm.setStatus(true);
						fsdm.setMobile(mobile);
						
						List<Region>regionList = new ArrayList<>();
						for(String s:egionCodes) {
						Region region = new Region();
						region.setRegionCode(s);
						region.setFsdm(fsdm);
						region.setStatus(true);
						regionList.add(region);
						}
						fsdm.setRegion(regionList);
						fsdmList.add(fsdm);  

					}
				}
				
				model.addAttribute("save_region", fsdmservice.saveAllFSDMS(fsdmList));
				model.addAttribute("duplicate_region",  duplicatefsdmList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:uploadRegion?msgError=Invalid Formatt";
		}
		return "uploadRegion";
	}
	
	@GetMapping(value = "/uploadTDM")
	public String uploadTDM() {
		return "uploadTDM";
	}

	@PostMapping({ "/uploadTDMPro" })
	public String uploadTDMPro(@RequestParam("file") final MultipartFile file, final Model model) {
		final List<HRE> tdmList = new ArrayList<HRE>();
		final List<HRE> duplicatetdmList = new ArrayList<HRE>();
		XSSFWorkbook workbook = null;
		XSSFSheet worksheet = null;
		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			worksheet = workbook.getSheetAt(0);
			Map<String,Outlet> outletmap = getOutlet( workbook.getSheetAt(1));
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); ++i) {
				final XSSFRow row = worksheet.getRow(i);
          
				if (row != null && row.getCell(0) != null && !row.getCell(0).equals("")) {
					String mobile="";
					final String mspin = row.getCell(0).getStringCellValue();
					final String name = row.getCell(1).getStringCellValue();
					 String email="";					
					//	email = row.getCell(2).getStringCellValue();
					//if(row.getCell(3).getStringCellValue() != null ) {
					// mobile = row.getCell(3).getStringCellValue();
					//}
					 
					final String outletName  = row.getCell(4).getStringCellValue();
					if(outletName != null) {
					String[] outletNames = outletName.split(",");
					
					for(int j=0; j<outletNames.length; j++) {
					}
					if (dealerService.checkDuplicate(mspin)) {
						final Dealer tdm = new Dealer();
						tdm.setMspin(mspin);
						tdm.setName(name);
						tdm.setEmail(email);
						tdm.setMobile(mobile);
						duplicatetdmList.add(tdm);
					} else {
						final Dealer tdm = new Dealer();
						tdm.setMspin(mspin);
						tdm.setName(name);
						tdm.setEmail(email);
						tdm.setMobile("");						
						tdm.setPassword(genratePasswordDealer());
						List<Outlet>ouptList = new ArrayList<>();
						for(String s:outletNames) {
						 Outlet outlet =	outletmap.get(s);			
						 outlet.setDealer(tdm);
						 ouptList.add(outlet);
						}
						tdm.setOutlet(ouptList);
						tdmList.add(tdm);  
					}
					}
				}
				model.addAttribute("save_tdm", dealerService.saveAll(tdmList));
				model.addAttribute("duplicate_tdm", (Object) duplicatetdmList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:uploadTDM?msgError=Invalid Formatt "+e;
		}
		return "uploadTDM";
	}
	
	private Map<String,Outlet> getOutlet(XSSFSheet worksheet ){
		Map<String,Outlet> map = new HashMap<>();
		
		for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); ++i) {

			final XSSFRow row = worksheet.getRow(i);
                if(row != null) {
			if (row != null && row.getCell(0) != null) {
				
				 String outletName = row.getCell(0).getStringCellValue();
				 String cityName = row.getCell(1).getStringCellValue();
				 String regionCode = row.getCell(2).getStringCellValue();
				 String parentDealerCode = row.getCell(3).getStringCellValue();
				// String stateName = row.getCell(4).getStringCellValue();
				// String location = row.getCell(5).getStringCellValue();
				 String outletCode = row.getCell(6).getStringCellValue();
				 String mapCode ="";
				 if(row.getCell(7).getStringCellValue() != null) {
				  mapCode = row.getCell(7).getStringCellValue();
				 }
				Optional<City> city = cityService.getCity(cityName);
				Optional<Region> region = regionService.getReagion(regionCode);
				//Optional<State> state =stateService.getState(stateName);
				List<State> state =  stateService.getStateCityCode(city.get().getStateCode());
				Optional<ParentDealer> parentDealer = parentDealerService.getParentDealerCode(parentDealerCode);
				Outlet outlet = new Outlet();
				outlet.setOutletName(outletName);
				//if(parentDealer.isPresent() && city.isPresent())
				//outlet.setOutletCode(parentDealer.get().getParentDealerCode()+"-"+city.get().getCityCode());
				outlet.setOutletCode(outletCode);
				outlet.setCity(city.get());
				outlet.setRegion(region.get());
				outlet.setState(state.get(0));
				outlet.setMapCode(mapCode);
				outlet.setParentDealer(parentDealer.get());
				map.put(outletCode, outlet);
			}
			}
		}
		//System.out.println(".........."+map.size());
		return map;
	}
	
	@GetMapping(value = "/uploadPrarentDealer")
	public String uploadPrarentDealer() {
		return "uploadPrarentDealer";
	}

	@PostMapping({ "/uploadPrarentDealerPro" })
	public String uploadPrarentDealerPro(@RequestParam("file") final MultipartFile file, final Model model) {
		final List<ParentDealer> parentDealerList = new ArrayList<ParentDealer>();
		final List<ParentDealer> duplicateParentDealerList = new ArrayList<ParentDealer>();
		XSSFWorkbook workbook = null;
		XSSFSheet worksheet = null;

		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			worksheet = workbook.getSheetAt(0);
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); ++i) {

				final XSSFRow row = worksheet.getRow(i);
				if (row != null && row.getCell(0) != null && row.getCell(1) != null) {
					final String parentName = row.getCell(0).getStringCellValue();
					final String parentCode = row.getCell(1).getStringCellValue();
					if (parentDealerService.checkDuplicate(parentName, parentCode)) {
						final ParentDealer parentDealer = new ParentDealer();
						parentDealer.setParentDealerName(parentName);
						parentDealer.setParentDealerCode(parentCode);
						duplicateParentDealerList.add(parentDealer);
					} else {
						final ParentDealer parentDealer = new ParentDealer();
						parentDealer.setParentDealerName(parentName);
						parentDealer.setParentDealerCode(parentCode);
						parentDealerList.add(parentDealer);
					}
				}
				model.addAttribute("save_prarentDealer", parentDealerService.saveAllCity(parentDealerList));
				model.addAttribute("duplicate_prarentDealer", (Object) duplicateParentDealerList);
			}
		} catch (Exception e) {
		e.printStackTrace();
			return "redirect:uploadPrarentDealer?msgError=Invalid Formatt";
		}
		return "uploadPrarentDealer";
	}
	
	
	private String genratePasswordDealer() {
		String password="";
		boolean check= false;
		while(!check) {
		password = Accesskey.getAccesskey();
		Optional<HRE> tdm = dealerService.getByPassword(password);
		if(tdm.isPresent()) {
			check = false;
		}else {
			check = true; 
		}
		}
		return password;
	}
	
	private String genratePasswordFSDM() {
		String password="";
		boolean check= false;
		while(!check) {
		password = Accesskey.getAccesskey();
		Optional<LineManager> tdm = fsdmservice.getByPassword(password);
		if(tdm.isPresent()) {
			check = false;
		}else {
			check = true; 
		}
		}
		return password;
	}
	*/
}
