package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.foodRecipe.demo.dto.Member;

@Mapper
public interface MemberDao {

	@Select("SELECT IF(COUNT(*) = 1, 1, 0) FROM member WHERE email = #{email}")
	public boolean isEmailExists(String email);

	@Insert("""
			INSERT INTO member(email, pw, name, phoneNumber, bir, nickName, regDate, updateDate) 
			VALUE(#{email}, #{pw}, #{name}, #{phoneNumber}, #{bir}, #{nickName}, NOW(), NOW())
			"""
			)
	public void insertMember(Member member);

	@Select("SELECT * FROM member WHERE email=#{email} AND pw=#{pw}")
	public Member findMemberByEmailAndPw(String email, String pw);

}
