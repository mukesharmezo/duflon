package com.armezo.duflon.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.QuestiwiseReport;
import com.armezo.duflon.Repositories.QuestiwiseReportRepository;

@Service
public class QuestiwiseReportService {
	
@Autowired
private QuestiwiseReportRepository questiwiseReportRepository;


  public void saveAll(List<QuestiwiseReport>list) {
	questiwiseReportRepository.saveAll(list);
  }
  
  public List<QuestiwiseReport> getByAcesskey(String accesskey){
	return  questiwiseReportRepository.getByAcesskey(accesskey);
  }
}
