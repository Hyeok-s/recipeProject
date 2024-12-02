package com.foodRecipe.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodRecipe.demo.dto.Recipe_Detail;
import com.foodRecipe.demo.dto.Recipe_Ingredient;
import com.foodRecipe.demo.service.RecipeInfoService;
import com.foodRecipe.demo.service.RecipeIngredient;

@Controller
public class RecipeViewController {
	private RecipeInfoService recipeInforService;
	private RecipeIngredient recipeIngredient;
	
	public RecipeViewController(RecipeInfoService recipeInforService, RecipeIngredient recipeIngredient) {
		this.recipeInforService = recipeInforService;
		this.recipeIngredient = recipeIngredient;
	}
    
    @GetMapping("/recipe/detail")
    public String recipeDetailForm(@RequestParam("RCP_SEQ") Integer RCP_SEQ, Model model) {
    	Recipe_Detail details = recipeInforService.findRecipeDetailByRCP_SEQ(RCP_SEQ);
    	List<Recipe_Ingredient> ingredients = recipeIngredient.findIngredientsByRCP_SEQ(RCP_SEQ);
    	model.addAttribute("details", details);
    	model.addAttribute("ingredients", ingredients);
    	return "recipe/detail";
    }
}


