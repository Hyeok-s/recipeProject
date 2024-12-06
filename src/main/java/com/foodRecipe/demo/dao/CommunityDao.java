package com.foodRecipe.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.foodRecipe.demo.dto.Category;
import com.foodRecipe.demo.dto.Comment;
import com.foodRecipe.demo.dto.Community;

@Mapper
public interface CommunityDao {

	@Select("""
			SELECT c.id, c.title, c.regDate, c.count, m.nickName FROM community c 
			INNER JOIN member m ON c.memberId = m.id ORDER BY regDate DESC
			""")
	List<Community> findAllCommunity();

	@Select("SELECT * FROM category ORDER BY id")
	List<Category> findAllCategory();
	
	@Select("""
			SELECT c.id, c.title, c.regDate, c.count, m.nickName FROM community c 
			INNER JOIN member m ON c.memberId = m.id WHERE c.categoryId = #{categoryId}
			ORDER BY regDate DESC
			""")
	List<Community> findCommunityByCategoryId(int categoryId);

	@Select("""
			SELECT c.*,  m.nickName FROM community c 
			INNER JOIN member m ON c.memberId = m.id WHERE c.id = #{id}
			""")
	Community findCommunityById(int id);

	@Select("""
			SELECT c.*, m.nickName FROM comment c INNER JOIN member m 
			ON c.memberId = m.id WHERE c.communityId = #{communityId} ORDER BY c.updateDate DESC
			""")
	List<Comment> findCommentByCommunityId(int communityId);

	@Insert("INSERT INTO comment(body, updateDate, memberId, communityId) VALUE(#{body}, NOW(), #{memberId}, #{communityId})")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	void insertComment(Comment request);
	
	@Select("SELECT c.*, m.nickName FROM comment c INNER JOIN member m ON c.memberId = m.id WHERE c.id = #{id}")
	Comment findCommentById(int id);

	@Update("UPDATE comment SET body = #{body}, updateDate = NOW() WHERE id = #{id}")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	void updateComment(Comment request);
}
