package com.armezo.duflon.controller;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.MasterData;
import com.armezo.duflon.Services.MasterDataService;

@Controller
public class ControlPanelController {
	
	@Autowired
	private MasterDataService masterDataService;
	
	@GetMapping("/controlPanel")
	public String showControlPanel(Model model, HttpSession session) {
		if(session.getAttribute("role")!=null) {
			String role = session.getAttribute("role").toString();
			if(role.equalsIgnoreCase("HOD") || role.equalsIgnoreCase("SA")) {
				//Get All Masters
				List<MasterData> masters = masterDataService.getAllMasterData();
				List<String> uniqueMasterList = masters.stream().map(MasterData :: getMasterName).distinct().sorted().collect(Collectors.toList());
				List<MasterData> masterList = masters.stream()
						.sorted(Comparator.comparing(MasterData :: getMasterName).thenComparing(MasterData :: getMasterDescription))
						.collect(Collectors.toList());
				model.addAttribute("uniqueMaster", uniqueMasterList);
				model.addAttribute("masters", masterList);
				return "control-panel";
			}else {
				return "redirect:login";
			}
		}else {
			return "redirect:login";
		}
	}
	//Hello
	//Save new master Data
	@PostMapping("/saveMasterData")
	@ResponseBody
	public String saveOrUpdateMasterData(@RequestParam(value="id", required = false) Long id,@RequestParam("masterDescription") String masterDescription, @RequestParam("masterName") String masterName,
			@RequestParam(value ="masterNew", required = false) String masterNew, Model model) {
			MasterData master = new MasterData();
			if(id!=null) {
				Optional<MasterData> optional = masterDataService.getMasterDataById(id);
				master = optional.isPresent() ? optional.get() : new MasterData();
			/*	if (optional.isPresent()) {
					master = optional.get();
				}*/
			}
			master.setMasterDescription(masterDescription);
			if(masterName.equalsIgnoreCase("Custom")) {
				master.setMasterName(masterNew);
			}else {
				master.setMasterName(masterName);
			}
			masterDataService.saveMasterData(master);
			return "success";
	}
	
	@GetMapping("/deleteMasterData")
	@ResponseBody
	public String deleteMasterData(@RequestParam("id") Long id) {
		String message = "";
		Optional<MasterData> masterOptional = masterDataService.getMasterDataById(id);
		if(masterOptional.isPresent()) {
			masterDataService.deleteMaster(masterOptional.get());
			message = "Master data has been successfully deleted.";
		}else {
			message = "Master data not found.";
		}
		return message;
	}

}
