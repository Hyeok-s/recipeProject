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

}
