package com.armezo.duflon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ControllerQBAnalysis {

	
	@GetMapping("/qb-analysis")
	public String getqQbAnalysis() {
		return "qb-analysis";
	}
	
	@GetMapping("/question-analysis")
	public String getQuestionAnalysis() {
		return "question-analysis";
	}
}
