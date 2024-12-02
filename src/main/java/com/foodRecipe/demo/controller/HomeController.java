package com.foodRecipe.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodRecipe.demo.dto.Recipe_Image;
import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeImageService;
import com.foodRecipe.demo.service.RecipeInfoService;

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
	public String mainForm(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		List<Recipe_Info> recipeInfos =  recipeInfoService.findRecipeInfoAndMainImage();
		
		if (recipeInfos != null || !recipeInfos.isEmpty()) {
			int pageSize = 20;
			int start = (page - 1) * pageSize;
			int end = Math.min(start + pageSize, recipeInfos.size());

			List<Recipe_Info> pagedRecipeInfos = recipeInfos.subList(start, end);

			model.addAttribute("recipeInfos", pagedRecipeInfos);
			
			int pageCnt = (int) Math.ceil((double) recipeInfos.size() / pageSize);
			model.addAttribute("page", page);
		    model.addAttribute("pageCnt", pageCnt);
		}
		return "recipe/main";
	}
	

}
