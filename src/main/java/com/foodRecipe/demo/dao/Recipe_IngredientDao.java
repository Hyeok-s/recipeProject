package com.foodRecipe.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.foodRecipe.demo.dto.Recipe_Ingredient;

@Mapper
public interface Recipe_IngredientDao {

    @Insert("""
    		INSERT INTO recipe_ingredient (RCP_PARTS_DTLS, RCP_SEQ) 
    		VALUES (#{RCP_PARTS_DTLS}, #{RCP_SEQ})
    		""")
	void insertRecipeIngredient(Recipe_Ingredient ingredient);

    @Select("SELECT RCP_PARTS_DTLS FROM recipe_ingredient WHERE RCP_SEQ = #{RCP_SEQ}")
	List<Recipe_Ingredient> findIngredientsByRCP_SEQ(Integer RCP_SEQ);

}
