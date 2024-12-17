package com.foodRecipe.demo.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.Collections;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import com.foodRecipe.demo.dto.Member;
import com.foodRecipe.demo.service.MemberService;
import com.foodRecipe.demo.util.Util;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	private MemberService memberService;

	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	@GetMapping("/member/signUpForm")
	public String signUpForm() {
		return "member/signUp";
	}

	@PostMapping("/member/signUp")
	    public String signUp(
	            @RequestParam("email") String email,
	            @RequestParam("pw") String pw,
	            @RequestParam("pwChk") String pwChk,
	            @RequestParam("name") String name,
	            @RequestParam("phone1") String phone1,
	            @RequestParam("phone2") String phone2,
	            @RequestParam("phone3") String phone3,
	            @RequestParam("birthYear") String birthYear,
	            @RequestParam("birthMonth") String birthMonth,
	            @RequestParam("birthDay") String birthDay,
	            @RequestParam("nickName") String nickName,
	            Model model) {
	        
			boolean exists = memberService.isEmailExists(email);
			if(exists) {
				return Util.jsReturn("이메일을 다시 확인해주세요", null);
			}
			if(!pw.equals(pwChk)) {
				return Util.jsReturn("비밀번호를 다시 확인해주세요", null);
			}
		
        	String fullPhone = phone1 + phone2 + phone3;
            int year = Integer.parseInt(birthYear);
            int month = Integer.parseInt(birthMonth);
            int day = Integer.parseInt(birthDay);
            String birStr  = String.format("%04d%02d%02d", year, month, day);
        	int bir =  Integer.parseInt(birStr);
        	
        	Member member = new Member(email, pw, name, fullPhone, bir, nickName);
        	
	        memberService.insertMember(member);

	        model.addAttribute("message", "회원가입이 완료되었습니다.");
	        return "redirect:/";
	    }

	@PostMapping("/member/checkEmail")
	@ResponseBody
	public ResponseEntity<String> checkEmail(@RequestParam String email) throws MessagingException {
		
		String token = UUID.randomUUID().toString();
		String verificationUrl = "http://example.com/verify?token=" + token;
		
		memberService.sendVerificationEmail(email, verificationUrl);
		
		return ResponseEntity.ok("이메일을 확인해 인증해주세요.");
	}
	
	
	@GetMapping("/member/loginForm")
	public String LoginForm() {
		return "member/login";
	}
	
	
	@PostMapping("/member/login")
	@ResponseBody
	public String Login(@RequestParam("email") String email,
            @RequestParam("pw") String pw, HttpSession session) {
		Member member = memberService.findMemberByEmailAndPw(email, pw);
		if(member == null) {
			return Util.jsReturn("아이디 또는 비밀번호를 확인해주세요", null);
		}
		session.setAttribute("memberId", member.getId());
		return Util.jsReturn(String.format("[ %s ] 님 로그인되었습니다.", member.getNickName()), "/");
	}
	
	@GetMapping("/member/logout")
	@ResponseBody
	public String Logout(HttpSession session) {
		session.removeAttribute("memberId");
		return Util.jsReturn("로그아웃되었습니다.", "/");
	}
	
	@GetMapping("/member/mypageForm")
	public String mypageForm(HttpSession session, Model model) {
		int id = (int)session.getAttribute("memberId");
		Member member = memberService.finMemberById(id);
		model.addAttribute("member", member);
		return "member/mypage";
	}
	@PostMapping("/member/checkPassword")
	@ResponseBody
	public Map<String, Boolean> checkPassword(@RequestBody Map<String, String> payload, HttpSession session) {
	    String pw = payload.get("password");
	    int memberId = (int) session.getAttribute("memberId");
	    boolean success = memberService.checkPassword(memberId, pw);
	    return Collections.singletonMap("success", success);
	}
	
	@PostMapping("/member/updateMember")
	@ResponseBody
	public String updateMember(
            @RequestParam("pw") String pw,
            @RequestParam("pwChk") String pwChk, @RequestParam("nickName") String nickName,
            HttpSession session) {
		
		if(!pw.equals(pwChk)) {
			return Util.jsReturn("비밀번호를 다시 확인해주세요", null);
		}
		int id = (int) session.getAttribute("memberId");
		memberService.updateMember(id, pw, nickName);
		return Util.jsReturn("변경되었습니다.", "/member/mypageForm");
	}
}
