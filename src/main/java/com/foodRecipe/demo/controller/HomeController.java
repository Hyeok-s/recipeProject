package com.foodRecipe.demo.controller;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeImageService;
import com.foodRecipe.demo.service.RecipeInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	RecipeInfoService recipeInfoService;
	
	public HomeController(RecipeInfoService recipeInfoService, RecipeImageService recipeImageService) {
		this.recipeInfoService = recipeInfoService;
	}
	
	@GetMapping("/")
	public String main() {
		return "redirect:/home/main";
	}
	
	@GetMapping("/home/main")
	public String mainForm(
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "method", required = false) String method,
	        @RequestParam(value = "category", required = false) String category,
	        @RequestParam(value = "searchQuery", required = false) String searchQuery,
	        Model model, HttpSession session) {

	    // 모든 레시피 가져오기
	    List<Recipe_Info> recipeInfos = recipeInfoService.findRecipeInfoAndMainImage();

	    // 검색 조건이 있을 경우 필터링
	    if (searchQuery != null && !searchQuery.isEmpty()) {
	        recipeInfos = recipeInfos.stream()
	                .filter(recipe -> recipe.getRCP_NM().contains(searchQuery))
	                .collect(Collectors.toList());
	    }

	    if (method != null && !method.isEmpty()) {
	        recipeInfos = recipeInfos.stream()
	                .filter(recipe -> method.equals(recipe.getRCP_WAY2()))
	                .collect(Collectors.toList());
	    }

	    if (category != null && !category.isEmpty()) {
	        recipeInfos = recipeInfos.stream()
	                .filter(recipe -> category.equals(recipe.getRCP_PAT2()))
	                .collect(Collectors.toList());
	    }

	    // 페이지네이션 처리
	    if (recipeInfos != null && !recipeInfos.isEmpty()) {
	        int pageSize = 20;
	        int start = (page - 1) * pageSize;
	        int end = Math.min(start + pageSize, recipeInfos.size());

	        List<Recipe_Info> pagedRecipeInfos = recipeInfos.subList(start, end);
	        model.addAttribute("recipeInfos", pagedRecipeInfos);

	        int pageCnt = (int) Math.ceil((double) recipeInfos.size() / pageSize);
	        model.addAttribute("page", page);
	        model.addAttribute("pageCnt", pageCnt);
	    } else {
	        model.addAttribute("recipeInfos", Collections.emptyList());
	        model.addAttribute("page", 1);
	        model.addAttribute("pageCnt", 1);
	    }
	    if(session.getAttribute("memberId") != null) {
	    	model.addAttribute("memberId", session.getAttribute("memberId"));
	    }
	    // 검색 조건 유지
	    model.addAttribute("method", method);
	    model.addAttribute("category", category);
	    model.addAttribute("searchQuery", searchQuery);

	    return "recipe/main";
	}
	

}
