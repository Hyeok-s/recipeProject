package com.foodRecipe.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.foodRecipe.demo.dto.Recipe_Tips;

@Mapper
public interface Recipe_TipsDao {
	@Insert("""
			INSERT INTO recipe_tips (RCP_NA_TIP, RCP_SEQ) 
            VALUES (#{RCP_NA_TIP}, #{RCP_SEQ})
			""")
    void insertRecipeTips(Recipe_Tips recipeTips);
}
