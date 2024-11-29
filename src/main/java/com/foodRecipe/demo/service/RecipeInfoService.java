package com.foodRecipe.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.Recipe_InfoDao;
import com.foodRecipe.demo.dto.Recipe_Info;

@Service
public class RecipeInfoService {
	Recipe_InfoDao recipeInfoDao;
	
	public RecipeInfoService(Recipe_InfoDao recipeInfoDao) {
		this.recipeInfoDao = recipeInfoDao;
	}
	
	public List<Recipe_Info> findRecipeInfoAndMainImage() {
		return recipeInfoDao.findRecipeInfoAndMainImage();
	}
}
