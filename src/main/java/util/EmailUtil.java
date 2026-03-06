package util;

		import java.util.Properties;
    	import jakarta.mail.*;
    	import jakarta.mail.internet.*;

    	public class EmailUtil {

    	    private static final String FROM_EMAIL = "oceanviewresort26@gmail.com"; 
    	    private static final String APP_PASSWORD = "sila lwfp hbdj nptg";       

    	    public static void sendEmail(String toEmail, String subject, String body) {

    	        Properties props = new Properties();
    	        props.put("mail.smtp.auth", "true");
    	        props.put("mail.smtp.starttls.enable", "true");
    	        props.put("mail.smtp.host", "smtp.gmail.com");
    	        props.put("mail.smtp.port", "587");

    	        Session session = Session.getInstance(props, new Authenticator() {
    	            protected PasswordAuthentication getPasswordAuthentication() {
    	                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
    	            }
    	        });

    	        try {
    	            Message message = new MimeMessage(session);
    	            message.setFrom(new InternetAddress(FROM_EMAIL, "Ocean View Resort"));
    	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
    	            message.setSubject(subject);
    	            message.setText(body);

    	            Transport.send(message);
    	            System.out.println("Email sent successfully to " + toEmail);

    	        } catch (Exception e) {
    	            e.printStackTrace();
    	        }
    	    }
    	}