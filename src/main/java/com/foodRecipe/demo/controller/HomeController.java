package com.foodRecipe.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	RecipeInfoService recipeInfoService;
	
	public HomeController(RecipeInfoService recipeInfoService) {
		this.recipeInfoService = recipeInfoService;
	}
	
	@GetMapping("/")
	public String main() {
		return "redirect:/home/main";
	}
	
	@GetMapping("/home/main")
	public String mainForm(
	        Model model, HttpSession session) {
	    if (session.getAttribute("memberId") != null) {
	        model.addAttribute("memberId", session.getAttribute("memberId"));
	    }
	    return "recipe/main";
	}
	
	@GetMapping("/recipe/search")
    @ResponseBody
	    public ResponseEntity<Map<String, Object>> searchRecipes(
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "query", required = false) String query,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort, HttpSession session) {
		 		final int pageSize = 20; // 페이지당 항목 수
		 		int offset = (page - 1) * pageSize;
		 		
		        Map<String, Object> response = new HashMap<>();
		        int memberId = 0;
		 		if(session.getAttribute("memberId") != null) {
		 			memberId = (int) session.getAttribute("memberId");
		 		}
		 		
		        List<Recipe_Info> recipeInfos = recipeInfoService.searchRecipes(query, sort, pageSize, offset, memberId);
		        response.put("recipeInfos", recipeInfos);
		        int totalDataCount = recipeInfoService.findTotalRecipeCountByQuery(query);
		        int totalPages = (int) Math.ceil((double) totalDataCount / pageSize);
		        response.put("page", page);
		        response.put("pageCnt", totalPages);
		        
		        return ResponseEntity.ok(response);
	    }
	
	@PostMapping("/like/toggle")
	@ResponseBody
	public Map<String, Object> toggleLike(@RequestBody Map<String, Object> request, HttpSession session) {
	    int RCP_SEQ = (int) request.get("recipeId");
	    int memberId = (int) session.getAttribute("memberId");
	    boolean like = (boolean) request.get("like");
	    
	    if(!like) {
	    	recipeInfoService.delteWishList(RCP_SEQ, memberId);
	    }
	    else {

	    	recipeInfoService.insertWishList(RCP_SEQ, memberId);
	    }
	    
	    // DB에서 해당 레시피와 사용자의 좋아요 상태를 업데이트합니다.
	    boolean success = true;
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", success);
	    
	    return response;
	}
 
	@GetMapping("/search/mainForm")
		public String searchMainForm() {
			return "search/main";
		}
	
	@GetMapping("/wishList/mainForm")
	public String wishListMainForm(HttpSession session, Model model) {
	    if (session.getAttribute("memberId") != null) {
	        model.addAttribute("memberId", session.getAttribute("memberId"));
	    }
	    return "wishList/main";
	}
	
	@GetMapping("/wishList/search")
    @ResponseBody
	    public ResponseEntity<Map<String, Object>> searchWishListRecipes(
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "query", required = false) String query, HttpSession session) {
		 		final int pageSize = 20; // 페이지당 항목 수
		 		int offset = (page - 1) * pageSize;
		        Map<String, Object> response = new HashMap<>();
		        int memberId = 0;
		 		if(session.getAttribute("memberId") != null) {
		 			memberId = (int) session.getAttribute("memberId");
		 		}
		 		
		        List<Recipe_Info> recipeInfos = recipeInfoService.searchWishListRecipes(query, pageSize, offset, memberId);
		        response.put("recipeInfos", recipeInfos);
		        int totalDataCount = recipeInfoService.findTotalWishListRecipeCountByQuery(query, memberId);
		        int totalPages = (int) Math.ceil((double) totalDataCount / pageSize);
		        response.put("page", page);
		        response.put("pageCnt", totalPages);
		        
		        return ResponseEntity.ok(response);
	    }

}