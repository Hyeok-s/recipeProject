package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.foodRecipe.demo.dto.Recipe_Image;

@Mapper
public interface Recipe_ImageDao {
	@Insert("""
			INSERT INTO recipe_image (ATT_FILE_NO_MAIN, ATT_FILE_NO_MK, RCP_SEQ) 
            VALUES (#{ATT_FILE_NO_MAIN}, #{ATT_FILE_NO_MK}, #{RCP_SEQ})
			""")
    void insertRecipeImage(Recipe_Image recipeImage);
}
