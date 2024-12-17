package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.foodRecipe.demo.dto.Member;
import org.apache.ibatis.annotations.Update;

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
	
	@Select("SELECT * FROM member WHERE id = #{id}")
	public Member finMemberById(int id);
	
	@Select("SELECT COUNT(*) FROM member WHERE id = #{memberId} AND pw = #{pw}")
	public boolean checkPassword(int memberId, String pw);
	
	@Update("<script>" +
	        "UPDATE member " +
	        "SET " +
	        "<if test='pw != \"\"'>pw = #{pw},</if>" +
	        "nickName = #{nickName} " +
	        "WHERE id = #{id}" +
	        "</script>")
	public void updateMember(int id, String pw, String nickName);

}
