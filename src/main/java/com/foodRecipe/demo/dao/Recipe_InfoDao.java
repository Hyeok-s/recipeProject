package com.foodRecipe.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.foodRecipe.demo.dto.Recipe_Detail;
import com.foodRecipe.demo.dto.Recipe_Info;

@Mapper
public interface Recipe_InfoDao {
	@Insert("""
			INSERT INTO recipe_info (RCP_SEQ, RCP_NM, RCP_WAY2, RCP_PAT2, HASH_TAG) 
            VALUES (#{RCP_SEQ}, #{RCP_NM}, #{RCP_WAY2}, #{RCP_PAT2}, #{HASH_TAG})
			""")
    void insertRecipeInfo(Recipe_Info recipeInfo);

	@Select("""
			SELECT info.RCP_SEQ, info.RCP_NM, info.RCP_WAY2, info.RCP_PAT2, image.ATT_FILE_NO_MAIN FROM Recipe_Info info 
			INNER JOIN Recipe_image image ON info.RCP_SEQ = image.RCP_SEQ
			""")
	List<Recipe_Info> findRecipeInfoAndMainImage();

	@Select("""
			SELECT info.RCP_SEQ, info.RCP_NM, info.RCP_WAY2, info.RCP_PAT2, image.ATT_FILE_NO_MAIN, 
			nutrition.INFO_WGT, nutrition.INFO_ENG, nutrition.INFO_CAR, nutrition.INFO_PRO, nutrition.INFO_FAT, nutrition.INFO_NA, 
			tips.RCP_NA_TIP 
				FROM Recipe_Info info INNER JOIN Recipe_image image ON info.RCP_SEQ = image.RCP_SEQ 
				INNER JOIN recipe_nutrition nutrition ON info.RCP_SEQ = nutrition.RCP_SEQ 
				INNER JOIN recipe_tips tips ON info.RCP_SEQ = tips.RCP_SEQ
				WHERE info.RCP_SEQ = #{RCP_SEQ}
			""")
	Recipe_Detail findRecipeDetailByRCP_SEQ(Integer RCP_SEQ);	
	
}
