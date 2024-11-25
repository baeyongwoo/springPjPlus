package utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;



@Service
public class EmailService {
	private static final String mail = "dyddn30612@naver.com";
	

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String text) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        CreateAuthCode code = new CreateAuthCode();
        helper.setTo(to);
        helper.setSubject("[IOCompany]" + subject);
        helper.setText(text, true);
        helper.setFrom(mail);

        mailSender.send(message);
    }
}
