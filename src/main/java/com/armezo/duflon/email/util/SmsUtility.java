package com.armezo.duflon.email.util;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.net.URL;


import java.io.*;
import java.util.Base64;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLPeerUnverifiedException;
import java.security.cert.Certificate;
import java.text.SimpleDateFormat;

public class SmsUtility {



	public static String sendSmsHandler( String mobileNumber, String msg,String senderId ) {
		if(mobileNumber.length()==10) {
			mobileNumber = "91"+mobileNumber;
		}
		msg = msg.replace(" ","%20");
		String url=	"https://sms4.tatacommunications.com:3821/sendsms?username=m_msil_lapp&password=w8P3CxnF&from="+senderId+"&to="+mobileNumber+"&text="+msg;
		String user="";  
		 try {
		    RestTemplate template = new RestTemplate();
			 user = template.getForObject(url, String.class);	
			  getHTML(url);
			}catch(Exception e) {
				e.printStackTrace();
			}

		return user;
	}
	
	
	public static String sendSmsHandlerRecuted( String mobileNumber, String msg,String senderId ) {
		if(mobileNumber.length()==10) {
			mobileNumber = "91"+mobileNumber;
		}
		msg = msg.replace(" ","%20");
		String url=	"https://sms4.tatacommunications.com:3821/sendsms?username=m_msil_lapp&password=w8P3CxnF&from="+senderId+"&to="+mobileNumber+"&text="+msg;
		String user="";  
		 try {
		    RestTemplate template = new RestTemplate();
			 user = template.getForObject(url, String.class);	
			 getHTML(url);
			}catch(Exception e) {
				e.printStackTrace();
			}

		return user;
	}
	
	public static String sendSmsPromotional( String mobileNumber, String msg,String senderId,String emplateid ) {
		if(mobileNumber.length()==10) {
			mobileNumber = "91"+mobileNumber;
		}
			msg = msg.replace(" ","%20");
		
		String url=	"https://sms3.tatacommunications.com:3821/sendsms?username=m_msil_lapp1&password=q4GCPGzG"
				+ "&from=522225&to="+mobileNumber
				+ "&text="+msg
				+ "&dlr-mask=31&PE_ID=1601100000000001379"
				+ "&TEMPLATE_ID="+emplateid
				+ "&dlr-url=";
		String user="";  
		
		
		  try {
			  RestTemplate template = new RestTemplate(); 
		    user =  template.getForObject(url, String.class); 
		  
		  }catch(Exception e) { 
			  e.printStackTrace();
		 }
		 
		 
		 StringBuilder sb = new StringBuilder();
	        String testName="";
	       
		return user;
	}
	
	
	public static String getHTML(String urlToRead) throws Exception {
	      StringBuilder result = new StringBuilder();
	      URL url = new URL(urlToRead);
	      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	      conn.setRequestMethod("GET");
	      try (BufferedReader reader = new BufferedReader(
	                  new InputStreamReader(conn.getInputStream()))) {
	          for (String line; (line = reader.readLine()) != null; ) {
	              result.append(line);
	          }
	      }
	      return result.toString();
	   }			
		  
}
