package com.foodRecipe.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.Recipe_IngredientDao;
import com.foodRecipe.demo.dto.Recipe_Ingredient;

@Service
public class RecipeIngredientService {
	private Recipe_IngredientDao recipeIngredientDao;
	
	public RecipeIngredientService(Recipe_IngredientDao recipeIngredientDao) {
		this.recipeIngredientDao = recipeIngredientDao;
	}

	public List<Recipe_Ingredient> findIngredientsByRCP_SEQ(Integer RCP_SEQ) {
		return recipeIngredientDao.findIngredientsByRCP_SEQ(RCP_SEQ);
	}
}
