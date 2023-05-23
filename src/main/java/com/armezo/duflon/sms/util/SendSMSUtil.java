package com.armezo.duflon.sms.util;

public class SendSMSUtil {
	
	
	public static String sendSms(SmsPayload smsPayload) {
		String smsUrl = "https://api.myvfirst.com/psms/servlet/psms.Eservice2?action=send&data=<?xml\r\n"
				+ "version='1.0' encoding='ISO-8859-1'?><!DOCTYPE MESSAGE SYSTEM\r\n"
				+ "'https://127.0.0.1/psms/dtd/messagev12.dtd' ><MESSAGE VER='1.2'><USER USERNAME='exon'\r\n"
				+ "PASSWORD='exon1245'/><SMS UDH='0' CODING='1' TEXT='Dear Candidate! The details of the "+smsPayload.getRecieverName()+" have been sent to your registered email id, kindly check once. Team Armezo  forwarded by Armezo' PROPERTY='0' ID='1'> <ADDRESS\r\n"
				+ "FROM='"+smsPayload.getSenderName()+"' TO='91"+smsPayload.getMobileNumber()+"' SEQ='1' TAG='' /></SMS></MESSAGE>";
		return smsUrl;
	}
	
	//demo testing
	/*
	public static String generateUrlToSendSms() {
		String url = "https://api.myvfirst.com/psms/servlet/psms.Eservice2?action=send&data=<?xml\r\n"
				+ "version='1.0' encoding='ISO-8859-1'?><!DOCTYPE MESSAGE SYSTEM\r\n"
				+ "'https://127.0.0.1/psms/dtd/messagev12.dtd' ><MESSAGE VER='1.2'><USER USERNAME='exon'\r\n"
				+ "PASSWORD='exon1245'/><SMS UDH='0' CODING='1' TEXT='Dear Candidate! The details of the DEMO TEST have been sent to your registered email id, kindly check once. Team Armezo  forwarded by Armezo' PROPERTY='0' ID='1'> <ADDRESS\r\n"
				+ "FROM='Armezo' TO='917607526679' SEQ='1' TAG='' /></SMS></MESSAGE>";
		return url;
	}
*/

}






















