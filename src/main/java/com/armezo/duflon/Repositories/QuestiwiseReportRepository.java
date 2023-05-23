package com.armezo.duflon.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.Entities.QuestiwiseReport;


public interface QuestiwiseReportRepository extends JpaRepository<QuestiwiseReport,Integer>{
	
	@Query("SELECT q FROM QuestiwiseReport q WHERE q.accesskey =:accesskey")
	List<QuestiwiseReport> getByAcesskey(String  accesskey);
}
