package com.armezo.duflon.client;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.QuestiwiseReport;
import com.armezo.duflon.Services.QuestiwiseReportService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;

@Service
public class RestClienQuestionReport {

	
	@Autowired
	RestTemplate restTemplate;
	@Autowired
	ParticipantServiceImpl participantServiceImpl;
	@Autowired
	QuestiwiseReportService questiwiseReportService;
	@Value("${Ap.assessmentURL}")
	private String assessmentURL;
	
	public  void callClient() {
		List<ParticipantRegistration> list =participantServiceImpl.getParticipant();
		for(ParticipantRegistration p:list) {
			List<QuestiwiseReport>queList=	questiwiseReportService.getByAcesskey(p.getAccessKey());
			if(queList.size()==0) {
			String url=assessmentURL+"pa/QuestionReportByAccesskey?accesskey="+p.getAccessKey()+"&testid=44";	
			ResponseEntity<String> response = restTemplate.getForEntity(url,String.class);
			JSONArray arr = new JSONArray(response.getBody());
			List<QuestiwiseReport>saveList = new ArrayList<>();
			for (int i = 0; i < arr.length(); i++) {
				QuestiwiseReport que = new QuestiwiseReport();
				JSONObject res = arr.getJSONObject(i); 
				que.setAccesskey(res.getString("accesskey"));
				que.setOption(res.getString("seloption"));
				que.setSrno(res.getInt("srno"));
				que.setQuestion(res.getInt("questionid"));
				que.setSecsion(res.getInt("sectionid"));
				saveList.add(que);
			}
			questiwiseReportService.saveAll(saveList);
			participantServiceImpl.updateQuestionReportStatus(p.getAccessKey());
			}
			
		}
	}
	
	
	public  void callClient(String accesskey) {
		
			List<QuestiwiseReport>queList=	questiwiseReportService.getByAcesskey(accesskey);
			if(queList.size()==0) {
			String url=assessmentURL+"pa/QuestionReportByAccesskey?accesskey="+accesskey+"&testid=44";	
			ResponseEntity<String> response = restTemplate.getForEntity(url,String.class);
			JSONArray arr = new JSONArray(response.getBody());
			List<QuestiwiseReport>saveList = new ArrayList<>();
			for (int i = 0; i < arr.length(); i++) {
				QuestiwiseReport que = new QuestiwiseReport();
				JSONObject res = arr.getJSONObject(i); 
				que.setAccesskey(res.getString("accesskey"));
				que.setOption(res.getString("seloption"));
				que.setSrno(res.getInt("srno"));
				que.setQuestion(res.getInt("questionid"));
				que.setSecsion(res.getInt("sectionid"));
				saveList.add(que);
			}
			questiwiseReportService.saveAll(saveList);
			participantServiceImpl.updateQuestionReportStatus(accesskey);
			}
		
		
	}
}
