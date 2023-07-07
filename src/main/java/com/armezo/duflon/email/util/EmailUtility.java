package com.armezo.duflon.email.util;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.armezo.duflon.Entities.ErrorLogger;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.ErrorLoggerService;
import com.armezo.duflon.utils.DataProccessor;

@Component
public class EmailUtility {
	
	@Autowired
    private static ErrorLoggerService errorService;
	
	private static ExecutorService executorService = Executors.newFixedThreadPool(5); // Here 2 thread will be created
	
	public static final void sendMailDuflon(String to, String from, String cc, String bcc, String sub, String mes,	String smtp)  {
		executorService.submit(() -> {
			sendMail(to, from, cc, bcc, sub, mes, smtp);
		});
	}
	
	
	/**
	 * Send a message. The message will be sent to all recepient addresses. <br>
	 *
	 * @param to
	 *            the recepeint's email address
	 * @param from
	 *            the sender's email address
	 * @param cc
	 *            the email address marked for cc
	 * @param bcc
	 *            the email address marked for bcc
	 * @param sub
	 *            the subject of a mail
	 * @param mes
	 *            the message (content) of a mail
	 * @param smtp
	 *            set SMTP IP (Mail Server IP) <br>
	 * @return returns <code>boolean</code> value on the basis of mail status,
	 *         <code>false</code> if there is an error in sending Mail else return
	 *         <code>true</code>.
	 * @throws UnsupportedEncodingException 
	 */

	public static final boolean sendMail(String to, String from, String cc, String bcc, String sub, String mes,	String smtp)  {

		
		from = "support@armezosolutions.com";
		boolean FLAG = false;

		// Replace smtp_username with your Amazon SES SMTP user name.
		final String SMTP_USERNAME = "AKIAJ66JFUOFYAWHTFRA";

		// Replace smtp_password with your Amazon SES SMTP password.
		final String SMTP_PASSWORD = "BGnRJkcHHk2I+61/zTvT3azdAo+3xxhyTBG9zx3B56dx";

		/*String SMTP_USERNAME = "AKIAJ66JFUOFYAWHTFRA";
		String SMTP_PASSWORD = "BGnRJkcHHk2I+61/zTvT3azdAo+3xxhyTBG9zx3B56dx";*/

		
		// for more information.
		final String HOST = "email-smtp.us-east-1.amazonaws.com";

		// The port you will connect to on the Amazon SES SMTP endpoint. 
		final int PORT = 587;

		Properties props = System.getProperties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.port", PORT); 
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");

		// Create a Session object to represent a mail session with the specified properties. 
		Session session = Session.getDefaultInstance(props);

		// Create a message with the specified information. 
		MimeMessage msg = new MimeMessage(session);
		Transport transport=null;
		try {
		msg.setFrom(new InternetAddress(from,"DuRecruit"));
		
		InternetAddress[] parse = InternetAddress.parse(cc , true);
		
		InternetAddress[] parseTo = InternetAddress.parse(to , true);
		
		if(parseTo.length>0) {
		   ///msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			msg.setRecipients(javax.mail.Message.RecipientType.TO,  parseTo);
		}
		
		if(parse.length>0 )
		{
			msg.setRecipients(javax.mail.Message.RecipientType.CC,  parse);
		//msg.setRecipient(Message.RecipientType.CC,new InternetAddress(cc));
		}
				
		//msg.setRecipient(Message.RecipientType.BCC, new InternetAddress("testarmezo@gmail.com"));
		
		msg.setSubject(sub);
		
		msg.setContent(mes,"text/html");
		// Add a configuration set header. Comment or delete the 
		// next line if you are not using a configuration set
		//msg.setHeader("X-SES-CONFIGURATION-SET", CONFIGSET);

		// Create a transport.
		transport = session.getTransport();
		
		// Send the message.
		
			// Connect to Amazon SES using the SMTP username and password you specified above.
			transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
			
			// Send the email.
			transport.sendMessage(msg, msg.getAllRecipients());
			
			FLAG=true;
			System.out.println("Email sent!");
		}
		
		catch (UnsupportedEncodingException | MessagingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			ErrorLogger error = new ErrorLogger();
            error.setAccesskey("");
            error.setErrorMessage(e2.getMessage());
            error.setErrorTime(LocalDateTime.now());
            error.setProcess("Email Sending");
            errorService.saveErrorLogger(error);
			System.out.println("The email was not sent.");
			System.out.println("Error message: " + e2.getMessage());
			return false;
		}
		finally
		{
			// Close and terminate the connection.
			try {
				transport.close();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		return FLAG;

	}

	/**
	 * This method is used to validate given email address. <br>
	 *
	 * @param estr
	 *            the email address for validation <br>
	 * @return returns <code>boolean</code> value. if email address is valid,
	 *         returns <code>true</code> else <code>false</code>
	 */

	public static final boolean validateMail(String estr) {
		String str = estr;
		String regExpr = "^[\\w\\.-]{1,}\\@([\\da-zA-Z-]{1,}\\.){1,}[\\da-zA-Z-]+$";
		Pattern pat;

		// Pattern Matching will be case insensitive.
		pat = Pattern.compile(regExpr, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pat.matcher(str);

		if (matcher.find()) {
			return true;
		} else {
			return false;
		}
	}
	
	//Using Utility to Send Participant Mail
	/*public static void sendEmailToParticipant(ParticipantRegistration part, String fileName) {
		String name = (part.getFirstName() == null ? "" : part.getFirstName()) + " "
				+ (part.getMiddleName() == null ? "" : part.getMiddleName()) + " "
				+ (part.getLastName() == null ? "" : part.getLastName());
		String subjectLine = "";
		String mailBody = "";
		if (fileName.equalsIgnoreCase("registration")) {
			subjectLine = "Your Job Application: Registration";
			mailBody = DataProccessor.readFileFromResource("duflonForRegistration");
		}
		if (fileName.equalsIgnoreCase("invitation")) {
			subjectLine = "Your Job Application: Assessment Invitation";
			mailBody = DataProccessor.readFileFromResource("duflonForInvitation");
			mailBody = mailBody.replace("${accesskey}", part.getAccessKey());
		}
		if (fileName.equalsIgnoreCase("interview")) {
			subjectLine = "Your Job Application: Assessment Invitation";
			mailBody = DataProccessor.readFileFromResource("interviewScheduleEmail");
			mailBody = mailBody.replace("${accesskey}", part.getAccessKey());
		}
		executorService.submit(() -> {
			
		});
	}*/

}
