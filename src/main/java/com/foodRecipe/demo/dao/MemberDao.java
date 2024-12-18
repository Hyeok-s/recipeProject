package com.foodRecipe.demo.dao;

import java.time.LocalDateTime;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.foodRecipe.demo.dto.Member;

@Mapper
public interface MemberDao {

	@Select("SELECT IF(COUNT(*) = 1, 1, 0) FROM member WHERE email = #{email}")
	public boolean isEmailExists(String email);

	@Insert("""
			INSERT INTO member(email, pw, name, phoneNumber, bir, nickName, regDate, updateDate, gender) 
			VALUE(#{email}, #{pw}, #{name}, #{phoneNumber}, #{bir}, #{nickName}, NOW(), NOW(), #{gender})
			"""
			)
	public void insertMember(Member member);

	@Select("SELECT * FROM member WHERE email=#{email} AND pw=#{pw}")
	public Member findMemberByEmailAndPw(String email, String pw);

	@Select("SELECT * FROM member WHERE id = #{id}")
	public Member finMemberById(int id);

	@Select("SELECT COUNT(*) FROM member WHERE id = #{memberId} AND pw = #{pw}")
	public boolean checkPassword(int memberId, String pw);


	@Update("""
			<script>
		        UPDATE member
		        SET
				<if test='pw != \"\"'>pw = #{pw},</if>
		        nickName = #{nickName}
		        WHERE id = #{id}
	        </script>
	        """)
	public void updateMember(int id, String pw, String nickName);

	@Insert("INSERT INTO token(email, token, expiration) VALUE(#{email}, #{token}, #{plusMinutes})")
	public void saveEmailVerificationToken(String email, String token, LocalDateTime plusMinutes);

	@Select("SELECT CASE WHEN expiration > NOW() THEN true ELSE false END FROM token WHERE token = #{token}")
    boolean verifyEmailToken(String token);

	@Select("SELECT EXISTS (SELECT 1 FROM token WHERE email = #{email} AND `check` = true AND expiration > NOW())")
	public boolean findCheckEmail(String email);

	@Update("UPDATE token SET `check` = true WHERE token = #{token}")
	public void changeCheck(String token);

}