package com.foodRecipe.demo.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.foodRecipe.demo.dto.RecipeDto;
import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeInfoService;
import com.foodRecipe.demo.service.RecipeSaveService;
import com.foodRecipe.demo.service.RecipeService;

@RestController
public class RecipeController {
    private final RecipeService recipeService;
    private final RecipeSaveService recipeSaveService;
    private final RecipeInfoService recipeInfoService;
    
    public RecipeController(RecipeService recipeService, RecipeSaveService recipeSaveService, RecipeInfoService recipeInfoService) {
        this.recipeService = recipeService;
        this.recipeSaveService = recipeSaveService;
        this.recipeInfoService = recipeInfoService;
    }

    @GetMapping("/save-recipes")
    public String saveRecipesToDatabase() {
        try {
        	// 외부 API에서 모든 레시피 데이터 가져오기
            List<RecipeDto> recipes = recipeService.fetchAllRecipes();
            
            // 데이터 저장
            recipeSaveService.saveRecipeData(recipes);
            return "Recipes saved successfully!";
        } catch (Exception e) {
            e.printStackTrace();
            return "Failed to save recipes: " + e.getMessage();
        }
    }
  

}