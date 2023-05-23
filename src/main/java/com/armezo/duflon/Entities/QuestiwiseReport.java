package com.armezo.duflon.Entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class QuestiwiseReport {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	private String  accesskey;
	private Integer secsion;
	private Integer question;
	private String  option;
	private Integer srno;
	public QuestiwiseReport() {	
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAccesskey() {
		return accesskey;
	}
	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}
	public Integer getSecsion() {
		return secsion;
	}
	public void setSecsion(Integer secsion) {
		this.secsion = secsion;
	}
	public Integer getQuestion() {
		return question;
	}
	public void setQuestion(Integer question) {
		this.question = question;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public Integer getSrno() {
		return srno;
	}
	public void setSrno(Integer srno) {
		this.srno = srno;
	}
	
	
}
