package com.armezo.duflon.email.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.Callable;

public class SendEmailUtility implements Callable<SendPayload> {

	private final SendPayload sendPayload;
	boolean flag = false;

	public SendEmailUtility(SendPayload sendPayload) {
		this.sendPayload = sendPayload;
	}

	@Override
	public SendPayload call() throws Exception {

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date dateobj = new Date();

		flag = EmailUtility.sendMail(sendPayload.getTo(), sendPayload.getFrom(), sendPayload.getCc(),
				sendPayload.getBcc(), sendPayload.getSubjectLine(), sendPayload.getMsg(), "smtp");

		sendPayload.setSentStatus(flag);
		sendPayload.setSendDate(df.format(dateobj));
		return sendPayload;
	}

}
