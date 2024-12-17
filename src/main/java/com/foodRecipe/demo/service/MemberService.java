package com.foodRecipe.demo.service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.MemberDao;
import com.foodRecipe.demo.dto.Member;

import jakarta.mail.internet.MimeMessage;

@Service
public class MemberService {
	private MemberDao memberDao;
	private final JavaMailSender javaMailSender;

	public MemberService(MemberDao memberDao, JavaMailSender javaMailSender) {
		this.memberDao = memberDao;
		this.javaMailSender = javaMailSender;
	}
	
	public boolean isEmailExists(String email) {
		return memberDao.isEmailExists(email);
	}

	public void insertMember(Member member) {
		memberDao.insertMember(member);
	}

	public Member findMemberByEmailAndPw(String email, String pw) {
		return memberDao.findMemberByEmailAndPw(email, pw);
	}
	
	public Member finMemberById(int id) {
		return memberDao.finMemberById(id);
	}
	
	public boolean checkPassword(int memberId, String pw) {
		return memberDao.checkPassword(memberId, pw);
	}
	
	public void updateMember(int id, String pw, String nickName) {
		memberDao.updateMember(id, pw, nickName);
	}

	public void sendVerificationEmail(String email, String verificationUrl){
		String subject = "이메일 인증";
        String text = "<h1>이메일 인증을 완료하려면 아래 링크를 클릭하세요.</h1>" +
                     "<a href='" + verificationUrl + "'>이메일 인증</a>";

        MimeMessage message = javaMailSender.createMimeMessage();
        try {
        	MimeMessageHelper helper = new MimeMessageHelper(message, true);  // true: HTML 지원
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(text, true);
            javaMailSender.send(message);
        }
		 catch (Exception e) {
		            e.printStackTrace();
        }
    }
}
