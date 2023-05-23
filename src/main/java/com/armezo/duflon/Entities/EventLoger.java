package com.armezo.duflon.Entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "event_loger")
public class EventLoger {
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
	private Integer Id;
	@Column(name = "user_id")
	private Integer userId;
	@Column(name = "event")
	private String event;
	//@LocalDateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "envet_time")
	private LocalDate eventTime;
	@Column(name = "accesskey")
	private String accesskey;
	@Column(name = "name")
	private String name;
	@Column(name = "email")
	private String email;
	
	public EventLoger() {
	}
	public Integer getId() {
		return Id;
	}
	public void setId(Integer id) {
		Id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public LocalDate getEventTime() {
		return eventTime;
	}
	public void setEventTime(LocalDate eventTime) {
		this.eventTime = eventTime;
	}
	public String getAccesskey() {
		return accesskey;
	}
	public void setAccesskey(String accesskey) {
		this.accesskey = accesskey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
