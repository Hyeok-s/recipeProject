package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.foodRecipe.demo.dto.Recipe_Nutrition;

@Mapper
public interface Recipe_NutritionDao {
	@Insert("""
			INSERT INTO recipe_nutrition (INFO_WGT, INFO_ENG, INFO_CAR, 
			INFO_PRO, INFO_FAT, INFO_NA, RCP_SEQ) 
            VALUES (#{INFO_WGT}, #{INFO_ENG}, #{INFO_CAR}, 
            #{INFO_PRO}, #{INFO_FAT}, #{INFO_NA}, #{RCP_SEQ})
			""")
    void insertRecipeNutrition(Recipe_Nutrition recipeNutrition);
}
