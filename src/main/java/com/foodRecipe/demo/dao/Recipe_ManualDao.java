package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.foodRecipe.demo.dto.Recipe_Manual;

@Mapper
public interface Recipe_ManualDao {
    @Insert("""
    		INSERT INTO recipe_manual (STEP_NO, MANUAL_TEXT, MANUAL_IMG, RCP_SEQ) 
    		VALUES (#{STEP_NO}, #{MANUAL_TEXT}, #{MANUAL_IMG}, #{RCP_SEQ})
    		""")
    void insertRecipeManual(Recipe_Manual recipeManual);
}
