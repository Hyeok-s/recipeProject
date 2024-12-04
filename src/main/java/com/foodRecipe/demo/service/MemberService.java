package com.foodRecipe.demo.service;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.MemberDao;
import com.foodRecipe.demo.dto.Member;

@Service
public class MemberService {
	private MemberDao memberDao;
	
	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
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

}
