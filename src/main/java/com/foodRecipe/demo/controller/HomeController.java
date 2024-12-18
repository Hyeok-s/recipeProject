package com.foodRecipe.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) {
		 		final int pageSize = 20; // 페이지당 항목 수
		 		int offset = (page - 1) * pageSize;
		 	// 검색 및 정렬된 데이터를 가져오기
		        List<Recipe_Info> recipeInfos = recipeInfoService.searchRecipes(query, sort, pageSize, offset);
		        int totalDataCount = recipeInfoService.findTotalRecipeCountByQuery(query);
		        int totalPages = (int) Math.ceil((double) totalDataCount / pageSize);
		     // 응답 데이터 구성
		        Map<String, Object> response = new HashMap<>();
		        response.put("recipeInfos", recipeInfos);
		        response.put("page", page);
		        response.put("pageCnt", totalPages);
		        return ResponseEntity.ok(response);
	    }
 
	@GetMapping("/test")
		public String test() {
			return "test";
		}

}