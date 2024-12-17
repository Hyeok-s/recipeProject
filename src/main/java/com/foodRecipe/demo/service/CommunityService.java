package com.foodRecipe.demo.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.CommunityDao;
import com.foodRecipe.demo.dto.Category;
import com.foodRecipe.demo.dto.Comment;
import com.foodRecipe.demo.dto.Community;
import com.foodRecipe.demo.dto.LikeDislike;

@Service
public class CommunityService {
	private CommunityDao communityDao;
	public CommunityService(CommunityDao communityDao) {
		this.communityDao = communityDao;
	}
	
	public List<Community> findAllCommunity() {
		return communityDao.findAllCommunity();
	}
	
	
	public Map<String, List<Category>> findAllCategory() {
	    List<Category> categories = communityDao.findAllCategory();
	    Map<String, List<Category>> categoryMap = new LinkedHashMap<>();

	    for (Category category : categories) {
	        categoryMap
	            .computeIfAbsent(category.getMainCategory(), k -> new ArrayList<>())
	            .add(category);
	    }
	    return categoryMap;
	}

	public List<Community> findCommunityByCategoryId(int categoryId) {
		return communityDao.findCommunityByCategoryId(categoryId);
	}

	public Community findCommunityById(int id) {
		return communityDao.findCommunityById(id);
	}

	public List<Comment> findCommentByCommunityId(int communityId) {
		return communityDao.findCommentByCommunityId(communityId);
	}

	public void insertComment(Comment request) {
		communityDao.insertComment(request);
		
	}
	
	public Comment findCommentById(int id) {
		return communityDao.findCommentById(id);
	}

	public void updateComment(Comment request) {
		communityDao.updateComment(request);
		
	}

	public boolean deleteCommentById(int id) {
		if(communityDao.findCommentById(id) == null) {
			return false;
		}
		communityDao.deleteCommentById(id);
		return true;
	}

	public int findCategoryIdByMainCategory(String mainCategory) {
		return communityDao.findCategoryIdByMainCategory(mainCategory);
	}

	public void insertCommunity(Community newCommunity) {
		communityDao.insertCommunity(newCommunity);
	}

	public void deleteCommunityById(int id) {
		communityDao.deleteCommunityById(id);
	}

	public void deleteCommentByCommunityId(int communityId) {
		communityDao.deleteCommentByCommunityId(communityId);
	}

	public Category findCategoryById(int id) {
		return communityDao.findCategoryById(id);
	}

	public String toggleLikeDislike(LikeDislike request) {
		LikeDislike existing = communityDao.findByLikeDislikeByMemberIdAndCommunityId(request.getMemberId(), request.getCommunityId());
        if (existing != null) {
            // 동일한 상태라면 삭제
            if (existing.isLikeStatus() == request.isLikeStatus()) {
            	communityDao.deleteLikeDislike(existing.getId());
                return request.isLikeStatus() ? "좋아요가 취소되었습니다." : "싫어요가 취소되었습니다.";
            } else {
                // 상태가 다르면 업데이트
                existing.setLikeStatus(request.isLikeStatus());
                communityDao.updateLikeDislike(existing);
                return request.isLikeStatus() ? "싫어요가 좋아요로 변경되었습니다." : "좋아요가 싫어요로 변경되었습니다.";
            }
        } else {
        	communityDao.createLikeDislike(request);
            return request.isLikeStatus() ? "좋아요가 등록되었습니다." : "싫어요가 등록되었습니다.";
        }
	}
	
	public LikeDislike findAllLikesDislikesByCommunityId(int communityId) {
		return communityDao.findAllLikesDislikesByCommunityId(communityId);
	}

	public boolean isLikedByUser(int communityId, int memberId) {
		return communityDao.isLikedByUser(communityId, memberId);
	}

	public boolean isDislikedByUser(int communityId, int memberId) {
		return communityDao.isDislikedByUser(communityId, memberId);
	}

	public void updateCommunity(Community community) {
		communityDao.updateCommunity(community);
	}

	public void incrementCommunityCount(int communityId) {
		communityDao.incrementCommunityCount(communityId);
		
	}


}
