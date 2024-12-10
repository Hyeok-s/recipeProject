package com.foodRecipe.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.foodRecipe.demo.dto.Category;
import com.foodRecipe.demo.dto.Comment;
import com.foodRecipe.demo.dto.Community;
import com.foodRecipe.demo.dto.LikeDislike;

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

	@Delete("DELETE FROM comment WHERE id = #{id}")
	void deleteCommentById(int id);

	@Select("SELECT id FROM category WHERE mainCategory = #{mainCategory}")
	int findCategoryIdByMainCategory(String mainCategory);

	@Insert("""
			INSERT INTO community(title, body, regDate, updateDate, memberId, categoryId)
			 VALUE(#{title}, #{body}, NOW(), NOW(), #{memberId}, #{categoryId})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insertCommunity(Community newCommunity);

	@Delete("DELETE FROM community WHERE id = #{id}")
	void deleteCommunityById(int id);

	@Delete("DELETE FROM comment WHERE communityId = #{communityId}")
	void deleteCommentByCommunityId(int communityId);

	@Select("SELECT * FROM category WHERE id=#{id}")
	Category findCategoryById(int id);

	@Select("SELECT * FROM LikesDislikes WHERE memberId = #{memberId} AND communityId = #{communityId}")
	LikeDislike findByLikeDislikeByMemberIdAndCommunityId(int memberId, int communityId);

	@Delete("DELETE FROM LikesDislikes WHERE id = #{id}")
	void deleteLikeDislike(int id);

	@Update("UPDATE LikesDislikes SET likeStatus = #{likeStatus} WHERE id = #{id}")
	void updateLikeDislike(LikeDislike existing);

	@Insert("INSERT INTO LikesDislikes(likeStatus, communityId, memberId) VALUE(#{likeStatus}, #{communityId}, #{memberId})")
	void createLikeDislike(LikeDislike request);
	
	@Select("""
			SELECT 
			    SUM(CASE WHEN likeStatus = 0 THEN 1 ELSE 0 END) AS dislikeCount,
			    SUM(CASE WHEN likeStatus = 1 THEN 1 ELSE 0 END) AS likeCount
					FROM LikesDislikes
					WHERE communityId = #{communityId};
			""")
	LikeDislike findAllLikesDislikesByCommunityId(int communityId);

	@Select("""
			SELECT COUNT(*) 
				FROM LikesDislikes 
				WHERE likeStatus = 1 
				  AND memberId = #{memberId} AND communityId = #{communityId};
			""")
	boolean isLikedByUser(int communityId, int memberId);
	
	@Select("""
			SELECT COUNT(*) 
				FROM LikesDislikes 
				WHERE likeStatus = 0
				  AND memberId = #{memberId} AND communityId = #{communityId};
			""")
	boolean isDislikedByUser(int communityId, int memberId);

	@Update("""
			UPDATE community SET title=#{title}, body=#{body}, categoryId = #{categoryId}
				WHERE id = #{id}
			""")
	void updateCommunity(Community community);
	
}
