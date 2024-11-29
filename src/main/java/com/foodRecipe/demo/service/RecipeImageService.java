package com.foodRecipe.demo.service;



import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.Recipe_ImageDao;

@Service
public class RecipeImageService {
	Recipe_ImageDao recipeImageDao;
	
	public RecipeImageService(Recipe_ImageDao recipeImageDao) {
		this.recipeImageDao = recipeImageDao;
	}

}
