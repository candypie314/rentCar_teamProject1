package com.RentLoGo.management.model;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailServiceImpl implements MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	@Async
	public void sendMail(String memberEmail, String title, String content) {
		
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("hr02cho@naver.com", "메일인증");
			messageHelper.setSubject(title);
			messageHelper.setTo(memberEmail);
			messageHelper.setText(content, true);
			
			mailSender.send(message);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
