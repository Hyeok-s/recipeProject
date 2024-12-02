package com.foodRecipe.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foodRecipe.demo.dao.Recipe_ImageDao;
import com.foodRecipe.demo.dao.Recipe_InfoDao;
import com.foodRecipe.demo.dao.Recipe_IngredientDao;
import com.foodRecipe.demo.dao.Recipe_ManualDao;
import com.foodRecipe.demo.dao.Recipe_NutritionDao;
import com.foodRecipe.demo.dao.Recipe_TipsDao;
import com.foodRecipe.demo.dto.RecipeDto;
import com.foodRecipe.demo.dto.Recipe_Image;
import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.dto.Recipe_Ingredient;
import com.foodRecipe.demo.dto.Recipe_Manual;
import com.foodRecipe.demo.dto.Recipe_Nutrition;
import com.foodRecipe.demo.dto.Recipe_Tips;

@Service
public class RecipeSaveService {
	private final Recipe_InfoDao recipeInfoDao;
	private final Recipe_NutritionDao recipeNutritionDao;
	private final Recipe_ImageDao recipeImageDao;
	private final Recipe_ManualDao recipeManualDao;
	private final Recipe_TipsDao recipeTipsDao;
	private final Recipe_IngredientDao recipeIngredientDao;

	public RecipeSaveService(Recipe_InfoDao recipeInfoDao, Recipe_NutritionDao recipeNutritionDao,
			Recipe_ImageDao recipeImageDao, Recipe_ManualDao recipeManualDao, Recipe_TipsDao recipeTipsDao, Recipe_IngredientDao recipeIngredientDao) {
		this.recipeInfoDao = recipeInfoDao;
		this.recipeNutritionDao = recipeNutritionDao;
		this.recipeImageDao = recipeImageDao;
		this.recipeManualDao = recipeManualDao;
		this.recipeTipsDao = recipeTipsDao;
		this.recipeIngredientDao = recipeIngredientDao;
	}

	// db 저장
	@Transactional
	public void saveRecipeData(List<RecipeDto> recipes) {

		for (RecipeDto dto : recipes) {
			// Recipe_Info 저장
			Recipe_Info recipeInfo = new Recipe_Info(parseIntOrNull(dto.getRCP_SEQ()), dto.getRCP_NM(),
					dto.getRCP_WAY2(), dto.getRCP_PAT2(), dto.getHASH_TAG());
			recipeInfoDao.insertRecipeInfo(recipeInfo);
			
			// RCP_PARTS_DTLS 분리
            String[] parts = dto.getRCP_PARTS_DTLS().split(",|●|·|•|(?<=g\\)\\s)");

            // 각 재료를 개별적으로 저장
            for (String part : parts) {
                String trimmed = part.trim();
                if (!trimmed.isEmpty()) {
                    Recipe_Ingredient ingredient = new Recipe_Ingredient(0, trimmed, parseIntOrNull(dto.getRCP_SEQ()));
                    recipeIngredientDao.insertRecipeIngredient(ingredient);
                }
            }

			// Recipe_Nutrition 저장
			Recipe_Nutrition recipeNutrition = new Recipe_Nutrition(0, parseIntOrNull(dto.getINFO_WGT()),
					parseIntOrNull(dto.getINFO_ENG()), parseIntOrNull(dto.getINFO_CAR()),
					parseIntOrNull(dto.getINFO_PRO()), parseIntOrNull(dto.getINFO_FAT()),
					parseIntOrNull(dto.getINFO_NA()), parseIntOrNull(dto.getRCP_SEQ()));
			recipeNutritionDao.insertRecipeNutrition(recipeNutrition);

			// Recipe_Image 저장
			Recipe_Image recipeImage = new Recipe_Image(0, dto.getATT_FILE_NO_MAIN(), dto.getATT_FILE_NO_MK(),
					parseIntOrNull(dto.getRCP_SEQ()));
			recipeImageDao.insertRecipeImage(recipeImage);
			
			// Recipe_Manual 저장
			dto.getManualTextMap().forEach((step, text) -> {
				String img = dto.getManualImgMap().get(step);

				if (text != null && !text.trim().isEmpty()) {
				Recipe_Manual recipeManual = new Recipe_Manual(0, step, text, img, parseIntOrNull(dto.getRCP_SEQ()));
				recipeManualDao.insertRecipeManual(recipeManual);
				}
			});

			// Recipe_Tips 저장
			Recipe_Tips recipeTip = new Recipe_Tips(0, dto.getRCP_NA_TIP(), Integer.parseInt(dto.getRCP_SEQ()));
			recipeTipsDao.insertRecipeTips(recipeTip);
		}
	}

	//숫자 형식으로 변환
	private Integer parseIntOrNull(String value) {
		if (value == null || value.trim().isEmpty()) {
			return null;
		}
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return null;
		}
	}

}
