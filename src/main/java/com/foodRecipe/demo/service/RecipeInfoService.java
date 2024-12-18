package com.foodRecipe.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.foodRecipe.demo.dao.Recipe_InfoDao;
import com.foodRecipe.demo.dto.Recipe_Detail;
import com.foodRecipe.demo.dto.Recipe_Info;

@Service
public class RecipeInfoService {
	Recipe_InfoDao recipeInfoDao;
	
	public RecipeInfoService(Recipe_InfoDao recipeInfoDao) {
		this.recipeInfoDao = recipeInfoDao;
	}
	
	public List<Recipe_Info> findRecipeInfoAndMainImage(int pageSize, int offset) {
		return recipeInfoDao.findRecipeInfoAndMainImage(pageSize, offset);
	}

	public Recipe_Detail findRecipeDetailByRCP_SEQ(Integer RCP_SEQ) {
		return recipeInfoDao.findRecipeDetailByRCP_SEQ(RCP_SEQ);
	}

	public String findRCP_NMByRCP_SEQ(Integer RCP_SEQ) {
		return recipeInfoDao.findRCP_NMByRCP_SEQ(RCP_SEQ);
	}
	
	public int findTotalRecipeCount() {
		return recipeInfoDao.findTotalRecipeCount();
	}
	
	public List<Recipe_Info> searchRecipes(String query, String sort, int pageSize, int offset) {
		return recipeInfoDao.searchRecipes(query, sort, pageSize, offset);
	}
	
	public int findTotalRecipeCountByQuery(String query) {
		return recipeInfoDao.findTotalRecipeCountByQuery(query);
	}
	
	public void incrementInfoCount(Integer RCP_SEQ) {
		recipeInfoDao.incrementInfoCount(RCP_SEQ);
		
	}

	public List<Recipe_Info> findRecipesByIngredients(List<String> ingredients) {
		return recipeInfoDao.findRecipesByIngredients(ingredients);
	}
}