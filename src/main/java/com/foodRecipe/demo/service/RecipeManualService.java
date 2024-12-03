package com.foodRecipe.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.Recipe_ManualDao;
import com.foodRecipe.demo.dto.Recipe_Manual;

@Service
public class RecipeManualService {
	private Recipe_ManualDao recipeManualDao;
	
	public RecipeManualService(Recipe_ManualDao recipeManualDao) {
		this.recipeManualDao = recipeManualDao;
	}

	public List<Recipe_Manual> findAllRecipeManualByRCP_SEQOrderSTEP_NO(Integer RCP_SEQ) {
		return recipeManualDao.findAllRecipeManualByRCP_SEQOrderSTEP_NO(RCP_SEQ);
	}
	
	
}
