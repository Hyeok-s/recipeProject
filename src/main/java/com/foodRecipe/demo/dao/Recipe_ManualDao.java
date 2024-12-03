package com.foodRecipe.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.foodRecipe.demo.dto.Recipe_Manual;

@Mapper
public interface Recipe_ManualDao {
    @Insert("""
    		INSERT INTO recipe_manual (STEP_NO, MANUAL_TEXT, MANUAL_IMG, RCP_SEQ) 
    		VALUES (#{STEP_NO}, #{MANUAL_TEXT}, #{MANUAL_IMG}, #{RCP_SEQ})
    		""")
    void insertRecipeManual(Recipe_Manual recipeManual);

    @Select("SELECT * FROM recipe_manual WHERE RCP_SEQ = #{RCP_SEQ} ORDER BY STEP_NO")
	List<Recipe_Manual> findAllRecipeManualByRCP_SEQOrderSTEP_NO(Integer RCP_SEQ);
}
