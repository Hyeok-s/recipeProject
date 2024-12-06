package com.foodRecipe.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodRecipe.demo.dto.Category;
import com.foodRecipe.demo.dto.Comment;
import com.foodRecipe.demo.dto.Community;
import com.foodRecipe.demo.service.CommunityService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommunityController {
	private CommunityService communityService;
	
	public CommunityController(CommunityService communityService) {
		this.communityService = communityService;
	}
	
	
	@GetMapping("/community/communityForm")
	public String coummunityForm(@RequestParam(value = "categoryId", defaultValue = "0") int categoryId,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		Map<String, List<Category>> categories = communityService.findAllCategory();
		model.addAttribute("categories", categories);
		
		List<Community> cmuLists = new ArrayList<>();
		
		if(categoryId == 0) {
			cmuLists = communityService.findAllCommunity();
		}
		else {
			cmuLists = communityService.findCommunityByCategoryId(categoryId);
		}
		
		if (cmuLists != null || !cmuLists.isEmpty()) {
			int pageSize = 18;
			int start = (page - 1) * pageSize;
			int end = Math.min(start + pageSize, cmuLists.size());

			List<Community> pagedCommunity = cmuLists.subList(start, end);
			model.addAttribute("cmuLists", pagedCommunity);
			
			int pageCnt = (int) Math.ceil((double) cmuLists.size() / pageSize);
			model.addAttribute("page", page);
		    model.addAttribute("pageCnt", pageCnt);
		}
		return "community/community";
	}
	
	@GetMapping("/community/detail")
	public String detailForm(@RequestParam("id") int communityId, Model model, HttpSession session) {
		Map<String, List<Category>> categories = communityService.findAllCategory();
		Community cmu = communityService.findCommunityById(communityId);
		
		List<Comment> comments = communityService.findCommentByCommunityId(communityId);
		model.addAttribute("categories", categories);
		model.addAttribute("cmu", cmu);
		model.addAttribute("comments", comments);
		if(session.getAttribute("memberId") != null) {
			model.addAttribute("memberId" , (int) session.getAttribute("memberId"));
		}
		return "community/detail";
	}
	
	@GetMapping("/community/checkLogin")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkLogin(HttpSession session) {
	    boolean isLoggedIn = session.getAttribute("memberId") != null;
	    Map<String, Boolean> response = new HashMap<>();
	    response.put("loggedIn", isLoggedIn);
	    return ResponseEntity.ok(response);
	}
	
	 // 댓글 추가
	@PostMapping("/community/addComment")
	@ResponseBody
	public ResponseEntity<Comment> addComment(@RequestBody Comment request, HttpSession session) {
	    try {
			int loginId = (int) session.getAttribute("memberId");
			request.setMemberId(loginId);
	    	communityService.insertComment(request);
	    	Comment insertedComment = communityService.findCommentById(request.getId());
	        return ResponseEntity.ok(insertedComment);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	@PostMapping("/community/editComment")
	@ResponseBody
	public ResponseEntity<Comment> editComment(@RequestBody Comment request) {
	    try {
	    	System.out.println(request);
	    	communityService.updateComment(request);
	    	Comment updateComment = communityService.findCommentById(request.getId());
	    	System.out.println(updateComment);
	        return ResponseEntity.ok(updateComment);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
}
