package com.foodRecipe.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodRecipe.demo.dto.Recipe_Detail;
import com.foodRecipe.demo.dto.Recipe_Ingredient;
import com.foodRecipe.demo.dto.Recipe_Manual;
import com.foodRecipe.demo.service.RecipeInfoService;
import com.foodRecipe.demo.service.RecipeIngredientService;
import com.foodRecipe.demo.service.RecipeManualService;

@Controller
public class RecipeViewController {
	private RecipeInfoService recipeInforService;
	private RecipeIngredientService recipeIngredient;
	private RecipeManualService recipeManualService;
	
	public RecipeViewController(RecipeInfoService recipeInforService, RecipeIngredientService recipeIngredient, RecipeManualService recipeManualService) {
		this.recipeInforService = recipeInforService;
		this.recipeIngredient = recipeIngredient;
		this.recipeManualService = recipeManualService;
	}
    
    @GetMapping("/recipe/detail")
    public String recipeDetailForm(@RequestParam("RCP_SEQ") Integer RCP_SEQ, Model model) {
    	Recipe_Detail details = recipeInforService.findRecipeDetailByRCP_SEQ(RCP_SEQ);
    	List<Recipe_Ingredient> ingredients = recipeIngredient.findIngredientsByRCP_SEQ(RCP_SEQ);
    	model.addAttribute("details", details);
    	model.addAttribute("ingredients", ingredients);
    	return "recipe/detail";
    }
    
    @GetMapping("/recipe/manual")
    public String recipeManualForm(@RequestParam("RCP_SEQ") Integer RCP_SEQ, Model model, @RequestParam(value = "step", defaultValue = "1") int step) {
    	List<Recipe_Manual> manuals = recipeManualService.findAllRecipeManualByRCP_SEQOrderSTEP_NO(RCP_SEQ);
    	String RCP_NM = recipeInforService.findRCP_NMByRCP_SEQ(RCP_SEQ);
    	int index = step-1;
    	if (manuals != null || !manuals.isEmpty()) {
        	int maxStep = manuals.size();
        	Recipe_Manual manual = manuals.get(index);
        	String manual_text = manual.getMANUAL_TEXT();
        	
        	 if (manual_text.matches("^\\d+\\.\\s.*")) {
                 manual_text = manual_text.substring(manual_text.indexOf(' ') + 1);
             }
        	manual_text = manual_text.replaceAll("[a-zA-Z]", "");
        	manual.setMANUAL_TEXT(manual_text);
        	model.addAttribute("manual", manual);
        	model.addAttribute("RCP_NM", RCP_NM);
        	model.addAttribute("step", step);
    	}
;    	return "recipe/manual";
    }
}


