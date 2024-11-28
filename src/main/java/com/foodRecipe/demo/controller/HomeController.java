package com.foodRecipe.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeInfoService;

@Controller
public class HomeController {
	RecipeInfoService recipeInfoService;
	
	public HomeController(RecipeInfoService recipeInfoService) {
		this.recipeInfoService = recipeInfoService;
	}
	
	@GetMapping("/home/main")
	@ResponseBody
	public String showMain() {
		Recipe_Info recipeInfo;
		return "안녕12";
	}
	
	@GetMapping("/home/asd")
	public String sdaf(Model model) {
		List<Recipe_Info> recipes =  recipeInfoService.showAllRecipe();
		model.addAttribute("a", recipes);
		return "Main";
	}
}
