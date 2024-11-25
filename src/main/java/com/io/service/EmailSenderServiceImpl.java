package com.io.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.nio.charset.StandardCharsets;

@Service
public class EmailSenderServiceImpl implements EmailSenderService {

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void sendEmail(String toEmail, String subject, String body) {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper;

        try {
            // UTF-8 인코딩을 명시적으로 설정
            helper = new MimeMessageHelper(message, true, StandardCharsets.UTF_8.name());
            helper.setFrom("dyddn30612@naver.com"); // 발신자 이메일 주소
            helper.setTo(toEmail);
            helper.setSubject(subject);
            helper.setText(body, true); // true로 설정하면 HTML 형식으로 전송됩니다.

            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("메일 전송 실패", e);
        }
    }
}
