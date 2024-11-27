package com.foodRecipe.demo.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.foodRecipe.demo.dto.RecipeDto;
import com.foodRecipe.demo.service.RecipeService;

@RestController
public class RecipeController {
    private RecipeService recipService;
    
    public RecipeController(RecipeService recipService) {
    	this.recipService = recipService;
    }

    @GetMapping("/fetch-recipes")
    public List<RecipeDto> fetchRecipes() {
        return recipService.fetchAllRecipes();
    }
}
